## Class **TDefaultInstanceOfMigrationListOrderCreator**

**Unit name:** M4D.Defaults

**Description:** This is a class used to provide a default instance of IMigrationListOrder.

**Responsability:** Get the default instance of migration´s list order object.

## Interface ##
None.

## Class ##

```sh
  TDefaultInstanceOfMigrationListOrderCreator = class
  private
    class var FMigrationListOrder: IMigrationListOrder;
  public
    class function getInstance: IMigrationListOrder;
  end;
```