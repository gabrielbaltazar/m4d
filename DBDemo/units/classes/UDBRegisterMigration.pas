unit UDBRegisterMigration;

interface

uses
  M4D.MigrationsHistoryInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationMethodExecutorInterface, M4D.MigrationListOrderInterface,
  M4D.MigrationsRegisterInterface, M4D.MigrationExecutorInterface,
  M4D.SetupExecutorInterface, M4D.PropertyClassReaderInterface,
  M4D.MigrationUpMethodExecutorInterface, M4D.MigrationDownMethodExecutorInterface;

procedure DBRegisterMigration(AMigration: TClass);

var
  LMigrationsHistory: IMigrationsHistory;
  LGetterMigration: IGetterMigrations;
  LMigrationMethodExecutor: IMigrationMethodExecutor;
  LMigrationListOrder: IMigrationListOrder;
  LMigrationsRegister: IMigrationsRegister;
  LMigrationExecutor: IMigrationExecutor;
  LMethodSetupExecutor: IMigrationSetupMethodExecutor;
  LReader: IPropertyClassReader;
  LMethodUpExecutor: IMigrationUpMethodExecutor;
  LMethodDownExecutor: IMigrationDownMethodExecutor;

implementation

uses
  M4D, M4D.Defaults, UDBMigrationHistory, UDMDBDemo;

procedure DBRegisterMigration(AMigration: TClass);
begin
  {Here I want to change the responsable of manage the history of migrations,
   to one that will save in database}
  LMigrationsHistory := TDBMigrationsHistory.Create(DMDBDemo.getConnection);

  LGetterMigration := TDefaultInstanceOfMigrationGetterCreator.getInstance;
  LMigrationListOrder := TDefaultInstanceOfMigrationListOrderCreator.getInstance;
  LMigrationsRegister := TDefaultInstanceOfMigrationsRegisterCreator.getInstance(LMigrationListOrder);
  LMigrationExecutor := TDefaultInstanceOfMigrationExecutorCreator.getInstance(LMigrationsHistory);

  RegisterMigration(AMigration, LMigrationsHistory, LGetterMigration, LMigrationsRegister, LMigrationExecutor);
end;

end.

