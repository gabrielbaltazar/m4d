
## Class **TMigrationExecPendingExecutor**

**Unit name:** M4D.MigrationExecPendingExecutor

**Description:** Standard class to execute pending´s migrations.

**Responsability:** Handle the list to know what is pendind and call for execution.

## Interface ##
The TMigrationExecPendingExecutor implements the **IMigrationExecPendingExecutor** interface:
```sh
  IMigrationExecPendingExecutor = interface
  ['{48E80446-C8C4-41B0-A81F-E5637DAD3587}']
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
  end;
```

## Class ##

```sh
  TMigrationExecPendingExecutor = class(TInterfacedObject, IMigrationExecPendingExecutor)
  private
    FMigrationExecExecutor: IMigrationExecExecutor;
  public
    constructor Create(AMigrationExecExecutor: IMigrationExecExecutor); reintroduce;
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
  end;
```