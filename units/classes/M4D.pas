{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D;

interface

uses
  M4D.MigrationsInterface,
  M4D.MigrationsManager,
  M4D.MigrationsHistoryInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationsRegisterInterface, M4D.MigrationExecutorInterface,
  M4D.MigrationSerializerInterface;

function MigrationManager(AMigrationsHistory: IMigrationsHistory;
                          AGetterMigration: IGetterMigrations;
                          AMigrationsRegister: IMigrationsRegister;
                          AMigrationExecutor: IMigrationExecutor): TMigrationsManager ; overload;

function MigrationManager: TMigrationsManager; overload;
procedure RegisterMigration(AMigration: TClass;
                            AMigrationsHistory: IMigrationsHistory;
                            AGetterMigration: IGetterMigrations;
                            AMigrationsRegister: IMigrationsRegister;
                            AMigrationExecutor: IMigrationExecutor); overload;
procedure RegisterMigration(AMigration: TClass); overload;
procedure Release;

var
  GMigrationsManager: TMigrationsManager;

implementation

uses
  System.Classes, System.SysUtils,
  M4D.MigrationsHistory, M4D.MigrationSerializer;

function MigrationManager(AMigrationsHistory: IMigrationsHistory;
                           AGetterMigration: IGetterMigrations;
                           AMigrationsRegister: IMigrationsRegister;
                           AMigrationExecutor: IMigrationExecutor): TMigrationsManager overload;
begin
  if Assigned(GMigrationsManager) then
  begin
    Result := GMigrationsManager;
  end
  else
  begin
    GMigrationsManager := TMigrationsManager.Create(AMigrationsHistory,
                                                    AGetterMigration,
                                                    AMigrationsRegister,
                                                    AMigrationExecutor);
    Result := GMigrationsManager;
  end;
end;

function MigrationManager: TMigrationsManager;  overload;
begin
  if Assigned(GMigrationsManager) then
  begin
    Result := GMigrationsManager;
  end
  else
  begin
    GMigrationsManager := TMigrationsManager.Create;
    Result := GMigrationsManager;
  end;
end;

procedure RegisterMigration(AMigration: TClass;
                            AMigrationsHistory: IMigrationsHistory;
                            AGetterMigration: IGetterMigrations;
                            AMigrationsRegister: IMigrationsRegister;
                            AMigrationExecutor: IMigrationExecutor); overload;
var
  MM: TMigrationsManager;
begin
  MM := MigrationManager(AMigrationsHistory,
                         AGetterMigration,
                         AMigrationsRegister,
                         AMigrationExecutor);
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
  MM: TMigrationsManager;
begin
  MM := MigrationManager;
  if Assigned(MM) then
  begin
    MM.RegisterMigration(AMigration);
  end;
end;

initialization

finalization
  if Assigned(GMigrationsManager) then GMigrationsManager.Free;

end.
