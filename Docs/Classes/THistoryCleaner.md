[Back](CLASS_REFERENCES.md)
## Class **THistoryCleaner** ## 

**Unit name:** M4D.HistoryCleaner
**Description:** Standard class for clear the history of migrations´s executions.
**Responsability:** Clear the history of migrations´s executions.

## Interface ##
The THistoryCleaner implements the **IHistoryCleaner** interface:
```sh
  IHistoryCleaner = interface
  ['{C7C5EEB3-9C17-4C95-9CE4-7A4DED0E1AA6}']
    procedure Clear;
  end;
```

## Class ##

```sh
  THistoryCleaner = class(TInterfacedObject, IHistoryCleaner)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: string;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string); reintroduce;
    procedure Clear;
  end;
```