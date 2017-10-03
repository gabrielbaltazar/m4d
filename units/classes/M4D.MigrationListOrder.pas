{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationListOrder;

interface

uses
  M4D.MigrationListOrderInterface, M4D.MigrationsInterface, System.Generics.Defaults;

type
  {$REGION 'TMigrationListOrder'}
    /// <Description>
    ///  Standard class to handle the order of the migration list.
    /// </Description>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
    /// <KeyWords>Migration, Sort</KeyWords>
  {$ENDREGION}
  TMigrationListOrder = class(TInterfacedObject, IMigrationListOrder)
  public
    function Comparison: TComparison<TClass>;
  end;

implementation

uses
  System.SysUtils, M4D.Defs;

{ TMigrationListOrder }

function TMigrationListOrder.Comparison: TComparison<TClass>;
begin
  Result := function(const Left, Right: TClass): Integer
            var
              LeftInstance: TObject;
              RightInstance: TObject;
              LeftSequence: Integer;
              RightSequence: Integer;
            begin
              LeftInstance := Left.Create;
              RightInstance := Right.Create;

              (LeftInstance as TInterfacedObject as IMigration).Setup;
              LeftSequence := (LeftInstance as TInterfacedObject as IMigration).SeqVersion;

              (RightInstance as TInterfacedObject as IMigration).Setup;
              RightSequence := (RightInstance as TInterfacedObject as IMigration).SeqVersion;

              Result := LeftSequence - RightSequence;
            end;
end;

end.

