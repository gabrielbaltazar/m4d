unit M4DTest.HistoryGetter;

interface

uses
  DUnitX.TestFramework, System.Generics.Collections, M4D.MigrationsHistoryItem;

type
  [TestFixture]
  TestMigrationHistoryGetter = class
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FItem: TMigrationsHistoryItem;

    procedure CreateGetterWithNoHistory;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckIfParameterAHistoryListCouldBeNil;
    [Test]
    procedure CheckIfGetTheAList;
  end;

implementation

uses
  M4D.HistoryGetterInterface, M4D.HistoryGetter;


{ TestMigrationHistoryGetter }

procedure TestMigrationHistoryGetter.CheckIfGetTheAList;
var
  Getter: IMigrationHistoryGetter;
  List: TList<TMigrationsHistoryItem>;
begin
  Getter := TMigrationHistoryGetter.Create(FHistoryList);
  List := Getter.getHistory(function(Item: TMigrationsHistoryItem): Boolean
                            begin
                              Result := Item.MigrationSeq = 2;
                            end);
  try
    Assert.IsTrue(List.Count = 1, 'The return of the function is a wrong list.');
  finally
    List.Clear;
    List.Free;
  end;
end;

procedure TestMigrationHistoryGetter.CheckIfParameterAHistoryListCouldBeNil;
begin
  Assert.WillRaiseAny(CreateGetterWithNoHistory, 'The parameter AHistoryList mjuust not be nil.');
end;

procedure TestMigrationHistoryGetter.CreateGetterWithNoHistory;
var
  Getter: IMigrationHistoryGetter;
begin
  Getter := TMigrationHistoryGetter.Create(nil);
end;

procedure TestMigrationHistoryGetter.Setup;
begin
  FHistoryList := TObjectList<TMigrationsHistoryItem>.Create;

  FItem := TMigrationsHistoryItem.Create;
  FItem.MigrationSeq := 1;

  FHistoryList.Add(FItem);

  FItem := TMigrationsHistoryItem.Create;
  FItem.MigrationSeq := 2;

  FHistoryList.Add(FItem);
end;

procedure TestMigrationHistoryGetter.TearDown;
begin
  FHistoryList.Clear;
  if Assigned(FHistoryList) then FHistoryList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationHistoryGetter);

end.
