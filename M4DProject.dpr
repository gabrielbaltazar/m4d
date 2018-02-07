{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
program M4DProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  M4D.GetterMigrationsInterface in 'units\interfaces\M4D.GetterMigrationsInterface.pas',
  M4D.RegisterMigrationInterface in 'units\interfaces\M4D.RegisterMigrationInterface.pas',
  M4D.Migrations in 'units\classes\M4D.Migrations.pas',
  M4D.MigrationsFacade in 'units\classes\M4D.MigrationsFacade.pas',
  M4D.MigrationExecutorFacadeInterface in 'units\interfaces\M4D.MigrationExecutorFacadeInterface.pas',
  M4D.GetterMigrations in 'units\classes\M4D.GetterMigrations.pas',
  M4D.MigrationExecutorFacade in 'units\classes\M4D.MigrationExecutorFacade.pas',
  M4D.MigrationsHistoryItem in 'units\classes\M4D.MigrationsHistoryItem.pas',
  M4D.MigrationsHistoryFacade in 'units\classes\M4D.MigrationsHistoryFacade.pas',
  M4D.MigrationsHistoryFacadeInterface in 'units\interfaces\M4D.MigrationsHistoryFacadeInterface.pas',
  M4D.MigrationSerializerFacadeInterface in 'units\interfaces\M4D.MigrationSerializerFacadeInterface.pas',
  M4D.MigrationSerializerFacade in 'units\classes\M4D.MigrationSerializerFacade.pas',
  M4D in 'units\classes\M4D.pas',
  M4D.MigrationListOrder in 'units\classes\M4D.MigrationListOrder.pas',
  M4D.MigrationListOrderInterface in 'units\interfaces\M4D.MigrationListOrderInterface.pas',
  M4D.MigrationsRegisterInterface in 'units\interfaces\M4D.MigrationsRegisterInterface.pas',
  M4D.MigrationsRegister in 'units\classes\M4D.MigrationsRegister.pas',
  M4D.Defaults in 'units\classes\M4D.Defaults.pas',
  M4D.MainMigrationsGetter in 'units\classes\M4D.MainMigrationsGetter.pas',
  M4D.SequenceMigrationsGetter in 'units\classes\M4D.SequenceMigrationsGetter.pas',
  M4D.MainMigrationsGetterInterface in 'units\interfaces\M4D.MainMigrationsGetterInterface.pas',
  M4D.SequenceMigrationsGetterInterface in 'units\interfaces\M4D.SequenceMigrationsGetterInterface.pas',
  M4D.DatetimeMigrationsGetterInterface in 'units\interfaces\M4D.DatetimeMigrationsGetterInterface.pas',
  M4D.DatetimeMigrationsGetter in 'units\classes\M4D.DatetimeMigrationsGetter.pas',
  M4D.MigrationExecExecutorInterface in 'units\interfaces\M4D.MigrationExecExecutorInterface.pas',
  M4D.MigrationExecExecutor in 'units\classes\M4D.MigrationExecExecutor.pas',
  M4D.MigrationExecPendingExecutor in 'units\classes\M4D.MigrationExecPendingExecutor.pas',
  M4D.MigrationExecPendingExecutorInterface in 'units\interfaces\M4D.MigrationExecPendingExecutorInterface.pas',
  M4D.MigrationExecUntilExecutorInterface in 'units\interfaces\M4D.MigrationExecUntilExecutorInterface.pas',
  M4D.MigrationExecUntilExecutor in 'units\classes\M4D.MigrationExecUntilExecutor.pas',
  M4D.MigrationRollbackExecutorInterface in 'units\interfaces\M4D.MigrationRollbackExecutorInterface.pas',
  M4D.MigrationRollbackExecutor in 'units\classes\M4D.MigrationRollbackExecutor.pas',
  M4D.MigrationRollbackUntilExecutorInterface in 'units\interfaces\M4D.MigrationRollbackUntilExecutorInterface.pas',
  M4D.MigrationRollbackUntilExecutor in 'units\classes\M4D.MigrationRollbackUntilExecutor.pas',
  M4D.HistoryToTextTransformerInterface in 'units\interfaces\M4D.HistoryToTextTransformerInterface.pas',
  M4D.HistoryToTextTransformer in 'units\classes\M4D.HistoryToTextTransformer.pas',
  M4D.TextToHistoryTransformerInterface in 'units\interfaces\M4D.TextToHistoryTransformerInterface.pas',
  M4D.TextToHistoryTransformer in 'units\classes\M4D.TextToHistoryTransformer.pas',
  M4D.HistoryCleanerInterface in 'units\interfaces\M4D.HistoryCleanerInterface.pas',
  M4D.HistoryCleaner in 'units\classes\M4D.HistoryCleaner.pas',
  M4D.MigrationsHistoryLoaderInterface in 'units\interfaces\M4D.MigrationsHistoryLoaderInterface.pas',
  M4D.MigrationsHistoryLoader in 'units\classes\M4D.MigrationsHistoryLoader.pas',
  M4D.MigrationsHistoryUnloaderInterface in 'units\interfaces\M4D.MigrationsHistoryUnloaderInterface.pas',
  M4D.MigrationsHistoryUnloader in 'units\classes\M4D.MigrationsHistoryUnloader.pas',
  M4D.MigrationsHistoryAdderInterface in 'units\interfaces\M4D.MigrationsHistoryAdderInterface.pas',
  M4D.MigrationsHistoryAdder in 'units\classes\M4D.MigrationsHistoryAdder.pas',
  M4D.MigrationsHistoryRemoverInterface in 'units\interfaces\M4D.MigrationsHistoryRemoverInterface.pas',
  M4D.MigrationsHistoryRemover in 'units\classes\M4D.MigrationsHistoryRemover.pas',
  M4D.MigrationsHistorySaverInterface in 'units\interfaces\M4D.MigrationsHistorySaverInterface.pas',
  M4D.MigrationsHistorySaver in 'units\classes\M4D.MigrationsHistorySaver.pas',
  M4D.LastMigrationsHistoryGetterInterface in 'units\interfaces\M4D.LastMigrationsHistoryGetterInterface.pas',
  M4D.LastMigrationsHistoryGetter in 'units\classes\M4D.LastMigrationsHistoryGetter.pas',
  M4D.HistoryGetterInterface in 'units\interfaces\M4D.HistoryGetterInterface.pas',
  M4D.HistoryGetter in 'units\classes\M4D.HistoryGetter.pas',
  M4D.MigrationRollbackPendingExecutorInterface in 'units\interfaces\M4D.MigrationRollbackPendingExecutorInterface.pas',
  M4D.MigrationRollbackPendingExecutor in 'units\classes\M4D.MigrationRollbackPendingExecutor.pas',
  M4D.MigrationExecRangeExecutorInterface in 'units\interfaces\M4D.MigrationExecRangeExecutorInterface.pas',
  M4D.MigrationExecRangeExecutor in 'units\classes\M4D.MigrationExecRangeExecutor.pas',
  M4D.MigrationRollbackRangeExecutorInterface in 'units\interfaces\M4D.MigrationRollbackRangeExecutorInterface.pas',
  M4D.MigrationRollbackRangeExecutor in 'units\classes\M4D.MigrationRollbackRangeExecutor.pas',
  M4D.MigrationsInterface in 'units\interfaces\M4D.MigrationsInterface.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
