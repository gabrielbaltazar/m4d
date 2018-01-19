{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 18/10/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationRollbackPendingExecutor;

interface

uses
  Generics.Collections, M4D.MigrationRollbackPendingExecutorInterface,
  M4D.MigrationsHistoryItem, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationRollbackExecutorInterface;

type
  {$REGION 'TMigrationRollbackPendingExecutor'}
    /// <Description>
    ///  Standard class to rollback pending´s migrations.
    /// </Description>
    /// <Responsability>
    ///  Handle the list to know what is pendind and call for rollback.
    /// </Responsability>
  {$ENDREGION}
  TMigrationRollbackPendingExecutor = class(TInterfacedObject, IMigrationRollbackPendingExecutor)
  private
    FMigrationRollbackExecutor: IMigrationRollbackExecutor;
  public
    constructor Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor); reintroduce;
    procedure RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
  end;

implementation

uses
  System.SysUtils, M4D.MigrationsInterface;

{ TMigrationExecPendingExecutor }

constructor TMigrationRollbackPendingExecutor.Create(AMigrationRollbackExecutor: IMigrationRollbackExecutor);
begin
  if not Assigned(AMigrationRollbackExecutor) then
  begin
    raise Exception.Create('The parameter AMigrationRollbackExecutor must not be nil');
  end
  else
  begin
    inherited Create;

    FMigrationRollbackExecutor:= AMigrationRollbackExecutor;
  end;
end;

procedure TMigrationRollbackPendingExecutor.RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
var
  I: Integer;
  LClass: TClass;
  Aux: TObject;
  SequenceProp: Integer;
  LList: TList<TClass>;
begin
  if not Assigned(AMigrationsList) then
  begin
    raise Exception.Create('The parameter AMigrationsList must not be nil.');
  end
  else
  begin
    if not Assigned(ALastMigration) then
    begin
      raise Exception.Create('The parameter ALastMigration must not be nil.');
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

        //Decide if the migration must be rolled back
        if not (Aux as TInterfacedObject as IMigration).DownWillExecute then
        begin
          Aux.Free;
        end
        else
        begin
          if SequenceProp <= ALastMigration.MigrationSeq then
          begin
            if not Assigned(LList) then LList := TList<TClass>.Create;
            LList.Add(LClass);
          end;
        end;
      end;

      if Assigned(LList) then
      begin
        if LList.Count > 0 then
        begin
          FMigrationRollbackExecutor.Rollback(LList, AMigrationHistoryFacade);
          if Assigned(LList) then FreeAndNil(LList);
        end;
      end;
    end;
  end;
end;

end.
