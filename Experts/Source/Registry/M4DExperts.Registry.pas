unit M4DExperts.Registry;

interface

uses
  ToolsAPI,
  M4DExperts.Wizard.InstallMigration.Wizard,
  M4DExperts.Wizard.NewMigration.Wizard;

{$IFDEF M4DPkg}
procedure Register;
{$ELSE}
function RegisterWizardMigration(ABorlandIDEServices: IBorlandIDEServices;
  ARegisterProc: TWizardRegisterProc; var ATerminate: TWizardTerminateProc): Boolean; stdcall;
{$ENDIF}

implementation

{$IFDEF M4DPkg}
procedure Register;
begin
  RegisterPackageWizard(TM4DExpertsWizardInstallMigrationWizard.New);
  RegisterPackageWizard(TM4DExpertsWizardNewMigrationWizard.New);
end;
{$ELSE}
function RegisterWizardMigration(ABorlandIDEServices: IBorlandIDEServices;
  ARegisterProc: TWizardRegisterProc; var ATerminate: TWizardTerminateProc): Boolean; stdcall;
begin
  Result := True;
  ARegisterProc(TM4DExpertsWizardInstallMigrationWizard.New);
  ARegisterProc(TM4DExpertsWizardNewMigrationWizard.New);
end;
{$ENDIF}

end.
