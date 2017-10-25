{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecRangeExecutor;

interface

uses
  M4D.MigrationExecRangeExecutorInterface, Generics.Collections,
  M4D.MigrationsHistoryInterface, M4D.MigrationExecExecutorInterface;

type
  TMigrationExecRangeExecutor = class(TInterfacedObject, IMigrationExecRangeExecutor)
  private
    FMigrationExecExecutor: IMigrationExecExecutor;
  public
    constructor Create(AMigrationExecExecutor: IMigrationExecExecutor); reintroduce;
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer);
  end;

implementation

uses
  System.SysUtils, M4D.MigrationsInterface;

{ TMigrationExecRangeExecutor }

constructor TMigrationExecRangeExecutor.Create(AMigrationExecExecutor: IMigrationExecExecutor);
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

procedure TMigrationExecRangeExecutor.ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory; AStartMigrationSequence, AEndMigrationSequence: Integer);
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
    if not Assigned(AMigrationHistory) then
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
          FMigrationExecExecutor.Execute(LList, AMigrationHistory);
          if Assigned(LList) then FreeAndNil(LList);
        end;
      end;
    end;
  end;
end;

end.
