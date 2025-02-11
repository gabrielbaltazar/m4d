unit M4DExperts.Wizard.NewMigration.Forms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.FileCtrl,
  ToolsAPI,
  M4DExperts.Wizard.NewMigration.Model,
  M4DExperts.OTA.Helper;

type
  TFrmM4DExpertsWizarNewMigrationForms = class(TForm)
    PnlTop: TPanel;
    Panel1: TPanel;
    Label3: TLabel;
    BtnCancel: TShape;
    BtnConfirm: TShape;
    LblConfirm: TLabel;
    LblCancel: TLabel;
    Panel2: TPanel;
    LblDescription: TLabel;
    lblName: TLabel;
    lblPrimaryKey: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    EdtDescription: TEdit;
    EdtName: TEdit;
    EdtSequence: TEdit;
    EdtMigrationDate: TDateTimePicker;
    Label1: TLabel;
    EdtSaveAs: TEdit;
    EdtPrefix: TEdit;
    Label2: TLabel;
    BtnPath: TButton;
    procedure LblCancelClick(Sender: TObject);
    procedure LblConfirmClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnPathClick(Sender: TObject);
    procedure EdtDescriptionChange(Sender: TObject);
  private
  public
    function Model: TM4DExpertsNewMigrationModel;
  end;

implementation

{$R *.dfm}

procedure TFrmM4DExpertsWizarNewMigrationForms.BtnPathClick(Sender: TObject);
var
  LDirectory: string;
begin
  LDirectory := EdtSaveAs.Text;

  SelectDirectory('Select Directory', ExtractFilePath(GetActiveProject.FileName), LDirectory);
  EdtSaveAs.Text := LDirectory;
end;

procedure TFrmM4DExpertsWizarNewMigrationForms.EdtDescriptionChange(Sender: TObject);
begin
  if EdtDescription.Text <> EmptyStr then
    EdtName.Text := StringReplace(EdtDescription.Text, ' ', '', [rfReplaceAll]);
end;

procedure TFrmM4DExpertsWizarNewMigrationForms.FormCreate(Sender: TObject);
begin
  EdtMigrationDate.DateTime := Now;
  EdtSequence.Text := '1';
  EdtSaveAs.Text := (ExtractFilePath(GetActiveProject.FileName) + '\Migrations').Replace('\\', '\');
end;

procedure TFrmM4DExpertsWizarNewMigrationForms.LblCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmM4DExpertsWizarNewMigrationForms.LblConfirmClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

function TFrmM4DExpertsWizarNewMigrationForms.Model: TM4DExpertsNewMigrationModel;
begin
  Result := TM4DExpertsNewMigrationModel.Create;
  try
    Result.Name := EdtName.Text;
    Result.Description := EdtDescription.Text;
    Result.CreationDate := EdtMigrationDate.DateTime;
    Result.Sequence := StrToIntDef(EdtSequence.Text, 1);
    Result.Directory := EdtSaveAs.Text;
    Result.Prefix := EdtPrefix.Text;
  except
    Result.Free;
    raise;
  end;
end;

end.
