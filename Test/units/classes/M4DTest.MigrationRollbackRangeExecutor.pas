unit M4DTest.MigrationRollbackRangeExecutor;

interface

uses
  DUnitX.TestFramework, M4D.MigrationRollbackExecutorInterface,
  M4D.MigrationsHistoryItem, Generics.Collections,
  M4D.MigrationsHistoryInterface;

type
  [TestFixture]
  TestMigrationRollbackRangeExecutor = class
  private
    FMigrationsList: TList<TClass>;
    FMigrationHistory: IMigrationsHistory;
    FMigrationHistoryItem: TMigrationsHistoryItem;
    FExecutor: IMigrationRollbackExecutor;

    procedure CreateWithExecutorParameterEqualNil;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckRollbackRange;
    [Test]
    procedure CheckIfRaiseWhenNotPassExecutorParameter;
  end;

implementation

uses
  M4D.MigrationRollbackRangeExecutor, M4D.MigrationRollbackExecutor,
  M4DTest.MStubMigrationToTest,
  M4DTest.MigrationsHistoryMock, System.SysUtils,
  M4D.MigrationRollbackRangeExecutorInterface;

{ TestMigrationRollbackRangeExecutor }

procedure TestMigrationRollbackRangeExecutor.CheckRollbackRange;
var
  Executor: IMigrationRollbackRangeExecutor;
begin
  Executor := TMigrationRollbackRangeExecutor.Create(FExecutor);
  Executor.RollbackRange(FMigrationsList, FMigrationHistory, 1, 1);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationRollbackRangeExecutor.CheckIfRaiseWhenNotPassExecutorParameter;
begin
  Assert.WillRaiseAny(CreateWithExecutorParameterEqualNil, 'A exception must raise when passing nil to the TMigrationExecRangeExecutor constructor.');
end;

procedure TestMigrationRollbackRangeExecutor.CreateWithExecutorParameterEqualNil;
var
  Executor: IMigrationRollbackRangeExecutor;
begin
  Executor := TMigrationRollbackRangeExecutor.Create(nil);
end;

procedure TestMigrationRollbackRangeExecutor.Setup;
begin
  FMigrationsList := TList<TClass>.Create;
  FMigrationsList.Add(TestStubClass);
  FMigrationHistory := TMigrationsHistoryMock.Create;

  FMigrationHistoryItem := TMigrationsHistoryItem.Create;
  FMigrationHistoryItem.MigrationVersion := '1';
  FMigrationHistoryItem.MigrationSeq := 1;
  FMigrationHistoryItem.MigrationDateTime := Now;

  FExecutor := TMigrationRollbackExecutor.Create;
end;

procedure TestMigrationRollbackRangeExecutor.TearDown;
begin
  if Assigned(FMigrationHistoryItem) then FMigrationHistoryItem.Free;
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationRollbackRangeExecutor);

end.

