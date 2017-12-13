unit M4DTestUnit;

interface

uses
  DUnitX.TestFramework, M4D, M4D.MigrationsHistoryFacadeInterface,
  M4D.GetterMigrationsInterface, M4D.MigrationsRegisterInterface,
  M4D.MigrationExecutorFacadeInterface, M4D.MigrationListOrderInterface;

type
  TestM4D = class
  private
    FMigrationsHistory: IMigrationsHistoryFacade;
    FGetterMigration: IGetterMigrations;
    FMigrationListOrder: IMigrationListOrder;
    FMigrationsRegister: IMigrationsRegister;
    FMigrationExecutor: IMigrationExecutorFacade;
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
  M4D.MigrationsHistoryFacade, M4D.GetterMigrations, M4D.MigrationsRegister,
  M4D.MigrationExecutorFacade, M4D.MigrationListOrder, M4DTest.MigrationsHistoryMock,
  M4DTest.MStubMigrationToTest, M4D.MigrationsFacade;

{ TestM4D }

procedure TestM4D.CheckMigrationManagerWithoutParameters;
var
  MM: TMigrationsFacade;
begin
  MM := M4D.MigrationFacade;
  Assert.IsTrue(Assigned(MM), 'The M4D.MigrationManager without parameters must be assigned.');
end;

procedure TestM4D.CheckMigrationManagerWithParameters;
var
  MM: TMigrationsFacade;
begin
  MM := M4D.MigrationFacade(FMigrationsHistory, FGetterMigration, FMigrationsRegister, FMigrationExecutor);

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
  M4D.MigrationFacade;
  M4D.Release;
  Assert.Pass('If get this point, works well.');
end;

procedure TestM4D.Setup;
begin
  FMigrationsHistory := TMigrationsHistoryMock.Create;
  FGetterMigration := TGetterMigrations.Create;
  FMigrationListOrder := TMigrationListOrder.Create;
  FMigrationsRegister := TMigrationsRegister.Create(FMigrationListOrder);
  FMigrationExecutor := M4D.MigrationExecutorFacade.TMigrationExecutorFacade.Create(FMigrationsHistory);
end;

initialization
  TDUnitX.RegisterTestFixture(TestM4D);

end.
