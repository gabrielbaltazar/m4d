unit MCreateTables;

interface

uses
  M4D.RegistryMigrations;

type
  TMCreateTables = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils, UDMDBDemo, FireDAC.Comp.Client;

{ TMDescription1 }

procedure TMCreateTables.Setup;
begin
  Self.Version := '1.00';
  Self.SeqVersion := 1;
  Self.DateTime := StrToDateTime('05/09/2017 07:19:00');
end;

procedure TMCreateTables.Up;
var
  LQuery: TFDQuery;
begin
  LQuery := DMDBDemo.GetQuery('CREATE TABLE IF NOT EXISTS CUSTOMERS ' +
    '(ID INTEGER NOT NULL, NAME VARCHAR(100) NOT NULL)', False);
  try
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

procedure TMCreateTables.Down;
var
  LQuery: TFDQuery;
begin
  LQuery := DMDBDemo.GetQuery('DROP TABLE CUSTOMERS', False);
  try
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;
{
var
  History: IMigrationsHistory;
}
initialization
{
  You can use a new register method to simplify (I prefer)
}
 // DBRegisterMigration(TMCreateTables);
  TM4DRegistryMigrations.GetInstance.Add(TMCreateTables);
{


  or you can implement direct here, but be careful with memory management.

  History := TDBMigrationsHistory.Create(DMDBDemo.getConnection);

  M4D.RegisterMigration(TMCreateTables,
                        History,
                        TDefaultInstanceOfMigrationGetterCreator.getInstance,
                        TDefaultInstanceOfMigrationsRegisterCreator.getInstance(TDefaultInstanceOfMigrationListOrderCreator.getInstance),
                        TDefaultInstanceOfMigrationExecutorCreator.getInstance(History));
}
end.
