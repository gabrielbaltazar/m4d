unit uMigrations;

interface

uses
  System.SysUtils,
  Firedac.Comp.Client,
  M4D.RegistryMigrations.Firedac,
  M4D.RegistryMigrations,
  M4D.MigrationsFacade,
  M4D;

procedure StartMigration
function GetQuery: TFDQuery;

implementation

function GetQuery: TFDQuery;
begin

end;

procedure StartMigration;
begin
  TM4DRegistryMigrations.GetInstance
    .History(TM4DMigrationsHistoryFiredac.New(Query)
    .ExecutePending;
end;

end.