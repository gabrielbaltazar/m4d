unit M4DTest.MigrationExecPendingExecutor;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MigrationExecPendingExecutorInterface,
  M4D.MigrationsHistoryInterface, M4D.MigrationsHistoryItem,
  M4D.MigrationExecExecutorInterface;

type
  TestMigrationExecPendingExecutor = class
  private
    FMigrationsList: TList<TClass>;
    FMigrationHistory: IMigrationsHistory;
    FMigrationHistoryItem: TMigrationsHistoryItem;
    FExecutor: IMigrationExecExecutor;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckExecutePending;
  end;

implementation

uses
  M4D.MigrationExecPendingExecutor, M4D.MigrationExecExecutor,
  M4DTest.MStubMigrationToTest, M4DTest.MigrationsHistoryMock, System.SysUtils;

{ TestMigrationExecPendingExecutor }

procedure TestMigrationExecPendingExecutor.CheckExecutePending;
var
  Executor: IMigrationExecPendingExecutor;
begin
  Executor := TMigrationExecPendingExecutor.Create(FExecutor);
  Executor.ExecutePending(FMigrationsList, FMigrationHistoryItem, FMigrationHistory);

  Assert.Pass('If get this point, the execution runs well.');
end;

procedure TestMigrationExecPendingExecutor.Setup;
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

procedure TestMigrationExecPendingExecutor.TearDown;
begin
  if Assigned(FMigrationHistoryItem) then FMigrationHistoryItem.Free;
  
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationExecPendingExecutor);

end.
