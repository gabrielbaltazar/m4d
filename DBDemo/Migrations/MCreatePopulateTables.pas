unit MCreatePopulateTables;

interface

uses
  {$IF DECLARED(FireMonkeyVersion)}
    FMX.Dialogs,
  {$ELSE}
    Vcl.Dialogs,
  {$ENDIF}
  M4D.Migrations,
  UDBRegisterMigration;

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
  Query: TFDQuery;
begin
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (1, ''John Doe'')', False);
  try
    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (2, ''Aonghus Anton'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (3, ''Hong Hortensius'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (4, ''Prasad Marciano'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (5, ''Svetlana Sarah'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (6, ''Cynebald Jakob'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (7, ''Sanjay Reneer'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (8, ''Carrie Maja'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (9, ''Hildiberht Jalen'')';
    Query.ExecSQL;

    Query.SQl.Text := 'INSERT INTO CUSTOMERS VALUES (10, ''Bibigul Aniela'')';
    Query.ExecSQL;
  finally
    Query.Free;
  end;

  ShowMessage('Just finish sequence 2 down!');
end;

procedure TMCreatePopulateTables.Down;
var
  Query: TFDQuery;
begin
  Query := DMDBDemo.getQuery('DELETE FROM CUSTOMERS', False);
  try
    Query.ExecSQL;
  finally
    Query.Free;
  end;

  ShowMessage('Just finish rollback of sequence 2 up!');
end;

initialization
  DBRegisterMigration(TMCreatePopulateTables);

end.
