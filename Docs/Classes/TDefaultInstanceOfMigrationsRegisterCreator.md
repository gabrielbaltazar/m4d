## Class **TDefaultInstanceOfMigrationsRegisterCreator**

**Unit name:** M4D.Defaults

**Description:** This is a class used to provide a default instance of IMigrationsRegister.

**Responsability:** Get the default instance of migration´s register object.

## Interface ##
None.

## Class ##

```sh
  TDefaultInstanceOfMigrationsRegisterCreator = class
  private
    class var FMigrationsRegister: IMigrationsRegister;
  public
    class function getInstance(AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;
  end;
```