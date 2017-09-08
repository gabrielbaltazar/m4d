program PerformanceTest;

uses
  Vcl.Forms,
  UTest in 'UTest.pas' {Form2},
  MDescription1 in '..\Demo\Migrations\MDescription1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
