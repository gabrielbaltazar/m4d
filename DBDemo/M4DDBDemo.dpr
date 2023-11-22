 program M4DDBDemo;

uses
  Vcl.Forms,
  FireDAC.DApt,
  UFrmDBMain in 'units\classes\UFrmDBMain.pas' {Form2},
  UDMDBDemo in 'units\classes\UDMDBDemo.pas' {DMDBDemo: TDataModule},
  MCreateTables in 'Migrations\MCreateTables.pas',
  MCreatePopulateTables in 'Migrations\MCreatePopulateTables.pas',
  UDBMigrationHistory in 'units\classes\UDBMigrationHistory.pas',
  UDBRegisterMigration in 'units\classes\UDBRegisterMigration.pas',
  MigrationInit in 'Migrations\MigrationInit.pas',
  MCreateOtherTable in 'Migrations\MCreateOtherTable.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  if not Assigned(DMDBDemo) then
    Application.CreateForm(TDMDBDemo, DMDBDemo);
  StartMigration;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
