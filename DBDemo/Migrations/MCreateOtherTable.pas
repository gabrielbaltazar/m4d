unit MCreateOtherTable;

interface

uses
{$IF DECLARED(FireMonkeyVersion)}
  FMX.Dialogs,
{$ELSE}
  Vcl.Dialogs,
{$ENDIF}
  M4D,
  M4D.Migrations,
  M4D.Defaults,
  UDBRegisterMigration;

type
  TMCreateOtherTable = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils, UDMDBDemo, FireDAC.Comp.Client, UDBMigrationHistory,
  M4D.MigrationsHistoryFacadeInterface;

{ TMDescription1 }

procedure TMCreateOtherTable.Setup;
begin
  Self.Version := '1.02';
  Self.SeqVersion := 3;
  Self.DateTime := StrToDateTime('22/11/2023 15:11:00');
end;

procedure TMCreateOtherTable.Up;
var
  LQuery: TFDQuery;
begin
  LQuery := DMDBDemo.GetQuery('CREATE TABLE IF NOT EXISTS SALES (' +
    'ID INTEGER NOT NULL, VALUE CURRENCY NOT NULL)', False);
  try
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

procedure TMCreateOtherTable.Down;
var
  LQuery: TFDQuery;
begin
  LQuery := DMDBDemo.GetQuery('DROP TABLE SALES', False);
  try
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

initialization
  DBRegisterMigration(TMCreateOtherTable);

end.
