unit M4DTest.MigrationsHistoryRemover;

interface

uses
  DUnitX.TestFramework, System.Generics.Collections, M4D.MigrationsHistoryItem,
  System.Generics.Defaults;

type
  [TestFixture]
  TestMigrationsHistoryRemover = class
  private
    FComparison: TComparison<TMigrationsHistoryItem>;
    FCompare: IComparer<TMigrationsHistoryItem>;
    FItem: TMigrationsHistoryItem;
    FHistoryList: TObjectList<TMigrationsHistoryItem>;

    procedure CreateHistoryRemoverWithNoHistoryList;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckIfParameterAHistoryListCouldBeNil;
    [Test]
    procedure CheckIfTheItemWasRemoved;
  end;

implementation

uses
  M4D.MigrationsHistoryRemoverInterface, M4D.MigrationsHistoryRemover;


{ TestMigrationsHistoryRemover }

procedure TestMigrationsHistoryRemover.CheckIfParameterAHistoryListCouldBeNil;
begin
  Assert.WillRaiseAny(CreateHistoryRemoverWithNoHistoryList, 'The parameter AHistoryList must be nil.');
end;

procedure TestMigrationsHistoryRemover.CheckIfTheItemWasRemoved;
var
  History: IMigrationsHistoryRemover;
begin
  History := TMigrationsHistoryRemover.Create(FHistoryList);
  History.Remove(1);
  Assert.IsTrue(FHistoryList.Count = 0, 'There is a problema with the remove of a history item.');
end;

procedure TestMigrationsHistoryRemover.CreateHistoryRemoverWithNoHistoryList;
var
  History: IMigrationsHistoryRemover;
begin
  History := TMigrationsHistoryRemover.Create(nil);
end;

procedure TestMigrationsHistoryRemover.Setup;
begin
  FItem := TMigrationsHistoryItem.Create;
  FComparison := function(const Left, Right: TMigrationsHistoryItem): Integer
                 begin
                   Result := Left.MigrationSeq - Right.MigrationSeq;
                 end;

  FCompare := TComparer<TMigrationsHistoryItem>.Construct(FComparison) as TDelegatedComparer<TMigrationsHistoryItem>;
  FHistoryList := TObjectList<TMigrationsHistoryItem>.Create(FCompare, False);
  FItem.MigrationSeq := 1;
  FHistoryList.Add(FItem);
end;

procedure TestMigrationsHistoryRemover.TearDown;
begin
  if Assigned(FItem) then FItem.Free;
  if Assigned(FHistoryList) then FHistoryList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsHistoryRemover);

end.
