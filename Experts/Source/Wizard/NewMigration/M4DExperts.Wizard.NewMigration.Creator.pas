unit M4DExperts.Wizard.NewMigration.Creator;

interface

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  ToolsAPI,
  M4DExperts.OTA.Helper,
  M4DExperts.Wizard.NewMigration.Model;

type
  TM4DExpertsWizardNewMigrationFile = class(TNotifierObject, IOTAFile)
  private
    FModel: TM4DExpertsNewMigrationModel;
  protected
    function GetSource: string;
    function GetAge: TDateTime;
  public
    constructor Create(AModel: TM4DExpertsNewMigrationModel);
    class function New(AModel: TM4DExpertsNewMigrationModel): IOTAFile;
  end;

  TM4DExpertsWizardNewMigrationCreator = class(TNotifierObject, IOTACreator, IOTAModuleCreator)
  private
    FModel: TM4DExpertsNewMigrationModel;
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
    constructor Create(AModel: TM4DExpertsNewMigrationModel);
    class function New(AModel: TM4DExpertsNewMigrationModel): IOTACreator;
  end;

implementation

{ TM4DExpertsWizardNewMigrationCreator }

constructor TM4DExpertsWizardNewMigrationCreator.Create(AModel: TM4DExpertsNewMigrationModel);
begin
  FModel := AModel;
end;

procedure TM4DExpertsWizardNewMigrationCreator.FormCreated(const AFormEditor: IOTAFormEditor);
begin
end;

function TM4DExpertsWizardNewMigrationCreator.GetAncestorName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardNewMigrationCreator.GetCreatorType: string;
begin
  Result := sUnit;
end;

function TM4DExpertsWizardNewMigrationCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TM4DExpertsWizardNewMigrationCreator.GetFileSystem: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardNewMigrationCreator.GetFormName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardNewMigrationCreator.GetImplFileName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardNewMigrationCreator.GetIntfFileName: string;
begin
  Result := EmptyStr;
end;

function TM4DExpertsWizardNewMigrationCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TM4DExpertsWizardNewMigrationCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProject;
end;

function TM4DExpertsWizardNewMigrationCreator.GetShowForm: Boolean;
begin
  Result := False;
end;

function TM4DExpertsWizardNewMigrationCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TM4DExpertsWizardNewMigrationCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

class function TM4DExpertsWizardNewMigrationCreator.New(AModel: TM4DExpertsNewMigrationModel): IOTACreator;
begin
  Result := Self.Create(AModel);
end;

function TM4DExpertsWizardNewMigrationCreator.NewFormFile(const AFormIdent, AAncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TM4DExpertsWizardNewMigrationCreator.NewImplSource(const AModuleIdent, AFormIdent, AAncestorIdent: string): IOTAFile;
begin
  Result := TM4DExpertsWizardNewMigrationFile.New(FModel);
end;

function TM4DExpertsWizardNewMigrationCreator.NewIntfSource(const AModuleIdent, AFormIdent, AAncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{ TM4DExpertsWizardNewMigrationFile }

constructor TM4DExpertsWizardNewMigrationFile.create(AModel: TM4DExpertsNewMigrationModel);
begin
  FModel := AModel;
end;

function TM4DExpertsWizardNewMigrationFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TM4DExpertsWizardNewMigrationFile.GetSource: string;
begin
  Result := 'unit %0:s;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  System.SysUtils,' + sLineBreak +
    '  System.DateUtils,' + sLineBreak +
    '  M4D,' + sLineBreak +
    '  M4D.Migrations,' + sLineBreak +
    '  M4D.Defaults,' + sLineBreak +
    '  M4D.RegistryMigrations,' + sLineBreak +
    '  %5:sMigrations;' + sLineBreak +
    '' + sLineBreak +
    'type' + sLineBreak +
    '  %1:s = class(TMigrations)' + sLineBreak +
    '  public' + sLineBreak +
    '    procedure Setup; override;' + sLineBreak +
    '    procedure Up; override;' + sLineBreak +
    '    procedure Down; override;' + sLineBreak +
    '  end;' + sLineBreak +
    ' ' + sLineBreak +
    'implementation' + sLineBreak +
    '' + sLineBreak +
    '{ %1:s }' + sLineBreak +
    '' + sLineBreak +
    'procedure %1:s.Down;' + sLineBreak +
    'begin' + sLineBreak +
    '  inherited;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure %1:s.Setup;' + sLineBreak +
    'begin' + sLineBreak +
    '  Self.SeqVersion := %2:d;' + sLineBreak +
    '  Self.Version := ''%3:s'';' + sLineBreak +
    '  Self.DateTime := %4:s;' + sLineBreak +
    '  inherited;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure %1:s.Up;' + sLineBreak +
    'begin' + sLineBreak +
    '' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'initialization' + sLineBreak +
    '  TM4DRegistryMigrations.GetInstance.Add(%1:s);' + sLineBreak +
    '' + sLineBreak +
    'end.';

  Result := Format(Result, [FModel.GetUnitName, FModel.GetClassName, FModel.Sequence,
    FModel.Description, FModel.GetEncodeDateCommand,
    IfThen(FModel.Prefix.Trim.IsEmpty, 'u', FModel.Prefix + '.')]);
end;

class function TM4DExpertsWizardNewMigrationFile.New(AModel: TM4DExpertsNewMigrationModel): IOTAFile;
begin
  Result := Self.Create(AModel);
end;

end.
