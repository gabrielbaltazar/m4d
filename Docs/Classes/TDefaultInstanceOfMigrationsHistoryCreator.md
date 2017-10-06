## Class **TDefaultInstanceOfMigrationsHistoryCreator**

**Unit name:** M4D.Defaults

**Description:** This is a class used to provide a default instance of IMigrationsHistory.

**Responsability:** Get the default instance of migration´s history object.

## Interface ##
None.

## Class ##

```sh
  TDefaultInstanceOfMigrationsHistoryCreator = class
  private
    const CFILE_NAME = 'history.m4d';
    class var FMigrationsHistory: IMigrationsHistory;
  public
    class function getInstance(AMigrationSerializer: IMigrationSerializer): IMigrationsHistory;
  end;
```