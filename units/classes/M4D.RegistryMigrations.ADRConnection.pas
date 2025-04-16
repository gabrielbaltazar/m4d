unit M4D.RegistryMigrations.ADRConnection;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.DateUtils,
  System.SysUtils,
  Data.DB,
  M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationsHistoryItem,
  ADRConn.Model.Interfaces;

type
  {$M+}
  TM4DMigrationsHistoryADRConnection = class(TInterfacedObject, IMigrationsHistoryFacade)
  private
    FTableName: string;
    FConnection: IADRConnection;
    FQuery: IADRQuery;
    FHistory: TObjectList<TMigrationsHistoryItem>;
    FLastMigration: TMigrationsHistoryItem;

    function DateTimeType: string;
    function Select: string;
    procedure CreateTableMigrations;
  protected
    procedure Clear;
    procedure Load; virtual;
    procedure UnLoad; virtual;
    procedure Save; virtual;
    function LastMigration: TMigrationsHistoryItem;

    procedure Add(AItem: TMigrationsHistoryItem);
    procedure Remove(AMigrationSequence: Integer);

    function GetHistory: TList<TMigrationsHistoryItem>; overload;
    function GetHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    function GetHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;

    property History: TList<TMigrationsHistoryItem> read GetHistory;
  public
    constructor Create(AConnection: IADRConnection; ATableName: string = '');
    class function New(AConnection: IADRConnection; ATableName: string = ''): IMigrationsHistoryFacade;
    destructor Destroy; override;
  end;

implementation

{ TM4DMigrationsHistoryADRConnection }

procedure TM4DMigrationsHistoryADRConnection.Add(AItem: TMigrationsHistoryItem);
begin
  if not Assigned(AItem) then
    raise Exception.Create('The parameter AItem must no be nil.');

  AItem.DurationOfExecution := MilliSecondsBetween(AItem.StartOfExecution, AItem.EndOfExecution);

  FQuery.SQL('INSERT INTO %s (SEQUENCE, VERSION,', [FTableName])
    .SQL('DATETIME, START_OF_EXECUTION, END_OF_EXECUTION, DURATION_OF_EXECUTION)')
    .SQL('VALUES (:SEQUENCE, :VERSION,')
    .SQL(':DATETIME, :START, :END, :DURATION)')
    .ParamAsInteger('SEQUENCE', AItem.MigrationSeq)
    .ParamAsString('VERSION', AItem.MigrationVersion)
    .ParamAsDateTime('DATETIME', AItem.MigrationDateTime)
    .ParamAsDateTime('START', AItem.StartOfExecution)
    .ParamAsDateTime('END', AItem.EndOfExecution)
    .ParamAsFloat('DURATION', AItem.DurationOfExecution)
    .ExecSQL;

  {As the class does not store the item, because all information must remain in the database,
   I have to destroy the item, so there is no memory leak}
  FreeAndNil(AItem);
end;

procedure TM4DMigrationsHistoryADRConnection.Clear;
begin
  FQuery.SQL('DELETE FROM %s', [FTableName])
    .ExecSQL;
end;

constructor TM4DMigrationsHistoryADRConnection.Create(AConnection: IADRConnection; ATableName: string = '');
begin
  FConnection := AConnection;
  FQuery := CreateQuery(FConnection);
  FTableName := 'MIGRATIONS_INFO';
  if ATableName <> EmptyStr then
    FTableName := ATableName;

  CreateTableMigrations;
end;

procedure TM4DMigrationsHistoryADRConnection.CreateTableMigrations;
var
  LSql: string;
begin
  LSql := Format('create table if not exists %s (', [FTableName]) +
    'SEQUENCE INT PRIMARY KEY NOT NULL, ' +
    'VERSION VARCHAR(255), ' +
    'DATETIME :DATETIME, ' +
    'START_OF_EXECUTION :DATETIME, ' +
    'END_OF_EXECUTION :DATETIME, ' +
    'DURATION_OF_EXECUTION INTEGER) ';
  LSql := LSql.Replace(':DATETIME', DateTimeType);
  FQuery.SQL(LSql).ExecSQL;
end;

function TM4DMigrationsHistoryADRConnection.DateTimeType: string;
begin
  Result := 'DATETIME';
  if FConnection.Params.Driver = TADRDriverConn.adrPostgres then
    Result := 'TIMESTAMP';
end;

destructor TM4DMigrationsHistoryADRConnection.Destroy;
begin
  if Assigned(FHistory) then
    FHistory.Free;

  if Assigned(FLastMigration) then
    FLastMigration.Free;
  inherited;
end;

function TM4DMigrationsHistoryADRConnection.GetHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>;
var
  LDataSet: TDataSet;
begin
  Result := nil;
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  LDataSet := FQuery.SQL(Select)
    .SQL('WHERE SEQUENCE >= :sequence ')
    .SQL('ORDER BY SEQUENCE ASC')
    .ParamAsInteger('sequence', AStartMigrationSeq)
    .OpenDataSet;
  try
    FHistory := TObjectList<TMigrationsHistoryItem>.Create;
    try
      LDataSet.First;
      while not LDataSet.Eof do
      begin
        FHistory.Add(TMigrationsHistoryItem.Create);
        FHistory.Last.MigrationSeq := LDataSet.Fields[0].AsInteger;
        FHistory.Last.MigrationVersion := LDataSet.Fields[1].AsString;
        FHistory.Last.MigrationDateTime := LDataSet.Fields[2].AsDateTime;
        FHistory.Last.StartOfExecution := LDataSet.Fields[3].AsDateTime;
        FHistory.Last.EndOfExecution := LDataSet.Fields[4].AsDateTime;
        FHistory.Last.DurationOfExecution := LDataSet.Fields[5].AsFloat;
        LDataSet.Next;
      end;
      Result := FHistory;
    except
      Result.Free;
      raise;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TM4DMigrationsHistoryADRConnection.GetHistory: TList<TMigrationsHistoryItem>;
var
  LDataSet: TDataSet;
begin
  Result := nil;
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  LDataSet := FQuery.SQL(Select)
    .SQL('ORDER BY SEQUENCE ASC')
    .OpenDataSet;
  try
    FHistory := TObjectList<TMigrationsHistoryItem>.Create;
    try
      LDataSet.First;
      while not LDataSet.Eof do
      begin
        FHistory.Add(TMigrationsHistoryItem.Create);
        FHistory.Last.MigrationSeq := LDataSet.Fields[0].AsInteger;
        FHistory.Last.MigrationVersion := LDataSet.Fields[1].AsString;
        FHistory.Last.MigrationDateTime := LDataSet.Fields[2].AsDateTime;
        FHistory.Last.StartOfExecution := LDataSet.Fields[3].AsDateTime;
        FHistory.Last.EndOfExecution := LDataSet.Fields[4].AsDateTime;
        FHistory.Last.DurationOfExecution := LDataSet.Fields[5].AsFloat;
        LDataSet.Next;
      end;
      Result := FHistory;
    except
      Result.Free;
      raise;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TM4DMigrationsHistoryADRConnection.GetHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>;
var
  LDataSet: TDataSet;
begin
  Result := nil;
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  LDataSet := FQuery.SQL(Select)
    .SQL('WHERE DATETIME >= :datetime ')
    .SQL('ORDER BY SEQUENCE ASC')
    .ParamAsDateTime('AStartMigrationDateTime', AStartMigrationDateTime)
    .OpenDataSet;
  try
    FHistory := TObjectList<TMigrationsHistoryItem>.Create;
    try
      LDataSet.First;
      while not LDataSet.Eof do
      begin
        FHistory.Add(TMigrationsHistoryItem.Create);
        FHistory.Last.MigrationSeq := LDataSet.Fields[0].AsInteger;
        FHistory.Last.MigrationVersion := LDataSet.Fields[1].AsString;
        FHistory.Last.MigrationDateTime := LDataSet.Fields[2].AsDateTime;
        FHistory.Last.StartOfExecution := LDataSet.Fields[3].AsDateTime;
        FHistory.Last.EndOfExecution := LDataSet.Fields[4].AsDateTime;
        FHistory.Last.DurationOfExecution := LDataSet.Fields[5].AsFloat;
        LDataSet.Next;
      end;
      Result := FHistory;
    except
      Result.Free;
      raise;
    end;
  finally
    LDataSet.Free;
  end;
end;

function TM4DMigrationsHistoryADRConnection.LastMigration: TMigrationsHistoryItem;
var
  LDataSet: TDataSet;
begin
  if Assigned(FLastMigration) then
    FreeAndNil(FLastMigration);

  Result := nil;
  LDataSet := FQuery.SQL(Select + 'ORDER BY SEQUENCE DESC').OpenDataSet;
  try
    if LDataSet.RecordCount > 0 then
    begin
      FLastMigration := TMigrationsHistoryItem.Create;
      FLastMigration.MigrationSeq := LDataSet.Fields[0].AsInteger;
      FLastMigration.MigrationVersion := LDataSet.Fields[1].AsString;
      FLastMigration.MigrationDateTime := LDataSet.Fields[2].AsDateTime;
      FLastMigration.StartOfExecution := LDataSet.Fields[3].AsDateTime;
      FLastMigration.EndOfExecution := LDataSet.Fields[4].AsDateTime;
      FLastMigration.DurationOfExecution := LDataSet.Fields[5].AsFloat;
      Result := FLastMigration;
    end;
  finally
    LDataSet.Free;
  end;
end;

procedure TM4DMigrationsHistoryADRConnection.Load;
begin

end;

class function TM4DMigrationsHistoryADRConnection.New(AConnection: IADRConnection; ATableName: string = ''): IMigrationsHistoryFacade;
begin
  Result := Self.Create(AConnection, ATableName);
end;

procedure TM4DMigrationsHistoryADRConnection.Remove(AMigrationSequence: Integer);
begin
  FQuery.SQL('DELETE FROM %s WHERE SEQUENCE = %d',
    [FTableName, AMigrationSequence]);
  FQuery.ExecSQL;
end;

procedure TM4DMigrationsHistoryADRConnection.Save;
begin
end;

function TM4DMigrationsHistoryADRConnection.Select: string;
begin
  Result := Format('SELECT SEQUENCE, VERSION, DATETIME, ' +
    'START_OF_EXECUTION, END_OF_EXECUTION, DURATION_OF_EXECUTION ' +
    'FROM %s ', [FTableName]);
end;

procedure TM4DMigrationsHistoryADRConnection.UnLoad;
begin
end;

end.
