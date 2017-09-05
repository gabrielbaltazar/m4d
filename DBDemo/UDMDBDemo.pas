unit UDMDBDemo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TDMDBDemo = class(TDataModule)
    SQLiteConection: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function getQuery(ASql: string; const AOpenQuery: Boolean = True): TFDQuery;
  end;

var
  DMDBDemo: TDMDBDemo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMDBDemo }

function TDMDBDemo.getQuery(ASql: string; const AOpenQuery: Boolean = True): TFDQuery;
begin
  Result := TFDQuery.Create(Self);

  Result.Close;
  Result.Connection := SQLiteConection;
  Result.SQL.Text := ASql;
  if AOpenQuery then Result.Open;
end;

end.
