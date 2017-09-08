unit M4D;

interface

uses
  UMigrationsInterface,
  UMigrationsManager,
  UMigrationsHistoryInterface, UGetterMigrationsInterface,
  UMigrationsRegisterInterface, UMigrationExecutorInterface,
  USetupExecutorInterface, UPropertyClassReaderInterface,
  UMigrationUpMethodExecutorInterface, UMigrationDownMethodExecutorInterface,
  UMigrationSerializerInterface;

function MigrationsManager(AMigrationsHistory: IMigrationsHistory;
                           AGetterMigration: IGetterMigrations;
                           AMigrationsRegister: IMigrationsRegister;
                           AMigrationExecutor: IMigrationExecutor;
                           AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                           AReader: IPropertyClassReader;
                           AMethodUpExecutor: IMigrationUpMethodExecutor;
                           AMethodDownExecutor: IMigrationDownMethodExecutor): TMigrationsManager ; overload;

function MigrationsManager: TMigrationsManager; overload;
procedure RegisterMigration(AMigration: TClass;
                            AMigrationsHistory: IMigrationsHistory;
                            AGetterMigration: IGetterMigrations;
                            AMigrationsRegister: IMigrationsRegister;
                            AMigrationExecutor: IMigrationExecutor;
                            AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                            AReader: IPropertyClassReader;
                            AMethodUpExecutor: IMigrationUpMethodExecutor;
                            AMethodDownExecutor: IMigrationDownMethodExecutor); overload;
procedure RegisterMigration(AMigration: TClass); overload;
procedure Release;

var
  GMigrationsManager: TMigrationsManager;

implementation

uses
  System.Classes, System.SysUtils,
  UMigrationsHistory, UMigrationSerializer;

function MigrationsManager(AMigrationsHistory: IMigrationsHistory;
                           AGetterMigration: IGetterMigrations;
                           AMigrationsRegister: IMigrationsRegister;
                           AMigrationExecutor: IMigrationExecutor;
                           AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                           AReader: IPropertyClassReader;
                           AMethodUpExecutor: IMigrationUpMethodExecutor;
                           AMethodDownExecutor: IMigrationDownMethodExecutor): TMigrationsManager overload;
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
                                                    AMigrationExecutor,
                                                    AMethodSetupExecutor,
                                                    AReader,
                                                    AMethodUpExecutor,
                                                    AMethodDownExecutor);
    Result := GMigrationsManager;
  end;
end;

function MigrationsManager: TMigrationsManager;  overload;
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
                            AMigrationExecutor: IMigrationExecutor;
                            AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                            AReader: IPropertyClassReader;
                            AMethodUpExecutor: IMigrationUpMethodExecutor;
                            AMethodDownExecutor: IMigrationDownMethodExecutor); overload;
var
  MM: TMigrationsManager;
begin
  MM := MigrationsManager(AMigrationsHistory,
                          AGetterMigration,
                          AMigrationsRegister,
                          AMigrationExecutor,
                          AMethodSetupExecutor,
                          AReader,
                          AMethodUpExecutor,
                          AMethodDownExecutor);
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
  MM := MigrationsManager;
  if Assigned(MM) then
  begin
    MM.RegisterMigration(AMigration);
  end;
end;

end.
