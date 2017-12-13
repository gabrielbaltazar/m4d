{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecutorFacadeInterface;

interface

uses
  M4D.MigrationsInterface, Generics.Collections, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationsHistoryItem;

type
  {$REGION 'IMigrationExecutorFacade'}
    /// <Description>
    ///  Standard method to execute migrations on a list.
    /// </Description>
    /// <Note>
    ///  This allows you to perform migrations, both forward and backward.
    /// </Note>
  {$ENDREGION}
  IMigrationExecutorFacade = interface
  ['{E348B052-BF8F-4BF0-9347-EC70B252F308}']
    {$REGION 'IMigrationExecutorFacade.Execute'}
      /// <Description>
      ///  Performs the migration forward.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      /// </InputParameters>
    {$ENDREGION}
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    {$REGION 'IMigrationExecutorFacade.ExecutePending'}
      /// <Description>
      ///  Performs the execution of pending´s migration.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      /// </InputParameters>
      /// <Note>
      ///  Pending migrations are those that have not yet been executed based on the execution
      ///  history. The class must identify which executions have not been performed (usually
      ///  based on the sequence of the migrations) and execute them.
      /// </Note>
    {$ENDREGION}
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    {$REGION 'IMigrationExecutorFacade.ExecuteUntil'}
      /// <Description>
      ///  Performs the execution until the inputted value.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      ///  AMigrationSequence - The last sequence value considered to execution.
      /// </InputParameters>
    {$ENDREGION}
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    {$REGION 'IMigrationExecutorFacade.ExecuteRange'}
      /// <Description>
      ///  Performs the execution of a range of migrations.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list of all the migrations that will be considered for the execution.
      ///  AMigrationHistory - The history component that will register the execution of the migrate.
      ///  AStartMigrationSequence - The first sequence value considered to execution
      ///  AEndMigrationSequence - The last sequence value considered to execution
      /// </InputParameters>
    {$ENDREGION}
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
    {$REGION 'IMigrationExecutorFacade.Rollback'}
      /// <Description>
      ///  Performs the migration back.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the rollback.
      /// </InputParameters>
    {$ENDREGION}
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    {$REGION 'IMigrationExecutorFacade.RollbackPending'}
      /// <Description>
      ///  Performs the rollback of pending´s migration.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the rollback.
      /// </InputParameters>
      /// <Note>
      ///  Pending migrations are those that have not yet been rolled back based on the execution
      ///  history. The class must identify which executions have been performed (usually
      ///  based on the sequence of the migrations) and rollback them.
      /// </Note>
    {$ENDREGION}
    procedure RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    {$REGION 'IMigrationExecutorFacade.RollbackUntil'}
      /// <Description>
      ///  Performs the migration back until the migration with sequence value equal inputted one.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the rollback.
      ///  AMigrationsSequence - Migration sequence value that will be considered as the last to
      ///  be executed in the migration´s rollback.
      /// </InputParameters>
    {$ENDREGION}
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    {$REGION 'IMigrationExecutorFacade.RollbackRange'}
      /// <Description>
      ///  Performs the rollback of a range of migrations.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list of all the migrations that will be considered for the rollback.
      ///  AMigrationHistory - The history component that will register the rollback of the migrate.
      ///  AStartMigrationSequence - The last sequence value considered to rollback. The rollback occurs
      ///  in reverse order of execution.
      ///  AEndMigrationSequence - The first sequence value considered to rollback. The rollback occurs
      ///  in reverse order of execution.
      /// </InputParameters>
    {$ENDREGION}
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
    {$REGION 'IMigrationExecutorFacade.getMigrationHistory'}
      /// <Description>
      ///  Get the list of migrations executed.
      /// </Description>
    {$ENDREGION}
    function getMigrationsHistoryFacade: IMigrationsHistoryFacade;
    {$REGION 'IMigrationExecutorFacade.MigrationHistory'}
      /// <Description>
      ///  Expose information on migration histories.
      /// </Description>
    {$ENDREGION}
    property MigrationHistoryFacade: IMigrationsHistoryFacade read getMigrationsHistoryFacade;
  end;

implementation

end.
