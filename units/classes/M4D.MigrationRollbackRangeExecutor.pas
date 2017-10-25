unit M4D.MigrationRollbackRangeExecutor;

interface

uses
  M4D.MigrationRollbackRangeExecutorInterface,
  M4D.MigrationRollbackExecutorInterface,
  Generics.Collections, M4D.MigrationsHistoryInterface;

type
  {$REGION 'TMigrationRollbackRangeExecutor'}
    /// <Description>
    ///  Standard class to execute the rollback of migrations of a specif range of sequences.
    /// </Description>
    /// <Responsability>
    ///  Handle a migration´s list and call for rollback execution.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
    /// <KeyWords>Migration, Rollback, Range</KeyWords>
  {$ENDREGION}
  TMigrationRollbackRangeExecutor = class(TInterfacedObject, IMigrationRollbackRangeExecutor)
  private
    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
  public
    constructor Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor); reintroduce;
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;

implementation

uses
  System.SysUtils, M4D.MigrationsInterface;

{ TMigrationRollbackRangeExecutor }

constructor TMigrationRollbackRangeExecutor.Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor);
begin
  if not Assigned(AMigrationRollbackExecutor) then
  begin
    raise Exception.Create('The parameter AMigrationRollbackExecutor must not be nil.');
  end
  else
  begin
    inherited Create;

    FMigrationRollbackExecutor := AMigrationRollbackExecutor;
  end;
end;

procedure TMigrationRollbackRangeExecutor.RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence, AEndMigrationSequence: Integer);
var
  LList: TList<TClass>;
  I: Integer;
  SequenceProp: Integer;
  LClass: TClass;
  Aux: TObject;
begin
  if not Assigned(AMigrationsList) then
  begin
    raise Exception.Create('The parameter AMigrationsList must not be nil.');
  end
  else
  begin
    if not Assigned(AMigrationHistory) then
    begin
      raise Exception.Create('The parameter AMigrationHistory must not be nil.');
    end
    else
    begin
      LList := nil;

      for I := AMigrationsList.Count - 1 downto 0 do
      begin
        LClass := AMigrationsList[I];

        Aux := LClass.Create;
        (Aux as TInterfacedObject as IMigration).Setup;

        SequenceProp := (Aux as TInterfacedObject as IMigration).SeqVersion;

        if (SequenceProp >= AStartMigrationSequence) and (SequenceProp <= AEndMigrationSequence) then
        begin
          if not Assigned(LList) then LList := TList<TClass>.Create;
          LList.Add(LClass);
        end;
      end;

      if Assigned(LList) then
      begin
        if LList.Count > 0 then
        begin
          FMigrationRollbackExecutor.Rollback(LList, AMigrationHistory);
          if Assigned(LList) then FreeAndNil(LList);
        end;
      end;
    end;
  end;
end;

end.
