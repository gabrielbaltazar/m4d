
## Class **TMainMigrationsGetter**

**Unit name:** M4D.MainMigrationsGetter

**Description:** Standard base class to get a list of registered´s migration.

**Responsability:** Be a base class to get a subset os items from a inputted list, based on the start parameter.

## Interface ##
The TMainMigrationsGetter implements the **IMainMigrationsGetter** interface:
```sh
  IMainMigrationsGetter = interface
  ['{E015610A-5C01-49C5-B991-150929792DB8}']
    function getMigrations(AMigrationsList: TList<IMigration>; APredicate: TPredicate<IMigration>): TList<IMigration>;
  end;
```

## Class ##

```sh
  TMainMigrationsGetter = class(TInterfacedObject, IMainMigrationsGetter)
  public
    function getMigrations(AMigrationsList: TList<IMigration>; APredicate: TPredicate<IMigration>): TList<IMigration>;
  end;
```