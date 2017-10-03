{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.GetterMigrationsInterface;

interface

uses
  M4D.MigrationsInterface, Generics.Collections;

type
  {$REGION 'IGetMigrations'}
    /// <Description>
    ///  Standard method to get migrations on the list of migrations.
    /// </Description>
    /// <Note>
    ///  A list of migrations is a repository of migrations used by a migration´s manager.
    ///  It is usually used to fire a migration execution.
    /// </Note>
  {$ENDREGION}
  IGetterMigrations = interface
  ['{E5339741-C1C0-4FA1-A19A-2A379DE43AA2}']
    {$REGION 'IGetMigrations.getMigrations - Sequence'}
      /// <Description>
      ///  Gets a list of all migrations whose sequence is greater than or equal to the
      ///  inputted sequence value.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the filter.
      ///  AStartSeqMigration - The initial sequencial value of the migration that will be
      ///  considered to return. The method will return all migrations after that based on
      ///  the sequence value.
      ///  Return - A list of migrations that has the sequence´s version value greater than
      /// the initial value inputted.
      /// </InputParameters>
    {$ENDREGION}
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer): TList<IMigration>; overload;
    {$REGION 'IGetMigrations.getMigrations - DateTime'}
      /// <Description>
      ///  Gets a list of all migrations whose date time is greater than or equal to the
      ///  inputted date time value.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the filter.
      ///  AStartSeqMigration - The initial date time value of the migration that will be
      ///  considered to return. The method will return all migrations after that based on
      ///  the date time value.
      ///  Return - A list of migrations that has the date time´s version value greater than
      /// the initial value inputted.
      /// </InputParameters>
    {$ENDREGION}
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDateTime): TList<IMigration>; overload;
  end;

implementation

end.
