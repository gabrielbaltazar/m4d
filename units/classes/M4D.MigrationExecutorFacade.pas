{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 31/08/2017
Use licence: See the license file

######################################################################################}

unit M4D.MigrationExecutorFacade;

interface

uses
  M4D.MigrationsInterface, M4D.MigrationExecutorFacadeInterface,
  M4D.MigrationsHistoryFacadeInterface, M4D.MigrationsHistoryFacade,
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
  {$REGION 'TMigrationExecutorFacade'}
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
  TMigrationExecutorFacade = class(TInterfacedObject, IMigrationExecutorFacade)
  private
    FMigrationHistoryFacade: IMigrationsHistoryFacade;

    FMigrationExecExecutor: IMigrationExecExecutor;
    FMigrationExecPendingExecutor: IMigrationExecPendingExecutor;
    FMigrationExecUntilExecutor: IMigrationExecUntilExecutor;
    FMigrationExecRangeExecutor: IMigrationExecRangeExecutor;

    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
    FMigrationRollbackPendingExecutor: IMigrationRollbackPendingExecutor;
    FMigrationRollbackUntilExecutor: IMigrationRollbackUntilExecutor;
    FMigrationRollbackRangeExecutor: IMigrationRollbackRangeExecutor;

    function getMigrationsHistoryFacade: IMigrationsHistoryFacade;
  public
    constructor Create(AMigrationHistoryFacade: IMigrationsHistoryFacade); reintroduce;
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    procedure RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  published
    property MigrationHistoryFacade: IMigrationsHistoryFacade read getMigrationsHistoryFacade;
  end;

implementation

uses
  System.SysUtils, M4D.MigrationExecExecutor, M4D.MigrationRollbackExecutor,
  M4D.MigrationExecPendingExecutor, M4D.MigrationExecUntilExecutor,
  M4D.MigrationRollbackUntilExecutor, M4D.MigrationRollbackPendingExecutor,
  M4D.MigrationRollbackRangeExecutor, M4D.MigrationExecRangeExecutor;

{ TMigrationExecutorFacade }

constructor TMigrationExecutorFacade.Create(AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  if not Assigned(AMigrationHistoryFacade) then
  begin
    raise Exception.Create('The parameter AMigrationHistory must not be nil.');
  end
  else
  begin
    inherited Create;

    FMigrationHistoryFacade := AMigrationHistoryFacade;
    FMigrationHistoryFacade.Load;

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

procedure TMigrationExecutorFacade.Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecExecutor.Execute(AMigrationsList, AMigrationHistoryFacade);
end;

procedure TMigrationExecutorFacade.ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecUntilExecutor.ExecuteUntil(AMigrationsList, AMigrationSequence, AMigrationHistoryFacade);
end;

function TMigrationExecutorFacade.getMigrationsHistoryFacade: IMigrationsHistoryFacade;
begin
  Result := Self.FMigrationHistoryFacade;
end;

procedure TMigrationExecutorFacade.ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecPendingExecutor.ExecutePending(AMigrationsList, ALastMigration, AMigrationHistoryFacade);
end;

procedure TMigrationExecutorFacade.ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  FMigrationExecRangeExecutor.ExecuteRange(AMigrationsList, AMigrationHistoryFacade, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationExecutorFacade.Rollback(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationRollbackExecutor.Rollback(AMigrationsList, AMigrationHistoryFacade);
end;

procedure TMigrationExecutorFacade.RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationRollbackPendingExecutor.RollbackPending(AMigrationsList, ALastMigration, AMigrationHistoryFacade);
end;

procedure TMigrationExecutorFacade.RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  FMigrationRollbackRangeExecutor.RollbackRange(AMigrationsList, AMigrationHistoryFacade, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationExecutorFacade.RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationRollbackUntilExecutor.RollbackUntil(AMigrationsList, AMigrationSequence, AMigrationHistoryFacade);
end;

end.
