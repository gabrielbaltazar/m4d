[Back](CLASS_REFERENCES.md)
## Class **TGetterMigrations** ## 

**Unit name:** M4D.GetterMigrations
**Description:** Standard class to get a list of registered´s migration.
**Responsability:** Get a subset os items from a inputted list, based on the start parameter.

## Interface ##
The TGetterMigrations implements the **IGetterMigrations** interface:
```sh
  IGetterMigrations = interface
  ['{E5339741-C1C0-4FA1-A19A-2A379DE43AA2}']
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer): TList<IMigration>; overload;
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDateTime): TList<IMigration>; overload;
  end;
```

## Class ##

```sh
  TGetterMigrations = class(TInterfacedObject, IGetterMigrations)
  private
    FMainMigrationGetter: IMainMigrationsGetter;
    FSequenceMigrationGetter: ISequenceMigrationsGetter;
    FDatetimeMigrationGetter: IDatetimeMigrationsGetter;

  public
    constructor Create; reintroduce;

    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer): TList<IMigration>; overload;
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDateTime): TList<IMigration>; overload;
  end;
```