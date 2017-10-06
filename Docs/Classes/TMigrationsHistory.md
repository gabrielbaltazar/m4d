[Back](CLASS_REFERENCES.md)
## Class **TMigrationsHistory** ## 

**Unit name:** M4D.MigrationsHistory
**Description:** Standard class for handling information about the history of migrations´s executions.
**Responsability:** Handle informations about the history of migrations´s executions.

## Interface ##
The TMigrationsHistory implements the **IMigrationsHistory** interface:
```sh
  IMigrationsHistory = interface
  ['{639BAD0D-0273-4EB2-B129-D9CB70B1B108}']
    procedure Clear;
    procedure Load;
    procedure UnLoad;
    procedure Add(AItem: TMigrationsHistoryItem);
    procedure Remove(AMigrationSequence: Integer);
    function getHistory: TList<TMigrationsHistoryItem>; overload;
    function getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    function getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;
    procedure Save;
    function LastMigration: TMigrationsHistoryItem;
    property HistoryList: TList<TMigrationsHistoryItem> read getHistory;
  end;
```

## Class ##

```sh
  TMigrationsHistory = class(TInterfacedObject, IMigrationsHistory)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FPath: string;
    FFile: TStringList;
    FSerializer: IMigrationSerializer;
    FLoaded: Boolean;
    FCompare: IComparer<TMigrationsHistoryItem>;

    FCleaner: IHistoryCleaner;
    FLoader: IMigrationsHistoryLoader;
    FUnLoader: IMigrationsHistoryUnLoader;
    FAdder: IMigrationsHistoryAdder;
    FRemover: IMigrationsHistoryRemover;
    FSaver: IMigrationsHistorySaver;
    FMigrationGetter: IMigrationHistoryGetter;
    FLastMigrationGetter: ILastMigrationsHistoryGetter;
    function getHistory: TList<TMigrationsHistoryItem>; overload;
  public
    constructor Create(APath: string; ASerializer: IMigrationSerializer); reintroduce;
    destructor Destroy; override;

    procedure Clear;
    procedure Load;
    procedure UnLoad;
    procedure Add(AItem: TMigrationsHistoryItem);
    procedure Remove(AMigrationSequence: Integer);
    function getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    function getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;
    function getHistory(AMigrationVersion: string): TList<TMigrationsHistoryItem>; overload;
    procedure Save;
    function LastMigration: TMigrationsHistoryItem;
  published
    property Path: string read FPath;
    property HistoryList: TList<TMigrationsHistoryItem> read getHistory;
  end;
```