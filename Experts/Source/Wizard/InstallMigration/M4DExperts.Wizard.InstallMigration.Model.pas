unit M4DExperts.Wizard.InstallMigration.Model;

interface

uses
  System.SysUtils;

type
  TM4DExpertsWizardInstallMigrationModel = class
  private
    FPrefix: string;
    FDirectory: string;
  public
    function GetFullFileName: string;
    function GetUnitName: string;

    property Prefix: string read FPrefix write FPrefix;
    property Directory: string read FDirectory write FDirectory;
  end;

implementation

{ TM4DExpertsWizardInstallMigrationModel }

function TM4DExpertsWizardInstallMigrationModel.GetFullFileName: string;
begin
  Result := Format('%s\%s.pas', [FDirectory, GetUnitName]);
  ForceDirectories(ExtractFilePath(Result));
end;

function TM4DExpertsWizardInstallMigrationModel.GetUnitName: string;
begin
  Result := 'uMigrations';
  if FPrefix <> EmptyStr then
    Result := Format('%s.Migrations', [FPrefix]);
end;

end.
