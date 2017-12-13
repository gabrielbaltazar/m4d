unit M4DTest.MigrationRollbackExecutor;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationsHistoryItem;

type
  [TestFixture]
  TestMigrationRollbackExecutor = class
  private
    FMigrationsList: TList<TClass>;
    FMigrationHistory: IMigrationsHistoryFacade;
    FMigrationHistoryItem: TMigrationsHistoryItem;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckRollback;
  end;


implementation

uses
  M4D.MigrationRollbackExecutorInterface, M4D.MigrationRollbackExecutor,
  M4DTest.MStubMigrationToTest, M4DTest.MigrationsHistoryMock, System.SysUtils;

{ TestMigrationRollbackExecutor }

procedure TestMigrationRollbackExecutor.CheckRollback;
var
  Executor: IMigrationRollbackExecutor;
begin
  Executor := TMigrationRollbackExecutor.Create;
  Executor.Rollback(FMigrationsList, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationRollbackExecutor.Setup;
begin
  FMigrationsList := TList<TClass>.Create;
  FMigrationsList.Add(TestStubClass);
  FMigrationHistory := TMigrationsHistoryMock.Create;

  FMigrationHistoryItem := TMigrationsHistoryItem.Create;
  FMigrationHistoryItem.MigrationVersion := '1';
  FMigrationHistoryItem.MigrationSeq := 1;
  FMigrationHistoryItem.MigrationDateTime := Now;

  FMigrationHistory.Add(FMigrationHistoryItem);
end;

procedure TestMigrationRollbackExecutor.TearDown;
begin
//  if Assigned(FMigrationHistoryItem) then FMigrationHistoryItem.Free;
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationRollbackExecutor);

end.
