unit M4DExperts.Wizard.InstallMigration.Creator;

interface

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  M4DExperts.OTA.Helper,
  M4DExperts.Wizard.InstallMigration.Model;

type
  TM4DExpertsWizardInstallMigrationFile = class(TNotifierObject, IOTAFile)
  private
    FModel: TM4DExpertsWizardInstallMigrationModel;
  protected
    function GetSource: string;
    function GetAge: TDateTime;
  public
    constructor Create(AModel: TM4DExpertsWizardInstallMigrationModel);
    class function New(AModel: TM4DExpertsWizardInstallMigrationModel): IOTAFile;
  end;

  TM4DExpertsWizardInstallMigrationCreator = class(TNotifierObject, IOTACreator, IOTAModuleCreator)
  private
    FModel: TM4DExpertsWizardInstallMigrationModel;
  protected
    // IOTACreator
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;

    // IOTAModuleCreator
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const AFormIdent, AAncestorIdent: string): IOTAFile;
    function NewIntfSource(const AModuleIdent, AFormIdent, AAncestorIdent: string): IOTAFile;
    function NewImplSource(const AModuleIdent: string; const AFormIdent: string;
      const AAncestorIdent: string): IOTAFile;
    procedure FormCreated(const AFormEditor: IOTAFormEditor);
  public
    constructor Create(AModel: TM4DExpertsWizardInstallMigrationModel);
    class function New(AModel: TM4DExpertsWizardInstallMigrationModel): IOTACreator;
  end;

implementation

{ TM4DExpertsWizardInstallMigrationFile }

constructor TM4DExpertsWizardInstallMigrationFile.Create(AModel: TM4DExpertsWizardInstallMigrationModel);
begin
  FModel := AModel;
end;

function TM4DExpertsWizardInstallMigrationFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TM4DExpertsWizardInstallMigrationFile.GetSource: string;
begin
  Result := 'unit %0:s;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  System.SysUtils,' + sLineBreak +
    '  Firedac.Comp.Client,' + sLineBreak +
    '  M4D.RegistryMigrations.Firedac,' + sLineBreak +
    '  M4D.RegistryMigrations,' + sLineBreak +
    '  M4D.MigrationsFacade,' + sLineBreak +
    '  M4D;' + sLineBreak +
    '' + sLineBreak +
    'procedure StartMigration;' + sLineBreak +
    'function GetQuery: TFDQuery;' + sLineBreak +
    '' + sLineBreak +
    'implementation' + sLineBreak +
    '' + sLineBreak +
    'function GetQuery: TFDQuery;' + sLineBreak +
    'begin' + sLineBreak +
    '' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure StartMigration;' + sLineBreak +
    'begin' + sLineBreak +
    '  TM4DRegistryMigrations.GetInstance' + sLineBreak +
    '    .History(TM4DMigrationsHistoryFiredac.New(GetQuery))' + sLineBreak +
    '    .ExecutePending;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'end.';

  Result := Format(Result, [FModel.GetUnitName]);
end;

class function TM4DExpertsWizardInstallMigrationFile.New(AModel: TM4DExpertsWizardInstallMigrationModel): IOTAFile;
begin
  Result := Self.Create(AModel);
end;

{ TM4DExpertsWizardInstallMigrationCreator }

constructor TM4DExpertsWizardInstallMigrationCreator.Create(AModel: TM4DExpertsWizardInstallMigrationModel);
begin
  FModel := AModel;
end;

procedure TM4DExpertsWizardInstallMigrationCreator.FormCreated(const AFormEditor: IOTAFormEditor);
begin
end;

function TM4DExpertsWizardInstallMigrationCreator.GetAncestorName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetCreatorType: string;
begin
  Result := sUnit;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetFileSystem: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetFormName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetImplFileName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetIntfFileName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetShowForm: Boolean;
begin
  Result := False;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TM4DExpertsWizardInstallMigrationCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

class function TM4DExpertsWizardInstallMigrationCreator.New(
  AModel: TM4DExpertsWizardInstallMigrationModel): IOTACreator;
begin
  Result := Self.Create(AModel);
end;

function TM4DExpertsWizardInstallMigrationCreator.NewFormFile(const AFormIdent,
  AAncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TM4DExpertsWizardInstallMigrationCreator.NewImplSource(const AModuleIdent, AFormIdent,
  AAncestorIdent: string): IOTAFile;
begin
  Result := TM4DExpertsWizardInstallMigrationFile.New(FModel);
end;

function TM4DExpertsWizardInstallMigrationCreator.NewIntfSource(const AModuleIdent, AFormIdent,
  AAncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

end.
