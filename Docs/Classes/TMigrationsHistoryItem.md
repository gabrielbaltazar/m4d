
## Class **TMigrationsHistoryItem**

**Unit name:** M4D.MigrationsHistoryItem

**Description:** Standard class for storing information about the execution of migration.

**Responsability:** Stores information about the execution of migration.

## Interface ##

None.

## Class ##

```sh
  TMigrationsHistoryItem = class
  private
    FMigrationVersion: string;
    FMigrationSeq: Integer;
    FMigrationDateTime: TDateTime;
    FStartOfExecution: TDateTime;
    FEndOfExecution: TDateTime;
    FDurationOfExecution: Extended;
  published
    property MigrationVersion: string read FMigrationVersion write FMigrationVersion;
    property MigrationSeq: Integer read FMigrationSeq write FMigrationSeq;
    property MigrationDateTime: TDatetime read FMigrationDateTime write FMigrationDateTime;
    property StartOfExecution: TDateTime read FStartOfExecution write FStartOfExecution;
    property EndOfExecution: TDateTime read FEndOfExecution write FEndOfExecution;
    property DurationOfExecution: Extended read FDurationOfExecution write FDurationOfExecution;
  end;
```