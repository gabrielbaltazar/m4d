[Back](CLASS_REFERENCES.md)
## Class **TMigrationRollbackUntilExecutor** ## 

**Unit name:** M4D.MigrationRollbackUntilExecutor
**Description:** Standar class to execute the rollback of migrations until a specif sequence.
**Responsability:** Handle a migration´s list and call for rollback execution.

## Interface ##
The TMigrationRollbackUntilExecutor implements the **IMigrationRollbackUntilExecutor** interface:
```sh
  IMigrationRollbackUntilExecutor = interface
  ['{3BA279FD-0785-412B-BC29-DBD32780DCD2}']
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  end;
```

## Class ##

```sh
  TMigrationRollbackUntilExecutor = class(TInterfacedObject, IMigrationRollbackUntilExecutor)
  private
    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
  public
    constructor Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor); reintroduce;
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  end;
```