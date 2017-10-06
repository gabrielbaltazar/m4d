[Back](CLASS_REFERENCES.md)
## Class **TMigrationsHistoryUnloader** ## 

**Unit name:** M4D.MigrationsHistoryUnloader
**Description:** Standard class to unload migration´s history.
**Responsability:** Unload the history of migrations.

## Interface ##
The TMigrationsHistoryUnloader implements the **IMigrationsHistoryUnloader** interface:
```sh
  IMigrationsHistoryUnloader = interface
  ['{097139C8-CFBA-4542-BB72-ECD3821A6713}']
    procedure UnLoad;
  end;
```

## Class ##

```sh
  TMigrationsHistoryUnloader = class(TInterfacedObject, IMigrationsHistoryUnloader)
  private
    FFile: TStringList;
  public
    constructor Create(AFile: TStringList); reintroduce;
    procedure UnLoad;
  end;
```