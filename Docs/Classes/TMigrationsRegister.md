
## Class **TMigrationsRegister**

**Unit name:** M4D.MigrationsRegister

**Description:** Standard implementation of the migration´s register.

**Responsability:** Register a migration.

## Interface ##
The TMigrationsRegister implements the **IMigrationsRegister** interface:
```sh
  IMigrationsRegister = interface
  ['{277A98B9-E8B7-4F58-8D30-26BBE1E4E39A}']
    procedure RegisterMigration(AMigration: TClass);
    function getMigrationsRegister: TList<TClass>;
    property Migrations: TList<TClass> read getMigrationsRegister;
  end;
```

## Class ##

```sh
  TMigrationsRegister = class(TInterfacedObject, IMigrationsRegister)
  private
    FMigrationsList: TList<TClass>;
    FCompare: IComparer<TClass>;
  public
    constructor Create(AComparison: IMigrationListOrder);
    destructor Destroy; override;
    procedure RegisterMigration(AMigration: TClass);
    function getMigrationsRegister: TList<TClass>;
  published
    property Migrations: TList<TClass> read getMigrationsRegister;
  end;
```