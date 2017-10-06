[Back](CLASS_REFERENCES.md)
## Class **TDefaultInstanceOfMigrationExecutorCreator** ## 

**Unit name:** M4D.Defaults
**Description:** This is a class used to provide a default instance of IMigrationExecutor.
**Responsability:** Get the default instance of migration´s executor object.

## Interface ##
None.

## Class ##

```sh
  TDefaultInstanceOfMigrationExecutorCreator = class
  private
    class var FExecutor: IMigrationExecutor;
  public
    class function getInstance(AMigrationsHistory: IMigrationsHistory): IMigrationExecutor;
  end;
```