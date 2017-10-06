## Class **THistoryToTextTransformer**

**Unit name:** M4D.HistoryToTextTransformer

**Description:** Convert history item to string value.

**Responsability:** Performs converters between history items to string values.

## Interface ##
The THistoryToTextTransformer implements the **IHistoryToTextTransformer** interface:
```sh
  IHistoryToTextTransformer = interface
  ['{F9650EEC-B3D0-47E7-994B-46D7B8DFDB2B}']
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
  end;
```

## Class ##

```sh
  THistoryToTextTransformer = class(TInterfacedObject, IHistoryToTextTransformer)
  public
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
  end;
```