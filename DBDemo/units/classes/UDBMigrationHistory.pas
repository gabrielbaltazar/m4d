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
  TGetConnectionFunc = reference to function: TFDConnection;

type
  {$M+}
  TDBMigrationsHistory = class(TInterfacedObject, IMigrationsHistoryFacade)
  private
    FGetConnectionFunc: TGetConnectionFunc;

    FMigrationList: TObjectList<TMigrationsHistoryItem>;

    function getQuery(ASql: string; const AOpenQuery: Boolean = True): TFDQuery;
    procedure ExecuteDBCmd(ASql: string);

    function getHistory(AFilterProc: TProc<TFDQuery>): TList<TMigrationsHistoryItem>; overload;
    function getHistory: TList<TMigrationsHistoryItem>; overload;
  public
    constructor Create(AGetConnectionFunc: TGetConnectionFunc); reintroduce;
    destructor Destroy; override;

    procedure Clear;
    procedure Load;
    procedure UnLoad;
    procedure Add(AItem: TMigrationsHistoryItem);
    procedure Remove(AMigrationSequence: Integer);

    function getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    function getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;
    procedure Save;
    function LastMigration: TMigrationsHistoryItem;
  published
    property HistoryList: TList<TMigrationsHistoryItem> read getHistory;
  end;

implementation

uses
  System.Generics.Defaults, System.Classes, FireDac.Stan.Param, Data.DB;

{ TDBMigrationsHistory }

procedure TDBMigrationsHistory.Add(AItem: TMigrationsHistoryItem);
var
  Query: TFDQuery;
begin
  if not Assigned(AItem) then
  begin
    raise Exception.Create('The parameter AItem must no be nil.');
  end
  else
  begin
    Query := getQuery('INSERT INTO MIGRATIONS_INFO (SEQUENCE,              ' +
                      '                             VERSION,               ' +
                      '                             DATETIME,              ' +
                      '                             START_OF_EXECUTION,    ' +
                      '                             END_OF_EXECUTION,      ' +
                      '                             DURATION_OF_EXECUTION) ' +
                      '                     VALUES (:SEQUENCE,             ' +
                      '                             :VERSION,              ' +
                      '                             :DATETIME,             ' +
                      '                             :START,                ' +
                      '                             :END,                  ' +
                      '                             :DURATION)             ', False);
    try
      Query.Params[0].AsInteger := AItem.MigrationSeq;
      Query.Params[1].AsString := AItem.MigrationVersion;
      Query.Params[2].AsDateTime := AItem.MigrationDateTime;
      Query.Params[3].AsDateTime := AItem.StartOfExecution;
      Query.Params[4].AsDateTime := AItem.EndOfExecution;
      Query.Params[5].AsFloat := AItem.DurationOfExecution;

      Query.ExecSQL;
    finally
      FreeAndNil(Query);
    end;

    {As the class does not store the item, because all information must remain in the database,
     I have to destroy the item, so there is no memory leak}
     AItem.DisposeOf;
  end;
end;

procedure TDBMigrationsHistory.Clear;
begin
  ExecuteDBCmd('DELETE FROM MIGRATIONS_INFO');
end;

constructor TDBMigrationsHistory.Create(AGetConnectionFunc: TGetConnectionFunc);
begin
  FMigrationList := TObjectList<TMigrationsHistoryItem>.Create;
  Self.FGetConnectionFunc := AGetConnectionFunc;
end;

destructor TDBMigrationsHistory.Destroy;
begin
  if Assigned(FMigrationList) then FMigrationList.DisposeOf;
  
  inherited;
end;

procedure TDBMigrationsHistory.ExecuteDBCmd(ASql: string);
var
  Query: TFDQuery;
begin
  Query := getQuery(ASql, False);
  try
    Query.ExecSQL;
  finally
    FreeAndNil(Query);
  end;
end;

function TDBMigrationsHistory.getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>;
begin
  Result := getHistory(procedure(AQuery: TFDQuery)
                       begin
                         if Assigned(AQuery) then
                         begin
                           AQuery.SQL.Add('WHERE DATETIME >= :datetime');
                           AQuery.Params[0].AsDateTime := AStartMigrationDateTime;
                         end;
                       end);
end;

function TDBMigrationsHistory.getHistory(AFilterProc: TProc<TFDQuery>): TList<TMigrationsHistoryItem>;
var
  Query: TFDQuery;
  Item: TMigrationsHistoryItem;
  LComparison: TComparison<TMigrationsHistoryItem>;
  LComparer: IComparer<TMigrationsHistoryItem>;
begin
  Result := nil;

  Query := getQuery(Format('SELECT SEQUENCE,              ' +
                           '       VERSION,               ' +
                           '       DATETIME,              ' +
                           '       START_OF_EXECUTION,    ' +
                           '       END_OF_EXECUTION,      ' +
                           '       DURATION_OF_EXECUTION  ' +
                           '  FROM MIGRATIONS_INFO        ' , []));
  try
    if Assigned(AFilterProc) then AFilterProc(Query);

    if not Query.IsEmpty then
    begin
      LComparison := function(const Left, Right: TMigrationsHistoryItem): Integer
                     begin
                       Result := Left.MigrationSeq - Right.MigrationSeq;
                     end;
      LComparer := TComparer<TMigrationsHistoryItem>.Construct(LComparison) as TDelegatedComparer<TMigrationsHistoryItem>;

      Result := TObjectList<TMigrationsHistoryItem>.Create(LComparer);

      Query.First;
      while not Query.Eof do
      begin
        Item := TMigrationsHistoryItem.Create;
        Item.MigrationSeq := Query.Fields[0].AsInteger;
        Item.MigrationVersion := Query.Fields[1].AsString;
        Item.MigrationDateTime := Query.Fields[2].AsDateTime;
        Item.StartOfExecution := Query.Fields[3].AsDateTime;
        Item.EndOfExecution := Query.Fields[4].AsDateTime;
        Item.DurationOfExecution := Query.Fields[5].AsFloat;

        Result.Add(Item);

        Query.Next;
      end;

      Result.Sort;
    end;
  finally
    Query.Close;
    Query.DisposeOf;
  end;
end;

function TDBMigrationsHistory.getQuery(ASql: string; const AOpenQuery: Boolean): TFDQuery;
begin
  Result := TFDQuery.Create(nil);

  Result.Close;
  Result.Connection := FGetConnectionFunc;
  Result.SQL.Text := ASql;
  if AOpenQuery then Result.Open;
end;

function TDBMigrationsHistory.getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>;
begin
  Result := getHistory(procedure(AQuery: TFDQuery)
                       begin 
                         if Assigned(AQuery) then
                         begin
                           AQuery.SQL.Add('WHERE SEQUENCE >= :sequence');
                           AQuery.Params[0].AsInteger := AStartMigrationSeq;
                         end;
                       end);
end;

function TDBMigrationsHistory.getHistory: TList<TMigrationsHistoryItem>;
begin
  Result := getHistory(nil);
end;

function TDBMigrationsHistory.LastMigration: TMigrationsHistoryItem;
var
  Query: TFDQuery;
begin
  Result := nil;

  Query := getQuery('SELECT SEQUENCE,                           ' +
                    '       VERSION,                            ' +
                    '       DATETIME,                           ' +
                    '       START_OF_EXECUTION,                 ' +
                    '       END_OF_EXECUTION,                   ' +
                    '       DURATION_OF_EXECUTION               ' +
                    '  FROM MIGRATIONS_INFO                     ' +
                    ' WHERE SEQUENCE = (SELECT MAX(SEQUENCE)    ' +
                    '                     FROM MIGRATIONS_INFO) ' );
  try
    if not Query.Eof then
    begin
      Result := TMigrationsHistoryItem.Create;
      Result.MigrationSeq := Query.Fields[0].AsInteger;
      Result.MigrationVersion := Query.Fields[1].AsString;
      Result.MigrationDateTime := Query.Fields[2].AsDateTime;
      Result.StartOfExecution := Query.Fields[3].AsDateTime;
      Result.EndOfExecution := Query.Fields[4].AsDateTime;
      Result.DurationOfExecution := Query.Fields[5].AsFloat;
    end;
  finally
    Query.Close;
    Query.DisposeOf;
  end;

  //We have to control this item list to avoid memory leak
  if Assigned(FMigrationList) then FMigrationList.Add(Result);
end;

procedure TDBMigrationsHistory.Load;
begin

end;

procedure TDBMigrationsHistory.Remove(AMigrationSequence: Integer);
begin
  ExecuteDBCmd(Format('DELETE FROM MIGRATIONS_INFO WHERE SEQUENCE = %d', [AMigrationSequence]));
end;

procedure TDBMigrationsHistory.Save;
begin

end;

procedure TDBMigrationsHistory.UnLoad;
begin

end;

end.
