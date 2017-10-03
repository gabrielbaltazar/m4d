unit M4DTestUnit;

interface

uses
  DUnitX.TestFramework, M4D, M4D.MigrationsHistoryInterface,
  M4D.GetterMigrationsInterface, M4D.MigrationsRegisterInterface,
  M4D.MigrationExecutorInterface, M4D.MigrationListOrderInterface;

type
  TestM4D = class
  private
    FMigrationsHistory: IMigrationsHistory;
    FGetterMigration: IGetterMigrations;
    FMigrationListOrder: IMigrationListOrder;
    FMigrationsRegister: IMigrationsRegister;
    FMigrationExecutor: IMigrationExecutor;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckMigrationManagerWithParameters;
    [Test]
    procedure CheckMigrationManagerWithoutParameters;
    [Test]
    procedure CheckRegisterMigrationWithParameters;
    [Test]
    procedure CheckRegisterMigrationWithoutParameters;
    [Test]
    procedure CheckRelease;
  end;

implementation

uses
  M4D.MigrationsHistory, M4D.GetterMigrations, M4D.MigrationsRegister,
  M4D.MigrationExecutor, M4D.MigrationListOrder, M4DTest.MigrationsHistoryMock,
  M4DTest.MStubMigrationToTest, M4D.MigrationsManager;

{ TestM4D }

procedure TestM4D.CheckMigrationManagerWithoutParameters;
var
  MM: TMigrationsManager;
begin
  MM := M4D.MigrationManager;
  Assert.IsTrue(Assigned(MM), 'The M4D.MigrationManager without parameters must be assigned.');
end;

procedure TestM4D.CheckMigrationManagerWithParameters;
var
  MM: TMigrationsManager;
begin
  MM := M4D.MigrationManager(FMigrationsHistory, FGetterMigration, FMigrationsRegister, FMigrationExecutor);

  Assert.IsTrue(Assigned(MM), 'The M4D.MigrationManager with parameters must be assigned.');
end;

procedure TestM4D.CheckRegisterMigrationWithoutParameters;
begin
  M4D.RegisterMigration(TestStubClass, FMigrationsHistory, FGetterMigration, FMigrationsRegister, FMigrationExecutor);
  Assert.Pass('If get this point, the registration works well.');
end;

procedure TestM4D.CheckRegisterMigrationWithParameters;
begin
  M4D.RegisterMigration(TestStubClass);
  Assert.Pass('If get this point, the registration works well.');
end;

procedure TestM4D.CheckRelease;
begin
  M4D.MigrationManager;
  M4D.Release;
  Assert.Pass('If get this point, works well.');
end;

procedure TestM4D.Setup;
begin
  FMigrationsHistory := TMigrationsHistoryMock.Create;
  FGetterMigration := TGetterMigrations.Create;
  FMigrationListOrder := TMigrationListOrder.Create;
  FMigrationsRegister := TMigrationsRegister.Create(FMigrationListOrder);
  FMigrationExecutor := M4D.MigrationExecutor.TMigrationExecutor.Create(FMigrationsHistory);
end;

initialization
  TDUnitX.RegisterTestFixture(TestM4D);

end.
