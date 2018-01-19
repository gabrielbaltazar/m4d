{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecExecutorInterface;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryFacadeInterface;

type
  {$REGION 'IMigrationExecExecutorInterface'}
    /// <Description>
    ///  Standard interface to execute migrations.
    /// </Description>
  {$ENDREGION}
  IMigrationExecExecutor = interface
  ['{31CE6179-89FD-4233-9FC0-97DA0FAA9CDE}']
    {$REGION 'IMigrationExecExecutorInterface.Execute'}
      /// <Description>
      ///  Performs the migration forward.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      ///  AChangeHistory - Informs whether migration produces changes to update histories.
      /// </InputParameters>
    {$ENDREGION}
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AChangeHistory: Boolean = True);
  end;

implementation

end.
