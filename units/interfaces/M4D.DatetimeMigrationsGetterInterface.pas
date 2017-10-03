{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.DatetimeMigrationsGetterInterface;

interface

uses
  Generics.Collections, M4D.MigrationsInterface, M4D.MainMigrationsGetterInterface;

type
  {$REGION 'IDatetimeMigrationsGetter'}
    /// <Description>
    ///  Standard interface to get a list of registered´s migration base on the datetime.
    /// </Description>
  {$ENDREGION}
  IDatetimeMigrationsGetter = interface
  ['{473148A6-C879-4589-8E20-AC9E69456206}']
    {$REGION 'IDatetimeMigrationsGetter.getMigrations'}
      /// <Description>
      ///  Method that returns migrations from a list of migrations based on the datetime.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - List of migrations being considered for return.
      ///  AStartMigrationDateTime - The datetime used to choose the migrations.
      ///  AMainMigrationsGetter - Main interface to choose the migrations.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Result - The list of migrations determined by the datetime.
      /// </OutputParameters>
    {$ENDREGION}
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDatetime; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
  end;


implementation

end.

