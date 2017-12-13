unit M4DTest.MigrationsHistoryMock;

interface

uses
  generics.Collections, M4D.MigrationsHistoryItem,
  M4D.MigrationsHistoryFacadeInterface;

type
  [TestFixture]
  TMigrationsHistoryMock = class(TInterfacedObject, IMigrationsHistoryFacade)
  public
    procedure Clear;
    procedure Load;
    procedure UnLoad;
    procedure Add(AItem: TMigrationsHistoryItem);
    procedure Remove(AMigrationSequence: Integer);
    function getHistory: TList<TMigrationsHistoryItem>; overload;
    function getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    function getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;
    procedure Save;
    function LastMigration: TMigrationsHistoryItem;
    property HistoryList: TList<TMigrationsHistoryItem> read getHistory;
  end;

implementation

{ TMigrationsHistoryMock }

procedure TMigrationsHistoryMock.Add(AItem: TMigrationsHistoryItem);
begin
  if Assigned(AItem) then AItem.Free;  
end;

procedure TMigrationsHistoryMock.Clear;
begin
  //Do nothing
end;

function TMigrationsHistoryMock.getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>;
begin
  Result := nil;
end;

function TMigrationsHistoryMock.getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>;
begin
  Result := nil;
end;

function TMigrationsHistoryMock.getHistory: TList<TMigrationsHistoryItem>;
begin
  Result := nil;
end;

function TMigrationsHistoryMock.LastMigration: TMigrationsHistoryItem;
begin
  Result := nil;
end;

procedure TMigrationsHistoryMock.Load;
begin
  //Do nothing
end;

procedure TMigrationsHistoryMock.Remove(AMigrationSequence: Integer);
begin
  //Do nothing
end;

procedure TMigrationsHistoryMock.Save;
begin
  //Do nothing
end;

procedure TMigrationsHistoryMock.UnLoad;
begin
  //Do nothing
end;

end.
