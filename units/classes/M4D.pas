unit M4D;

interface

uses
  UMigrationsInterface,
  UMigrationsManager;

function MigrationsManager: TMigrationsManager;
procedure RegisterMigration(AMigration: TClass);
procedure Release;

var
  GMigrationsManager: TMigrationsManager;

implementation

uses
  System.Classes, System.SysUtils;

function MigrationsManager: TMigrationsManager;
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

procedure RegisterMigration(AMigration: TClass);
var
  MM: TMigrationsManager;
begin
  MM := MigrationsManager;
  if Assigned(MM) then
  begin
    MM.RegisterMigration(AMigration);
  end;
end;

procedure Release;
begin
  if Assigned(GMigrationsManager) then FreeAndNil(GMigrationsManager);
  
end;

end.
