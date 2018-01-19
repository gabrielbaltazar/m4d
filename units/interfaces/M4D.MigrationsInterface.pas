{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsInterface;

interface

type
  TCheckMigrationExecuteMethod = function: Boolean of object;

type
  {$REGION 'IMigration'}
    /// <Description>
    ///  Standard interface for any type of migration.
    /// </Description>
  {$ENDREGION}
  IMigration = interface
  ['{ED3A27A7-D0EA-44D2-ACE6-64E92F5BC7EB}']

    procedure Setup;

    {$REGION 'IMigration.Up'}
      /// <Description>
      ///  Method that updates the migrations.
      /// </Description
    {$ENDREGION}
    procedure Up;

    {$REGION 'IMigration.UpWillExecute'}
      /// <Description>
      ///  Method that return if a migration up method will be executed.
      /// </Description
    {$ENDREGION}
    function UpWillExecute: Boolean;

    {$REGION 'IMigration.Down'}
      /// <Description>
      ///  Method that downgrade the migrations.
      /// </Description
    {$ENDREGION}
    procedure Down;

    {$REGION 'IMigration.DownWillExecute'}
      /// <Description>
      ///  Method that return if a migration down method will be executed.
      /// </Description
    {$ENDREGION}
    function DownWillExecute: Boolean;

    {$REGION 'IMigration.setVersion'}
      /// <Description>
      ///  Method that sets the value of the migration version´s description.
      /// </Description
      /// <Note>
      ///  The migration version is only a description of the migration sequence.
      ///  The migration sequence is that it is used internally to determine the order of
      ///  execution of the migrations.
      /// </Note>
    {$ENDREGION}
    procedure setVersion(AValue: string);

    {$REGION 'IMigration.getVersion'}
      /// <Description>
      ///  Method that gets the value of the migration version´s description.
      /// </Description
      /// <Note>
      ///  The migration version is only a description of the migration sequence.
      ///  The migration sequence is that it is used internally to determine the order of
      ///  execution of the migrations.
      /// </Note>
    {$ENDREGION}
    function getVersion: string;

    {$REGION 'IMigration.setSeqVersion'}
      /// <Description>
      ///  Method that sets the value of the migration version´s sequence.
      /// </Description
      /// <Note>
      ///  The migration sequence is that it is used internally to determine the order of execution of
      ///  the migrations. Thus, classes can, by simple ordering, determine which migration
      ///  should occur before or after.
      /// </Note>
    {$ENDREGION}
    procedure setSeqVersion(AValue: Integer);

    {$REGION 'IMigration.getSeqVersion'}
      /// <Description>
      ///  Method that gets the value of the migration version´s sequence.
      /// </Description
      /// <Note>
      ///  The migration sequence is that it is used internally to determine the order of execution of
      ///  the migrations. Thus, classes can, by simple ordering, determine which migration
      ///  should occur before or after.
      /// </Note>
    {$ENDREGION}
    function getSeqVersion: Integer;

    {$REGION 'IMigration.setDateTime'}
      /// <Description>
      ///  Method that gets the value of the migration version´s date time.
      /// </Description
      /// <Note>
      ///  The migration "date time" is just a migration information. Thus, you can
      ///  determine when it was created.
      ///  The migration sequence is that it is used internally to determine the order of
      ///  execution of the migrations.
      /// </Note>
    {$ENDREGION}
    procedure setDateTime(AValue: TDateTime);

    {$REGION 'IMigration.getDateTime'}
      /// <Description>
      ///  Method that gets the value of the migration version´s date time.
      /// </Description
      /// <Note>
      ///  The migration "date time" is just a migration information. Thus, you can
      ///  determine when it was created.
      ///  The migration sequence is that it is used internally to determine the order of
      ///  execution of the migrations.
      /// </Note>
    {$ENDREGION}
    function getDateTime: TDateTime;

    {$REGION 'IMigration.Version'}
      /// <Description>
      ///  Just the property to get and set values of the version.
      /// </Description>
      /// <Note>
      ///  The migration version is only a description of the migration sequence.
      /// </Note>
    {$ENDREGION}
    property Version: string read getVersion write setVersion;

    {$REGION 'IMigration.SeqVersion'}
      /// <Description>
      ///  Just the property to get and set values of the version´s sequence.
      /// </Description>
      /// <Note>
      ///  The migration sequence is that it is used internally to determine the order
      ///  of migration´s execution.
      /// </Note>
    {$ENDREGION}
    property SeqVersion: Integer read getSeqVersion write setSeqVersion;

    {$REGION 'IMigration.DateTime'}
      /// <Description>
      ///  Just the property to get and set values of the version´s date time.
      /// </Description>
      /// <Note>
      ///  The migration "date time" is just a migration information. Thus, you can
      ///  determine when it was created.
      /// </Note>
    {$ENDREGION}
    property DateTime: TDateTime read getDateTime write setDateTime;
  end;

implementation

end.
