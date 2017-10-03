{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationRollbackExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryInterface;

type
  {$REGION 'IMigrationRollbackExecutor'}
    /// <Description>
    ///  Standard interface to rollback migrations.
    /// </Description>
  {$ENDREGION}
  IMigrationRollbackExecutor = interface
  ['{1EB71323-095D-4288-B2A4-8D24C067A1F5}']
    {$REGION 'IMigrationRollbackExecutor.Rollback'}
      /// <Description>
      ///  Performs the migration back.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the rollback.
      ///  AMigrationHistory - The history handler to record rollbacks.
      /// </InputParameters>
    {$ENDREGION}
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
  end;

implementation

end.
