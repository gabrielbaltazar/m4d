## Class **TLastMigrationsHistoryGetter** 

**Unit name:** M4D.LastMigrationsHistoryGetter

**Description:** Standard class to get the last migration from the migration´s history.

**Responsability:** Get the last migration from the history of migrations.

## Interface ##
The TLastMigrationsHistoryGetter implements the **ILastMigrationsHistoryGetter** interface:
```sh
  ILastMigrationsHistoryGetter = interface
  ['{BF1B62A9-2531-434F-A070-605BC10C6ADB}']
    function LastMigration: TMigrationsHistoryItem;
  end;
```

## Class ##

```sh
  TLastMigrationsHistoryGetter = class(TInterfacedObject, ILastMigrationsHistoryGetter)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
    function LastMigration: TMigrationsHistoryItem;
  end;
```