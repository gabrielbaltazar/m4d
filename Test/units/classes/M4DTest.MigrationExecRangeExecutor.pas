unit M4DTest.MigrationExecRangeExecutor;

interface

uses
  DUnitX.TestFramework, M4D.MigrationExecExecutorInterface,
  M4D.MigrationsHistoryItem, Generics.Collections,
  M4D.MigrationsHistoryFacadeInterface;

type
  [TestFixture]
  TestMigrationExecRangeExecutor = class
  private
    FMigrationsList: TList<TClass>;
    FMigrationHistory: IMigrationsHistoryFacade;
    FMigrationHistoryItem: TMigrationsHistoryItem;
    FExecutor: IMigrationExecExecutor;

    procedure CreateWithExecutorParameterEqualNil;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckExecuteRange;
    [Test]
    procedure CheckIfRaiseWhenNotPassExecutorParameter;
  end;

implementation

uses
  M4D.MigrationExecRangeExecutor, M4D.MigrationExecRangeExecutorInterface,
  M4D.MigrationExecExecutor, M4DTest.MStubMigrationToTest,
  M4DTest.MigrationsHistoryMock, System.SysUtils;

{ TestMigrationRollbackRangeExecutor }

procedure TestMigrationExecRangeExecutor.CheckExecuteRange;
var
  Executor: IMigrationExecRangeExecutor;
begin
  Executor := TMigrationExecRangeExecutor.Create(FExecutor);
  Executor.ExecuteRange(FMigrationsList, FMigrationHistory, 1, 1);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecRangeExecutor.CheckIfRaiseWhenNotPassExecutorParameter;
begin
  Assert.WillRaiseAny(CreateWithExecutorParameterEqualNil, 'A exception must raise when passing nil to the TMigrationExecRangeExecutor constructor.');
end;

procedure TestMigrationExecRangeExecutor.CreateWithExecutorParameterEqualNil;
var
  Executor: IMigrationExecRangeExecutor;
begin
  Executor := TMigrationExecRangeExecutor.Create(nil);
end;

procedure TestMigrationExecRangeExecutor.Setup;
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

procedure TestMigrationExecRangeExecutor.TearDown;
begin
  if Assigned(FMigrationHistoryItem) then FMigrationHistoryItem.Free;
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationExecRangeExecutor);

end.
