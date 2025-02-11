unit M4DExperts.Wizard.InstallMigration.Wizard;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.Controls,
  ToolsAPI,
  M4DExperts.OTA.Helper,
  M4DExperts.Wizard.InstallMigration.Forms,
  M4DExperts.Wizard.InstallMigration.Model,
  M4DExperts.Wizard.InstallMigration.Creator;

type
  TM4DExpertsWizardInstallMigrationWizard = class(TNotifierObject, IOTAWizard)
  protected
    procedure CreateMenu;
    procedure OnInstallMigrationClick(Sender: TObject);

    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;

    { Launch the AddIn }
    procedure Execute;
  public
    constructor Create;
    class function New: IOTAWizard;
  end;

implementation

{ TM4DExpertsWizardInstallMigrationWizard }

constructor TM4DExpertsWizardInstallMigrationWizard.Create;
begin
  CreateMenu;
end;

procedure TM4DExpertsWizardInstallMigrationWizard.CreateMenu;
var
  LDelphiMenu: TMainMenu;
  LItemMenu: TMenuItem;
  LItemExecute: TMenuItem;
begin
  LDelphiMenu := TM4DExpertsOTAHelper.GetMainMenu;
  LItemMenu := LDelphiMenu.Items.Find('Migrations');
  if LItemMenu = nil then
  begin
    LItemMenu := TMenuItem.Create(nil);
    LItemMenu.Caption := 'Migrations';
    LDelphiMenu.Items.Add(LItemMenu);
  end;

  LItemExecute := LItemMenu.Find('Install Migration');
  if LItemExecute = nil then
  begin
    LItemExecute := TMenuItem.Create(LItemMenu);
    LItemExecute.Caption := 'Install Migration';
    LItemExecute.GroupIndex := 0;
    LItemMenu.Add(LItemExecute);
  end;

  LItemExecute.OnClick := OnInstallMigrationClick;
end;

procedure TM4DExpertsWizardInstallMigrationWizard.Execute;
begin
end;

function TM4DExpertsWizardInstallMigrationWizard.GetIDString: string;
begin
  Result := Self.ClassName;
end;

function TM4DExpertsWizardInstallMigrationWizard.GetName: string;
begin
  Result := Self.ClassName;
end;

function TM4DExpertsWizardInstallMigrationWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

class function TM4DExpertsWizardInstallMigrationWizard.New: IOTAWizard;
begin
  Result := Self.Create;
end;

procedure TM4DExpertsWizardInstallMigrationWizard.OnInstallMigrationClick(Sender: TObject);
var
  LForm : TFrmM4DExpertsWizardInstallMigrationForms;
  LModel: TM4DExpertsWizardInstallMigrationModel;
  LCreator: IOTACreator;
begin
  LForm := TFrmM4DExpertsWizardInstallMigrationForms.Create(nil);
  try
    LForm.ShowModal;
    if LForm.ModalResult = mrOK then
    begin
      LModel := LForm.Model;
      try
        LCreator := TM4DExpertsWizardInstallMigrationCreator.New(LModel);
        (BorlandIDEServices as IOTAModuleServices).CreateModule(LCreator);
        (BorlandIDEServices as IOTAModuleServices).CurrentModule.FileName := LModel.GetFullFileName;
        (BorlandIDEServices as IOTAModuleServices).CurrentModule.Save(False, True);
      finally
        LModel.Free;
      end;
    end;
  finally
    LForm.Free;
  end;
end;

end.
