
## Class **TMigrationsManager** 

**Unit name:** M4D.MigrationsManager

**Description:** Standard implementation of the migration´s manager.

**Responsability:** Provide centralized migration features.

## Interface ##

None.

## Class ##

```sh
  TMigrationsManager = class
  private
    FGetterMigration: IGetterMigrations;
    FMigrationsRegister: IMigrationsRegister;
    FMigrationsHistory: IMigrationsHistory;
    FMigrationExecutor: IMigrationExecutor;

    procedure RegisterMigration(AMigrationList: TList<TClass>; AMigration: TClass); overload;

    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory); overload;
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory); overload;
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory); overload;

    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory); overload;
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory); overload;

    function getMigrationHistory: IMigrationsHistory;
  public
    constructor Create(AMigrationsHistory: IMigrationsHistory; AGetterMigration: IGetterMigrations; AMigrationsRegister: IMigrationsRegister; AMigrationExecutor: IMigrationExecutor); reintroduce; overload;
    constructor Create; overload;
    procedure RegisterMigration(AMigration: TClass); overload;

    procedure Execute; overload;
    procedure ExecutePending; overload;
    procedure ExecuteUntil(AMigrationSequence: Integer); overload;

    procedure Rollback; overload;
    procedure RollbackUntil(AMigrationSequence: Integer); overload;

    function MigrationInfo(AClass: TClass): IMigration;
  published
    property MigrationHistory: IMigrationsHistory read getMigrationHistory;
    property MigrationsRegister: IMigrationsRegister read FMigrationsRegister;
    property GetterMigration: IGetterMigrations read FGetterMigration;
    property MigrationsHistory: IMigrationsHistory read FMigrationsHistory;
    property MigrationExecutor: IMigrationExecutor read FMigrationExecutor;
  end;
```