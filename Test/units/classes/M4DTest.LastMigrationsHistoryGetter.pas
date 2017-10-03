unit M4DTest.LastMigrationsHistoryGetter;

interface

uses
  DUnitX.TestFramework, System.Generics.Collections, M4D.MigrationsHistoryItem;

type
  TestLastMigrationsHistoryGetter = class
  private
    FItem: TMigrationsHistoryItem;
    FHistoryList: TObjectList<TMigrationsHistoryItem>;

    procedure CreateGetterWithNoHistory;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckIfParameterAHistoryListCouldBeNil;
    [Test]
    procedure CheckIfGetTheLastMigration;
  end;

implementation

uses
  M4D.LastMigrationsHistoryGetterInterface, M4D.LastMigrationsHistoryGetter;

{ TestLastMigrationsHistoryGetter }

procedure TestLastMigrationsHistoryGetter.CheckIfGetTheLastMigration;
var
  Getter: ILastMigrationsHistoryGetter;
  LItem: TMigrationsHistoryItem;
begin
  Getter := TLastMigrationsHistoryGetter.Create(FHistoryList);
  LItem := Getter.LastMigration;

  Assert.IsTrue(LItem.MigrationSeq = 2, 'The TLastMigrationsHistoryGetter was not returning the correct last migration.');
end;

procedure TestLastMigrationsHistoryGetter.CheckIfParameterAHistoryListCouldBeNil;
begin
  Assert.WillRaiseAny(CreateGetterWithNoHistory, 'The parameter AHistoryList mjuust not be nil.');
end;

procedure TestLastMigrationsHistoryGetter.CreateGetterWithNoHistory;
var
  Getter: ILastMigrationsHistoryGetter;
begin
  Getter := TLastMigrationsHistoryGetter.Create(nil);
end;

procedure TestLastMigrationsHistoryGetter.Setup;
begin
  FHistoryList := TObjectList<TMigrationsHistoryItem>.Create;

  FItem := TMigrationsHistoryItem.Create;
  FItem.MigrationSeq := 1;

  FHistoryList.Add(FItem);

  FItem := TMigrationsHistoryItem.Create;
  FItem.MigrationSeq := 2;

  FHistoryList.Add(FItem);
end;

procedure TestLastMigrationsHistoryGetter.TearDown;
begin
  FHistoryList.Clear;
  if Assigned(FHistoryList) then FHistoryList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestLastMigrationsHistoryGetter);

end.
