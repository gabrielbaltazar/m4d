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
  end;

implementation

uses
  M4D.MigrationsHistoryFacade, M4D.MigrationSerializerFacade,
  M4D.MigrationExecExecutorInterface, M4D.MigrationExecExecutor,
  M4DTest.MStubMigrationToTest, M4DTest.MigrationsHistoryMock;

{ TestMigrationExecExecutor }

procedure TestMigrationExecExecutor.CheckTheExecution;
var
  Executor: IMigrationExecExecutor;
begin
  Executor := TMigrationExecExecutor.Create;
  Executor.Execute(FMigrationsList, FMigrationHistory);

  Assert.Pass('If get this point, the execution run well.');
end;

procedure TestMigrationExecExecutor.Setup;
begin
  FMigrationsList := TList<TClass>.Create;
  FMigrationsList.Add(TestStubClass);
  FMigrationHistory := TMigrationsHistoryMock.Create;
end;

procedure TestMigrationExecExecutor.TearDown;
begin
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationExecExecutor);


end.
