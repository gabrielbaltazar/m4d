program M4DDBDemo;

uses
  Vcl.Forms,
  FireDAC.DApt,
  UFrmDBMain in 'units\classes\UFrmDBMain.pas' {Form2},
  UDMDBDemo in 'units\classes\UDMDBDemo.pas' {DMDBDemo: TDataModule},
  MCreateTables in 'Migrations\MCreateTables.pas',
  MCreatePopulateTables in 'Migrations\MCreatePopulateTables.pas',
  UDBMigrationHistory in 'units\classes\UDBMigrationHistory.pas',
  UDBRegisterMigration in 'units\classes\UDBRegisterMigration.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMDBDemo, DMDBDemo);
  DMDBDemo.SQLiteConection.Connected := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
