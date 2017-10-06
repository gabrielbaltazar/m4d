## Class **TDefaultInstanceOfMigrationGetterCreator**

**Unit name:** M4D.Defaults

**Description:** This is a class used to provide a default instance of IGetterMigrations.

**Responsability:** Get the default instance of migration´s getter object.

## Interface ##
None.

## Class ##

```sh
  TDefaultInstanceOfMigrationGetterCreator = class
  private
    class var FMigrationGetter: IGetterMigrations;
  public
    class function getInstance: IGetterMigrations;
  end;
```