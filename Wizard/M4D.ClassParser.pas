unit M4D.ClassParser;

interface

uses
  System.Classes;

type
  TClassParser = class
  private
    class function FirstClassName(AText: string; AClassDirectiveStartPosition: Integer): string;
  public
    class function ClassesNames(AUnitFileName: string): TStringList;
  end;

implementation

uses
  M4D.UnitValidator, System.SysUtils, StrUtils, Vcl.Dialogs;

{ TClassParser }

class function TClassParser.ClassesNames(AUnitFileName: string): TStringList;
const
  CLASS_DERECTIVE = 'class';

var
  LFile: TStringList;
  LText: String;
  LClassName: string;
  LPosition: Integer;
begin
  Result := nil;

  //Load the file
  LFile := TStringList.Create;
  try
    LFile.LoadFromFile(AUnitFileName);
    LText := LFile.Text;
  finally
    LFile.Free;
  end;

  //Seek for class directive
  LClassName := '';
  LPosition := Pos(AnsiLowerCase(CLASS_DERECTIVE), LText);
  while LPosition > 0 do
  begin
    if not Assigned(Result) then
    begin
      Result := TStringList.Create;
      Result.Clear;
    end;

    LClassName := FirstClassName(LText, LPosition);
    if LClassName <> '' then Result.Add(LClassName);
    LClassName := '';

    Delete(LText, 1, LPosition);
    LPosition := Pos(AnsiLowerCase(CLASS_DERECTIVE), LText);
  end;
end;

class function TClassParser.FirstClassName(AText: string; AClassDirectiveStartPosition: Integer): string;
var
  Aux: string;
  I: Integer;
begin
  Result := '';

  Aux := AText;
  Delete(Aux, AClassDirectiveStartPosition, Length(Aux) - AClassDirectiveStartPosition);
  ShowMessage(Aux);

  Aux := ReverseString(Aux);

  for I := 1 to Length(Aux) do
  begin
    if Aux[I] = '' then
    begin
      Break;
    end
    else
    begin
      Result := Result + Aux[I];
    end;
  end;

  ShowMessage(Result);
end;

end.
