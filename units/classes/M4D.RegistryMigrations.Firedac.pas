unit M4D.RegistryMigrations.Firedac;

interface

uses
  M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationsHistoryItem,
  Data.DB,
  FireDAC.Comp.Client,
  FireDac.Stan.Param,
  System.Classes,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.DateUtils,
  System.SysUtils;

type
  {$M+}
  TM4DMigrationsHistoryFiredac = class(TInterfacedObject, IMigrationsHistoryFacade)
  private
    FTableName: string;
    FQuery: TFDQuery;
    FHistory: TObjectList<TMigrationsHistoryItem>;
    FLastMigration: TMigrationsHistoryItem;

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
    constructor Create(AQuery: TFDQuery; ATableName: string = '');
    class function New(AQuery: TFDQuery; ATableName: string = ''): IMigrationsHistoryFacade;
    destructor Destroy; override;
  end;

implementation

{ TM4DMigrationsHistoryFiredac }

procedure TM4DMigrationsHistoryFiredac.Add(AItem: TMigrationsHistoryItem);
begin
  if not Assigned(AItem) then
    raise Exception.Create('The parameter AItem must no be nil.');

  FQuery.Close;
  FQuery.SQL.Text := Format('INSERT INTO %s (SEQUENCE, ', [FTableName]) +
    'VERSION, DATETIME, START_OF_EXECUTION, END_OF_EXECUTION, ' +
    'DURATION_OF_EXECUTION) ' +
    ' VALUES (:SEQUENCE, :VERSION, :DATETIME, :START, :END, ' +
    ':DURATION)';

  AItem.DurationOfExecution := MilliSecondsBetween(AItem.StartOfExecution, AItem.EndOfExecution);
  FQuery.Params[0].AsInteger := AItem.MigrationSeq;
  FQuery.Params[1].AsString := AItem.MigrationVersion;
  FQuery.Params[2].AsDateTime := AItem.MigrationDateTime;
  FQuery.Params[3].AsDateTime := AItem.StartOfExecution;
  FQuery.Params[4].AsDateTime := AItem.EndOfExecution;
  FQuery.Params[5].AsFloat := AItem.DurationOfExecution;

  FQuery.ExecSQL;
  FQuery.Close;

  {As the class does not store the item, because all information must remain in the database,
   I have to destroy the item, so there is no memory leak}
  FreeAndNil(AItem);
end;

procedure TM4DMigrationsHistoryFiredac.Clear;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'DELETE FROM ' + FTableName;
  FQuery.ExecSQL;
end;

constructor TM4DMigrationsHistoryFiredac.Create(AQuery: TFDQuery; ATableName: string);
begin
  FQuery := AQuery;
  FTableName := 'MIGRATIONS_INFO';
  if ATableName <> EmptyStr then
    FTableName := ATableName;

  CreateTableMigrations;
end;

procedure TM4DMigrationsHistoryFiredac.CreateTableMigrations;
begin
  FQuery.Close;
  FQuery.SQL.Text := Format('create table if not exists %s (', [FTableName]) +
    'SEQUENCE INT PRIMARY KEY NOT NULL, ' +
    'VERSION VARCHAR(255), ' +
    'DATETIME DATETIME, ' +
    'START_OF_EXECUTION DATETIME, ' +
    'END_OF_EXECUTION DATETIME, ' +
    'DURATION_OF_EXECUTION INTEGER) ';
  FQuery.ExecSQL;
  FQuery.Close;
end;

destructor TM4DMigrationsHistoryFiredac.Destroy;
begin
  if Assigned(FHistory) then
    FHistory.Free;

  if Assigned(FLastMigration) then
    FLastMigration.Free;
  inherited;
end;

function TM4DMigrationsHistoryFiredac.GetHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>;
begin
  Result := nil;
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  FQuery.Close;
  FQuery.SQL.Text := Select +
    'WHERE SEQUENCE >= :sequence ' +
    'ORDER BY SEQUENCE ASC';
  FQuery.Params[0].AsInteger := AStartMigrationSeq;
  FQuery.Open;
  FHistory := TObjectList<TMigrationsHistoryItem>.Create;
  try
    FQuery.First;
    while not FQuery.Eof do
    begin
      FHistory.Add(TMigrationsHistoryItem.Create);
      FHistory.Last.MigrationSeq := FQuery.Fields[0].AsInteger;
      FHistory.Last.MigrationVersion := FQuery.Fields[1].AsString;
      FHistory.Last.MigrationDateTime := FQuery.Fields[2].AsDateTime;
      FHistory.Last.StartOfExecution := FQuery.Fields[3].AsDateTime;
      FHistory.Last.EndOfExecution := FQuery.Fields[4].AsDateTime;
      FHistory.Last.DurationOfExecution := FQuery.Fields[5].AsFloat;
      FQuery.Next;
    end;
    FQuery.Close;
    Result := FHistory;
  except
    Result.Free;
    raise;
  end;
end;

function TM4DMigrationsHistoryFiredac.GetHistory: TList<TMigrationsHistoryItem>;
begin
  Result := nil;
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  FQuery.Close;
  FQuery.SQL.Text := Select + 'ORDER BY SEQUENCE ASC';
  FQuery.Open;
  FHistory := TObjectList<TMigrationsHistoryItem>.Create;
  try
    FQuery.First;
    while not FQuery.Eof do
    begin
      FHistory.Add(TMigrationsHistoryItem.Create);
      FHistory.Last.MigrationSeq := FQuery.Fields[0].AsInteger;
      FHistory.Last.MigrationVersion := FQuery.Fields[1].AsString;
      FHistory.Last.MigrationDateTime := FQuery.Fields[2].AsDateTime;
      FHistory.Last.StartOfExecution := FQuery.Fields[3].AsDateTime;
      FHistory.Last.EndOfExecution := FQuery.Fields[4].AsDateTime;
      FHistory.Last.DurationOfExecution := FQuery.Fields[5].AsFloat;
      FQuery.Next;
    end;
    FQuery.Close;
    Result := FHistory;
  except
    Result.Free;
    raise;
  end;
end;

function TM4DMigrationsHistoryFiredac.GetHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>;
begin
  Result := nil;
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  FQuery.Close;
  FQuery.SQL.Text := Select +
    'WHERE DATETIME >= :datetime ' +
    'ORDER BY SEQUENCE ASC';
  FQuery.Params[0].AsDateTime := AStartMigrationDateTime;
  FQuery.Open;
  FHistory := TObjectList<TMigrationsHistoryItem>.Create;
  try
    FQuery.First;
    while not FQuery.Eof do
    begin
      FHistory.Add(TMigrationsHistoryItem.Create);
      FHistory.Last.MigrationSeq := FQuery.Fields[0].AsInteger;
      FHistory.Last.MigrationVersion := FQuery.Fields[1].AsString;
      FHistory.Last.MigrationDateTime := FQuery.Fields[2].AsDateTime;
      FHistory.Last.StartOfExecution := FQuery.Fields[3].AsDateTime;
      FHistory.Last.EndOfExecution := FQuery.Fields[4].AsDateTime;
      FHistory.Last.DurationOfExecution := FQuery.Fields[5].AsFloat;
      FQuery.Next;
    end;
    FQuery.Close;
    Result := FHistory;
  except
    Result.Free;
    raise;
  end;
end;

function TM4DMigrationsHistoryFiredac.LastMigration: TMigrationsHistoryItem;
begin
  if Assigned(FLastMigration) then
    FreeAndNil(FLastMigration);

  Result := nil;
  FQuery.Close;
  FQuery.SQL.Text := Select + 'ORDER BY SEQUENCE DESC';
  FQuery.FetchOptions.RecsMax := 1;
  try
    FQuery.Open;
    if FQuery.RecordCount > 0 then
    begin
      FLastMigration := TMigrationsHistoryItem.Create;
      FLastMigration.MigrationSeq := FQuery.Fields[0].AsInteger;
      FLastMigration.MigrationVersion := FQuery.Fields[1].AsString;
      FLastMigration.MigrationDateTime := FQuery.Fields[2].AsDateTime;
      FLastMigration.StartOfExecution := FQuery.Fields[3].AsDateTime;
      FLastMigration.EndOfExecution := FQuery.Fields[4].AsDateTime;
      FLastMigration.DurationOfExecution := FQuery.Fields[5].AsFloat;
      Result := FLastMigration;
    end;
  finally
    FQuery.FetchOptions.RecsMax := -1;
    FQuery.Close;
  end;
end;

procedure TM4DMigrationsHistoryFiredac.Load;
begin

end;

class function TM4DMigrationsHistoryFiredac.New(AQuery: TFDQuery; ATableName: string): IMigrationsHistoryFacade;
begin
  Result := Self.Create(AQuery, ATableName);
end;

procedure TM4DMigrationsHistoryFiredac.Remove(AMigrationSequence: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Text := Format('DELETE FROM %s WHERE SEQUENCE = %d',
    [FTableName, AMigrationSequence]);
  FQuery.ExecSQL;
  FQuery.Close;
end;

procedure TM4DMigrationsHistoryFiredac.Save;
begin
end;

function TM4DMigrationsHistoryFiredac.Select: string;
begin
  Result := Format('SELECT SEQUENCE, VERSION, DATETIME, ' +
    'START_OF_EXECUTION, END_OF_EXECUTION, DURATION_OF_EXECUTION ' +
    'FROM %s ', [FTableName]);
end;

procedure TM4DMigrationsHistoryFiredac.UnLoad;
begin
end;

end.
