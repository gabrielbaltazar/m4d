unit M4DTest.MStubMigrationToTest;

interface

uses
  M4D.Migrations;

type
  TestStubClass = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils;

{ TStubClass }

procedure TestStubClass.Down;
begin
  inherited;
  //do nothing
end;

procedure TestStubClass.Setup;
begin
  Self.Version := '1';
  Self.SeqVersion := 1;
  Self.DateTime := Now;
end;

procedure TestStubClass.Up;
begin
  //do nothing
end;

end.
