
## Class **TMigrationRollbackRangeExecutor** 

**Unit name:** M4D.MigrationRollbackRangeExecutor

**Description:** Standard class to execute the rollback of migrations of a specif range of sequences.

**Responsability:** Handle a migration´s list and call for rollback execution.

## Interface ##
The TMigrationRollbackRangeExecutor implements the **IMigrationRollbackRangeExecutor** interface:
```sh
  IMigrationRollbackRangeExecutor = interface
  ['{39480555-8DB7-4092-A41C-0C02F63F5770}']
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;
```

## Class ##

```sh
  TMigrationRollbackRangeExecutor = class(TInterfacedObject, IMigrationRollbackRangeExecutor)
  private
    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
  public
    constructor Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor); reintroduce;
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;
```