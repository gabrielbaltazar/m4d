unit UFrmDBMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  M4D.RegistryMigrations;

type
  TForm2 = class(TForm)
    pnlLeft: TPanel;
    pnlRigth: TPanel;
    memInfo: TMemo;
    btnExecuteAll: TButton;
    btnExecutePending: TButton;
    btnRollbackAll: TButton;
    pnlHistory: TPanel;
    Button4: TButton;
    btnMigrationsList: TButton;
    Button5: TButton;
    btnRollbackUntil: TButton;
    edtSeqToRollback: TEdit;
    btnExecuteUntil: TButton;
    edtSeqToExecute: TEdit;
    btnClearHistory: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    qryEmployers: TFDQuery;
    dtsEmployers: TDataSource;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    btnExecuteRange: TButton;
    edtStartExecute: TEdit;
    edtEndExecute: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    btnRollbackRange: TButton;
    edtStartRollback: TEdit;
    edtEndRollback: TEdit;
    procedure btnExecuteAllClick(Sender: TObject);
    procedure btnExecutePendingClick(Sender: TObject);
    procedure btnRollbackAllClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnRollbackUntilClick(Sender: TObject);
    procedure btnMigrationsListClick(Sender: TObject);
    procedure btnExecuteUntilClick(Sender: TObject);
    procedure btnClearHistoryClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnExecuteRangeClick(Sender: TObject);
    procedure btnRollbackRangeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  Generics.Collections,
  System.SysUtils, UDMDBDemo;

{$R *.dfm}

procedure TForm2.btnClearHistoryClick(Sender: TObject);
begin
  TM4DRegistryMigrations.GetInstance.Clear;
end;

procedure TForm2.btnExecuteAllClick(Sender: TObject);
begin
  TM4DRegistryMigrations.GetInstance.Execute;
end;

procedure TForm2.btnExecutePendingClick(Sender: TObject);
begin
  TM4DRegistryMigrations.GetInstance.ExecutePending;
end;

procedure TForm2.btnExecuteRangeClick(Sender: TObject);
var
  LStart: Integer;
  LEnd: Integer;
begin
  LStart := StrToInt(EdtStartExecute.Text);
  LEnd := StrToInt(EdtEndExecute.Text);
  TM4DRegistryMigrations.GetInstance.ExecuteRange(LStart, LEnd);
end;

procedure TForm2.btnExecuteUntilClick(Sender: TObject);
var
  LSequence: Integer;
begin
  LSequence := StrToInt(EdtSeqToExecute.Text);
  TM4DRegistryMigrations.GetInstance.ExecuteUntil(LSequence);
end;

procedure TForm2.btnMigrationsListClick(Sender: TObject);
var
  LMigrations: TList<IMigration>;
  LMigration: IMigration;
begin
  MemInfo.Clear;
  MemInfo.Lines.Add('Registered migrations');

  LMigrations := TM4DRegistryMigrations.GetInstance.ListMigrations;
  try
    for LMigration in LMigrations do
    begin
      MemInfo.Lines.Add('');
      MemInfo.Lines.Add('Class name: ' + TObject(LMigration).ClassName);
      MemInfo.Lines.Add('Unit name:' + TObject(LMigration).UnitName);
      MemInfo.Lines.Add('Migration sequence: ' + LMigration.SeqVersion.ToString);
      MemInfo.Lines.Add('Migration version: ' + LMigration.Version);
      MemInfo.Lines.Add('Migration date time: ' + DateTimeToStr(LMigration.DateTime));
    end;
  finally
    LMigrations.Free;
  end;
end;

procedure TForm2.btnRollbackAllClick(Sender: TObject);
begin
  TM4DRegistryMigrations.GetInstance.Rollback;
end;

procedure TForm2.btnRollbackRangeClick(Sender: TObject);
var
  LStart: Integer;
  LEnd: Integer;
begin
  LStart := StrToInt(EdtStartRollback.Text);
  LEnd := StrToInt(EdtEndRollback.Text);
  TM4DRegistryMigrations.GetInstance.RollbackRange(LStart, LEnd);
end;

procedure TForm2.btnRollbackUntilClick(Sender: TObject);
var
  LSequence: Integer;
begin
  LSequence := StrToInt(EdtSeqToRollback.Text);
  TM4DRegistryMigrations.GetInstance.RollbackUtil(LSequence);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  try
    QryEmployers.Close;
    QryEmployers.Open;
  except
    ShowMessage('Probably the table doesn´t exist yet.');
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  TM4DRegistryMigrations.GetInstance.RollbackPending;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  LMigrationHistory: TList<TMigrationsHistoryItem>;
  LItem: TMigrationsHistoryItem;
begin
  MemInfo.Clear;
  LMigrationHistory := TM4DRegistryMigrations.GetInstance.GetHistory;
  if Assigned(LMigrationHistory) then
  begin
    MemInfo.Lines.Add('History of migrations:');
    for LItem in LMigrationHistory do
    begin
      MemInfo.Lines.Add('');
      MemInfo.Lines.Add('Migration : ' + LItem.MigrationSeq.ToString);
      MemInfo.Lines.Add('Version: ' + LItem.MigrationVersion);
      MemInfo.Lines.Add('Date of creation: ' + DateTimeToStr(LItem.MigrationDateTime));
      MemInfo.Lines.Add('Start of execution: ' + DateTimeToStr(LItem.StartOfExecution));
      MemInfo.Lines.Add('End of execution: ' + DateTimeToStr(LItem.EndOfExecution));
      MemInfo.Lines.Add('Duration of execution: ' + LItem.DurationOfExecution.ToString);
    end;
  end;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  LItem: TMigrationsHistoryItem;
begin
  MemInfo.Clear;
  LItem := TM4DRegistryMigrations.GetInstance.LastMigration;
  if Assigned(LItem) then
  begin
    MemInfo.Lines.Add('History of migrations:');
    MemInfo.Lines.Add('');
    MemInfo.Lines.Add('Migration : ' + LItem.MigrationSeq.ToString);
    MemInfo.Lines.Add('Version: ' + LItem.MigrationVersion);
    MemInfo.Lines.Add('Date of creation: ' + DateTimeToStr(LItem.MigrationDateTime));
    MemInfo.Lines.Add('Start of execution: ' + DateTimeToStr(LItem.StartOfExecution));
    MemInfo.Lines.Add('End of execution: ' + DateTimeToStr(LItem.EndOfExecution));
    MemInfo.Lines.Add('Duration of execution: ' + LItem.DurationOfExecution.ToString);
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TM4DRegistryMigrations.GetInstance.Release;
end;

end.
