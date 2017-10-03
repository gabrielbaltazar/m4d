{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecUntilExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryInterface;

type
  {$REGION 'IMigrationExecUntilExecutor'}
    /// <Description>
    ///  Standard interface to execute migrations until a specific sequence.
    /// </Description>
  {$ENDREGION}
  IMigrationExecUntilExecutor = interface
  ['{0E2BE565-92E6-4419-8A62-742B7D04D60A}']
    {$REGION 'IMigrationExecUntilExecutor.Execute'}
      /// <Description>
      ///  Performs the execution until the inputted value.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      ///  AMigrationSequence - The last sequence value considered to execution.
      ///  AMigrationHistory - The history handler to record executions.
      /// </InputParameters>
    {$ENDREGION}
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  end;

implementation

end.
