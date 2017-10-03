unit M4D.MigrationUpMethodExecutor;

interface

uses
  M4D.MigrationUpMethodExecutorInterface, M4D.MigrationMethodExecutor,
  M4D.MigrationMethodExecutorInterface;

type
  TMigrationUpMethodExecutor = class(TInterfacedObject, IMigrationUpMethodExecutor)
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

constructor TMigrationUpMethodExecutor.Create(AExecutor: IMigrationMethodExecutor);
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

function TMigrationUpMethodExecutor.Execute(AClass: TClass; AInstance: TObject): boolean;
begin
  Result := FExecutor.Execute(AClass, AInstance, METHOD_UP);
end;

end.
