unit MigrationInit;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Forms,
  UDMDBDemo,
  FireDAC.Comp.Client,
  M4D,
  M4D.MigrationsFacade;

procedure StartMigration;

implementation

procedure CreateTableMigration;
var
  LQuery: TFDQuery;
begin
  if not Assigned(DMDBDemo) then
    Application.CreateForm(TDMDBDemo, DMDBDemo);

  LQuery := DMDBDemo.GetQuery('create table if not exists MIGRATIONS_INFO (' +
    'SEQUENCE INT PRIMARY KEY NOT NULL, ' +
    'VERSION VARCHAR(50), ' +
    'DATETIME DATETIME, ' +
    'START_OF_EXECUTION DATETIME, ' +
    'END_OF_EXECUTION DATETIME, ' +
    'DURATION_OF_EXECUTION INTEGER) ', False);
  try
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

procedure StartMigration;
begin
  try
    CreateTableMigration;
    M4D.MigrationFacade.ExecutePending;
  except
  end;
end;

end.
