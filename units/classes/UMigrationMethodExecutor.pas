unit UMigrationMethodExecutor;

interface

uses
  UMigrationMethodExecutorInterface;

type
  TMigrationMethodExecutor = class(TInterfacedObject, IMigrationMethodExecutor)
  public
    function Execute(AClass: TClass; AInstance: TObject; ANameOfMethod: string): boolean;
  end;

implementation

uses
  System.Rtti, System.SysUtils;

{ TMigrationMethodExecutor }

function TMigrationMethodExecutor.Execute(AClass: TClass; AInstance: TObject; ANameOfMethod: string): boolean;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LMethod: TRttiMethod;
begin
  Result := False;

  if not Assigned(AClass) then
  begin
    raise Exception.Create('The parameter AClass must not be nil.');
  end
  else
  begin
    if not Assigned(AInstance) then
    begin
      raise Exception.Create('The parameter AInstance must not be nil.');
    end
    else
    begin
      LType := LContext.GetType(AClass.ClassInfo);

      for LMethod in LType.GetDeclaredMethods do
      begin
        if LowerCase(LMethod.Name) = LowerCase(ANameOfMethod) then
        begin
          LMethod.Invoke(AInstance, []);
          Result := True;
        end;
      end;
    end;
  end;
end;

end.
