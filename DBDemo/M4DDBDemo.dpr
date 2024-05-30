 program M4DDBDemo;

uses
  Vcl.Forms,
  FireDAC.DApt,
  M4D.RegistryMigrations,
  M4D.RegistryMigrations.Firedac,
  UFrmDBMain in 'units\classes\UFrmDBMain.pas' {Form2},
  UDMDBDemo in 'units\classes\UDMDBDemo.pas' {DMDBDemo: TDataModule},
  MCreateTables in 'Migrations\MCreateTables.pas',
  MCreatePopulateTables in 'Migrations\MCreatePopulateTables.pas',
  MCreateOtherTable in 'Migrations\MCreateOtherTable.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  if not Assigned(DMDBDemo) then
    Application.CreateForm(TDMDBDemo, DMDBDemo);
  TM4DRegistryMigrations.GetInstance
    .History(TM4DMigrationsHistoryFiredac.New(DMDBDemo.FDQMigration))
    .ExecutePending;

  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
