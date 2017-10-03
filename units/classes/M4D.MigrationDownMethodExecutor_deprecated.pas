unit M4D.MigrationDownMethodExecutor;

interface

uses
  M4D.MigrationDownMethodExecutorInterface, M4D.MigrationMethodExecutor,
  M4D.MigrationMethodExecutorInterface;

type
  TMigrationDownMethodExecutor = class(TInterfacedObject, IMigrationDownMethodExecutor)
  private
    FExecutor: IMigrationMethodExecutor;
  public
    constructor Create(AExecutor: IMigrationMethodExecutor); reintroduce;

    function Execute(AClass: TClass; AInstance: TObject): boolean;
  end;

implementation

uses
  System.SysUtils, M4D.Defs;

{ TMigrationUpMethodExecutor }

constructor TMigrationDownMethodExecutor.Create(AExecutor: IMigrationMethodExecutor);
begin
  inherited Create;

  if not Assigned(AExecutor) then
  begin
    raise Exception.Create('The parameter AExecutor must not be nil.');
  end
  else
  begin
    FExecutor := AExecutor;
  end;
end;

function TMigrationDownMethodExecutor.Execute(AClass: TClass; AInstance: TObject): boolean;
begin
  Result := FExecutor.Execute(AClass, AInstance, METHOD_DOWN);
end;

end.

