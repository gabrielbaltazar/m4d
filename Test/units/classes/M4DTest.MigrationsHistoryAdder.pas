unit M4DTest.MigrationsHistoryAdder;

interface

uses
  DUnitX.TestFramework, M4D.MigrationsHistoryItem, System.Generics.Collections,
  System.Generics.Defaults;

type
  [TestFixture]
  TestMigrationsHistoryAdder = class
  private
    FComparison: TComparison<TMigrationsHistoryItem>;
    FCompare: IComparer<TMigrationsHistoryItem>;
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FItem: TMigrationsHistoryItem;

    procedure CreateHistoryAdderWithNoHistoryList;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckIfParameterAHistoryListCouldBeNil;
    [Test]
    procedure CheckAdd;
  end;

implementation

uses
  M4D.MigrationsHistoryAdder, M4D.MigrationsHistoryAdderInterface;

{ TestMigrationsHistoryAdder }

procedure TestMigrationsHistoryAdder.CheckAdd;
var
  Adder: IMigrationsHistoryAdder;
begin
  Adder := TMigrationsHistoryAdder.Create(FHistoryList);
  Adder.Add(FItem);
  Assert.Pass('If get this point, must be passed.');
end;

procedure TestMigrationsHistoryAdder.CheckIfParameterAHistoryListCouldBeNil;
begin
  Assert.WillRaiseAny(CreateHistoryAdderWithNoHistoryList, 'The parameter AHistoryList must be nil.');
end;

procedure TestMigrationsHistoryAdder.CreatehistoryAdderWithNoHistoryList;
var
  History: IMigrationsHistoryAdder;
begin
  History := TMigrationsHistoryAdder.Create(nil);
end;

procedure TestMigrationsHistoryAdder.Setup;
begin
  FComparison := function(const Left, Right: TMigrationsHistoryItem): Integer
                 begin
                   Result := Left.MigrationSeq - Right.MigrationSeq;
                 end;

  FCompare := TComparer<TMigrationsHistoryItem>.Construct(FComparison) as TDelegatedComparer<TMigrationsHistoryItem>;
  FHistoryList := TObjectList<TMigrationsHistoryItem>.Create(FCompare, False);

  FItem := TMigrationsHistoryItem.Create;
end;

procedure TestMigrationsHistoryAdder.TearDown;
begin
  if Assigned(FHistoryList) then FHistoryList.Free;
  if Assigned(FItem) then FItem.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsHistoryAdder);

end.
