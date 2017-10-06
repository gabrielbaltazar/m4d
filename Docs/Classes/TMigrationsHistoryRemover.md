
## Class **TMigrationsHistoryRemover** 

**Unit name:** M4D.MigrationsHistoryRemover

**Description:** Standard class to remove a migration into a migration´s history.

**Responsability:** Remove a migration into the history of migrations.

## Interface ##
The TMigrationsHistoryRemover implements the **IMigrationsHistoryRemover** interface:
```sh
  IMigrationsHistoryRemover = interface
  ['{9DC85F6D-D338-4A00-9365-A3C6E9EBA71D}']
    procedure Remove(AMigrationSequence: Integer);
  end;
```

## Class ##

```sh
  TMigrationsHistoryRemover = class(TInterfacedObject, IMigrationsHistoryRemover)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
    procedure Remove(AMigrationSequence: Integer);
  end;
```