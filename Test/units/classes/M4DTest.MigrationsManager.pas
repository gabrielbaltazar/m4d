unit M4DTest.MigrationsManager;

interface

uses
  DUnitX.TestFramework, M4D.MigrationSerializerInterface,
  M4D.GetterMigrationsInterface, M4D.MigrationsHistoryInterface,
  M4D.MigrationExecutorInterface, M4D.MigrationListOrderInterface,
  M4D.MigrationsRegisterInterface, M4D.MigrationsManager;

type
  [TestFixture]
  TestMigrationsManager = class
  private
    FMigrationSerializer: IMigrationSerializer;
    FMigrationGetter: IGetterMigrations;
    FMigrationsHistory: IMigrationsHistory;
    FExecutor: IMigrationExecutor;
    FMigrationListOrder: IMigrationListOrder;
    FMigrationsRegister: IMigrationsRegister;

    function instanceOfMigrationManagerWithRegisteredMigration: TMigrationsManager;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckTheCreationWithParameters;
    [Test]
    procedure CheckTheCreationWithoutParameters;
    [Test]
    procedure CheckIfTheMigrationRegistrationAndRecoveryMechanismWorks;
    [Test]
    procedure CheckExecute;
    [Test]
    procedure CheckExecutePending;
    [Test]
    procedure CheckExecuteUntil;
    [Test]
    procedure CheckExecuteRange;
    [Test]
    procedure CheckRollback;
    [Test]
    procedure CheckRollbackUntil;
    [Test]
    procedure CheckRollbackRange;
    [Test]
    procedure CheckMigrationInfo;
    [Test]
    procedure CheckReturnOfMigrationHistory;
    [Test]
    procedure CheckReturnOfMigrationsRegister;
    [Test]
    procedure CheckReturnOfGetterMigration;
    [Test]
    procedure CheckReturnOfMigrationsHistory;
    [Test]
    procedure CheckReturnOfMigrationExecutor;
  end;

implementation

uses
  M4D.Defaults, M4DTest.MStubMigrationToTest, Generics.Collections,
  M4D.MigrationsInterface;

{ TestMigrationsManager }

procedure TestMigrationsManager.CheckExecute;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.Execute;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckExecutePending;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.ExecutePending;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckExecuteRange;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.ExecuteRange(1, 1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckExecuteUntil;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.ExecuteUntil(1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckIfTheMigrationRegistrationAndRecoveryMechanismWorks;
var
  MigrationsManager: TMigrationsManager;
  List: TList<TClass>;
begin
  MigrationsManager := TMigrationsManager.Create;
  try
    MigrationsManager.RegisterMigration(TestStubClass);
    List := MigrationsManager.MigrationsRegister.Migrations;
//    try
      Assert.IsTrue(List.Count = 1, 'The quantity of registered migration is wrong.');
//    finally
//      if Assigned(List) then List.Free;
//    end;
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckMigrationInfo;
var
  MigrationsManager: TMigrationsManager;
  Migration: IMigration;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Migration := MigrationsManager.MigrationInfo(TestStubClass);
    Assert.isTrue(Assigned(Migration), 'The migration could not be returned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckReturnOfGetterMigration;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.GetterMigration), 'The return of MigrationsManager.GetterMigration was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckReturnOfMigrationExecutor;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationExecutor), 'The return of MigrationsManager.MigrationExecutor was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckReturnOfMigrationHistory;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationsHistory), 'The return of MigrationsManager.MigrationHistory was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckReturnOfMigrationsHistory;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationsHistory), 'The return of MigrationsManager.MigrationsHistory was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckReturnOfMigrationsRegister;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationsRegister), 'The return of MigrationsManager.MigrationsRegister was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckRollback;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.Rollback;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckRollbackRange;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.RollbackRange(1, 1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckRollbackUntil;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.RollbackUntil(1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckTheCreationWithoutParameters;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := TMigrationsManager.Create;
  try
    Assert.Pass('If get this point, the create works fine.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsManager.CheckTheCreationWithParameters;
var
  MigrationsManager: TMigrationsManager;
begin
  MigrationsManager := TMigrationsManager.Create(FMigrationsHistory, FMigrationGetter, FMigrationsRegister, FExecutor);
  try
    Assert.Pass('If get this point, the create works fine.');
  finally
    MigrationsManager.Free;
  end;
end;

function TestMigrationsManager.instanceOfMigrationManagerWithRegisteredMigration: TMigrationsManager;
begin
  Result := TMigrationsManager.Create;
  Result.RegisterMigration(TestStubClass);
end;

procedure TestMigrationsManager.Setup;
begin
  FMigrationSerializer := M4D.Defaults.TDefaultInstanceOfMigrationsSerializerCreator.getInstance;
  FMigrationsHistory := M4D.Defaults.TDefaultInstanceOfMigrationsHistoryCreator.getInstance(FMigrationSerializer);
  FMigrationGetter := M4D.Defaults.TDefaultInstanceOfMigrationGetterCreator.getInstance;
  FMigrationListOrder := M4D.Defaults.TDefaultInstanceOfMigrationListOrderCreator.getInstance;
  FMigrationsRegister := M4D.Defaults.TDefaultInstanceOfMigrationsRegisterCreator.getInstance(FMigrationListOrder);
  FExecutor := M4D.Defaults.TDefaultInstanceOfMigrationExecutorCreator.getInstance(FMigrationsHistory);
end;

procedure TestMigrationsManager.TearDown;
begin

end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsManager);

end.
