unit M4D.Wizard;

interface

uses
  Classes, ToolsAPI, Winapi.Windows;

type
  TM4DWizard = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard, IOTARepositoryWizard60, IOTARepositoryWizard80, IOTAFormWizard)
  public
    // IOTAWizard
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    // IOTARepositoryWizard
    function GetAuthor : string;
    function GetComment : string;
    function GetPage : string;
    function GetGlyph: Cardinal;
    // IOTARepositoryWizard80
    function GetGalleryCategory: IOTAGalleryCategory;
    function GetPersonality: string;
    function GetDesigner: string;
  end;

type
  TM4DModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  public
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
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;

type
  TMigrationFile = class(TInterfacedObject, IOTAFile)
  private
    FSource: string;
  public
    function GetSource: string;
    function GetAge: TDateTime;
    constructor Create(const Source: string);
  end;

type
  TMigrationToolExpert = class(TNotifierObject, IOTANotifier, IOTAWizard, IOTAMenuWizard)
  public
    procedure Execute;
    function GetIDString: string;
    function GetMenuText: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Destroyed;
  end;

procedure AddSplashText;

procedure Register;

var
  iWizard: Integer;

implementation

uses
  Vcl.Forms, Vcl.Graphics, System.SysUtils, M4D.FrmMigrationTool;

procedure Register;
begin
//  iWizard := 0;
  RegisterPackageWizard(TM4DWizard.Create);
//  iWizard := (BorlandIDEServices As IOTAWizardServices).AddWizard(
//  InitialiseWizard(BorlandIDEServices));
  RegisterPackageWizard(TMigrationToolExpert.Create);
end;

{ TM4DWizard }

procedure TM4DWizard.Execute;
begin
  if Assigned(BorlandIDEServices) then
  begin
    (BorlandIDEServices as IOTAModuleServices).CreateModule(TM4DModuleCreator.Create);
  end;
end;

function TM4DWizard.GetAuthor: string;
begin
  Result := 'Edgar Borges Pavão';
end;

function TM4DWizard.GetComment: string;
begin
  Result := 'This is a wizard to create migrations.';
end;

function TM4DWizard.GetDesigner: string;
begin
//  Result := dVCL;
  Result := dAny;
end;

function TM4DWizard.GetGalleryCategory: IOTAGalleryCategory;
var
  Category: IOTAGalleryCategory;
  CatManager: IOTAGalleryCategoryManager;
begin
  CatManager := (BorlandIDEServices as IOTAGalleryCategoryManager);
  Assert(Assigned(CatManager));
  Category := CatManager.FindCategory(sCategoryDelphiNewFiles);
  Assert(Assigned(Category));
  Result := Category;
end;

function TM4DWizard.GetGlyph: Cardinal;
begin
  Result := 0;
end;

function TM4DWizard.GetIDString: string;
begin
  Result := 'M4D.Wizard';
end;

function TM4DWizard.GetName: string;
begin
  Result := 'Migration for Delphi';
end;

function TM4DWizard.GetPage: string;
begin
  Result := 'New';
end;

function TM4DWizard.GetPersonality: string;
begin
  Result := sDelphiPersonality;
end;

function TM4DWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure AddSplashText;
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp.LoadFromResourceName(HInstance, 'splash');
    SplashScreenServices.AddPluginBitmap('M4D', bmp.Handle, False, '', '');
  finally
    bmp.Free;
  end;
end;

{ TM4DModuleCreator }

procedure TM4DModuleCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TM4DModuleCreator.GetAncestorName: string;
begin
//  Result := 'Form';
  Result := 'Unit';
end;

function TM4DModuleCreator.GetCreatorType: string;
begin
//  Result := sForm;
  Result := sUnit;
end;

function TM4DModuleCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TM4DModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TM4DModuleCreator.GetFormName: string;
begin
  Result := '';
end;

function TM4DModuleCreator.GetImplFileName: string;
begin
  Result := '';
end;

function TM4DModuleCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TM4DModuleCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

function TM4DModuleCreator.GetOwner: IOTAModule;
var
  ModuleServices: IOTAModuleServices;
  Module: IOTAModule;
  NewModule: IOTAModule;
begin
  Result := nil;
  ModuleServices := (BorlandIDEServices as IOTAModuleServices);
  Module := ModuleServices.CurrentModule;

  if Module <> nil then
  begin
    if Module.QueryInterface(IOTAProject, NewModule) = S_OK then
      Result := NewModule

    else if Module.OwnerModuleCount > 0 then
    begin
      NewModule := Module.OwnerModules[0];
      if NewModule <> nil then
        if NewModule.QueryInterface(IOTAProject, Result) <> S_OK then
          Result := nil;
    end;
  end;
end;

function TM4DModuleCreator.GetShowForm: Boolean;
begin
  Result := False;
end;

function TM4DModuleCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TM4DModuleCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TM4DModuleCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TM4DModuleCreator.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
const
  sSource = 'unit MMigration1;                                          ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'interface                                                  ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'uses                                                       ' + Chr(10) + Chr(13) +
            '  M4D,                                                     ' + Chr(10) + Chr(13) +
            '  M4D.Migrations;                                          ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'type                                                       ' + Chr(10) + Chr(13) +
            '  TMyNewMigration1 = class(TMigrations)                    ' + Chr(10) + Chr(13) +
            '  public                                                   ' + Chr(10) + Chr(13) +
            '    procedure Setup; override;                             ' + Chr(10) + Chr(13) +
            '    procedure Up; override;                                ' + Chr(10) + Chr(13) +
            '    procedure Down; override;                              ' + Chr(10) + Chr(13) +
            '  end;                                                     ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'implementation                                             ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'uses                                                       ' + Chr(10) + Chr(13) +
            '  System.SysUtils;                                         ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            '{ TMyNewMigration1 }                                       ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'procedure TMyNewMigration1.Setup;                          ' + Chr(10) + Chr(13) +
            'begin                                                      ' + Chr(10) + Chr(13) +
            '  Self.Version := '''';                                    ' + Chr(10) + Chr(13) +
            '  Self.SeqVersion := 0;                                    ' + Chr(10) + Chr(13) +
            '  Self.DateTime := StrToDateTime(''%s'');                  ' + Chr(10) + Chr(13) +
            'end;                                                       ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'procedure TMyNewMigration1.Down;                           ' + Chr(10) + Chr(13) +
            'begin                                                      ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'end;                                                       ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'procedure TMyNewMigration1.Up;                             ' + Chr(10) + Chr(13) +
            'begin                                                      ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'end;                                                       ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'initialization                                             ' + Chr(10) + Chr(13) +
            '  RegisterMigration(TMyNewMigration1);                     ' + Chr(10) + Chr(13) +
            '                                                           ' + Chr(10) + Chr(13) +
            'end.                                                       ' ;
begin
  Result := TMigrationFile.Create(Format(sSource, [DatetimeToStr(Now)]));
end;

function TM4DModuleCreator.NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{ TMigrationFile }

constructor TMigrationFile.Create(const Source: string);
begin
  FSource := Source;
end;

function TMigrationFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TMigrationFile.GetSource: string;
begin
  Result := FSource;
end;

{ TMigrationToolExpert }

procedure TMigrationToolExpert.Destroyed;
begin

end;

procedure TMigrationToolExpert.Execute;
begin
  TM4DFrmMigrationTool.ShowExampleDockForm;
end;

function TMigrationToolExpert.GetIDString: string;
begin
  Result := 'M4D.MigrationTool';
end;

function TMigrationToolExpert.GetMenuText: string;
begin
  Result := 'Migration Tool';
end;

function TMigrationToolExpert.GetName: string;
begin
  Result := 'Migration Tool';
end;

function TMigrationToolExpert.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

initialization
  AddSplashText;

finalization
  TM4DFrmMigrationTool.RemoveExampleDockForm;

end.
