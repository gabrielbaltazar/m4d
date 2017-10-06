[Back](DOCUMENTATION.md)

### Class Reference ###

Below are all project classes. Most are very simple, following the principle of **"Single Responsibility"**, which explains the number of classes below. However, for some cases, a class has more than one responsibility. These are the front-end classes for the user, which make migration functionalities easier and faster.

**[TDefaultInstanceOfMigrationsSerializerCreator](Classes/TDefaultInstanceOfMigrationsSerializerCreator.md)**
>Responsability: Get the default instance of migration´s serializer object

**[TDefaultInstanceOfMigrationsHistoryCreator](TDefaultInstanceOfMigrationsHistoryCreator.md)**
>Responsability: Get the default instance of migration´s history object.

**[TDefaultInstanceOfMigrationGetterCreator](TDefaultInstanceOfMigrationGetterCreator.md)**
>Responsability: Get the default instance of migration´s getter object.

**[TDefaultInstanceOfMigrationListOrderCreator](TDefaultInstanceOfMigrationListOrderCreator.md)**
>Responsability: Get the default instance of migration´s list order object.

**[TDefaultInstanceOfMigrationsRegisterCreator](TDefaultInstanceOfMigrationsRegisterCreator.md)**
>Responsability: Get the default instance of migration´s register object.

**[TDefaultInstanceOfMigrationExecutorCreator](TDefaultInstanceOfMigrationExecutorCreator.md)**
>Responsability: Get the default instance of migration´s executor object.

**[TDatetimeMigrationsGetter](TDatetimeMigrationsGetter.md)**
>Responsability: Get a subset of items from a inputted list, based on the start parameter.

**[TGetterMigrations](TGetterMigrations.md)**
>Responsability: Get a subset os items from a inputted list, based on the start parameter.

**[TMainMigrationsGetter](TMainMigrationsGetter.md)**
>Responsability: Be a base class to get a subset os items from a inputted list, based on the start parameter.

**[TMigrationExecExecutor](TMigrationExecExecutor.md)**
>Responsability: Execute the up method of a migration.

**[TMigrationExecPendingExecutor](TMigrationExecPendingExecutor.md)**
>Responsability: Handle the list to know what is pendind and call for execution.

**[TMigrationExecUntilExecutor](TMigrationExecUntilExecutor.md)**
>Responsability: Call for migration´s execution until a specific sequence.

**[TMigrationExecutor](TMigrationExecutor.md)**
>Responsability: Performs executions and rollbacks of the migrations.

**[TMigrationListOrder](TMigrationListOrder.md)**
>Responsability: Provide a migration sort mechanism.

**[TMigrationRollbackExecutor](TMigrationRollbackExecutor.md)**
>Responsability: Execute the migration´s down method.

**[TMigrationRollbackUntilExecutor](TMigrationRollbackUntilExecutor.md)**
>Responsability: Handle a migration´s list and call for rollback execution.

**[TMigrations](TMigrations.md)**
>Responsability: Be a set of updates.

**[TMigrationSerializer](TMigrationSerializer.md)**
>Responsability: Performs converters between string values and history items.

**[TMigrationsHistory](TMigrationsHistory.md)**
>Responsability: Handle informations about the history of migrations´s executions.

**[TMigrationsHistoryItem](TMigrationsHistoryItem.md)**
>Responsability: Stores information about the execution of migration.

**[TMigrationsManager](TMigrationsManager.md)**
>Responsability: Provide centralized migration features.

**[TMigrationsRegister](TMigrationsRegister.md)**
>Responsability: Register a migration.

**[TSequenceMigrationsGetter](TSequenceMigrationsGetter.md)**
>Responsability: Get a subset os items from a inputted list, based on the sequence start parameter.

**[THistoryToTextTransformer](THistoryToTextTransformer.md)**
>Responsability: Performs converters between history items to string values.

**[TTextToHistoryTransformer](TTextToHistoryTransformer.md)**
>Responsability: Performs converters between string values to history items.

**[THistoryCleaner](THistoryCleaner.md)**
>Responsability: Clear the history of migrations´s executions.

**[TMigrationsHistoryLoader](TMigrationsHistoryLoader.md)**
>Responsability: Load the history of migrations.

**[TMigrationsHistoryUnloader](TMigrationsHistoryUnloader.md)**
>Responsability: Unload the history of migrations.

**[TMigrationsHistoryAdder](TMigrationsHistoryAdder.md)**
>Responsability: Add a migration into the history of migrations.

**[TMigrationsHistoryRemover](TMigrationsHistoryRemover.md)**
>Responsability: Remove a migration into the history of migrations.

**[TMigrationsHistorySaver](TMigrationsHistorySaver.md)**
>Responsability: Save the history of migrations.

**[TLastMigrationsHistoryGetter](TLastMigrationsHistoryGetter.md)**
>Responsability: Get the last migration from the history of migrations.

**[TMigrationHistoryGetter](TMigrationHistoryGetter.md)**
>Responsability: Get a migration from the history of migrations.