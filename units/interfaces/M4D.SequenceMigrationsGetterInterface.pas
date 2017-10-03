{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.SequenceMigrationsGetterInterface;

interface

uses
  Generics.Collections, M4D.MigrationsInterface, M4D.MainMigrationsGetterInterface;

type
  {$REGION 'ISequenceMigrationsGetter'}
    /// <Description>
    ///  Standard interface to get a list of registered´s migration base on the sequence.
    /// </Description>
  {$ENDREGION}
  ISequenceMigrationsGetter = interface
  ['{F38CFBAB-A158-482A-8F5B-0496CED2CB60}']
    {$REGION 'ISequenceMigrationsGetter.getMigrations'}
      /// <Description>
      ///  Method that returns migrations from a list of migrations based on the sequence.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - List of migrations being considered for return.
      ///  AStartMigrationSeq - The sequence used to choose the migrations.
      ///  AMainMigrationsGetter - Main interface to choose the migrations.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Result - The list of migrations determined by the sequence.
      /// </OutputParameters>
    {$ENDREGION}
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
  end;


implementation

end.
