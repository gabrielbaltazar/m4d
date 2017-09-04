{######################################################################################

                                      M4D Framework

Author: Edgar Borges Pav�o
Date of creation: 30/08/2017
Use licence: Free

######################################################################################}

unit URegisterMigration;

interface

uses
  URegisterMigrationInterface, UMigrationsInterface, Generics.Collections;

type
  {$REGION 'TRegisterMigration'}
    /// <Description>
    ///  Standard class to register a migration on a list.
    /// </Description>
    /// <Responsability>
    ///  Add a migration on a list.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TRegisterMigration = class(TInterfacedObject, IRegisterMigration)
  public
    procedure RegisterMigration(AMigrationsList: TList<IMigration>; AMigration: IMigration);
  end;

implementation

{ TRegisterMigration }

procedure TRegisterMigration.RegisterMigration(AMigrationsList: TList<IMigration>; AMigration: IMigration);
begin
  if Assigned(AMigrationsList) then
  begin
    AMigrationsList.Add(AMigration);
  end;
end;

end.
