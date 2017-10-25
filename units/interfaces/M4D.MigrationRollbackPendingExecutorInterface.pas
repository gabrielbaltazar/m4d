{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 18/10/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationRollbackPendingExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryInterface,
  M4D.MigrationsHistoryItem;

type
  {$REGION 'IMigrationRollbackPendingExecutor'}
    /// <Description>
    ///  Standard interface to rollback pending´s migrations.
    /// </Description>
  {$ENDREGION}
  IMigrationRollbackPendingExecutor = interface
  ['{3C92B7A5-10D6-4FF0-B6AC-089A50FCB11D}']
    {$REGION 'IMigrationRollbackPendingExecutor.ExecutePending'}
      /// <Description>
      ///  Performs the rollback of pending´s migration.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the rollback.
      ///  ALastMigration - The last migrations executed. This migration is the base to know
      ///  which migrations arer still pending.
      ///  AMigrationHistory - The migration´s history handle to record the news rollbacks.
      /// </InputParameters>
      /// <Note>
      ///  Pending migrations are those that have not yet been rollback based on the execution
      ///  history. The class must identify which executions have been performed (usually
      ///  based on the sequence of the migrations) and rollback them.
      /// </Note>
    {$ENDREGION}
    procedure RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
  end;

implementation

end.
