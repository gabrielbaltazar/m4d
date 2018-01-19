unit M4DTest.MStubMigrationNotExecuteUpNeitherDown;

interface

uses
  M4D.Migrations;

type
  TestStubClassNotExecuteUpNeitherDown = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    function UpWillExecute: Boolean; override;
    procedure Down; override;
    function DownWillExecute: Boolean; override;
  end;

implementation

uses
  System.SysUtils;

{ TStubClass }

procedure TestStubClassNotExecuteUpNeitherDown.Down;
begin
  inherited;
  //do nothing
end;

function TestStubClassNotExecuteUpNeitherDown.DownWillExecute: Boolean;
begin
  Result := False;
end;

procedure TestStubClassNotExecuteUpNeitherDown.Setup;
begin
  Self.Version := '2';
  Self.SeqVersion := 2;
  Self.DateTime := Now;
end;

procedure TestStubClassNotExecuteUpNeitherDown.Up;
begin
  //do nothing
end;

function TestStubClassNotExecuteUpNeitherDown.UpWillExecute: Boolean;
begin
  Result := False;
end;

end.
