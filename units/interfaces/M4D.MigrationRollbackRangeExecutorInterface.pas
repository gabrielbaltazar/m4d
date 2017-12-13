{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/10/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationRollbackRangeExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryFacadeInterface;

type
  {$REGION 'IMigrationRollbackRangeExecutor'}
    /// <Description>
    ///  Standard interface to rollback migrations of a specific sequence range.
    /// </Description>
  {$ENDREGION}
  IMigrationRollbackRangeExecutor = interface
  ['{39480555-8DB7-4092-A41C-0C02F63F5770}']
    {$REGION 'IMigrationRollbackRangeExecutor.RollbackRange'}
      /// <Description>
      ///  Performs the rollback of a specific range of migrations.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the rollback.
      ///  AMigrationHistory - The history handler to record rollback.
      ///  AStartMigrationSequence - The last sequence value considered to rollback. The rollback execution order is inverse.
      ///  AEndMigrationSequence - The first sequence value considered to rollback. The rollback execution order is inverse.
      /// </InputParameters>
    {$ENDREGION}
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;

implementation

end.
