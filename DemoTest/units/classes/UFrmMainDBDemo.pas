unit UFrmMainDBDemo;

interface

uses
 Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, M4D, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

//  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms
//  , Vcl.Graphics,
//  Vcl.Controls, , Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
//  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
//  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, M4D, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
//  FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids;

type
  TfrmMainDBDemo = class(TForm)
    pnlLeft: TPanel;
    btnExecuteAll: TButton;
    btnExecutePending: TButton;
    btnRollbackAll: TButton;
    btnMigrationsList: TButton;
    btnRollbackUntil: TButton;
    edtSeqToRollback: TEdit;
    btnExecuteUntil: TButton;
    edtSeqToExecute: TEdit;
    pnlRigth: TPanel;
    memInfo: TMemo;
    pnlHistory: TPanel;
    Button4: TButton;
    Button5: TButton;
    btnClearHistory: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    qryCustomers: TFDQuery;
    dtsCustomers: TDataSource;
    Button1: TButton;
    procedure btnClearHistoryClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnMigrationsListClick(Sender: TObject);
    procedure btnExecuteAllClick(Sender: TObject);
    procedure btnExecuteUntilClick(Sender: TObject);
    procedure btnExecutePendingClick(Sender: TObject);
    procedure btnRollbackAllClick(Sender: TObject);
    procedure btnRollbackUntilClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainDBDemo: TfrmMainDBDemo;

implementation

//uses
//  UMigrationsHistoryInterface, System.Generics.Collections,
//  UMigrationsHistoryItem, UMigrationsInterface;

{$R *.dfm}

procedure TfrmMainDBDemo.btnClearHistoryClick(Sender: TObject);
//var
//  MH: IMigrationsHistory;
begin
//  //Before performing all migrations, you must clear the migration information
//  //so that it is not registered duplicatively.
//
//   MH := M4D.MigrationsManager.MigrationHistory;
//   MH.Clear;
end;

procedure TfrmMainDBDemo.btnExecuteAllClick(Sender: TObject);
//var
//  MH: IMigrationsHistory;
begin
  //Before performing all migrations, you must clear the migration information
  //so that it is not registered duplicatively.

//   MH := M4D.MigrationsManager.MigrationHistory;
//   MH.Clear;
//
//   M4D.MigrationsManager.Execute;
end;

procedure TfrmMainDBDemo.btnExecutePendingClick(Sender: TObject);
begin
//  M4D.MigrationsManager.ExecutePending;
end;

procedure TfrmMainDBDemo.btnExecuteUntilClick(Sender: TObject);
//var
//  Aux: Integer;
//  MH: IMigrationsHistory;
begin
//  if not TryStrToInt(edtSeqToExecute.Text, Aux) then
//  begin
//    ShowMessage('You must insert a positive integer value.');
//    edtSeqToExecute.SetFocus;
//  end
//  else
//  begin
//    //Before performing all migrations, you must clear the migration information
//    //so that it is not registered duplicatively.
//
//     MH := M4D.MigrationsManager.MigrationHistory;
//     MH.Clear;
//
//     M4D.MigrationsManager.ExecuteUntil(Aux);
//  end;
end;

procedure TfrmMainDBDemo.btnMigrationsListClick(Sender: TObject);
//var
//  RM: TList<TClass>;
//  LClass: TClass;
//  Migration: IMigration;
begin
//  memInfo.Clear;
//
//  RM := M4D.MigrationsManager.MigrationsRegister.Migrations;
//  if Assigned(RM) then
//  begin
//    memInfo.Lines.Add('Registered migrations');
//    for LClass in RM do
//    begin
//      memInfo.Lines.Add('');
//      memInfo.Lines.Add('Class name: ' + LClass.ClassName);
//      memInfo.Lines.Add('Unit name:' + LClass.UnitName);
//
//      Migration := M4D.MigrationsManager.MigrationInfo(LClass, M4D.MigrationsManager.MethodSetupExecutor);
//      memInfo.Lines.Add('Migration sequence: ' + Migration.SeqVersion.ToString);
//      memInfo.Lines.Add('Migration version: ' + Migration.Version);
//      memInfo.Lines.Add('Migration date time: ' + DateTimeToStr(Migration.DateTime));
//    end;
//  end;
end;

procedure TfrmMainDBDemo.btnRollbackAllClick(Sender: TObject);
begin
//  M4D.MigrationsManager.Rollback;
end;

procedure TfrmMainDBDemo.btnRollbackUntilClick(Sender: TObject);
//var
//  Aux: Integer;
begin
//  if not TryStrToInt(edtSeqToRollback.Text, Aux) then
//  begin
//    ShowMessage('You must insert a positive integer value.');
//    edtSeqToRollback.SetFocus;
//  end
//  else
//  begin
//     M4D.MigrationsManager.RollbackUntil(Aux);
//  end;
end;

procedure TfrmMainDBDemo.Button1Click(Sender: TObject);
begin
//  try
//    qryCustomers.Close;
//    qryCustomers.Open;
//  except
//    ShowMessage('Probably a table structure is not yet created.');
//  end;
end;

procedure TfrmMainDBDemo.Button4Click(Sender: TObject);
//var
//  MH: TList<TMigrationsHistoryItem>;
//  Item: TMigrationsHistoryItem;
begin
//  memInfo.Clear;
//
//  MH := M4D.MigrationsManager.MigrationHistory.getHistory;
//  if Assigned(MH) then
//  begin
//    memInfo.Lines.Add('History of migrations:');
//    for Item in MH do
//    begin
//      memInfo.Lines.Add('');
//      memInfo.Lines.Add('Migration : ' + Item.MigrationSeq.ToString);
//      memInfo.Lines.Add('Version: ' + Item.MigrationVersion);
//      memInfo.Lines.Add('Date of creation: ' + DateTimeToStr(Item.MigrationDateTime));
//      memInfo.Lines.Add('Start of execution: ' + DateTimeToStr(Item.StartOfExecution));
//      memInfo.Lines.Add('End of execution: ' + DateTimeToStr(Item.EndOfExecution));
//      memInfo.Lines.Add('Duration of execution: ' + Item.DurationOfExecution.ToString);
//    end;
//  end;
end;

procedure TfrmMainDBDemo.Button5Click(Sender: TObject);
//var
//  Item: TMigrationsHistoryItem;
begin
//  memInfo.Clear;
//
//  Item := M4D.MigrationsManager.MigrationHistory.LastMigration;
//  if Assigned(Item) then
//  begin
//    memInfo.Lines.Add('History of migrations:');
//    memInfo.Lines.Add('');
//    memInfo.Lines.Add('Migration : ' + Item.MigrationSeq.ToString);
//    memInfo.Lines.Add('Version: ' + Item.MigrationVersion);
//    memInfo.Lines.Add('Date of creation: ' + DateTimeToStr(Item.MigrationDateTime));
//    memInfo.Lines.Add('Start of execution: ' + DateTimeToStr(Item.StartOfExecution));
//    memInfo.Lines.Add('End of execution: ' + DateTimeToStr(Item.EndOfExecution));
//    memInfo.Lines.Add('Duration of execution: ' + Item.DurationOfExecution.ToString);
//  end;
end;

end.
