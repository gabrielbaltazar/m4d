[Back](CLASS_REFERENCES.md)
## Class **TMigrationRollbackExecutor** ## 

**Unit name:** M4D.MigrationRollbackExecutor
**Description:** Standar class to execute the rollback of migrations.
**Responsability:** Execute the migration´s down method.

## Interface ##
The TMigrationRollbackExecutor implements the **IMigrationRollbackExecutor** interface:
```sh
  IMigrationRollbackExecutor = interface
  ['{1EB71323-095D-4288-B2A4-8D24C067A1F5}']
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
  end;
```

## Class ##

```sh
  TMigrationRollbackExecutor = class(TInterfacedObject, IMigrationRollbackExecutor)
  public
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
  end;
```