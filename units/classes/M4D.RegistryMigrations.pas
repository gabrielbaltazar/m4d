unit M4D.RegistryMigrations;

interface

uses
  System.Generics.Collections,
  System.Generics.Defaults,
  System.SysUtils,
  M4D,
  M4D.Defaults,
  M4D.Migrations,
  M4D.MigrationsInterface,
  M4D.MigrationsHistoryItem,
  M4D.MigrationsHistoryFacadeInterface,
  M4D.GetterMigrationsInterface,
  M4D.MigrationMethodExecutorInterface,
  M4D.MigrationListOrderInterface,
  M4D.MigrationsRegisterInterface,
  M4D.MigrationExecutorFacadeInterface;

type
  IMigration = M4D.MigrationsInterface.IMigration;

  TMigrationsHistoryItem = M4D.MigrationsHistoryItem.TMigrationsHistoryItem;

  TMigrations = M4D.Migrations.TMigrations;

  TM4DRegistryMigrations = class
  private
    class var FInstance: TM4DRegistryMigrations;
  private
    FMigrations: TList<TClass>;
    FHistory: IMigrationsHistoryFacade;
    FGetterMigration: IGetterMigrations;
    FMigrationListOrder: IMigrationListOrder;
    FMigrationsRegister: IMigrationsRegister;
    FMigrationExecutor: IMigrationExecutorFacade;

    constructor CreatePrivate;
    procedure RegistryMigrations;
    function Build: TM4DRegistryMigrations;
  public
    constructor Create;
    class function GetInstance: TM4DRegistryMigrations;
    destructor Destroy; override;
    class destructor Unitialize;

    function Add(AClass: TClass): TM4DRegistryMigrations;
    function History(AValue: IMigrationsHistoryFacade): TM4DRegistryMigrations;
    function Release: TM4DRegistryMigrations;

    function Clear: TM4DRegistryMigrations;
    function GetHistory: TList<TMigrationsHistoryItem>;
    function LastMigration: TMigrationsHistoryItem;
    function ListMigrations: TList<IMigration>;

    function Execute: TM4DRegistryMigrations;
    function ExecutePending: TM4DRegistryMigrations;
    function ExecuteRange(AStartMigrationSequence, AEndMigrationSequence: Integer): TM4DRegistryMigrations;
    function ExecuteUntil(AMigrationSequence: Integer): TM4DRegistryMigrations;

    function Rollback: TM4DRegistryMigrations;
    function RollbackPending: TM4DRegistryMigrations;
    function RollbackRange(AStartMigrationSequence, AEndMigrationSequence: Integer): TM4DRegistryMigrations;
    function RollbackUtil(AMigrationSequence: Integer): TM4DRegistryMigrations;
  end;

implementation

{ TM4DRegistryMigrations }

function TM4DRegistryMigrations.Add(AClass: TClass): TM4DRegistryMigrations;
begin
  Result := Self;
  FMigrations.Add(AClass);
end;

function TM4DRegistryMigrations.Build: TM4DRegistryMigrations;
begin
  Result := Self;
  if not Assigned(FHistory) then
    raise Exception.Create('History must not be nil. Set History please...');

  if not Assigned(FGetterMigration) then
    FGetterMigration := TDefaultInstanceOfMigrationGetterCreator.GetInstance;

  if not Assigned(FMigrationListOrder) then
    FMigrationListOrder := TDefaultInstanceOfMigrationListOrderCreator.GetInstance;

  if not Assigned(FMigrationsRegister) then
    FMigrationsRegister := TDefaultInstanceOfMigrationsRegisterCreator.GetInstance(FMigrationListOrder);

  if not Assigned(FMigrationExecutor) then
    FMigrationExecutor := TDefaultInstanceOfMigrationExecutorCreator.GetInstance(FHistory);

  RegistryMigrations;
end;

function TM4DRegistryMigrations.Clear: TM4DRegistryMigrations;
var
  LMigrationHistory: IMigrationsHistoryFacade;
begin
  Result := Self;
  Build;
  LMigrationHistory := M4D.MigrationFacade.MigrationsHistoryFacade;
  LMigrationHistory.Clear;
end;

constructor TM4DRegistryMigrations.Create;
begin
  raise Exception.Create('Use the GetInstance...');
end;

constructor TM4DRegistryMigrations.CreatePrivate;
begin
  FMigrations := TList<TClass>.Create;
end;

destructor TM4DRegistryMigrations.Destroy;
begin
  FMigrations.Free;
  inherited;
end;

function TM4DRegistryMigrations.Execute: TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.Execute;
end;

function TM4DRegistryMigrations.ExecutePending: TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.ExecutePending;
end;

function TM4DRegistryMigrations.ExecuteRange(AStartMigrationSequence,
  AEndMigrationSequence: Integer): TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.ExecuteRange(AStartMigrationSequence,
    AEndMigrationSequence);
end;

function TM4DRegistryMigrations.ExecuteUntil(AMigrationSequence: Integer): TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.ExecuteUntil(AMigrationSequence);
end;

function TM4DRegistryMigrations.GetHistory: TList<TMigrationsHistoryItem>;
begin
  Result := M4D.MigrationFacade.MigrationsHistoryFacade.GetHistory;
end;

class function TM4DRegistryMigrations.GetInstance: TM4DRegistryMigrations;
begin
  if not Assigned(FInstance) then
    FInstance := TM4DRegistryMigrations.CreatePrivate;
  Result := FInstance;
end;

function TM4DRegistryMigrations.History(AValue: IMigrationsHistoryFacade): TM4DRegistryMigrations;
begin
  Result := Self;
  FHistory := AValue;
end;

function TM4DRegistryMigrations.LastMigration: TMigrationsHistoryItem;
begin
  Build;
  Result := M4D.MigrationFacade.MigrationsHistoryFacade
    .LastMigration;
end;

function TM4DRegistryMigrations.ListMigrations: TList<IMigration>;
var
  LClass: TClass;
  LMigrations: TList<TClass>;
  LMigration: IMigration;
begin
  LMigrations := M4D.MigrationFacade.MigrationsRegister.Migrations;
  Result := TList<IMigration>.Create;
  try
    for LClass in LMigrations do
    begin
      LMigration := M4D.MigrationFacade.MigrationInfo(LClass);
      Result.Add(LMigration);
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TM4DRegistryMigrations.RegistryMigrations;
var
  LMigration: TClass;
begin
  if FMigrations.Count > 0 then
  begin
    for LMigration in FMigrations do
      RegisterMigration(LMigration, FHistory, FGetterMigration, FMigrationsRegister, FMigrationExecutor);
    FMigrations.Clear;
  end;
end;

function TM4DRegistryMigrations.Release: TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.Release;
end;

function TM4DRegistryMigrations.Rollback: TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.Rollback;
end;

function TM4DRegistryMigrations.RollbackPending: TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.RollbackPending;
end;

function TM4DRegistryMigrations.RollbackRange(AStartMigrationSequence,
  AEndMigrationSequence: Integer): TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.RollbackRange(AStartMigrationSequence,
    AEndMigrationSequence);
end;

function TM4DRegistryMigrations.RollbackUtil(
  AMigrationSequence: Integer): TM4DRegistryMigrations;
begin
  Result := Self;
  Build;
  M4D.MigrationFacade.RollbackUntil(AMigrationSequence);
end;

class destructor TM4DRegistryMigrations.Unitialize;
begin
  if Assigned(FInstance) then
    FreeAndNil(FInstance);
end;

end.
