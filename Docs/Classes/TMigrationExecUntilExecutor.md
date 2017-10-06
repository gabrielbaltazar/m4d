[Back](CLASS_REFERENCES.md)
## Class **TMigrationExecUntilExecutor** ## 

**Unit name:** M4D.MigrationExecUntilExecutor
**Description:** Standar class to execute the migrations until a specif sequence.
**Responsability:** Call for migration´s execution until a specific sequence.

## Interface ##
The TMigrationExecUntilExecutor implements the **IMigrationExecUntilExecutor** interface:
```sh
  IMigrationExecUntilExecutor = interface
  ['{0E2BE565-92E6-4419-8A62-742B7D04D60A}']
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  end;
```

## Class ##

```sh
  TMigrationExecUntilExecutor = class(TInterfacedObject, IMigrationExecUntilExecutor)
  private
    FMigrationExecExecutor: IMigrationExecExecutor;
  public
    constructor Create(AMigrationExecExecutor: IMigrationExecExecutor); reintroduce;
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  end;
```