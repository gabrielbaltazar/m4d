{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecPendingExecutor;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryFacadeInterface, M4D.MigrationExecPendingExecutorInterface,
  M4D.MigrationsHistoryItem, M4D.MigrationExecExecutorInterface;

type
  {$REGION 'TMigrationExecPendingExecutor'}
    /// <Description>
    ///  Standard class to execute pending´s migrations.
    /// </Description>
    /// <Responsability>
    ///  Handle the list to know what is pendind and call for execution.
    /// </Responsability>
  {$ENDREGION}
  TMigrationExecPendingExecutor = class(TInterfacedObject, IMigrationExecPendingExecutor)
  private
    FMigrationExecExecutor: IMigrationExecExecutor;
  public
    constructor Create(AMigrationExecExecutor: IMigrationExecExecutor); reintroduce;
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
  end;

implementation

uses
  M4D.MigrationsInterface, System.SysUtils;

{ TMigrationExecPendingExecutor }

constructor TMigrationExecPendingExecutor.Create(AMigrationExecExecutor: IMigrationExecExecutor);
begin
  if not Assigned(AMigrationExecExecutor) then
  begin
    raise Exception.Create('The parameter AMigrationExecExecutor must not be nil');
  end
  else
  begin
    inherited Create;

    FMigrationExecExecutor:= AMigrationExecExecutor;
  end;
end;

procedure TMigrationExecPendingExecutor.ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
var
  LList: TList<TClass>;
  MigrationDate: TDateTime;
  LClass: TClass;
  Aux: TObject;
begin
  if not Assigned(AMigrationsList) then
  begin
    raise Exception.Create('The parameter AMigrationsList must not be nil.');
  end
  else
  begin
    LList := nil;
    if not Assigned(ALastMigration) then
    begin
      FMigrationExecExecutor.Execute(AMigrationsList, AMigrationHistoryFacade);
    end
    else
    begin
      for LClass in AMigrationsList do
      begin
        Aux := LClass.Create;
        (Aux as TInterfacedObject as IMigration).Setup;

        MigrationDate := (Aux as TInterfacedObject as IMigration).DateTime;

        if MigrationDate > ALastMigration.MigrationDateTime then
        begin
          //Decide if the migration must be executed
          if not (Aux as TInterfacedObject as IMigration).UpWillExecute then
          begin
            Aux.Free;
          end
          else
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
          FMigrationExecExecutor.Execute(LList, AMigrationHistoryFacade);
          if Assigned(LList) then FreeAndNil(LList);
        end;
      end;
    end;
  end;
end;

end.

