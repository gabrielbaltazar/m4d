{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}

unit M4D.MigrationsFacade;

interface

uses

  {$IF DECLARED(FireMonkeyVersion)}
    FMX.Dialogs,
//  {$ELSE}
//    Vcl.Dialogs,
  {$ENDIF}

  M4D.MigrationsInterface, M4D.RegisterMigrationInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationExecutorFacadeInterface, M4D.GetterMigrations, M4D.MigrationExecutorFacade,
  M4D.MigrationsHistoryFacadeInterface, M4D.MigrationsHistoryFacade, M4D.MigrationSerializerFacade, Generics.Collections,
  System.SysUtils, System.Rtti, M4D.MigrationListOrderInterface,
  M4D.MigrationListOrder, System.Generics.Defaults, M4D.MigrationSerializerFacadeInterface,
  M4D.MigrationsHistoryItem, M4D.MigrationsRegisterInterface;

type
  {$M+}
  {$REGION 'TMigrationsFacade'}
    /// <Description>
    ///  Standard implementation of the migration´s Facade.
    /// </Description>
    /// <Responsability>
    ///  Provide centralized migration features.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsFacade = class
  private
    FGetterMigration: IGetterMigrations;
    FMigrationsRegister: IMigrationsRegister;
    FMigrationsHistoryFacade: IMigrationsHistoryFacade;
    FMigrationExecutorFacade: IMigrationExecutorFacade;

    procedure RegisterMigration(AMigrationList: TList<TClass>; AMigration: TClass); overload;

    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade); overload;
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade); overload;
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade); overload;
    procedure ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer); overload;

    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade); overload;
    procedure RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade); overload;
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade); overload;
    procedure RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence: Integer; AEndMigrationSequence: Integer); overload;

//    function getMigrationHistory: IMigrationsHistory;
  public
    constructor Create(AMigrationsHistoryFacade: IMigrationsHistoryFacade; AGetterMigration: IGetterMigrations; AMigrationsRegister: IMigrationsRegister; AMigrationExecutorFacade: IMigrationExecutorFacade); reintroduce; overload;
    constructor Create; overload;

    {$REGION 'TMigrationsManager.RegisterMigration'}
      /// <Description>
      ///  Migration´s register method.
      /// </Description>
      /// <InputParameters>
      ///  AMigration - The migration that will be registered.
      /// </InputParameters>
      /// <Note>
      ///  This method is just a bridge for the private method RegisterMigration (interfaced).
      /// </Note>
    {$ENDREGION}
    procedure RegisterMigration(AMigration: TClass); overload;

    procedure Execute; overload;
    procedure ExecutePending; overload;
    procedure ExecuteUntil(AMigrationSequence: Integer); overload;
    procedure ExecuteRange(AStartMigrationSequence: Integer; AEndMigrationSequence: Integer); overload;

    procedure Rollback; overload;
    procedure RollbackPending; overload;
    procedure RollbackUntil(AMigrationSequence: Integer); overload;
    procedure RollbackRange(AStartMigrationSequence: Integer; AEndMigrationSequence: Integer); overload;

    function MigrationInfo(AClass: TClass): IMigration;
  published
//    property MigrationHistory: IMigrationsHistory read getMigrationHistory;
    property MigrationsRegister: IMigrationsRegister read FMigrationsRegister;
    property GetterMigration: IGetterMigrations read FGetterMigration;
    property MigrationsHistoryFacade: IMigrationsHistoryFacade read FMigrationsHistoryFacade;
    property MigrationExecutorFacade: IMigrationExecutorFacade read FMigrationExecutorFacade;
  end;

implementation

uses
  M4D.MigrationsRegister, M4D.Defaults;

{ TMigrationsFacade }

constructor TMigrationsFacade.Create(AMigrationsHistoryFacade: IMigrationsHistoryFacade; AGetterMigration: IGetterMigrations; AMigrationsRegister: IMigrationsRegister; AMigrationExecutorFacade: IMigrationExecutorFacade);
begin
  if not Assigned(AMigrationsHistoryFacade) then
  begin
    raise Exception.Create('The parameter AMigrationsHistory must not be nil!');
  end
  else
  begin
    if not Assigned(AGetterMigration) then
    begin
      raise Exception.Create('The parameter AGetterMigration must not be nil!');
    end
    else
    begin
      if not Assigned(AMigrationsRegister) then
      begin
        raise Exception.Create('The parameter AMigrationsRegister must not be nil!');
      end
      else
      begin
        if not Assigned(AMigrationExecutorFacade) then
        begin
          raise Exception.Create('The parameter AMigrationExecutor must not be nil!');
        end
        else
        begin
          inherited Create;

          FMigrationsHistoryFacade := AMigrationsHistoryFacade;
          FGetterMigration := AGetterMigration;
          FMigrationsRegister := AMigrationsRegister;
          FMigrationExecutorFacade := AMigrationExecutorFacade;
        end;
      end;
    end;
  end;
end;

constructor TMigrationsFacade.Create;
var
  LMigrationSerializerFacade: IMigrationSerializerFacade;
  LMigrationGetter: IGetterMigrations;
  LMigrationsHistoryFacade: IMigrationsHistoryFacade;
  LExecutorFacade: IMigrationExecutorFacade;
  LMigrationListOrder: IMigrationListOrder;
  LMigrationsRegister: IMigrationsRegister;
begin
  LMigrationSerializerFacade := M4D.Defaults.TDefaultInstanceOfMigrationsSerializerFacadeCreator.getInstance;
  LMigrationsHistoryFacade := M4D.Defaults.TDefaultInstanceOfMigrationsHistoryCreator.getInstance(LMigrationSerializerFacade);
  LMigrationGetter := M4D.Defaults.TDefaultInstanceOfMigrationGetterCreator.getInstance;
  LMigrationListOrder := M4D.Defaults.TDefaultInstanceOfMigrationListOrderCreator.getInstance;
  LMigrationsRegister := M4D.Defaults.TDefaultInstanceOfMigrationsRegisterCreator.getInstance(LMigrationListOrder);
  LExecutorFacade := M4D.Defaults.TDefaultInstanceOfMigrationExecutorCreator.getInstance(LMigrationsHistoryFacade);

  Self.Create(LMigrationsHistoryFacade, LMigrationGetter, LMigrationsRegister, LExecutorFacade);
end;

procedure TMigrationsFacade.Execute;
begin
  Self.Execute(FMigrationsRegister.Migrations, FMigrationsHistoryFacade);
end;

procedure TMigrationsFacade.ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecutorFacade.ExecutePending(AMigrationsList, ALastMigration, AMigrationHistoryFacade);
end;

procedure TMigrationsFacade.ExecutePending;
var
  Item: TMigrationsHistoryItem;
begin
  Item := FMigrationsHistoryFacade.LastMigration;
  Self.ExecutePending(FMigrationsRegister.Migrations, Item, FMigrationsHistoryFacade);
end;

procedure TMigrationsFacade.ExecuteRange(AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  Self.ExecuteRange(FMigrationsRegister.Migrations, FMigrationsHistoryFacade, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationsFacade.ExecuteRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  FMigrationExecutorFacade.ExecuteRange(AMigrationsList, AMigrationHistoryFacade, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationsFacade.ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecutorFacade.ExecuteUntil(AMigrationsList, AMigrationSequence, AMigrationHistoryFacade);
end;

procedure TMigrationsFacade.ExecuteUntil(AMigrationSequence: Integer);
begin
  Self.ExecuteUntil(FMigrationsRegister.Migrations, AMigrationSequence, FMigrationsHistoryFacade);
end;

procedure TMigrationsFacade.Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecutorFacade.Execute(AMigrationsList, AMigrationHistoryFacade);
end;

//function TMigrationsManager.getMigrationHistory: IMigrationsHistory;
//begin
//  Result := nil;
//
//  if Assigned(FMigrationExecutor) then
//  begin
//    Result := FMigrationExecutor.MigrationHistory;
//  end;
//end;

function TMigrationsFacade.MigrationInfo(AClass: TClass): IMigration;
var
  Aux: TObject;
  Teste:IMigration;
begin
  Result := nil;

  if not Assigned(AClass) then
  begin
    raise Exception.Create('The parameter AClass must not be nil.');
  end
  else
  begin
    Aux := AClass.Create;

    //First, call for setup to load informations
    Teste := (Aux as TInterfacedObject as IMigration);
    Teste.Setup;

    Result := Aux as TInterfacedObject as IMigration;
  end;
end;

procedure TMigrationsFacade.RegisterMigration(AMigration: TClass);
begin
  Self.RegisterMigration(FMigrationsRegister.Migrations, AMigration);
end;

procedure TMigrationsFacade.Rollback(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecutorFacade.Rollback(AMigrationsList, AMigrationHistoryFacade);
end;

procedure TMigrationsFacade.Rollback;
begin
  Self.Rollback(FMigrationsRegister.Migrations, FMigrationsHistoryFacade);
end;

procedure TMigrationsFacade.RollbackPending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecutorFacade.RollbackPending(AMigrationsList, ALastMigration, AMigrationHistoryFacade);
end;

procedure TMigrationsFacade.RollbackPending;
var
  Item: TMigrationsHistoryItem;
begin
  Item := FMigrationsHistoryFacade.LastMigration;
  Self.RollbackPending(FMigrationsRegister.Migrations, Item, FMigrationsHistoryFacade);
end;

procedure TMigrationsFacade.RollbackRange(AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  Self.RollbackRange(FMigrationsRegister.Migrations, FMigrationsHistoryFacade, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationsFacade.RollbackRange(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AStartMigrationSequence, AEndMigrationSequence: Integer);
begin
  FMigrationExecutorFacade.RollbackRange(AMigrationsList, AMigrationHistoryFacade, AStartMigrationSequence, AEndMigrationSequence);
end;

procedure TMigrationsFacade.RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistoryFacade: IMigrationsHistoryFacade);
begin
  FMigrationExecutorFacade.RollbackUntil(AMigrationsList, AMigrationSequence, AMigrationHistoryFacade);
end;

procedure TMigrationsFacade.RollbackUntil(AMigrationSequence: Integer);
begin
  Self.RollbackUntil(MigrationsRegister.Migrations, AMigrationSequence, FMigrationsHistoryFacade);
end;

procedure TMigrationsFacade.RegisterMigration(AMigrationList: TList<TClass>; AMigration: TClass);
begin
  if Assigned(AMigrationList) then
  begin
    AMigrationList.Add(AMigration);
  end;
end;

end.
