
## Class **TMigrationListOrder** 

**Unit name:** M4D.MigrationListOrder

**Description:** Standard class to handle the order of the migration list.

**Responsability:** Provide a migration sort mechanism.

## Interface ##
The TMigrationListOrder implements the **IMigrationListOrder** interface:
```sh
  IMigrationListOrder = interface
    ['{34BA6E20-B893-4665-B6EE-E72A6640E17D}']
    function Comparison: TComparison<TClass>;
  end;
```

## Class ##

```sh
  TMigrationListOrder = class(TInterfacedObject, IMigrationListOrder)
  public
    function Comparison: TComparison<TClass>;
  end;
```