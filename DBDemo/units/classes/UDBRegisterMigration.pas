unit UDBRegisterMigration;

interface

uses
  M4D.MigrationsHistoryInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationMethodExecutorInterface, M4D.MigrationListOrderInterface,
  M4D.MigrationsRegisterInterface, M4D.MigrationExecutorInterface;

procedure DBRegisterMigration(AMigration: TClass);

var
  LMigrationsHistory: IMigrationsHistory;
  LGetterMigration: IGetterMigrations;
  LMigrationListOrder: IMigrationListOrder;
  LMigrationsRegister: IMigrationsRegister;
  LMigrationExecutor: IMigrationExecutor;

implementation

uses
  M4D, M4D.Defaults, UDBMigrationHistory, UDMDBDemo;

procedure DBRegisterMigration(AMigration: TClass);
begin
  {Here I want to change the responsable of manage the history of migrations,
   to one that will save in database}
  if not Assigned(LMigrationsHistory) then LMigrationsHistory := TDBMigrationsHistory.Create(DMDBDemo.getConnection);

  if not Assigned(LGetterMigration) then LGetterMigration := TDefaultInstanceOfMigrationGetterCreator.getInstance;
  if not Assigned(LMigrationListOrder) then LMigrationListOrder := TDefaultInstanceOfMigrationListOrderCreator.getInstance;
  if not Assigned(LMigrationsRegister) then LMigrationsRegister := TDefaultInstanceOfMigrationsRegisterCreator.getInstance(LMigrationListOrder);
  if not Assigned(LMigrationExecutor) then LMigrationExecutor := TDefaultInstanceOfMigrationExecutorCreator.getInstance(LMigrationsHistory);

  RegisterMigration(AMigration, LMigrationsHistory, LGetterMigration, LMigrationsRegister, LMigrationExecutor);
end;

end.

