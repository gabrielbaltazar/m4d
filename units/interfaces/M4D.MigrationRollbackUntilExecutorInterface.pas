{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationRollbackUntilExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryInterface;

type
  {$REGION 'IMigrationRollbackUntilExecutor'}
    /// <Description>
    ///  Standard interface to rollback migrations until a specif sequence.
    /// </Description>
  {$ENDREGION}
  IMigrationRollbackUntilExecutor = interface
  ['{3BA279FD-0785-412B-BC29-DBD32780DCD2}']
    {$REGION 'IMigrationRollbackUntilExecutor.RollbackUntil'}
      /// <Description>
      ///  Performs the migration back until the migration with sequence value equal inputted one.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the rollback.
      ///  AMigrationsSequence - Migration sequence value that will be considered as the last to
      ///  be executed in the migration´s rollback.
      /// </InputParameters>
    {$ENDREGION}
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  end;

implementation

end.
