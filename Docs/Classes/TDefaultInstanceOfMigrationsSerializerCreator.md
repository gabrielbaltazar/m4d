## Class **TDefaultInstanceOfMigrationsSerializerCreator** ## 

**Unit name:** M4D.Defaults

**Description:** This is a class used to provide a default instance of IMigrationSerializer.

**Responsability:** Get the default instance of migration´s serializer object.

## Interface ##
None.

## Class ##

```sh
  TDefaultInstanceOfMigrationsSerializerCreator = class
  private
    class var FMigrationSerializer: IMigrationSerializer;
  public
    class function getInstance: IMigrationSerializer;
  end;
```