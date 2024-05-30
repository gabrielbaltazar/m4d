unit UDMDBDemo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDMDBDemo = class(TDataModule)
    SQLiteConection: TFDConnection;
    FDQMigration: TFDQuery;
    procedure SQLiteConectionBeforeConnect(Sender: TObject);
  public
    function GetQuery(ASql: string; const AOpenQuery: Boolean = True): TFDQuery;
    function GetConnection: TFDConnection;
  end;

var
  DMDBDemo: TDMDBDemo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMDBDemo }

function TDMDBDemo.GetConnection: TFDConnection;
begin
  Result := SQLiteConection;
end;

function TDMDBDemo.GetQuery(ASql: string; const AOpenQuery: Boolean = True): TFDQuery;
begin
  Result := TFDQuery.Create(Self);
  try
    Result.Close;
    Result.Connection := SQLiteConection;
    Result.SQL.Text := ASql;
    if AOpenQuery then
      Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

procedure TDMDBDemo.SQLiteConectionBeforeConnect(Sender: TObject);
var
  LFileName: string;
begin
  LFileName := 'Demo.db3';
  if not FileExists(LFileName) then
  begin
    with TStringList.Create do
    try
      SaveToFile(LFileName);
    finally
      Free;
    end;
  end;
end;

end.
