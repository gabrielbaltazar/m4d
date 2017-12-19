unit M4DTest.MigrationsFacade;

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

    function instanceOfMigrationFacadeWithRegisteredMigration: TMigrationsFacade;
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

{ TestMigrationsFacade }

procedure TestMigrationsFacade.CheckExecute;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    MigrationsFacade.Execute;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckExecutePending;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    MigrationsFacade.ExecutePending;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckExecuteRange;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    MigrationsFacade.ExecuteRange(1, 1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckExecuteUntil;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    MigrationsFacade.ExecuteUntil(1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckIfTheMigrationRegistrationAndRecoveryMechanismWorks;
var
  MigrationsFacade: TMigrationsFacade;
  List: TList<TClass>;
begin
  MigrationsFacade := TMigrationsFacade.Create;
  try
    MigrationsFacade.RegisterMigration(TestStubClass);
    List := MigrationsFacade.MigrationsRegister.Migrations;
//    try
      Assert.IsTrue(List.Count = 1, 'The quantity of registered migration is wrong.');
//    finally
//      if Assigned(List) then List.Free;
//    end;
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckMigrationInfo;
var
  MigrationsFacade: TMigrationsFacade;
  Migration: IMigration;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    Migration := MigrationsFacade.MigrationInfo(TestStubClass);
    Assert.isTrue(Assigned(Migration), 'The migration could not be returned.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfGetterMigration;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsFacade.GetterMigration), 'The return of MigrationsFacade.GetterMigration was not assigned.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationExecutor;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsFacade.MigrationExecutorFacade), 'The return of MigrationsFacade.MigrationExecutor was not assigned.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationHistory;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsFacade.MigrationsHistoryFacade), 'The return of MigrationsFacade.MigrationHistory was not assigned.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationsHistory;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsFacade.MigrationsHistoryFacade), 'The return of MigrationsFacade.MigrationsHistory was not assigned.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckReturnOfMigrationsRegister;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    Assert.isTrue(Assigned(MigrationsFacade.MigrationsRegister), 'The return of MigrationsFacade.MigrationsRegister was not assigned.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckRollback;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    MigrationsFacade.Rollback;
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckRollbackRange;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    MigrationsFacade.RollbackRange(1, 1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckRollbackUntil;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := instanceOfMigrationFacadeWithRegisteredMigration;
  try
    MigrationsFacade.RollbackUntil(1);
    Assert.Pass('If get in this point, works well.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckTheCreationWithoutParameters;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := TMigrationsFacade.Create;
  try
    Assert.Pass('If get this point, the create works fine.');
  finally
    MigrationsFacade.Free;
  end;
end;

procedure TestMigrationsFacade.CheckTheCreationWithParameters;
var
  MigrationsFacade: TMigrationsFacade;
begin
  MigrationsFacade := TMigrationsFacade.Create(FMigrationsHistory, FMigrationGetter, FMigrationsRegister, FExecutor);
  try
    Assert.Pass('If get this point, the create works fine.');
  finally
    MigrationsFacade.Free;
  end;
end;

function TestMigrationsFacade.instanceOfMigrationFacadeWithRegisteredMigration: TMigrationsFacade;
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
