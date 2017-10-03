{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 31/08/2017
Use licence: See the license file

######################################################################################}

unit M4D.MigrationExecutor;

interface

uses
  M4D.MigrationsInterface, M4D.MigrationExecutorInterface, M4D.MigrationsHistoryInterface, M4D.MigrationsHistory,
  M4D.MigrationsHistoryItem, Generics.Collections, System.Rtti,
  M4D.MigrationExecExecutorInterface, M4D.MigrationRollbackExecutorInterface,
  M4D.MigrationExecPendingExecutorInterface,
  M4D.MigrationExecUntilExecutorInterface,
  M4D.MigrationRollbackUntilExecutorInterface;

type
  {$M+}
  {$REGION 'TMigrationExecutor'}
    /// <Description>
    ///  Standard class to execute migrations.
    /// </Description>
    /// <Responsability>
    ///  Performs executions and rollbacks of the migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationExecutor = class(TInterfacedObject, IMigrationExecutor)
  private
    FMigrationHistory: IMigrationsHistory;

    FMigrationExecExecutor: IMigrationExecExecutor;
    FMigrationExecPendingExecutor: IMigrationExecPendingExecutor;
    FMigrationExecUntilExecutor: IMigrationExecUntilExecutor;

    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
    FMigrationRollbackUntilExecutor: IMigrationRollbackUntilExecutor;

    function getMigrationsHistory: IMigrationsHistory;
  public
    constructor Create(AMigrationHistory: IMigrationsHistory); reintroduce;
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
  published
    property MigrationHistory: IMigrationsHistory read getMigrationsHistory;
  end;

implementation

uses
  System.SysUtils, M4D.MigrationExecExecutor, M4D.MigrationRollbackExecutor,
  M4D.MigrationExecPendingExecutor, M4D.MigrationExecUntilExecutor,
  M4D.MigrationRollbackUntilExecutor;

{ TMigrationExecutor }

constructor TMigrationExecutor.Create(AMigrationHistory: IMigrationsHistory{; AMethodUpExecutor: IMigrationUpMethodExecutor; AMethodDownExecutor: IMigrationDownMethodExecutor; AMethodSetupExecutor: IMigrationSetupMethodExecutor});
begin
  if not Assigned(AMigrationHistory) then
  begin
    raise Exception.Create('The parameter AMigrationHistory must not be nil.');
  end
  else
  begin
    inherited Create;

    FMigrationHistory := AMigrationHistory;
    FMigrationHistory.Load;

    FMigrationExecExecutor := TMigrationExecExecutor.Create;
    FMigrationExecPendingExecutor := TMigrationExecPendingExecutor.Create(FMigrationExecExecutor);
    FMigrationExecUntilExecutor := TMigrationExecUntilExecutor.Create(FMigrationExecExecutor);

    FMigrationRollbackExecutor := TMigrationRollbackExecutor.Create;
    FMigrationRollbackUntilExecutor := TMigrationRollbackUntilExecutor.Create(FMigrationRollbackExecutor);
  end;
end;

procedure TMigrationExecutor.Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecExecutor.Execute(AMigrationsList, AMigrationHistory);
end;

procedure TMigrationExecutor.ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecUntilExecutor.ExecuteUntil(AMigrationsList, AMigrationSequence, AMigrationHistory);
end;

function TMigrationExecutor.getMigrationsHistory: IMigrationsHistory;
begin
  Result := Self.FMigrationHistory;
end;

procedure TMigrationExecutor.ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecPendingExecutor.ExecutePending(AMigrationsList, ALastMigration, AMigrationHistory);
end;

procedure TMigrationExecutor.Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationRollbackExecutor.Rollback(AMigrationsList, AMigrationHistory);
end;

procedure TMigrationExecutor.RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationRollbackUntilExecutor.RollbackUntil(AMigrationsList, AMigrationSequence, AMigrationHistory);
end;

end.
