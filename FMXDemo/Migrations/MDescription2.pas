unit MDescription2;

interface

uses
  FMX.Dialogs,
  M4D,
  M4D.Migrations;

type
  TMDescription2 = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils;

{ TMDescription1 }

procedure TMDescription2.Setup;
begin
  Self.Version := '1.01';
  Self.SeqVersion := 2;
  Self.DateTime := StrToDateTime('01/09/2017 07:15:00');
end;

procedure TMDescription2.Down;
begin
  ShowMessage('Executing down sequence version 2!');
end;

procedure TMDescription2.Up;
begin
  ShowMessage('Executing up sequence version 2!');
end;

initialization
  RegisterMigration(TMDescription2);

end.
