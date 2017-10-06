[Back](CLASS_REFERENCES.md)
## Class **TMigrationExecutor** ## 

**Unit name:** M4D.MigrationExecutor
**Description:** Standard class to execute migrations.
**Responsability:** Performs executions and rollbacks of the migrations.

## Interface ##
The TMigrationExecutor implements the **IMigrationExecutor** interface:
```sh
  IMigrationExecutor = interface
  ['{E348B052-BF8F-4BF0-9347-EC70B252F308}']
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
    function getMigrationsHistory: IMigrationsHistory;
    property MigrationHistory: IMigrationsHistory read getMigrationsHistory;
  end;
```

## Class ##

```sh
  TMigrationExecutor = class(TInterfacedObject, IMigrationExecutor)
  private
    FMigrationHistory: IMigrationsHistory;

    FMigrationExecExecutor: IMigrationExecExecutor;
    FMigrationExecPendingExecutor: IMigrationExecPendingExecutor;
    FMigrationExecUntilExecutor: IMigrationExecUntilExecutor;

    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
    FMigrationRollbackUntilExecutor: IMigrationRollbackUntilExecutor;

    function getMigrationsHistory: IMigrationsHistory;
  public
    constructor Create(AMigrationHistory: IMigrationsHistory); reintroduce;
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  published
    property MigrationHistory: IMigrationsHistory read getMigrationsHistory;
  end;
```