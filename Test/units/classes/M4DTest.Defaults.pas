unit M4DTest.Defaults;

interface
uses
  DUnitX.TestFramework, M4D.Defaults, M4D.MigrationSerializerInterface,
  M4D.MigrationsHistoryInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationListOrderInterface, M4D.MigrationsRegisterInterface,
  M4D.MigrationExecutorInterface;

type
  [TestFixture]
  TestDefaultInstanceOfMigrationsSerializerCreator = class(TObject)
  private
    FMigrationSerializer: IMigrationSerializer;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckIfIsTheCorretClass;
  end;

type
  [TestFixture]
  TestDefaultInstanceOfMigrationsHistoryCreator = class(TObject)
  private
    FMigrationSerializer: IMigrationSerializer;
    FMigrationsHistory: IMigrationsHistory;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckIfIsTheCorretClass;
  end;

type
  [TestFixture]
  TestDefaultInstanceOfMigrationGetterCreator = class(TObject)
  private
    FMigrationGetter: IGetterMigrations;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckIfIsTheCorretClass;
  end;

type
  [TestFixture]
  TestDefaultInstanceOfMigrationListOrderCreator = class(TObject)
  private
    FMigrationListOrder: IMigrationListOrder;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckIfIsTheCorretClass;
  end;

type
  [TestFixture]
  TestDefaultInstanceOfMigrationsRegisterCreator = class(TObject)
  private
    FMigrationListOrder: IMigrationListOrder;
    FMigrationsRegister: IMigrationsRegister;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckIfIsTheCorretClass;
  end;

type
  [TestFixture]
  TestDefaultInstanceOfMigrationExecutorCreator = class(TObject)
  private
    FMigrationSerializer: IMigrationSerializer;
    FMigrationsHistory: IMigrationsHistory;
    FExecutor: IMigrationExecutor;
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckIfIsTheCorretClass;
  end;

implementation

procedure TestDefaultInstanceOfMigrationsSerializerCreator.CheckIfIsTheCorretClass;
begin
  Assert.IsTrue(Assigned(FMigrationSerializer), 'The instance of FMigrationSerializer is not assigned.');
end;

procedure TestDefaultInstanceOfMigrationsSerializerCreator.Setup;
begin
  FMigrationSerializer := TDefaultInstanceOfMigrationsSerializerCreator.getInstance;
end;

{ TestDefaultInstanceOfMigrationsHistoryCreator }

procedure TestDefaultInstanceOfMigrationsHistoryCreator.CheckIfIsTheCorretClass;
begin
  Assert.IsTrue(Assigned(FMigrationsHistory), 'The instance of FMigrationsHistory is not assigned.');
end;

procedure TestDefaultInstanceOfMigrationsHistoryCreator.Setup;
begin
  FMigrationSerializer := TDefaultInstanceOfMigrationsSerializerCreator.getInstance;
  FMigrationsHistory := TDefaultInstanceOfMigrationsHistoryCreator.getInstance(FMigrationSerializer);
end;

{ TestDefaultInstanceOfMigrationGetterCreator }

procedure TestDefaultInstanceOfMigrationGetterCreator.CheckIfIsTheCorretClass;
begin
  Assert.IsTrue(Assigned(FMigrationGetter), 'The instance of FMigrationGetter is not assigned.');
end;

procedure TestDefaultInstanceOfMigrationGetterCreator.Setup;
begin
  FMigrationGetter := TDefaultInstanceOfMigrationGetterCreator.getInstance;
end;

{ TestDefaultInstanceOfMigrationListOrderCreator }

procedure TestDefaultInstanceOfMigrationListOrderCreator.CheckIfIsTheCorretClass;
begin
  Assert.IsTrue(Assigned(FMigrationListOrder), 'The instance of FMigrationListOrder is not assigned.');
end;

procedure TestDefaultInstanceOfMigrationListOrderCreator.Setup;
begin
  FMigrationListOrder := TDefaultInstanceOfMigrationListOrderCreator.getInstance;
end;

{ TestDefaultInstanceOfMigrationsRegisterCreator }

procedure TestDefaultInstanceOfMigrationsRegisterCreator.CheckIfIsTheCorretClass;
begin
  Assert.IsTrue(Assigned(FMigrationsRegister), 'The instance of FMigrationsRegister is not assigned.');
end;

procedure TestDefaultInstanceOfMigrationsRegisterCreator.Setup;
begin
  FMigrationListOrder := TDefaultInstanceOfMigrationListOrderCreator.getInstance;
  FMigrationsRegister := TDefaultInstanceOfMigrationsRegisterCreator.getInstance(FMigrationListOrder);
end;

{ TestDefaultInstanceOfMigrationExecutorCreator }

procedure TestDefaultInstanceOfMigrationExecutorCreator.CheckIfIsTheCorretClass;
begin
  Assert.IsTrue(Assigned(FExecutor), 'The instance of FExecutor is not assigned.');
end;

procedure TestDefaultInstanceOfMigrationExecutorCreator.Setup;
begin
  FMigrationSerializer := TDefaultInstanceOfMigrationsSerializerCreator.getInstance;
  FMigrationsHistory := TDefaultInstanceOfMigrationsHistoryCreator.getInstance(FMigrationSerializer);
  FExecutor := TDefaultInstanceOfMigrationExecutorCreator.getInstance(FMigrationsHistory);
end;

initialization
  TDUnitX.RegisterTestFixture(TestDefaultInstanceOfMigrationsSerializerCreator);

end.
