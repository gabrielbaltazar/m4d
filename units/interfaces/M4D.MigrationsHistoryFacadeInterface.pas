{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryFacadeInterface;

interface

uses
  M4D.MigrationsHistoryItem, M4D.MigrationsInterface, Generics.Collections;

type
  {$M+}
  {$REGION 'IMigrationsHistoryFacade'}
    /// <Description>
    ///  Standard methods to handle migrations´s executions history.
    /// </Description>
  {$ENDREGION}
  IMigrationsHistoryFacade = interface
  ['{639BAD0D-0273-4EB2-B129-D9CB70B1B108}']
    {$REGION 'IMigrationExecutorFacade.Clear'}
      /// <Description>
      ///  Clear the history info.
      /// </Description>
    {$ENDREGION}
    procedure Clear;
    {$REGION 'IMigrationsHistoryFacade.Load'}
      /// <Description>
      ///  Load all the history of migrations executions.
      /// </Description>
    {$ENDREGION}
    procedure Load;
    {$REGION 'IMigrationsHistoryFacade.UnLoad'}
      /// <Description>
      ///  Unload all the history of migrations executions.
      /// </Description>
    {$ENDREGION}
    procedure UnLoad;
    {$REGION 'IMigrationsHistoryFacade.Add'}
      /// <Description>
      ///  Add a execution history information.
      /// </Description>
      /// <InputParameters>
      ///  AItem - The history item that will be stored.
      /// </InputParameters>
    {$ENDREGION}
    procedure Add(AItem: TMigrationsHistoryItem);
    {$REGION 'IMigrationsHistoryFacade.Remove'}
      /// <Description>
      ///  Remove a execution history information.
      /// </Description>
      /// <InputParameters>
      ///  AItem - The history item that will be removed.
      /// </InputParameters>
    {$ENDREGION}
    procedure Remove(AMigrationSequence: Integer);
    {$REGION 'IMigrationsHistoryFacade.getHistory'}
      /// <Description>
      ///  Gets a list with informations of all migration´s executions.
      /// </Description>
      /// <OutputParameters>
      ///  Return - A list with all migrations.
      /// </OutputParameters>
      /// <Note>
      ///  Get all history os executions.
      /// </Note>
    {$ENDREGION}
    function getHistory: TList<TMigrationsHistoryItem>; overload;
    {$REGION 'IMigrationsHistoryFacade.getHistory'}
      /// <Description>
      ///  Gets a list with informations of migration´s executions.
      /// </Description>
      /// <InputParameters>
      ///  AStartMigrationSeq - The sequential value of the migration that will be
      ///  considered as the start migration.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Return - A list with all migrations with the sequence value equal or gratter then the AStartMigrationSeq.
      /// </OutputParameters>
      /// <Note>
      ///  Only takes histories greater than or equal to the sequence inputted.
      /// </Note>
    {$ENDREGION}
    function getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    {$REGION 'IMigrationsHistoryFacade.getHistory'}
      /// <Description>
      ///  Gets a list with informations of migration´s executions.
      /// </Description>
      /// <InputParameters>
      ///  AStartMigrationDateTime - The date time value of the migration that will be
      ///  considered as the start migration.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Return - A list with all migrations with the date time value equal or gratter
      ///  then the AStartMigrationDateTime.
      /// </OutputParameters>
      /// <Note>
      ///  Only takes histories greater than or equal to the date time inputted.
      /// </Note>
    {$ENDREGION}
    function getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;
    {$REGION 'IMigrationsHistoryFacade.Save'}
      /// <Description>
      ///  Save all the history of migrations executions.
      /// </Description>
    {$ENDREGION}
    procedure Save;
    {$REGION 'IMigrationsHistoryFacade.LastMigration'}
      /// <Description>
      ///  Return the last migration executed.
      /// </Description>
      /// <OutputParameters>
      ///  Return - Last migration executed on the history list.
      /// </OutputParameters>
    {$ENDREGION}
    function LastMigration: TMigrationsHistoryItem;

    property HistoryList: TList<TMigrationsHistoryItem> read getHistory;
  end;

implementation

end.
