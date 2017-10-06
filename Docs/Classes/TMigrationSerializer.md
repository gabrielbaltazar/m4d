[Back](CLASS_REFERENCES.md)
## Class **TMigrationSerializer** ## 

**Unit name:** M4D.MigrationSerializer
**Description:** Standard class to convert between string values and history items.
**Responsability:** Performs converters between string values and history items.

## Interface ##
The TMigrationSerializer implements the **IMigrationSerializer** interface:
```sh
  IMigrationSerializer = interface
  ['{1E3E8A3D-4994-4C4C-8911-2A4C2371B4A9}']
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;
```

## Class ##

```sh
  TMigrationSerializer = class(TInterfacedObject, IMigrationSerializer)
  private
    FHistoryToTextTransformer: IHistoryToTextTransformer;
    FTextToHistoryTransformer: ITextToHistoryTransformer;
  public
    constructor Create; reintroduce;
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;
```