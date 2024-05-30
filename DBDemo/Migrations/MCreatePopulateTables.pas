unit MCreatePopulateTables;

interface

uses
  M4D.RegistryMigrations;

type
  TMCreatePopulateTables = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils, UDMDBDemo, FireDAC.Comp.Client;

{ TMDescription1 }

procedure TMCreatePopulateTables.Setup;
begin
  Self.Version := '1.01';
  Self.SeqVersion := 2;
  Self.DateTime := StrToDateTime('05/09/2017 07:20:00');
end;

procedure TMCreatePopulateTables.Up;
var
  LQuery: TFDQuery;
begin
  LQuery := DMDBDemo.GetQuery('INSERT INTO CUSTOMERS VALUES (1, ''John Doe'')', False);
  try
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (2, ''Aonghus Anton'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (3, ''Hong Hortensius'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (4, ''Prasad Marciano'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (5, ''Svetlana Sarah'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (6, ''Cynebald Jakob'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (7, ''Sanjay Reneer'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (8, ''Carrie Maja'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (9, ''Hildiberht Jalen'')';
    LQuery.ExecSQL;

    LQuery.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (10, ''Bibigul Aniela'')';
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

procedure TMCreatePopulateTables.Down;
var
  LQuery: TFDQuery;
begin
  LQuery := DMDBDemo.GetQuery('DELETE FROM CUSTOMERS', False);
  try
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

initialization
  TM4DRegistryMigrations.GetInstance.Add(TMCreatePopulateTables);

end.
