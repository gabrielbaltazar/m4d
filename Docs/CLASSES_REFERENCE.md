### Class Reference ###

Below are all project classes. Most are very simple, following the principle of **"Single Responsibility"**, which explains the number of classes below. However, for some cases, a class has more than one responsibility. These are the front-end classes for the user, which make migration functionalities easier and faster to learn.

**[TDefaultInstanceOfMigrationsSerializerCreator](Classes/TDefaultInstanceOfMigrationsSerializerCreator.md)**
>Responsability: Get the default instance of migration´s serializer object

**[TDefaultInstanceOfMigrationsHistoryCreator](Classes/TDefaultInstanceOfMigrationsHistoryCreator.md)**
>Responsability: Get the default instance of migration´s history object.

**[TDefaultInstanceOfMigrationGetterCreator](Classes/TDefaultInstanceOfMigrationGetterCreator.md)**
>Responsability: Get the default instance of migration´s getter object.

**[TDefaultInstanceOfMigrationListOrderCreator](Classes/TDefaultInstanceOfMigrationListOrderCreator.md)**
>Responsability: Get the default instance of migration´s list order object.

**[TDefaultInstanceOfMigrationsRegisterCreator](Classes/TDefaultInstanceOfMigrationsRegisterCreator.md)**
>Responsability: Get the default instance of migration´s register object.

**[TDefaultInstanceOfMigrationExecutorCreator](Classes/TDefaultInstanceOfMigrationExecutorCreator.md)**
>Responsability: Get the default instance of migration´s executor object.

**[TDatetimeMigrationsGetter](Classes/TDatetimeMigrationsGetter.md)**
>Responsability: Get a subset of items from a inputted list, based on the start parameter.

**[TGetterMigrations](Classes/TGetterMigrations.md)**
>Responsability: Get a subset os items from a inputted list, based on the start parameter.

**[TMainMigrationsGetter](Classes/TMainMigrationsGetter.md)**
>Responsability: Be a base class to get a subset os items from a inputted list, based on the start parameter.

**[TMigrationExecExecutor](Classes/TMigrationExecExecutor.md)**
>Responsability: Execute the up method of a migration.

**[TMigrationExecPendingExecutor](Classes/TMigrationExecPendingExecutor.md)**
>Responsability: Handle the list to know what is pendind and call for execution.

**[TMigrationExecUntilExecutor](Classes/TMigrationExecUntilExecutor.md)**
>Responsability: Call for migration´s execution until a specific sequence.

**[TMigrationExecRangeExecutor](Classes/TMigrationExecRangeExecutor.md)**
>Responsability: Call for migration´s execution of a specific range of migrations.

**[TMigrationExecutor](Classes/TMigrationExecutor.md)**
>Responsability: Performs executions and rollbacks of the migrations.

**[TMigrationListOrder](Classes/TMigrationListOrder.md)**
>Responsability: Provide a migration sort mechanism.

**[TMigrationRollbackExecutor](Classes/TMigrationRollbackExecutor.md)**
>Responsability: Execute the migration´s down method.

**[TMigrationRollbackUntilExecutor](Classes/TMigrationRollbackUntilExecutor.md)**
>Responsability: Handle a migration´s list and call for rollback execution.

**[TMigrationRollbackRangeExecutor](Classes/TMigrationRollbackRangeExecutor.md)**
>Responsability: Handle a migration´s list and call for rollback execution.

**[TMigrations](Classes/TMigrations.md)**
>Responsability: Be a set of updates.

**[TMigrationSerializer](Classes/TMigrationSerializer.md)**
>Responsability: Performs converters between string values and history items.

**[TMigrationsHistory](Classes/TMigrationsHistory.md)**
>Responsability: Handle informations about the history of migrations´s executions.

**[TMigrationsHistoryItem](Classes/TMigrationsHistoryItem.md)**
>Responsability: Stores information about the execution of migration.

**[TMigrationsFacade](Classes/TMigrationsFacade.md)**
>Responsability: Provide centralized migration features.

**[TMigrationsRegister](Classes/TMigrationsRegister.md)**
>Responsability: Register a migration.

**[TSequenceMigrationsGetter](Classes/TSequenceMigrationsGetter.md)**
>Responsability: Get a subset os items from a inputted list, based on the sequence start parameter.

**[THistoryToTextTransformer](Classes/THistoryToTextTransformer.md)**
>Responsability: Performs converters between history items to string values.

**[TTextToHistoryTransformer](Classes/TTextToHistoryTransformer.md)**
>Responsability: Performs converters between string values to history items.

**[THistoryCleaner](Classes/THistoryCleaner.md)**
>Responsability: Clear the history of migrations´s executions.

**[TMigrationsHistoryLoader](Classes/TMigrationsHistoryLoader.md)**
>Responsability: Load the history of migrations.

**[TMigrationsHistoryUnloader](Classes/TMigrationsHistoryUnloader.md)**
>Responsability: Unload the history of migrations.

**[TMigrationsHistoryAdder](Classes/TMigrationsHistoryAdder.md)**
>Responsability: Add a migration into the history of migrations.

**[TMigrationsHistoryRemover](Classes/TMigrationsHistoryRemover.md)**
>Responsability: Remove a migration into the history of migrations.

**[TMigrationsHistorySaver](Classes/TMigrationsHistorySaver.md)**
>Responsability: Save the history of migrations.

**[TLastMigrationsHistoryGetter](Classes/TLastMigrationsHistoryGetter.md)**
>Responsability: Get the last migration from the history of migrations.

**[TMigrationHistoryGetter](Classes/TMigrationHistoryGetter.md)**
>Responsability: Get a migration from the history of migrations.