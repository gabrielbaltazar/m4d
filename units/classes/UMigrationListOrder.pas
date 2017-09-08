unit UMigrationListOrder;

interface

uses
  UMigrationListOrderInterface, UMigrationsInterface, System.Generics.Defaults,
  UMigrationMethodExecutorInterface;

type
  TMigrationListOrder = class(TInterfacedObject, IMigrationListOrder)
  private
    FMethodExecutor: IMigrationMethodExecutor;
  public
    constructor Create(AMethodExecutor: IMigrationMethodExecutor); reintroduce;
    function Comparison: TComparison<TClass>;
  end;

implementation

uses
  UDefs, USetupExecutorInterface, USetupExecutor, UPropertyClassReaderInterface, UPropertyClassReader,
  System.SysUtils, UMigrationMethodExecutor;

{ TMigrationListOrder }

function TMigrationListOrder.Comparison: TComparison<TClass>;
begin
  Result := function(const Left, Right: TClass): Integer
            var
              LMethodExecutor: IMigrationMethodExecutor;
              Setup: IMigrationSetupMethodExecutor;
              LeftInstance: TObject;
              RightInstance: TObject;
              Reader: IPropertyClassReader;
              LeftSequence: Integer;
              RightSequence: Integer;
            begin
              LMethodExecutor := TMigrationMethodExecutor.Create;

              LeftInstance := Left.Create;
              RightInstance := Right.Create;
              try
                Setup := USetupExecutor.TMigrationSetupMethodExecutor.Create(LMethodExecutor);
                Reader := TPropertyClassReader.Create;

//                Setup.Execute(Left, LeftInstance);
                (LeftInstance as TInterfacedObject as IMigration).Setup;
                LeftSequence := Reader.PropertyOfMigrationClass(Left, LeftInstance, PROP_SEQUENCE).AsInteger;

//                Setup.Execute(Right, RightInstance);
                (RightInstance as TInterfacedObject as IMigration).Setup;
                RightSequence := Reader.PropertyOfMigrationClass(Right, RightInstance, PROP_SEQUENCE).AsInteger;
              finally
//                LeftInstance.Free;
//                RightInstance.Free;
              end;

              Result := LeftSequence - RightSequence;
            end;
end;

constructor TMigrationListOrder.Create(AMethodExecutor: IMigrationMethodExecutor);
begin
  if not Assigned(AMethodExecutor) then
  begin
    raise Exception.Create('The parameter AMethodExecutor must not be nil.');
  end
  else
  begin
    inherited Create;
    FMethodExecutor := AMethodExecutor;
  end;
end;

end.

