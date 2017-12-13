{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pav�o
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D;

interface

uses
  M4D.MigrationsInterface,
  M4D.MigrationsFacade,
  M4D.MigrationsHistoryFacadeInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationsRegisterInterface, M4D.MigrationExecutorFacadeInterface,
  M4D.MigrationSerializerFacadeInterface;

function MigrationFacade(AMigrationsHistoryFacade: IMigrationsHistoryFacade;
                         AGetterMigration: IGetterMigrations;
                         AMigrationsRegister: IMigrationsRegister;
                         AMigrationExecutorFacade: IMigrationExecutorFacade): TMigrationsFacade; overload;

function MigrationFacade: TMigrationsFacade; overload;
procedure RegisterMigration(AMigration: TClass;
                            AMigrationsHistoryFacade: IMigrationsHistoryFacade;
                            AGetterMigration: IGetterMigrations;
                            AMigrationsRegister: IMigrationsRegister;
                            AMigrationExecutorFacade: IMigrationExecutorFacade); overload;
procedure RegisterMigration(AMigration: TClass); overload;
procedure Release;

var
  GMigrationsManager: TMigrationsFacade;

implementation

uses
  System.Classes, System.SysUtils,
  M4D.MigrationsHistoryFacade, M4D.MigrationSerializerFacade;

function MigrationFacade(AMigrationsHistoryFacade: IMigrationsHistoryFacade;
                         AGetterMigration: IGetterMigrations;
                         AMigrationsRegister: IMigrationsRegister;
                         AMigrationExecutorFacade: IMigrationExecutorFacade): TMigrationsFacade; overload;
begin
  if Assigned(GMigrationsManager) then
  begin
    Result := GMigrationsManager;
  end
  else
  begin
    GMigrationsManager := TMigrationsFacade.Create(AMigrationsHistoryFacade,
                                                   AGetterMigration,
                                                   AMigrationsRegister,
                                                   AMigrationExecutorFacade);
    Result := GMigrationsManager;
  end;
end;

function MigrationFacade: TMigrationsFacade;  overload;
begin
  if Assigned(GMigrationsManager) then
  begin
    Result := GMigrationsManager;
  end
  else
  begin
    GMigrationsManager := TMigrationsFacade.Create;
    Result := GMigrationsManager;
  end;
end;

procedure RegisterMigration(AMigration: TClass;
                            AMigrationsHistoryFacade: IMigrationsHistoryFacade;
                            AGetterMigration: IGetterMigrations;
                            AMigrationsRegister: IMigrationsRegister;
                            AMigrationExecutorFacade: IMigrationExecutorFacade); overload;
var
  MM: TMigrationsFacade;
begin
  MM := MigrationFacade(AMigrationsHistoryFacade,
                        AGetterMigration,
                        AMigrationsRegister,
                        AMigrationExecutorFacade);
  if Assigned(MM) then
  begin
    MM.RegisterMigration(AMigration);
  end;
end;

procedure Release;
begin
  if Assigned(GMigrationsManager) then FreeAndNil(GMigrationsManager);
end;

procedure RegisterMigration(AMigration: TClass); overload;
var
  MM: TMigrationsFacade;
begin
  MM := MigrationFacade;
  if Assigned(MM) then
  begin
    MM.RegisterMigration(AMigration);
  end;
end;

initialization

finalization
  if Assigned(GMigrationsManager) then GMigrationsManager.Free;

end.
