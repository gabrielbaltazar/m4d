{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}

unit M4D.MigrationsManager;

interface

uses

  {$IF DECLARED(FireMonkeyVersion)}
    FMX.Dialogs,
  {$ELSE}
    Vcl.Dialogs,
  {$ENDIF}

  M4D.MigrationsInterface, M4D.RegisterMigrationInterface, M4D.GetterMigrationsInterface,
  M4D.MigrationExecutorInterface, M4D.GetterMigrations, M4D.MigrationExecutor,
  M4D.MigrationsHistoryInterface, M4D.MigrationsHistory, M4D.MigrationSerializer, Generics.Collections,
  System.SysUtils, System.Rtti, M4D.MigrationListOrderInterface,
  M4D.MigrationListOrder, System.Generics.Defaults, M4D.MigrationSerializerInterface,
  M4D.MigrationsHistoryItem, M4D.Defs, M4D.MigrationsRegisterInterface;

type
  {$M+}
  {$REGION 'TMigrationsManager'}
    /// <Description>
    ///  Standard implementation of the migration´s manager.
    /// </Description>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsManager = class
  private
    FGetterMigration: IGetterMigrations;
    FMigrationsRegister: IMigrationsRegister;
    FMigrationsHistory: IMigrationsHistory;
    FMigrationExecutor: IMigrationExecutor;

    procedure RegisterMigration(AMigrationList: TList<TClass>; AMigration: TClass); overload;

    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory); overload;
    procedure ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory); overload;
    procedure ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory); overload;

    procedure Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory); overload;
    procedure RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory); overload;

    function getMigrationHistory: IMigrationsHistory;
  public
    constructor Create(AMigrationsHistory: IMigrationsHistory; AGetterMigration: IGetterMigrations; AMigrationsRegister: IMigrationsRegister; AMigrationExecutor: IMigrationExecutor); reintroduce; overload;
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

    procedure Rollback; overload;
    procedure RollbackUntil(AMigrationSequence: Integer); overload;

    function MigrationInfo(AClass: TClass): IMigration;
  published
    property MigrationHistory: IMigrationsHistory read getMigrationHistory;
    property MigrationsRegister: IMigrationsRegister read FMigrationsRegister;
    property GetterMigration: IGetterMigrations read FGetterMigration;
    property MigrationsHistory: IMigrationsHistory read FMigrationsHistory;
    property MigrationExecutor: IMigrationExecutor read FMigrationExecutor;
  end;

implementation

uses
  M4D.MigrationsRegister, M4D.Defaults;

{ TMigrationsManager }

constructor TMigrationsManager.Create(AMigrationsHistory: IMigrationsHistory; AGetterMigration: IGetterMigrations; AMigrationsRegister: IMigrationsRegister; AMigrationExecutor: IMigrationExecutor);
begin
  if not Assigned(AMigrationsHistory) then
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
        if not Assigned(AMigrationExecutor) then
        begin
          raise Exception.Create('The parameter AMigrationExecutor must not be nil!');
        end
        else
        begin
          inherited Create;

          FMigrationsHistory := AMigrationsHistory;
          FGetterMigration := AGetterMigration;
          FMigrationsRegister := AMigrationsRegister;
          FMigrationExecutor := AMigrationExecutor;
        end;
      end;
    end;
  end;
end;

constructor TMigrationsManager.Create;
var
  LMigrationSerializer: IMigrationSerializer;
  LMigrationGetter: IGetterMigrations;
  LMigrationsHistory: IMigrationsHistory;
  LExecutor: IMigrationExecutor;
  LMigrationListOrder: IMigrationListOrder;
  LMigrationsRegister: IMigrationsRegister;
begin
  LMigrationSerializer := M4D.Defaults.TDefaultInstanceOfMigrationsSerializerCreator.getInstance;
  LMigrationsHistory := M4D.Defaults.TDefaultInstanceOfMigrationsHistoryCreator.getInstance(LMigrationSerializer);
  LMigrationGetter := M4D.Defaults.TDefaultInstanceOfMigrationGetterCreator.getInstance;
  LMigrationListOrder := M4D.Defaults.TDefaultInstanceOfMigrationListOrderCreator.getInstance;
  LMigrationsRegister := M4D.Defaults.TDefaultInstanceOfMigrationsRegisterCreator.getInstance(LMigrationListOrder);
  LExecutor := M4D.Defaults.TDefaultInstanceOfMigrationExecutorCreator.getInstance(LMigrationsHistory);

  Self.Create(LMigrationsHistory, LMigrationGetter, LMigrationsRegister, LExecutor);
end;

procedure TMigrationsManager.Execute;
begin
  Self.Execute(FMigrationsRegister.Migrations, FMigrationsHistory);
end;

procedure TMigrationsManager.ExecutePending(AMigrationsList: TList<TClass>; ALastMigration: TMigrationsHistoryItem; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.ExecutePending(AMigrationsList, ALastMigration, AMigrationHistory);
end;

procedure TMigrationsManager.ExecutePending;
var
  Item: TMigrationsHistoryItem;
begin
  Item := FMigrationsHistory.LastMigration;
  Self.ExecutePending(FMigrationsRegister.Migrations, Item, FMigrationsHistory);
end;

procedure TMigrationsManager.ExecuteUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.ExecuteUntil(AMigrationsList, AMigrationSequence, AMigrationHistory);
end;

procedure TMigrationsManager.ExecuteUntil(AMigrationSequence: Integer);
begin
  Self.ExecuteUntil(FMigrationsRegister.Migrations, AMigrationSequence, FMigrationsHistory);
end;

procedure TMigrationsManager.Execute(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.Execute(AMigrationsList, AMigrationHistory);
end;

function TMigrationsManager.getMigrationHistory: IMigrationsHistory;
begin
  Result := nil;

  if Assigned(FMigrationExecutor) then
  begin
    Result := FMigrationExecutor.MigrationHistory;
  end;
end;

function TMigrationsManager.MigrationInfo(AClass: TClass): IMigration;
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

procedure TMigrationsManager.RegisterMigration(AMigration: TClass);
begin
  Self.RegisterMigration(FMigrationsRegister.Migrations, AMigration);
end;

procedure TMigrationsManager.Rollback(AMigrationsList: TList<TClass>; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.Rollback(AMigrationsList, AMigrationHistory);
end;

procedure TMigrationsManager.Rollback;
begin
  Self.Rollback(FMigrationsRegister.Migrations, FMigrationsHistory);
end;

procedure TMigrationsManager.RollbackUntil(AMigrationsList: TList<TClass>; AMigrationSequence: Integer; AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.RollbackUntil(AMigrationsList, AMigrationSequence, AMigrationHistory);
end;

procedure TMigrationsManager.RollbackUntil(AMigrationSequence: Integer);
begin
  Self.RollbackUntil(MigrationsRegister.Migrations, AMigrationSequence, FMigrationsHistory);
end;

procedure TMigrationsManager.RegisterMigration(AMigrationList: TList<TClass>; AMigration: TClass);
begin
  if Assigned(AMigrationList) then
  begin
    AMigrationList.Add(AMigration);
  end;
end;

end.
