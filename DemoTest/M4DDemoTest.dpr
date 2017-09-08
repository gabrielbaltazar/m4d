program M4DDemoTest;

uses
  Vcl.Forms,
  M4D,
  UFrmMainDBDemo in 'units\classes\UFrmMainDBDemo.pas' {frmMainDBDemo},
  UFrmMain in 'UFrmMain.pas' {Form2},
  MCreatePopulateTables in 'Migrations\MCreatePopulateTables.pas',
  MCreateTables in 'Migrations\MCreateTables.pas',
  UDMDBDemo in 'units\classes\UDMDBDemo.pas' {DMDBDemo: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMDBDemo, DMDBDemo);

//  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TFrmMainDBDemo, frmMainDBDemo);

  Application.Run;
end.
