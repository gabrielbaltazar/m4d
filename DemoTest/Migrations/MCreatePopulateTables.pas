unit MCreatePopulateTables;

interface

uses
  {$IF DECLARED(FireMonkeyVersion)}
    FMX.Dialogs,
  {$ELSE}
    Vcl.Dialogs,
  {$ENDIF}
  M4D,
  UMigrations;

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
  Self.Version := '1.00';
  Self.SeqVersion := 1;
  Self.DateTime := StrToDateTime('05/09/2017 07:19:00');
end;

procedure TMCreatePopulateTables.Down;
var
  Query: TFDQuery;
begin
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (1, ''John Doe'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (2, ''Aonghus Anton'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (3, ''Hong Hortensius'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (4, ''Prasad Marciano'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (5, ''Svetlana Sarah'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (6, ''Cynebald Jakob'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (7, ''Sanjay Reneer'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (8, ''Carrie Maja'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (9, ''Hildiberht Jalen'')');
  Query := DMDBDemo.getQuery('INSERT INTO CUSTOMERS VALUES (10, ''Bibigul Aniela'')');

  ShowMessage('Just finish sequence 2 down!');
end;

procedure TMCreatePopulateTables.Up;
var
  Query: TFDQuery;
begin
  Query := DMDBDemo.getQuery('DELETE FROM CUSTOMERS');

  ShowMessage('Just finish sequence 2 up!');
end;

initialization
//  RegisterMigration(TMCreatePopulateTables);

end.
