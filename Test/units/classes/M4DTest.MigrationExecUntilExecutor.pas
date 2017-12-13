unit M4DTest.MigrationExecUntilExecutor;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MigrationExecExecutorInterface,
  M4D.MigrationsHistoryFacadeInterface, M4D.MigrationsHistoryItem;


type
  [TestFixture]
  TestMigrationExecUntilExecutor = class
  private
    FMigrationsList: TList<TClass>;
    FMigrationHistory: IMigrationsHistoryFacade;
    FMigrationHistoryItem: TMigrationsHistoryItem;
    FExecutor: IMigrationExecExecutor;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckExecuteUntil;
  end;

implementation

uses
  M4D.MigrationExecUntilExecutor, M4D.MigrationExecExecutor, M4DTest.MStubMigrationToTest,
  M4DTest.MigrationsHistoryMock, M4D.MigrationExecUntilExecutorInterface,
  System.SysUtils;

{ TestMigrationExecUntilExecutor }

procedure TestMigrationExecUntilExecutor.CheckExecuteUntil;
var
  Executor: IMigrationExecUntilExecutor;
begin
  Executor := TMigrationExecUntilExecutor.Create(FExecutor);
  Executor.ExecuteUntil(FMigrationsList, 1, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecUntilExecutor.Setup;
begin
  FMigrationsList := TList<TClass>.Create;
  FMigrationsList.Add(TestStubClass);
  FMigrationHistory := TMigrationsHistoryMock.Create;

  FMigrationHistoryItem := TMigrationsHistoryItem.Create;
  FMigrationHistoryItem.MigrationVersion := '1';
  FMigrationHistoryItem.MigrationSeq := 1;
  FMigrationHistoryItem.MigrationDateTime := Now;

  FExecutor := TMigrationExecExecutor.Create;
end;

procedure TestMigrationExecUntilExecutor.TearDown;
begin
  if Assigned(FMigrationHistoryItem) then FMigrationHistoryItem.Free;
  if Assigned(FMigrationsList) then FMigrationsList.Free;  
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationExecUntilExecutor);

end.
