unit M4D.UnitValidator;

interface

type
  TUnitValidator = class
  public
    class function isAValidUnitToTry(AUnitFileName: string): Boolean;
  end;

implementation

uses
  System.SysUtils, StrUtils, Vcl.Dialogs;

{ TUnitValidator }

class function TUnitValidator.isAValidUnitToTry(AUnitFileName: string): Boolean;
const
  VALID_UNIT_EXTENSION = '.pas';

var
  Aux: string;
begin
  Result := False;

  if Length(AUnitFileName) > 4 then
  begin
    if FileExists(AUnitFileName) then
    begin
      Aux := Trim(ReverseString(AUnitFileName));

      if AnsiLowerCase(ReverseString(VALID_UNIT_EXTENSION)) = AnsiLowerCase(Aux[1] + Aux[2] + Aux[3] + Aux[4]) then
      begin
        Result := True;
      end;
    end;
  end;
end;

end.
