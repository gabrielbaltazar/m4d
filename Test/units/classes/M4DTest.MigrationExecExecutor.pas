unit M4DTest.MigrationExecExecutor;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationSerializerFacadeInterface;

type
  [TestFixture]
  TestMigrationExecExecutor = class(TObject)
  private
    FMigrationsList: TList<TClass>;
    FMigrationHistory: IMigrationsHistoryFacade;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckTheExecution;
    [Test]
    procedure ChecksWhetherExecutionConditionPreventsExecution;
  end;

implementation

uses
  M4D.MigrationsHistoryFacade, M4D.MigrationSerializerFacade,
  M4D.MigrationExecExecutorInterface, M4D.MigrationExecExecutor,
  M4DTest.MStubMigrationToTest, M4DTest.MStubMigrationNotExecuteUpNeitherDown,
  M4DTest.MigrationsHistoryMock;

{ TestMigrationExecExecutor }

procedure TestMigrationExecExecutor.ChecksWhetherExecutionConditionPreventsExecution;
var
  Executor: IMigrationExecExecutor;
begin
  FMigrationsList.Add(TestStubClassNotExecuteUpNeitherDown);

  Executor := TMigrationExecExecutor.Create;
  Executor.Execute(FMigrationsList, FMigrationHistory);

  {TODO: Find a way to check this}
  Assert.Pass('If get this point, the execution run well.');
end;

procedure TestMigrationExecExecutor.CheckTheExecution;
var
  Executor: IMigrationExecExecutor;
begin
  FMigrationsList.Add(TestStubClass);

  Executor := TMigrationExecExecutor.Create;
  Executor.Execute(FMigrationsList, FMigrationHistory);

  Assert.Pass('If get this point, the execution run well.');
end;

procedure TestMigrationExecExecutor.Setup;
begin
  FMigrationsList := TList<TClass>.Create;
  FMigrationsList.Clear;

  FMigrationHistory := TMigrationsHistoryMock.Create;
end;

procedure TestMigrationExecExecutor.TearDown;
begin
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationExecExecutor);


end.
