{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecUntilExecutor;

interface

uses
  Generics.Collections, M4D.MigrationExecUntilExecutorInterface,
  M4D.MigrationExecExecutorInterface, M4D.MigrationsHistoryFacadeInterface;

type
  {$REGION 'TMigrationExecUntilExecutor'}
    /// <Description>
    ///  Standar class to execute the migrations until a specif sequence.
    /// </Description>
    /// <Responsability>
    ///  Call for migration´s execution until a specific sequence.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
    /// <KeyWords>Migration</KeyWords>
  {$ENDREGION}
  TMigrationExecUntilExecutor = class(TInterfacedObject, IMigrationExecUntilExecutor)
  private
    FMigrationExecExecutor: IMigrationExecExecutor;
  public
    constructor Create(AMigrationExecExecutor: IMigrationExecExecutor); reintroduce;
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
  end;

implementation

uses
  System.SysUtils, M4D.MigrationsInterface;

{ TMigrationExecUntilExecutor }

constructor TMigrationExecUntilExecutor.Create(AMigrationExecExecutor: IMigrationExecExecutor);
begin
  if not Assigned(AMigrationExecExecutor) then
  begin
    raise Exception.Create('The parameter AMigrationExecExecutor must not be nil');
  end
  else
  begin
    inherited Create;

    FMigrationExecExecutor := AMigrationExecExecutor;
  end;
end;

procedure TMigrationExecUntilExecutor.ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
var
  LList: TList<TClass>;
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
    if not Assigned(AMigrationHistoryFacade) then
    begin
      raise Exception.Create('The parameter AMigrationHistory must not be nil.');
    end
    else
    begin
      LList := nil;

      for LClass in AMigrationsList do
      begin
        Aux := LClass.Create;

        (Aux as TInterfacedObject as IMigration).Setup;

        SequenceProp := (Aux as TInterfacedObject as IMigration).SeqVersion;

        if SequenceProp <= AMigrationSequence then
        begin
          if not Assigned(LList) then LList := TList<TClass>.Create;
          LList.Add(LClass);
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
