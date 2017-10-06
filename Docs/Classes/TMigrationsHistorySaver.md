
## Class **TMigrationsHistorySaver** 

**Unit name:** M4D.MigrationsHistorySaver

**Description:** Standard class to save the migration´s history.

**Responsability:** Save the history of migrations.

## Interface ##
The TMigrationsHistorySaver implements the **IMigrationsHistorySaver** interface:
```sh
  IMigrationsHistorySaver = interface
  ['{9D801497-2331-4CF8-BE3C-F32683B2A741}']
    procedure Save;
  end;
```

## Class ##

```sh
  TMigrationsHistorySaver = class(TInterfacedObject, IMigrationsHistorySaver)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: string;
    FSerializer: IMigrationSerializer;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string; ASerializer: IMigrationSerializer); reintroduce;
    procedure Save;
  end;
```