unit M4DExperts.Wizard.NewMigration.Model;

interface

uses
  System.SysUtils,
  System.Classes,
  System.DateUtils;

type
  TM4DExpertsNewMigrationModel = class
  private
    FName: string;
    FDescription: string;
    FCreationDate: TDateTime;
    FSequence: Integer;
    FPrefix: string;
    FDirectory: string;

    function StrSequence: string;
  public
    property Name: string read FName write FName;
    property Description: string read FDescription write FDescription;
    property CreationDate: TDateTime read FCreationDate write FCreationDate;
    property Sequence: Integer read FSequence write FSequence;
    property Prefix: string read FPrefix write FPrefix;
    property Directory: string read FDirectory write FDirectory;

    function GetFullFileName: string;
    function GetUnitName: string;
    function GetClassName: string;
    function GetEncodeDateCommand: string;
  end;

implementation

{ TM4DExpertsNewMigrationModel }

function TM4DExpertsNewMigrationModel.GetClassName: string;
begin
  Result := 'T' + GetUnitName.Replace('.', EmptyStr);
end;

function TM4DExpertsNewMigrationModel.GetEncodeDateCommand: string;
var
  LYear: Integer;
  LMonth: Integer;
  LDay: Integer;
  LHour: Integer;
  LMinute: Integer;
  LSecond: Integer;
begin
  LYear := YearOf(FCreationDate);
  LMonth := MonthOf(FCreationDate);
  LDay := DayOf(FCreationDate);
  LHour := HourOf(FCreationDate);
  LMinute := MinuteOf(FCreationDate);
  LSecond := SecondOf(FCreationDate);

  Result := Format('EncodeDateTime(%d, %d, %d, %d, %d, %d, 0)', [LYear, LMonth, LDay,
    LHour, LMinute, LSecond]);
end;

function TM4DExpertsNewMigrationModel.GetFullFileName: string;
begin
  Result := Format('%s\%s.pas', [FDirectory, GetUnitName]);
end;

function TM4DExpertsNewMigrationModel.GetUnitName: string;
begin
  Result := Format('M%s%s', [StrSequence, FName]);
  if FPrefix <> EmptyStr then
    Result := Format('%s.Migrations.M%s.%s', [FPrefix, StrSequence, FName]);
end;

function TM4DExpertsNewMigrationModel.StrSequence: string;
begin
  Result := FSequence.ToString.PadLeft(6, '0');
end;

end.
