
## Class **TMigrationHistoryGetter** 

**Unit name:** M4D.HistoryGetter

**Description:** Standard class to get a migration from the migration´s history.

**Responsability:** Get a migration from the history of migrations.

## Interface ##
The TMigrationHistoryGetter implements the **IMigrationHistoryGetter** interface:
```sh
  IMigrationHistoryGetter = interface
  ['{DC1023F7-5698-4754-AF3C-FF9FBDB1FD88}']
    function getHistory(APredicate: TPredicate<TMigrationsHistoryItem>): TList<TMigrationsHistoryItem>; overload;
  end;
```

## Class ##

```sh
  TMigrationHistoryGetter = class(TInterfacedObject, IMigrationHistoryGetter)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
     function getHistory(APredicate: TPredicate<TMigrationsHistoryItem>): TList<TMigrationsHistoryItem>;
  end;
```