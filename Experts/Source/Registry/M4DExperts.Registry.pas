unit M4DExperts.Registry;

interface

uses
  ToolsAPI,
  M4DExperts.Wizard.NewMigration.Wizard;

procedure Register;

implementation

procedure Register;
begin
  RegisterPackageWizard(TM4DExpertsWizardNewMigrationWizard.New);
end;

end.
