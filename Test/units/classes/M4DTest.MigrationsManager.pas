unit M4DTest.MigrationsManager;

interface

uses
  DUnitX.TestFramework, M4D.MigrationSerializerFacadeInterface,
  M4D.GetterMigrationsInterface, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationExecutorFacadeInterface, M4D.MigrationListOrderInterface,
  M4D.MigrationsRegisterInterface, M4D.MigrationsFacade;

type
  [TestFixture]
  TestMigrationsFacade = class
  private
    FMigrationSerializer: IMigrationSerializerFacade;
    FMigrationGetter: IGetterMigrations;
    FMigrationsHistory: IMigrationsHistoryFacade;
    FExecutor: IMigrationExecutorFacade;
    FMigrationListOrder: IMigrationListOrder;
    FMigrationsRegister: IMigrationsRegister;

    function instanceOfMigrationManagerWithRegisteredMigration: TMigrationsFacade;
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

procedure TestMigrationsFacade.CheckExecute;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.Execute;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckExecutePending;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.ExecutePending;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckExecuteRange;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.ExecuteRange(1, 1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckExecuteUntil;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.ExecuteUntil(1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckIfTheMigrationRegistrationAndRecoveryMechanismWorks;
var
  MigrationsManager: TMigrationsFacade;
  List: TList<TClass>;
begin
  MigrationsManager := TMigrationsFacade.Create;
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

procedure TestMigrationsFacade.CheckMigrationInfo;
var
  MigrationsManager: TMigrationsFacade;
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

procedure TestMigrationsFacade.CheckReturnOfGetterMigration;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.GetterMigration), 'The return of MigrationsManager.GetterMigration was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationExecutor;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationExecutorFacade), 'The return of MigrationsManager.MigrationExecutor was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationHistory;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationsHistoryFacade), 'The return of MigrationsManager.MigrationHistory was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationsHistory;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationsHistoryFacade), 'The return of MigrationsManager.MigrationsHistory was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationsRegister;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsManager.MigrationsRegister), 'The return of MigrationsManager.MigrationsRegister was not assigned.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckRollback;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.Rollback;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckRollbackRange;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.RollbackRange(1, 1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckRollbackUntil;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := instanceOfMigrationManagerWithRegisteredMigration;
  try
    MigrationsManager.RollbackUntil(1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckTheCreationWithoutParameters;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := TMigrationsFacade.Create;
  try
    Assert.Pass('If get this point, the create works fine.');
  finally
    MigrationsManager.Free;
  end;
end;

procedure TestMigrationsFacade.CheckTheCreationWithParameters;
var
  MigrationsManager: TMigrationsFacade;
begin
  MigrationsManager := TMigrationsFacade.Create(FMigrationsHistory, FMigrationGetter, FMigrationsRegister, FExecutor);
  try
    Assert.Pass('If get this point, the create works fine.');
  finally
    MigrationsManager.Free;
  end;
end;

function TestMigrationsFacade.instanceOfMigrationManagerWithRegisteredMigration: TMigrationsFacade;
begin
  Result := TMigrationsFacade.Create;
  Result.RegisterMigration(TestStubClass);
end;

procedure TestMigrationsFacade.Setup;
begin
  FMigrationSerializer := M4D.Defaults.TDefaultInstanceOfMigrationsSerializerFacadeCreator.getInstance;
  FMigrationsHistory := M4D.Defaults.TDefaultInstanceOfMigrationsHistoryCreator.getInstance(FMigrationSerializer);
  FMigrationGetter := M4D.Defaults.TDefaultInstanceOfMigrationGetterCreator.getInstance;
  FMigrationListOrder := M4D.Defaults.TDefaultInstanceOfMigrationListOrderCreator.getInstance;
  FMigrationsRegister := M4D.Defaults.TDefaultInstanceOfMigrationsRegisterCreator.getInstance(FMigrationListOrder);
  FExecutor := M4D.Defaults.TDefaultInstanceOfMigrationExecutorCreator.getInstance(FMigrationsHistory);
end;

procedure TestMigrationsFacade.TearDown;
begin

end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsFacade);

end.
