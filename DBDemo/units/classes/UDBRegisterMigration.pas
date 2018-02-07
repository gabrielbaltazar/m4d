{######################################################################################

                                      M4D Framework

Author: Edgar Borges Pavão
Date of creation: 06/09/2017
Use licence: Free

######################################################################################}

unit UDBRegisterMigration;

interface

uses
  M4D.MigrationsHistoryFacadeInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationMethodExecutorInterface, M4D.MigrationListOrderInterface,
  M4D.MigrationsRegisterInterface, M4D.MigrationExecutorFacadeInterface;

procedure DBRegisterMigration(AMigration: TClass);

var
  LMigrationsHistory: IMigrationsHistoryFacade;
  LGetterMigration: IGetterMigrations;
  LMigrationListOrder: IMigrationListOrder;
  LMigrationsRegister: IMigrationsRegister;
  LMigrationExecutor: IMigrationExecutorFacade;

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

