
## Class **TMigrationsHistoryAdder** 

**Unit name:** M4D.MigrationsHistoryAdder

**Description:** Standard class to add a migration into a migration´s history.

**Responsability:** Add a migration into the history of migrations.

## Interface ##
The TMigrationsHistoryAdder implements the **IMigrationsHistoryAdder** interface:
```sh
  IMigrationsHistoryAdder = interface
  ['{82C95471-F422-4E14-B6D8-BA61C2969805}']
    procedure Add(AItem: TMigrationsHistoryItem);
  end;
```

## Class ##

```sh
  TMigrationsHistoryAdder = class(TInterfacedObject, IMigrationsHistoryAdder)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
    procedure Add(AItem: TMigrationsHistoryItem);
  end;
```