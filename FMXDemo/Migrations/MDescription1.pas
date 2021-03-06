unit MDescription1;

interface

uses
  FMX.Dialogs,
  M4D,
  M4D.Migrations;

type
  TMDescription1 = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils;

{ TMDescription1 }

procedure TMDescription1.Setup;
begin
  Self.Version := '1.00';
  Self.SeqVersion := 1;
  Self.DateTime := StrToDateTime('01/09/2017 07:13:00');
end;

procedure TMDescription1.Down;
begin
  ShowMessage('Executing down!');
end;

procedure TMDescription1.Up;
begin
  ShowMessage('Executing up!');
end;

initialization
  RegisterMigration(TMDescription1);

end.
