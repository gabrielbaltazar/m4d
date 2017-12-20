program M4DFMXDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UFrmMain in 'UFrmMain.pas' {Form3},
  MDescription1 in 'Migrations\MDescription1.pas',
  MDescription2 in 'Migrations\MDescription2.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
