unit UDBRegisterMigration;

interface

uses
  UMigrationsHistoryInterface, UGetterMigrationsInterface,
  UMigrationMethodExecutorInterface, UMigrationListOrderInterface,
  UMigrationsRegisterInterface, UMigrationExecutorInterface,
  USetupExecutorInterface, UPropertyClassReaderInterface,
  UMigrationUpMethodExecutorInterface, UMigrationDownMethodExecutorInterface;

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

  LGetterMigration := TDefaults.instanceOfMigrationGetter;
  LMigrationMethodExecutor := TDefaults.instanceOfMigrationMethodExecutor;
  LMigrationListOrder := TDefaults.instanceOfMigrationListOrder(LMigrationMethodExecutor);
  LMigrationsRegister := TDefaults.instanceOfMigrationsRegister(LMigrationListOrder);
  LMethodSetupExecutor := TDefaults.instanceOfMigrationSetupMethodExecutor(LMigrationMethodExecutor);
  LReader := TDefaults.instanceOfPropertyClassReader;
  LMethodUpExecutor := TDefaults.instanceOfMigrationUpMethodExecutor(LMigrationMethodExecutor);
  LMethodDownExecutor := TDefaults.instanceOfMigrationDownMethodExecutor(LMigrationMethodExecutor);

  LMigrationExecutor := TDefaults.instanceOfMigrationExecutor(LMigrationsHistory,
                                                              LMethodUpExecutor,
                                                              LMethodDownExecutor,
                                                              LMethodSetupExecutor);

  RegisterMigration(AMigration,
                    LMigrationsHistory,
                    LGetterMigration,
                    LMigrationsRegister,
                    LMigrationExecutor,
                    LMethodSetupExecutor,
                    LReader,
                    LMethodUpExecutor,
                    LMethodDownExecutor);
end;

end.

