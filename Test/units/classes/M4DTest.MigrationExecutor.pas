unit M4DTest.MigrationExecutor;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationsHistoryItem, M4D.MigrationExecExecutorInterface;

type
  [TestFixture]
  TestMigrationExecutor = class
  private
    FMigrationsList: TList<TClass>;
    FMigrationHistory: IMigrationsHistoryFacade;
    FMigrationHistoryItem: TMigrationsHistoryItem;
    FMigrationExecExecutor: IMigrationExecExecutor;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckExecute;
    [Test]
    procedure CheckExecutePending;
    [Test]
    procedure CheckExecuteUntil;
    [Test]
    procedure CheckRollback;
    [Test]
    procedure CheckRollbackUntil;
    [Test]
    procedure CheckGetMigrationsHistory;
  end;

implementation

uses
  M4DTest.MStubMigrationToTest, M4DTest.MigrationsHistoryMock, M4D.MigrationExecExecutor,
  System.SysUtils, M4D.MigrationExecPendingExecutorInterface,
  M4D.MigrationExecPendingExecutor, M4D.MigrationExecUntilExecutorInterface,
  M4D.MigrationExecUntilExecutor, M4D.MigrationExecutorFacadeInterface, M4D.MigrationExecutorFacade;

{ TestMigrationExecutor }

procedure TestMigrationExecutor.CheckExecute;
var
  Executor: IMigrationExecutorFacade;
begin
  Executor := TMigrationExecutorFacade.Create(FMigrationHistory);
  Executor.Execute(FMigrationsList, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecutor.CheckExecutePending;
var
  Executor: IMigrationExecutorFacade;
begin
  Executor := TMigrationExecutorFacade.Create(FMigrationHistory);
  Executor.ExecutePending(FMigrationsList, FMigrationHistoryItem, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecutor.CheckExecuteUntil;
var
  Executor: IMigrationExecutorFacade;
begin
  Executor := TMigrationExecutorFacade.Create(FMigrationHistory);
  Executor.ExecuteUntil(FMigrationsList, 1, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecutor.CheckGetMigrationsHistory;
var
  Executor: IMigrationExecutorFacade;
begin
  Executor := TMigrationExecutorFacade.Create(FMigrationHistory);
  Assert.IsTrue(Assigned(Executor.MigrationHistoryFacade), 'The Migration History here must be assigned');
end;

procedure TestMigrationExecutor.CheckRollback;
var
  Executor: IMigrationExecutorFacade;
begin
  Executor := TMigrationExecutorFacade.Create(FMigrationHistory);
  Executor.Rollback(FMigrationsList, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecutor.CheckRollbackUntil;
var
  Executor: IMigrationExecutorFacade;
begin
  Executor := TMigrationExecutorFacade.Create(FMigrationHistory);
  Executor.RollbackUntil(FMigrationsList, 1, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecutor.Setup;
begin
  FMigrationsList := TList<TClass>.Create;
  FMigrationsList.Add(TestStubClass);
  FMigrationHistory := TMigrationsHistoryMock.Create;

  FMigrationHistoryItem := TMigrationsHistoryItem.Create;
  FMigrationHistoryItem.MigrationVersion := '1';
  FMigrationHistoryItem.MigrationSeq := 1;
  FMigrationHistoryItem.MigrationDateTime := Now;

  FMigrationExecExecutor := TMigrationExecExecutor.Create;
end;

procedure TestMigrationExecutor.TearDown;
begin
  if Assigned(FMigrationHistoryItem) then FMigrationHistoryItem.Free;
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationExecutor);

end.
