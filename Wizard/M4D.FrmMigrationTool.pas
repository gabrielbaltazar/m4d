unit M4D.FrmMigrationTool;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, M4D.BaseDockForm, Vcl.ComCtrls, Vcl.ToolWin, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TM4DFrmMigrationTool = class(TM4DBaseDockableForm)
    ToolBar1: TToolBar;
    btnUp: TToolButton;
    btnUpAll: TToolButton;
    ToolButton3: TToolButton;
    ImageList: TImageList;
    List: TListView;
    btnDown: TToolButton;
    btnDownAll: TToolButton;
    ToolButton1: TToolButton;
    btnRefresh: TToolButton;
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure RemoveExampleDockForm;
    class procedure ShowExampleDockForm;
    class procedure CreateExampleDockForm;
  end;

var
  BaseDockableForm1: TM4DFrmMigrationTool;

implementation

uses
  ToolsAPI, M4D.UnitValidator, M4D.ClassParser;

{$R *.dfm}

var
  FormInstance: TM4DBaseDockableForm = nil;

{ TBaseDockableForm1 }

procedure TM4DFrmMigrationTool.btnRefreshClick(Sender: TObject);
var
  LProject: IOTAProject;
  LModule: IOTAModuleInfo;
  I: Integer;
  Item: TListItem;
  LClasses: TStringList;
  J: Integer;
begin
  inherited;
  LProject := GetActiveProject;

  if Assigned(LProject) then
  begin
    for I := 0 to LProject.GetModuleCount - 1 do
    begin
      LModule := LProject.GetModule(I);

      if TUnitValidator.isAValidUnitToTry(LModule.FileName) then
      begin
        Item := List.Items.Add;
        Item.Caption := LModule.FileName;

        LClasses := TClassParser.ClassesNames(LModule.FileName);

        if Assigned(LClasses) then
        begin
          for J := 0 to LClasses.Count - 1 do
          begin
            Item.SubItems.Add(LClasses.Strings[J]);
          end;
        end;
      end;
    end;
  end;
end;

class procedure TM4DFrmMigrationTool.CreateExampleDockForm;
begin
  if not Assigned(FormInstance) then
    CreateDockableForm(FormInstance, TM4DFrmMigrationTool);
end;

class procedure TM4DFrmMigrationTool.RemoveExampleDockForm;
begin
  FreeDockableForm(FormInstance);
end;

class procedure TM4DFrmMigrationTool.ShowExampleDockForm;
begin
  CreateExampleDockForm;
  ShowDockableForm(FormInstance);
end;

end.
