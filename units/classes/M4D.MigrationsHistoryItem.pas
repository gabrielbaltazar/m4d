{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 31/08/2017
Use licence: See the license file

######################################################################################}

unit M4D.MigrationsHistoryItem;

interface

type
  {$M+}
  {$REGION 'TMigrationsConfigHistoryItem'}
    /// <Description>
    ///  Standard class for storing information about the execution of migration.
    /// </Description>
    /// <Responsability>
    ///  Stores information about the execution of migration.
    /// </Responsability>
  {$ENDREGION}
  TMigrationsHistoryItem = class
  private
    FMigrationVersion: string;
    FMigrationSeq: Integer;
    FMigrationDateTime: TDateTime;
    FStartOfExecution: TDateTime;
    FEndOfExecution: TDateTime;
    FDurationOfExecution: Extended;
  published
    property MigrationVersion: string read FMigrationVersion write FMigrationVersion;
    {$REGION 'TMigrationsHistoryItem.MigrationSeq'}
      /// <Description>
      ///  Stores the sequence value of the executed migration.
      /// </Description>
    {$ENDREGION}
    property MigrationSeq: Integer read FMigrationSeq write FMigrationSeq;
    {$REGION 'TMigrationsHistoryItem.MigrationDateTime'}
      /// <Description>
      ///  Stores the date time value of the executed migration.
      /// </Description>
    {$ENDREGION}
    property MigrationDateTime: TDatetime read FMigrationDateTime write FMigrationDateTime;
    {$REGION 'TMigrationsHistoryItem.StartOfExecution'}
      /// <Description>
      ///  Stores the date time value of the migration´s execution start.
      /// </Description>
    {$ENDREGION}
    property StartOfExecution: TDateTime read FStartOfExecution write FStartOfExecution;
    {$REGION 'TMigrationsHistoryItem.EndOfExecution'}
      /// <Description>
      ///  Stores the date time value of the migration´s execution finish.
      /// </Description>
    {$ENDREGION}
    property EndOfExecution: TDateTime read FEndOfExecution write FEndOfExecution;
    {$REGION 'TMigrationsHistoryItem.DurationOfExecution'}
      /// <Description>
      ///  Stores the elapsed time in the migration execution.
      /// </Description>
    {$ENDREGION}
    property DurationOfExecution: Extended read FDurationOfExecution write FDurationOfExecution;
  end;

implementation

end.
