{######################################################################################

                                      M4D Framework

Author: Edgar Borges Pavão
Date of creation: 06/09/2017
Use licence: Free

######################################################################################}

unit UDBMigrationHistory;

interface

uses
  M4D.MigrationsHistoryFacadeInterface, Winapi.CommCtrl, M4D.MigrationsHistoryItem,
  System.Generics.Collections, FireDAC.Comp.Client, System.SysUtils;

type
  {$M+}
  TDBMigrationsHistory = class(TInterfacedObject, IMigrationsHistoryFacade)
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FHistory: TObjectList<TMigrationsHistoryItem>;
    FLastMigration: TMigrationsHistoryItem;
  protected
    procedure Clear;
    procedure Load;
    procedure UnLoad;
    procedure Add(AItem: TMigrationsHistoryItem);
    procedure Remove(AMigrationSequence: Integer);

    function GetHistory: TList<TMigrationsHistoryItem>; overload;
    function GetHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    function GetHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;
    procedure Save;
    function LastMigration: TMigrationsHistoryItem;
  published
    property HistoryList: TList<TMigrationsHistoryItem> read GetHistory;
  public
    constructor Create(AConnection: TFDConnection); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  System.Generics.Defaults,
  System.Classes,
  FireDac.Stan.Param,
  Data.DB,
  System.DateUtils;

{ TDBMigrationsHistory }

procedure TDBMigrationsHistory.Add(AItem: TMigrationsHistoryItem);
begin
  if not Assigned(AItem) then
    raise Exception.Create('The parameter AItem must no be nil.');

  FQuery.Close;
  FQuery.SQL.Text := 'INSERT INTO MIGRATIONS_INFO (SEQUENCE, ' +
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
  AItem.DisposeOf;
end;

procedure TDBMigrationsHistory.Clear;
begin
  FQuery.Close;
  FQuery.SQL.Text := 'DELETE FROM MIGRATIONS_INFO';
  FQuery.ExecSQL;
end;

constructor TDBMigrationsHistory.Create(AConnection: TFDConnection);
begin
  Self.FConnection := AConnection;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConnection;
end;

destructor TDBMigrationsHistory.Destroy;
begin
  FQuery.Close;
  FQuery.DisposeOf;
  if Assigned(FHistory) then
    FHistory.DisposeOf;

  if Assigned(FLastMigration) then
    FLastMigration.DisposeOf;
  inherited;
end;

function TDBMigrationsHistory.getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>;
begin
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  FQuery.Close;
  FQuery.SQL.Text := 'SELECT SEQUENCE, VERSION, DATETIME, ' +
    'START_OF_EXECUTION, END_OF_EXECUTION, DURATION_OF_EXECUTION ' +
    'FROM MIGRATIONS_INFO ' +
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

function TDBMigrationsHistory.GetHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>;
begin
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  FQuery.Close;
  FQuery.SQL.Text := 'SELECT SEQUENCE, VERSION, DATETIME, ' +
    'START_OF_EXECUTION, END_OF_EXECUTION, DURATION_OF_EXECUTION ' +
    'FROM MIGRATIONS_INFO ' +
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

function TDBMigrationsHistory.GetHistory: TList<TMigrationsHistoryItem>;
begin
  if Assigned(FHistory) then
    FreeAndNil(FHistory);

  FQuery.Close;
  FQuery.SQL.Text := 'SELECT SEQUENCE, VERSION, DATETIME, ' +
    'START_OF_EXECUTION, END_OF_EXECUTION, DURATION_OF_EXECUTION ' +
    'FROM MIGRATIONS_INFO ORDER BY SEQUENCE ASC';
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

function TDBMigrationsHistory.LastMigration: TMigrationsHistoryItem;
begin
  if Assigned(FLastMigration) then
    FreeAndNil(FLastMigration);

  Result := nil;
  FQuery.Close;
  FQuery.SQL.Text := 'SELECT SEQUENCE, VERSION, DATETIME, ' +
    'START_OF_EXECUTION, END_OF_EXECUTION, DURATION_OF_EXECUTION ' +
    'FROM MIGRATIONS_INFO ' +
    'ORDER BY SEQUENCE DESC ' +
    'LIMIT 1';
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
    FQuery.Close;
  end;
end;

procedure TDBMigrationsHistory.Load;
begin

end;

procedure TDBMigrationsHistory.Remove(AMigrationSequence: Integer);
begin
  FQuery.Close;
  FQuery.SQL.Text := Format('DELETE FROM MIGRATIONS_INFO WHERE SEQUENCE = %d',
    [AMigrationSequence]);
  FQuery.ExecSQL;
  FQuery.Close;
end;

procedure TDBMigrationsHistory.Save;
begin

end;

procedure TDBMigrationsHistory.UnLoad;
begin

end;

end.
