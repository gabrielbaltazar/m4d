
## Class **TMigrationExecExecutor**

**Unit name:** M4D.MigrationExecExecutor

**Description:** Standard class to execute migrations.

**Responsability:** Execute the up method of a migration.

## Interface ##
The TMigrationExecExecutor implements the **IMigrationExecExecutor** interface:
```sh
  IMigrationExecExecutor = interface
  ['{31CE6179-89FD-4233-9FC0-97DA0FAA9CDE}']
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
  end;
```

## Class ##

```sh
  TMigrationExecExecutor = class(TInterfacedObject, IMigrationExecExecutor)
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
  end;
```