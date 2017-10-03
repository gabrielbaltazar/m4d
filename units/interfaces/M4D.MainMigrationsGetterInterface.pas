{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MainMigrationsGetterInterface;

interface

uses
  Generics.Collections, System.SysUtils, M4D.MigrationsInterface;

type
  {$REGION 'IMainMigrationsGetterInterface'}
    /// <Description>
    ///  Standard interface to get a list of registered´s migration.
    /// </Description>
    /// <Responsability>
    ///  Get a subset os items from a inputted list, based on the start parameter.
    /// </Responsability>
    /// <Note>
    ///  There are other specialized classes that use this class as the default search..
    /// </Note>
  {$ENDREGION}
  IMainMigrationsGetter = interface
  ['{E015610A-5C01-49C5-B991-150929792DB8}']
    {$REGION 'IMainMigrationsGetterInterface.getMigrations'}
      /// <Description>
      ///  Method that returns migrations from a list of migrations based on the rules of the predicate.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - List of migrations being considered for return.
      ///  APredicate - The predicate is used to determine which migrations will be returned.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Result - The list of migrations determined by the predicate.
      /// </OutputParameters>
    {$ENDREGION}
    function getMigrations(AMigrationsList: TList<IMigration>; APredicate: TPredicate<IMigration>): TList<IMigration>;
  end;

implementation

end.
