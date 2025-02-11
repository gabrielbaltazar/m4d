unit M4DExperts.Wizard.InstallMigration.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  ToolsAPI,
  Vcl.FileCtrl,
  M4DExperts.Wizard.InstallMigration.Model,
  M4DExperts.OTA.Helper;

type
  TFrmM4DExpertsWizardInstallMigrationForms = class(TForm)
    PnlTop: TPanel;
    Panel1: TPanel;
    Label3: TLabel;
    BtnCancel: TShape;
    BtnConfirm: TShape;
    LblConfirm: TLabel;
    LblCancel: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    EdtSaveAs: TEdit;
    EdtPrefix: TEdit;
    BtnPath: TButton;
    procedure FormCreate(Sender: TObject);
    procedure LblCancelClick(Sender: TObject);
    procedure LblConfirmClick(Sender: TObject);
    procedure BtnPathClick(Sender: TObject);
  private
  public
    function Model: TM4DExpertsWizardInstallMigrationModel;
  end;

implementation

{$R *.dfm}

procedure TFrmM4DExpertsWizardInstallMigrationForms.BtnPathClick(Sender: TObject);
var
  LDirectory: string;
begin
  LDirectory := EdtSaveAs.Text;

  SelectDirectory('Select Directory', ExtractFilePath(GetActiveProject.FileName), LDirectory);
  EdtSaveAs.Text := LDirectory;
end;

procedure TFrmM4DExpertsWizardInstallMigrationForms.FormCreate(Sender: TObject);
begin
  EdtSaveAs.Text := (ExtractFilePath(GetActiveProject.FileName) + '\Migrations').Replace('\\', '\');
end;

procedure TFrmM4DExpertsWizardInstallMigrationForms.LblCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmM4DExpertsWizardInstallMigrationForms.LblConfirmClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

function TFrmM4DExpertsWizardInstallMigrationForms.Model: TM4DExpertsWizardInstallMigrationModel;
begin
  Result := TM4DExpertsWizardInstallMigrationModel.Create;
  try
    Result.Directory := EdtSaveAs.Text;
    Result.Prefix := EdtPrefix.Text;
  except
    Result.Free;
    raise;
  end;
end;

end.
