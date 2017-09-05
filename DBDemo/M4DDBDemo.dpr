program M4DDBDemo;

uses
  Vcl.Forms,
  UFrmMainDBDemo in 'UFrmMainDBDemo.pas' {frmMainDBDemo},
  MCreateTables in 'Migrations\MCreateTables.pas',
  UDMDBDemo in 'UDMDBDemo.pas' {DMDBDemo: TDataModule},
  MCreatePopulateTables in 'Migrations\MCreatePopulateTables.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMDBDemo, DMDBDemo);
  Application.CreateForm(TfrmMainDBDemo, frmMainDBDemo);
  Application.Run;
end.
