[Back](CLASSES_REFERENCE.md)
## Class **TDatetimeMigrationsGetter** ## 

**Unit name:** M4D.DatetimeMigrationsGetter
**Description:** Standard class to get a list of registered´s migration base on the sequence.
**Responsability:** Get a subset of items from a inputted list, based on the start parameter.

## Interface ##
The TDatetimeMigrationsGetter implements the **IDatetimeMigrationsGetter** interface:
```sh
  IDatetimeMigrationsGetter = interface
  ['{473148A6-C879-4589-8E20-AC9E69456206}']
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDatetime; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
  end;
```
## Class ##

```sh
  TDatetimeMigrationsGetter = class(TInterfacedObject, IDatetimeMigrationsGetter)
  public
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDateTime; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
  end;
```