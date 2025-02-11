library M4DExperts;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters.

  Important note about VCL usage: when this DLL will be implicitly
  loaded and this DLL uses TWicImage / TImageCollection created in
  any unit initialization section, then Vcl.WicImageInit must be
  included into your library's USES clause. }

uses
  System.SysUtils,
  System.Classes,
  ToolsAPI,
  M4DExperts.OTA.Helper in 'Source\Helper\M4DExperts.OTA.Helper.pas',
  M4DExperts.Wizard.NewMigration.Creator in 'Source\Wizard\NewMigration\M4DExperts.Wizard.NewMigration.Creator.pas',
  M4DExperts.Wizard.NewMigration.Forms in 'Source\Wizard\NewMigration\M4DExperts.Wizard.NewMigration.Forms.pas' {FrmM4DExpertsWizarNewMigrationForms},
  M4DExperts.Wizard.NewMigration.Model in 'Source\Wizard\NewMigration\M4DExperts.Wizard.NewMigration.Model.pas',
  M4DExperts.Wizard.NewMigration.Wizard in 'Source\Wizard\NewMigration\M4DExperts.Wizard.NewMigration.Wizard.pas',
  M4DExperts.Wizard.InstallMigration.Creator in 'Source\Wizard\InstallMigration\M4DExperts.Wizard.InstallMigration.Creator.pas',
  M4DExperts.Wizard.InstallMigration.Forms in 'Source\Wizard\InstallMigration\M4DExperts.Wizard.InstallMigration.Forms.pas' {FrmM4DExpertsWizardInstallMigrationForms},
  M4DExperts.Wizard.InstallMigration.Model in 'Source\Wizard\InstallMigration\M4DExperts.Wizard.InstallMigration.Model.pas',
  M4DExperts.Wizard.InstallMigration.Wizard in 'Source\Wizard\InstallMigration\M4DExperts.Wizard.InstallMigration.Wizard.pas',
  M4DExperts.Registry in 'Source\Registry\M4DExperts.Registry.pas';

exports
  RegisterWizardMigration Name WizardEntryPoint;

{$R *.res}

begin
end.
