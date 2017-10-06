
## Class **TTextToHistoryTransformer** 

**Unit name:** M4D.TextToHistoryTransformer

**Description:** Standard class to convert from string value to history item.

**Responsability:** Performs converters between string values to history items.

## Interface ##
The TTextToHistoryTransformer implements the **ITextToHistoryTransformer** interface:
```sh
  ITextToHistoryTransformer = interface
  ['{0B3B46FA-BBA3-4AF9-B499-517E45281509}']
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;
```

## Class ##

```sh
  TTextToHistoryTransformer = class(TInterfacedObject, ITextToHistoryTransformer)
  public
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;
```