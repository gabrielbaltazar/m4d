unit M4DExperts.Wizard.NewMigration.Wizard;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.Controls,
  ToolsAPI,
  M4DExperts.OTA.Helper,
  M4DExperts.Wizard.NewMigration.Forms,
  M4DExperts.Wizard.NewMigration.Model,
  M4DExperts.Wizard.NewMigration.Creator;

type
  TM4DExpertsWizardNewMigrationWizard = class(TNotifierObject, IOTAWizard)
  protected
    procedure CreateMenu;
    procedure OnNewMigrationClick(Sender: TObject);

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

{ TM4DExpertsWizardNewMigrationWizard }

constructor TM4DExpertsWizardNewMigrationWizard.Create;
begin
  CreateMenu;
end;

procedure TM4DExpertsWizardNewMigrationWizard.CreateMenu;
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

  LItemExecute := LItemMenu.Find('New Migration');
  if LItemExecute = nil then
  begin
    LItemExecute := TMenuItem.Create(LItemMenu);
    LItemExecute.Caption := 'New Migration';
    LItemMenu.Add(LItemExecute);
  end;

  LItemExecute.OnClick := OnNewMigrationClick;
end;

procedure TM4DExpertsWizardNewMigrationWizard.Execute;
begin
end;

function TM4DExpertsWizardNewMigrationWizard.GetIDString: string;
begin
  Result := Self.ClassName;
end;

function TM4DExpertsWizardNewMigrationWizard.GetName: string;
begin
  Result := Self.ClassName;
end;

function TM4DExpertsWizardNewMigrationWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

class function TM4DExpertsWizardNewMigrationWizard.New: IOTAWizard;
begin
  Result := Self.Create;
end;

procedure TM4DExpertsWizardNewMigrationWizard.OnNewMigrationClick(Sender: TObject);
var
  LForm : TFrmM4DExpertsWizarNewMigrationForms;
  LModel: TM4DExpertsNewMigrationModel;
  LCreator: IOTACreator;
begin
  LForm := TFrmM4DExpertsWizarNewMigrationForms.Create(nil);
  try
    LForm.ShowModal;
    if LForm.ModalResult = mrOK then
    begin
      LModel := LForm.Model;
      try
        LCreator := TMENewMigrationCreator.New(LModel);
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
