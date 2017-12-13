{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecPendingExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationsHistoryItem;

type
  {$REGION 'IMigrationExecPendingExecutor'}
    /// <Description>
    ///  Standard interface to execute pending´s migrations.
    /// </Description>
  {$ENDREGION}
  IMigrationExecPendingExecutor = interface
  ['{48E80446-C8C4-41B0-A81F-E5637DAD3587}']
    {$REGION 'IMigrationExecPendingExecutor.ExecutePending'}
      /// <Description>
      ///  Performs the execution of pending´s migration.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      ///  ALastMigration - The last migrations executed before. This migration is the base to know
      ///  which migrations arer still pending.
      ///  AMigrationHistory - The migration´s history handle to record the news executions.
      /// </InputParameters>
      /// <Note>
      ///  Pending migrations are those that have not yet been executed based on the execution
      ///  history. The class must identify which executions have not been performed (usually
      ///  based on the sequence of the migrations) and execute them.
      /// </Note>
    {$ENDREGION}
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
  end;

implementation

end.
