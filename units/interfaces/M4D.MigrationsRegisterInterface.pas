{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsRegisterInterface;

interface
  uses
    System.Generics.Collections;

type
  IMigrationsRegister = interface
  ['{277A98B9-E8B7-4F58-8D30-26BBE1E4E39A}']
    procedure RegisterMigration(AMigration: TClass);
    function getMigrationsRegister: TList<TClass>;
    property Migrations: TList<TClass> read getMigrationsRegister;
  end;

implementation

end.
