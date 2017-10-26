
## Class **TMigrationExecRangeExecutor** 

**Unit name:** M4D.MigrationExecRangeExecutor

**Description:** Standar class to execute a range of migrations.

**Responsability:** Call for migration´s execution of a specific range of migrations.

## Interface ##
The TMigrationExecRangeExecutor implements the **IMigrationExecRangeExecutor** interface:
```sh
  IMigrationExecRangeExecutor = interface
  ['{7E9C940B-E461-42A7-92CA-635A8F4DBE17}']
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;
```

## Class ##

```sh
  TMigrationExecRangeExecutor = class(TInterfacedObject, IMigrationExecRangeExecutor)
  private
    FMigrationExecExecutor: IMigrationExecExecutor;
  public
    constructor Create(AMigrationExecExecutor: IMigrationExecExecutor); reintroduce;
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;
```