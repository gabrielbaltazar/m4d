unit M4D.BaseDockForm;

interface

uses
  Windows, SysUtils, Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  // You must link to the DesignIde/DsnIdeXX package to compile this unit
  DockForm;

type
  TM4DBaseDockableForm = class(TDockableForm)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TBaseDockableFormClass = class of TM4DBaseDockableForm;

procedure ShowDockableForm(Form: TM4DBaseDockableForm);
procedure CreateDockableForm(var FormVar: TM4DBaseDockableForm; FormClass: TBaseDockableFormClass);
procedure FreeDockableForm(var FormVar: TM4DBaseDockableForm);

implementation

{$R *.dfm}

uses DeskUtil;

procedure ShowDockableForm(Form: TM4DBaseDockableForm);
begin
  if not Assigned(Form) then
    Exit;
  if not Form.Floating then
  begin
    Form.ForceShow;
    FocusWindow(Form);
  end
  else
    Form.Show;
end;

procedure RegisterDockableForm(FormClass: TBaseDockableFormClass;
  var FormVar; const FormName: string);
begin
  if @RegisterFieldAddress <> nil then
    RegisterFieldAddress(FormName, @FormVar);

  RegisterDesktopFormClass(FormClass, FormName, FormName);
end;

procedure UnRegisterDockableForm(var FormVar; const FormName: string);
begin
  if @UnregisterFieldAddress <> nil then
    UnregisterFieldAddress(@FormVar);
end;

procedure CreateDockableForm(var FormVar: TM4DBaseDockableForm; FormClass: TBaseDockableFormClass);
begin
  TCustomForm(FormVar) := FormClass.Create(nil);
  RegisterDockableForm(FormClass, FormVar, TCustomForm(FormVar).Name);
end;

procedure FreeDockableForm(var FormVar: TM4DBaseDockableForm);
begin
  if Assigned(FormVar) then
  begin
    UnRegisterDockableForm(FormVar, FormVar.Name);
    FreeAndNil(FormVar);
  end;
end;

{ TIDEDockableForm }

constructor TM4DBaseDockableForm.Create(AOwner: TComponent);
begin
  inherited;
  DeskSection := Name;
  AutoSave := True;
  SaveStateNecessary := True;
end;

destructor TM4DBaseDockableForm.Destroy;
begin
  SaveStateNecessary := True;
  inherited;
end;

end.
