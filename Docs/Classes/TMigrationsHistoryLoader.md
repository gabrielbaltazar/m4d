[Back](CLASS_REFERENCES.md)
## Class **TMigrationsHistoryLoader** ## 

**Unit name:** M4D.MigrationsHistoryLoader
**Description:** Standard class to load migration´s history.
**Responsability:** Load the history of migrations.

## Interface ##
The TMigrationsHistoryLoader implements the **IMigrationsHistoryLoader** interface:
```sh
  IMigrationsHistoryLoader = interface
  ['{6CBBDDB8-01B2-41C9-9366-BE39930D7A43}']
    procedure Load;
  end;
```

## Class ##

```sh
  TMigrationsHistoryLoader = class(TInterfacedObject, IMigrationsHistoryLoader)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: String;
    FSerializer: IMigrationSerializer;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string; ASerializer: IMigrationSerializer); reintroduce;
    procedure Load;
  end;
```