{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.RegisterMigrationInterface;

interface

uses
  M4D.MigrationsInterface, Generics.Collections;

type
  {$REGION 'IRegisterMigration'}
    /// <Description>
    ///  Standard implementation of the migration´s register.
    /// </Description>
    /// <Note>
    ///  A migration register is responsible for registering the migration within
    ///  the migration management class. Thus, the migration becomes known by the
    ///  migration management class and can be used when needed. This just must
    ///  be used to implement a migration manager class.
    /// </Note>
  {$ENDREGION}
  IRegisterMigration = interface
  ['{E86F157C-0762-44A8-8497-38FD6251F481}']
    {$REGION 'IRegisterMigration.RegisterMigration'}
      /// <Description>
      ///  Migration´s register method.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the filter.
      ///  AMigration - The migration that will be registered.
      /// </InputParameters>
    {$ENDREGION}
    procedure RegisterMigration(AMigrationsList: TList<IMigration>; AMigration: IMigration);
  end;

implementation

end.
