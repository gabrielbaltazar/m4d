unit UFrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  M4D;

type
  TForm3 = class(TForm)
    Layout1: TLayout;
    btnMigrationList: TButton;
    btnExecuteAllMigrations: TButton;
    btnExecuteMigrationsUntil: TButton;
    btnExecutePendingMigrations: TButton;
    btnExecuteRange: TButton;
    btnRollbackAllMigrations: TButton;
    btnRollbackUntil: TButton;
    btnRollbackPendingMigrations: TButton;
    btnRollbackRange: TButton;
    Layout2: TLayout;
    Layout3: TLayout;
    memInfo: TMemo;
    btnClearHistory: TButton;
    Button11: TButton;
    Button12: TButton;
    edtSeqToExecute: TEdit;
    edtStartExecute: TEdit;
    edtEndExecute: TEdit;
    edtSeqToRollback: TEdit;
    edtStartRollback: TEdit;
    edtEndRollback: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMigrationListClick(Sender: TObject);
    procedure btnExecuteAllMigrationsClick(Sender: TObject);
    procedure btnExecuteMigrationsUntilClick(Sender: TObject);
    procedure btnExecutePendingMigrationsClick(Sender: TObject);
    procedure btnExecuteRangeClick(Sender: TObject);
    procedure btnRollbackAllMigrationsClick(Sender: TObject);
    procedure btnRollbackUntilClick(Sender: TObject);
    procedure btnRollbackPendingMigrationsClick(Sender: TObject);
    procedure btnRollbackRangeClick(Sender: TObject);
    procedure btnClearHistoryClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationsHistoryItem,
  M4D.MigrationsInterface,
  Generics.Collections;

{$R *.fmx}

procedure TForm3.btnClearHistoryClick(Sender: TObject);
var
  MH: IMigrationsHistoryFacade;
begin
   MH := M4D.MigrationFacade.MigrationsHistoryFacade;
   MH.Clear;
end;

procedure TForm3.btnExecuteAllMigrationsClick(Sender: TObject);
begin
   M4D.MigrationFacade.Execute;
end;

procedure TForm3.btnExecuteMigrationsUntilClick(Sender: TObject);
var
  Aux: Integer;
begin
  if not TryStrToInt(edtSeqToExecute.Text, Aux) then
  begin
    ShowMessage('You must insert a positive integer value.');
    edtSeqToExecute.SetFocus;
  end
  else
  begin
     M4D.MigrationFacade.ExecuteUntil(Aux);
  end;
end;

procedure TForm3.btnExecutePendingMigrationsClick(Sender: TObject);
begin
  M4D.MigrationFacade.ExecutePending;
end;

procedure TForm3.btnExecuteRangeClick(Sender: TObject);
var
  LStart: Integer;
  LEnd: Integer;
begin
  if not TryStrToInt(edtStartExecute.Text, LStart) then
  begin
    ShowMessage('You must insert a valid execution start value.');
    edtStartExecute.SetFocus;
  end
  else
  begin
    if not TryStrToInt(edtEndExecute.Text, LEnd) then
    begin
      ShowMessage('You must insert a valid execution end value.');
      edtEndExecute.SetFocus;
    end
    else
    begin
      M4D.MigrationFacade.ExecuteRange(LStart, LEnd);
    end;
  end;
end;

procedure TForm3.btnMigrationListClick(Sender: TObject);
var
  RM: TList<TClass>;
  LClass: TClass;
  Migration: IMigration;
begin
  memInfo.Lines.Clear;

  RM := M4D.MigrationFacade.MigrationsRegister.Migrations;
  if Assigned(RM) then
  begin
    memInfo.Lines.Add('Registered migrations');
    for LClass in RM do
    begin
      memInfo.Lines.Add('');
      memInfo.Lines.Add('Class name: ' + LClass.ClassName);
      memInfo.Lines.Add('Unit name:' + LClass.UnitName);

      Migration := M4D.MigrationFacade.MigrationInfo(LClass{, M4D.MigrationManager.MethodSetupExecutor});
      memInfo.Lines.Add('Migration sequence: ' + Migration.SeqVersion.ToString);
      memInfo.Lines.Add('Migration version: ' + Migration.Version);
      memInfo.Lines.Add('Migration date time: ' + DateTimeToStr(Migration.DateTime));
    end;
  end;
end;

procedure TForm3.btnRollbackAllMigrationsClick(Sender: TObject);
begin
  M4D.MigrationFacade.Rollback;
end;

procedure TForm3.btnRollbackPendingMigrationsClick(Sender: TObject);
begin
  M4D.MigrationFacade.RollbackPending;
end;

procedure TForm3.btnRollbackRangeClick(Sender: TObject);
var
  LStart: Integer;
  LEnd: Integer;
begin
  if not TryStrToInt(edtStartRollback.Text, LStart) then
  begin
    ShowMessage('You must insert a valid rollback start value.');
    edtStartRollback.SetFocus;
  end
  else
  begin
    if not TryStrToInt(edtEndRollback.Text, LEnd) then
    begin
      ShowMessage('You must insert a valid rollback end value.');
      edtEndRollback.SetFocus;
    end
    else
    begin
      M4D.MigrationFacade.RollbackRange(LStart, LEnd);
    end;
  end;
end;

procedure TForm3.btnRollbackUntilClick(Sender: TObject);
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
     M4D.MigrationFacade.RollbackUntil(Aux);
  end;
end;

procedure TForm3.Button11Click(Sender: TObject);
var
  MH: TList<TMigrationsHistoryItem>;
  Item: TMigrationsHistoryItem;
begin
  memInfo.Lines.Clear;

  MH := M4D.MigrationFacade.MigrationsHistoryFacade.getHistory;
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

procedure TForm3.Button12Click(Sender: TObject);
var
  Item: TMigrationsHistoryItem;
begin
  memInfo.Lines.Clear;

  Item := M4D.MigrationFacade.MigrationsHistoryFacade.LastMigration;
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

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  M4D.Release;
end;

end.
