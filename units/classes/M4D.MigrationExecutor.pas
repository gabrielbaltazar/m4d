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
  M4D.MigrationRollbackUntilExecutorInterface,
  M4D.MigrationRollbackPendingExecutorInterface,
  M4D.MigrationExecRangeExecutorInterface,
  M4D.MigrationRollbackRangeExecutorInterface;

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
    FMigrationExecRangeExecutor: IMigrationExecRangeExecutor;

    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
    FMigrationRollbackPendingExecutor: IMigrationRollbackPendingExecutor;
    FMigrationRollbackUntilExecutor: IMigrationRollbackUntilExecutor;
    FMigrationRollbackRangeExecutor: IMigrationRollbackRangeExecutor;

    function getMigrationsHistory: IMigrationsHistory;
  public
    constructor Create(AMigrationHistory: IMigrationsHistory); reintroduce;
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
    procedure RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  published
    property MigrationHistory: IMigrationsHistory read getMigrationsHistory;
  end;

implementation

uses
  System.SysUtils, M4D.MigrationExecExecutor, M4D.MigrationRollbackExecutor,
  M4D.MigrationExecPendingExecutor, M4D.MigrationExecUntilExecutor,
  M4D.MigrationRollbackUntilExecutor, M4D.MigrationRollbackPendingExecutor,
  M4D.MigrationRollbackRangeExecutor, M4D.MigrationExecRangeExecutor;

{ TMigrationExecutor }

constructor TMigrationExecutor.Create(AMigrationHistory: IMigrationsHistory);
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
    FMigrationExecRangeExecutor := TMigrationExecRangeExecutor.Create(FMigrationExecExecutor);

    FMigrationRollbackExecutor := TMigrationRollbackExecutor.Create;
    FMigrationRollbackPendingExecutor := TMigrationRollbackPendingExecutor.Create(FMigrationRollbackExecutor);
    FMigrationRollbackUntilExecutor := TMigrationRollbackUntilExecutor.Create(FMigrationRollbackExecutor);
    FMigrationRollbackRangeExecutor := TMigrationRollbackRangeExecutor.Create(FMigrationRollbackExecutor);
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

procedure TMigrationExecutor.ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  FMigrationExecRangeExecutor.ExecuteRange(AMigrationsList, AMigrationHistory, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationExecutor.Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationRollbackExecutor.Rollback(AMigrationsList, AMigrationHistory);
end;

procedure TMigrationExecutor.RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationRollbackPendingExecutor.RollbackPending(AMigrationsList, ALastMigration, AMigrationHistory);
end;

procedure TMigrationExecutor.RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  FMigrationRollbackRangeExecutor.RollbackRange(AMigrationsList, AMigrationHistory, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationExecutor.RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationRollbackUntilExecutor.RollbackUntil(AMigrationsList, AMigrationSequence, AMigrationHistory);
end;

end.
