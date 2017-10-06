[Back](CLASS_REFERENCES.md)
## Class **TSequenceMigrationsGetter** ## 

**Unit name:** M4D.SequenceMigrationsGetter
**Description:** Standard class to get a list of registered´s migration base on the sequence.
**Responsability:** Get a subset os items from a inputted list, based on the sequence start parameter.

## Interface ##
The TSequenceMigrationsGetter implements the **ISequenceMigrationsGetter** interface:
```sh
  ISequenceMigrationsGetter = interface
  ['{F38CFBAB-A158-482A-8F5B-0496CED2CB60}']
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
  end;
```

## Class ##

```sh
  TSequenceMigrationsGetter = class(TInterfacedObject, ISequenceMigrationsGetter)
  public
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
  end;
```