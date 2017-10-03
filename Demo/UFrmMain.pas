unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, M4D, Vcl.ExtCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  M4D.MigrationsHistoryInterface, M4D.MigrationsHistoryItem, Generics.Collections,
  System.SysUtils, M4D.MigrationsInterface;

{$R *.dfm}

procedure TForm2.btnClearHistoryClick(Sender: TObject);
var
  MH: IMigrationsHistory;
begin
  //Before performing all migrations, you must clear the migration information
  //so that it is not registered duplicatively.

   MH := M4D.MigrationManager.MigrationHistory;
   MH.Clear;
end;

procedure TForm2.btnExecuteAllClick(Sender: TObject);
var
  MH: IMigrationsHistory;
begin
  //Before performing all migrations, you must clear the migration information
  //so that it is not registered duplicatively.

   MH := M4D.MigrationManager.MigrationHistory;
   MH.Clear;

   M4D.MigrationManager.Execute;
end;

procedure TForm2.btnExecutePendingClick(Sender: TObject);
begin
  M4D.MigrationManager.ExecutePending;
end;

procedure TForm2.btnExecuteUntilClick(Sender: TObject);
var
  Aux: Integer;
  MH: IMigrationsHistory;
begin
  if not TryStrToInt(edtSeqToExecute.Text, Aux) then
  begin
    ShowMessage('You must insert a positive integer value.');
    edtSeqToExecute.SetFocus;
  end
  else
  begin
    //Before performing all migrations, you must clear the migration information
    //so that it is not registered duplicatively.

     MH := M4D.MigrationManager.MigrationHistory;
     MH.Clear;

     M4D.MigrationManager.ExecuteUntil(Aux);
  end;
end;

procedure TForm2.btnMigrationsListClick(Sender: TObject);
var
  RM: TList<TClass>;
  LClass: TClass;
  Migration: IMigration;
begin
  memInfo.Clear;

  RM := M4D.MigrationManager.MigrationsRegister.Migrations;
  if Assigned(RM) then
  begin
    memInfo.Lines.Add('Registered migrations');
    for LClass in RM do
    begin
      memInfo.Lines.Add('');
      memInfo.Lines.Add('Class name: ' + LClass.ClassName);
      memInfo.Lines.Add('Unit name:' + LClass.UnitName);

      Migration := M4D.MigrationManager.MigrationInfo(LClass{, M4D.MigrationManager.MethodSetupExecutor});
      memInfo.Lines.Add('Migration sequence: ' + Migration.SeqVersion.ToString);
      memInfo.Lines.Add('Migration version: ' + Migration.Version);
      memInfo.Lines.Add('Migration date time: ' + DateTimeToStr(Migration.DateTime));
    end;
  end;
end;

procedure TForm2.btnRollbackAllClick(Sender: TObject);
begin
  M4D.MigrationManager.Rollback;
end;

procedure TForm2.btnRollbackUntilClick(Sender: TObject);
var
  Aux: Integer;
begin
  if not TryStrToInt(edtSeqToRollback.Text, Aux) then
  begin
    ShowMessage('You must insert a positive integer value.');
    edtSeqToRollback.SetFocus;
  end
  else
  begin
     M4D.MigrationManager.RollbackUntil(Aux);
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  MH: TList<TMigrationsHistoryItem>;
  Item: TMigrationsHistoryItem;
begin
  memInfo.Clear;

  MH := M4D.MigrationManager.MigrationHistory.getHistory;
  if Assigned(MH) then
  begin
    memInfo.Lines.Add('History of migrations:');
    for Item in MH do
    begin
      memInfo.Lines.Add('');
      memInfo.Lines.Add('Migration : ' + Item.MigrationSeq.ToString);
      memInfo.Lines.Add('Version: ' + Item.MigrationVersion);
      memInfo.Lines.Add('Date of creation: ' + DateTimeToStr(Item.MigrationDateTime));
      memInfo.Lines.Add('Start of execution: ' + DateTimeToStr(Item.StartOfExecution));
      memInfo.Lines.Add('End of execution: ' + DateTimeToStr(Item.EndOfExecution));
      memInfo.Lines.Add('Duration of execution: ' + Item.DurationOfExecution.ToString);
    end;
  end;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  Item: TMigrationsHistoryItem;
begin
  memInfo.Clear;

  Item := M4D.MigrationManager.MigrationHistory.LastMigration;
  if Assigned(Item) then
  begin
    memInfo.Lines.Add('History of migrations:');
    memInfo.Lines.Add('');
    memInfo.Lines.Add('Migration : ' + Item.MigrationSeq.ToString);
    memInfo.Lines.Add('Version: ' + Item.MigrationVersion);
    memInfo.Lines.Add('Date of creation: ' + DateTimeToStr(Item.MigrationDateTime));
    memInfo.Lines.Add('Start of execution: ' + DateTimeToStr(Item.StartOfExecution));
    memInfo.Lines.Add('End of execution: ' + DateTimeToStr(Item.EndOfExecution));
    memInfo.Lines.Add('Duration of execution: ' + Item.DurationOfExecution.ToString);
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  M4D.Release;
end;

end.
