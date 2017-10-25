{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/10/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecRangeExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryInterface;

type
  {$REGION 'IMigrationExecRangeExecutor'}
    /// <Description>
    ///  Standard interface to execute migrations of a specific sequence range.
    /// </Description>
  {$ENDREGION}
  IMigrationExecRangeExecutor = interface
  ['{7E9C940B-E461-42A7-92CA-635A8F4DBE17}']
    {$REGION 'IMigrationExecRangeExecutor.ExecuteRange'}
      /// <Description>
      ///  Performs the execution of a specific range of migrations.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      ///  AMigrationHistory - The history handler to record execution.
      ///  AStartMigrationSequence - The first sequence value considered to execution.
      ///  AEndMigrationSequence - The last sequence value considered to execution.
      /// </InputParameters>
    {$ENDREGION}
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;

implementation

end.
