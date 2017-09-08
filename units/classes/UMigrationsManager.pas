{######################################################################################

                                      M4D Framework

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: Free

######################################################################################}

unit UMigrationsManager;

interface

uses

  {$IF DECLARED(FireMonkeyVersion)}
    FMX.Dialogs,
  {$ELSE}
    Vcl.Dialogs,
  {$ENDIF}

  UMigrationsInterface, URegisterMigrationInterface, UGetterMigrationsInterface,
  UMigrationExecutorInterface, UGetterMigrations, URegisterMigration, UMigrationExecutor,
  UMigrationsHistoryInterface, UMigrationsHistory, UMigrationSerializer, Generics.Collections, 
  System.SysUtils, System.Rtti, UMigrationListOrderInterface,
  UMigrationListOrder, System.Generics.Defaults, UMigrationSerializerInterface,
  UMigrationUpMethodExecutorInterface, UMigrationDownMethodExecutorInterface,
  UMigrationMethodExecutorInterface, USetupExecutorInterface,
  UMigrationsHistoryItem, UPropertyClassReader, UPropertyClassReaderInterface,
  UDefs, UMigrationsRegisterInterface;

type
  {$M+}
  {$REGION 'TMigrationsManager'}
    /// <Description>
    ///  Standard implementation of the migration´s register.
    /// </Description>
    /// <Note>
    ///  A migration register is responsible for registering the migration within
    ///  the migration management class. Thus, the migration becomes known by the
    ///  migration management class and can be used when needed.
    ///
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
    FMethodUpExecutor: IMigrationUpMethodExecutor;
    FMethodDownExecutor: IMigrationDownMethodExecutor;
    FMethodSetupExecutor: IMigrationSetupMethodExecutor;
    FReader: IPropertyClassReader;

    procedure RegisterMigration(AMigrationList: TList<TClass>; AMigration: TClass); overload;

    function getMigrations(AMigrationsList: TList<TClass>;
                           AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                           AReader: IPropertyClassReader;
                           APropName: string;
                           APredicate: TPredicate<TValue>): TList<IMigration>; overload;

    function getMigrations(AMigrationsList: TList<TClass>;
                           AStartSeqMigration: Integer;
                           AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                           AReader: IPropertyClassReader): TList<IMigration>; overload;

    function getMigrations(AMigrationsList: TList<TClass>;
                           AStartMigrationDateTime: TDateTime;
                           AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                           AReader: IPropertyClassReader): TList<IMigration>; overload;

    procedure Execute(AMigrationsList: TList<TClass>;
                      AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                      AReader: IPropertyClassReader;
                      AMethodUpExecutor: IMigrationUpMethodExecutor;
                      AMigrationHistory: IMigrationsHistory); overload;
    procedure ExecutePending(AMigrationsList: TList<TClass>;
                             ALastMigration: TMigrationsHistoryItem;
                             AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                             AReader: IPropertyClassReader;
                             AMethodUpExecutor: IMigrationUpMethodExecutor;
                             AMigrationHistory: IMigrationsHistory); overload;
    procedure ExecuteUntil(AMigrationsList: TList<TClass>;
                           AMigrationSequence: Integer;
                           AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                           AReader: IPropertyClassReader;
                           AMethodUpExecutor: IMigrationUpMethodExecutor;
                           AMigrationHistory: IMigrationsHistory); overload;

    procedure Rollback(AMigrationsList: TList<TClass>;
                       AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                       AReader: IPropertyClassReader;
                       AMethodDownExecutor: IMigrationDownMethodExecutor;
                       AMigrationHistory: IMigrationsHistory); overload;
    procedure RollbackUntil(AMigrationsList: TList<TClass>;
                            AMigrationSequence: Integer;
                            AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                            AReader: IPropertyClassReader;
                            AMethodDownExecutor: IMigrationDownMethodExecutor;
                            AMigrationHistory: IMigrationsHistory); overload;

    function getMigrationHistory: IMigrationsHistory;
  public
    constructor Create(AMigrationsHistory: IMigrationsHistory;
                       AGetterMigration: IGetterMigrations;
                       AMigrationsRegister: IMigrationsRegister;
                       AMigrationExecutor: IMigrationExecutor;
                       AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                       AReader: IPropertyClassReader;
                       AMethodUpExecutor: IMigrationUpMethodExecutor;
                       AMethodDownExecutor: IMigrationDownMethodExecutor); reintroduce; overload;

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

    {$REGION 'IGetMigrations.getMigrations - Sequence'}
      /// <Description>
      ///  Gets a list of all migrations whose sequence is greater than or equal to the
      ///  inputted sequence value.
      /// </Description>
      /// <InputParameters>
      ///  AStartSeqMigration - The initial date time value of the migration that will be
      ///  considered to return. The method will return all migrations after that based on
      ///  the sequence value.
      ///  Return - A list of migrations that has the sequence´s version value greater than
      /// the initial value inputted.
      /// </InputParameters>
      /// <Note>
      ///  This method is just a bridge for the private method RegisterMigration (interfaced).
      /// </Note>
    {$ENDREGION}
    function getMigrations(AStartMigrationSeq: Integer): TList<IMigration>; overload;

    {$REGION 'IGetMigrations.getMigrations - DateTime'}
      /// <Description>
      ///  Gets a list of all migrations whose date time is greater than or equal to the
      ///  inputted date time value.
      /// </Description>
      /// <InputParameters>
      ///  AStartSeqMigration - The initial date time value of the migration that will be
      ///  considered to return. The method will return all migrations after that based on
      ///  the date time value.
      ///  Return - A list of migrations that has the date time´s version value greater than
      /// the initial value inputted.
      /// </InputParameters>
      /// <Note>
      ///  This method is just a bridge for the private method RegisterMigration (interfaced).
      /// </Note>
    {$ENDREGION}
    function getMigrations(AStartMigrationDateTime: TDateTime): TList<IMigration>; overload;

    procedure Execute; overload;
    procedure ExecutePending; overload;
    procedure ExecuteUntil(AMigrationSequence: Integer); overload;

    procedure Rollback; overload;
    procedure RollbackUntil(AMigrationSequence: Integer); overload;

    function MigrationInfo(AClass: TClass; AMethodSetupExecutor: IMigrationSetupMethodExecutor): IMigration;
  published
    property MigrationHistory: IMigrationsHistory read getMigrationHistory;
    property MigrationsRegister: IMigrationsRegister read FMigrationsRegister;
    property GetterMigration: IGetterMigrations read FGetterMigration;
    property MigrationsHistory: IMigrationsHistory read FMigrationsHistory;
    property MigrationExecutor: IMigrationExecutor read FMigrationExecutor;
    property MethodUpExecutor: IMigrationUpMethodExecutor read FMethodUpExecutor;
    property MethodDownExecutor: IMigrationDownMethodExecutor read FMethodDownExecutor;
    property MethodSetupExecutor: IMigrationSetupMethodExecutor read FMethodSetupExecutor;
    property Reader: IPropertyClassReader read FReader;
  end;

implementation

uses
  UMigrationUpMethodExecutor, UMigrationMethodExecutor,
  UMigrationDownMethodExecutor, USetupExecutor, UMigrationsRegister, M4D.Defaults;

{ TMigrationsManager }

constructor TMigrationsManager.Create(AMigrationsHistory: IMigrationsHistory;
                                      AGetterMigration: IGetterMigrations;
                                      AMigrationsRegister: IMigrationsRegister;
                                      AMigrationExecutor: IMigrationExecutor;
                                      AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                      AReader: IPropertyClassReader;
                                      AMethodUpExecutor: IMigrationUpMethodExecutor;
                                      AMethodDownExecutor: IMigrationDownMethodExecutor);
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
          if not Assigned(AMethodSetupExecutor) then
          begin
            raise Exception.Create('The parameter AMethodSetupExecutor must not be nil!');
          end
          else
          begin
            if not Assigned(AReader) then
            begin
              raise Exception.Create('The parameter AReader must not be nil!');
            end
            else
            begin
              if not Assigned(AMethodUpExecutor) then
              begin
                raise Exception.Create('The parameter AMethodUpExecutor must not be nil!');
              end
              else
              begin
                if not Assigned(AMethodDownExecutor) then
                begin
                  raise Exception.Create('The parameter AMethodDownExecutor must not be nil!');
                end
                else
                begin
                  inherited Create;

                  FMigrationsHistory := AMigrationsHistory;
                  FGetterMigration := AGetterMigration;
                  FMigrationsRegister := AMigrationsRegister;
                  FMigrationExecutor := AMigrationExecutor;
                  FMethodSetupExecutor := AMethodSetupExecutor;
                  FReader := AReader;
                  FMethodUpExecutor := AMethodUpExecutor;
                  FMethodDownExecutor := AMethodDownExecutor;
                end;
              end;
            end;
          end;
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
  LMethodExecutor: IMigrationMethodExecutor;
  LMethodUpExecutor: IMigrationUpMethodExecutor;
  LMethodDownExecutor: IMigrationDownMethodExecutor;
  LMethodSetupExecutor: IMigrationSetupMethodExecutor;
  LReader: IPropertyClassReader;
begin
  LMigrationSerializer := M4D.Defaults.TDefaults.instanceOfMigrationsSerializer;
  LMigrationsHistory := TDefaults.instanceOfMigrationsHistory(LMigrationSerializer);
  LMigrationGetter := TDefaults.instanceOfMigrationGetter;
  LMethodExecutor := TDefaults.instanceOfMigrationMethodExecutor;
  LMethodSetupExecutor := TDefaults.instanceOfMigrationSetupMethodExecutor(LMethodExecutor);
  LMethodUpExecutor := TDefaults.instanceOfMigrationUpMethodExecutor(LMethodExecutor);
  LMethodDownExecutor := TDefaults.instanceOfMigrationDownMethodExecutor(LMethodExecutor);
  LMigrationListOrder := TDefaults.instanceOfMigrationListOrder(LMethodExecutor);
  LMigrationsRegister := TDefaults.instanceOfMigrationsRegister(LMigrationListOrder);
  LExecutor := TDefaults.instanceOfMigrationExecutor(LMigrationsHistory, LMethodUpExecutor, LMethodDownExecutor, LMethodSetupExecutor);
  LReader := TDefaults.instanceOfPropertyClassReader;

  Self.Create(LMigrationsHistory,
              LMigrationGetter,
              LMigrationsRegister,
              LExecutor,
              LMethodSetupExecutor,
              LReader,
              LMethodUpExecutor,
              LMethodDownExecutor);
end;

procedure TMigrationsManager.Execute;
begin
  Self.Execute(FMigrationsRegister.Migrations,
               FMethodSetupExecutor,
               FReader,
               FMethodUpExecutor,
               FMigrationsHistory);
end;

procedure TMigrationsManager.ExecutePending(AMigrationsList: TList<TClass>;
                                            ALastMigration: TMigrationsHistoryItem;
                                            AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                            AReader: IPropertyClassReader;
                                            AMethodUpExecutor: IMigrationUpMethodExecutor;
                                            AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.ExecutePending(AMigrationsList,
                                    ALastMigration,
                                    AMethodSetupExecutor,
                                    AReader,
                                    AMethodUpExecutor,
                                    AMigrationHistory);
end;

procedure TMigrationsManager.ExecutePending;
var
  Item: TMigrationsHistoryItem;
begin
  Item := FMigrationsHistory.LastMigration;
  Self.ExecutePending(FMigrationsRegister.Migrations,
//                      FMigrationsHistory.LastMigration,
                      Item,
                      FMethodSetupExecutor,
                      FReader,
                      FMethodUpExecutor,
                      FMigrationsHistory);
  Item.DisposeOf;
end;

procedure TMigrationsManager.ExecuteUntil(AMigrationsList: TList<TClass>;
                                          AMigrationSequence: Integer;
                                          AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                          AReader: IPropertyClassReader;
                                          AMethodUpExecutor: IMigrationUpMethodExecutor;
                                          AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.ExecuteUntil(AMigrationsList,
                                  AMigrationSequence,
                                  AMethodSetupExecutor,
                                  AReader,
                                  AMethodUpExecutor,
                                  AMigrationHistory);
end;

procedure TMigrationsManager.ExecuteUntil(AMigrationSequence: Integer);
begin
  Self.ExecuteUntil(FMigrationsRegister.Migrations,
                    AMigrationSequence,
                    FMethodSetupExecutor,
                    FReader,
                    FMethodUpExecutor,
                    FMigrationsHistory);
end;

procedure TMigrationsManager.Execute(AMigrationsList: TList<TClass>;
                                     AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                     AReader: IPropertyClassReader;
                                     AMethodUpExecutor: IMigrationUpMethodExecutor;
                                     AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.Execute(AMigrationsList,
                             AMethodSetupExecutor,
                             AReader,
                             AMethodUpExecutor,
                             AMigrationHistory);
end;

function TMigrationsManager.getMigrationHistory: IMigrationsHistory;
begin
  Result := nil;

  if Assigned(FMigrationExecutor) then
  begin
    Result := FMigrationExecutor.MigrationHistory;
  end;
end;

function TMigrationsManager.getMigrations(AStartMigrationDateTime: TDateTime): TList<IMigration>;
begin
  Result := Self.getMigrations(FMigrationsRegister.Migrations,
                               AStartMigrationDateTime,
                               FMethodSetupExecutor,
                               FReader);
end;

function TMigrationsManager.MigrationInfo(AClass: TClass; AMethodSetupExecutor: IMigrationSetupMethodExecutor): IMigration;
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
//    AMethodSetupExecutor.Execute(AClass, Aux);
    Teste := (Aux as TInterfacedObject as IMigration);
    Teste.Setup;

    Result := Aux as TInterfacedObject as IMigration;
  end;
end;

procedure TMigrationsManager.RegisterMigration(AMigration: TClass);
begin
  Self.RegisterMigration(FMigrationsRegister.Migrations, AMigration);
end;

procedure TMigrationsManager.Rollback(AMigrationsList: TList<TClass>;
                                      AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                      AReader: IPropertyClassReader;
                                      AMethodDownExecutor: IMigrationDownMethodExecutor;
                                      AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.Rollback(AMigrationsList,
                              AMethodSetupExecutor,
                              AReader,
                              AMethodDownExecutor,
                              AMigrationHistory);
end;

procedure TMigrationsManager.Rollback;
begin
  Self.Rollback(FMigrationsRegister.Migrations,
                FMethodSetupExecutor,
                FReader,
                FMethodDownExecutor,
                FMigrationsHistory);
end;

procedure TMigrationsManager.RollbackUntil(AMigrationsList: TList<TClass>;
                                           AMigrationSequence: Integer;
                                           AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                           AReader: IPropertyClassReader;
                                           AMethodDownExecutor: IMigrationDownMethodExecutor;
                                           AMigrationHistory: IMigrationsHistory);
begin
  FMigrationExecutor.RollbackUntil(AMigrationsList,
                                   AMigrationSequence,
                                   AMethodSetupExecutor,
                                   AReader,
                                   AMethodDownExecutor,
                                   AMigrationHistory);
end;

procedure TMigrationsManager.RollbackUntil(AMigrationSequence: Integer);
begin
  Self.RollbackUntil(MigrationsRegister.Migrations,
                     AMigrationSequence,
                     FMethodSetupExecutor,
                     FReader,
                     FMethodDownExecutor,
                     FMigrationsHistory);
end;

function TMigrationsManager.getMigrations(AStartMigrationSeq: Integer): TList<IMigration>;
begin
  Result := Self.getMigrations(FMigrationsRegister.Migrations,
                               AStartMigrationSeq,
                               FMethodSetupExecutor,
                               FReader);
end;

function TMigrationsManager.getMigrations(AMigrationsList: TList<TClass>;
                                          AStartMigrationDateTime: TDateTime;
                                          AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                          AReader: IPropertyClassReader): TList<IMigration>;
begin
  Result := getMigrations(AMigrationsList, AMethodSetupExecutor, AReader, PROP_DATETIME,
                          function (Value: TValue): boolean
                          begin
                            Result := Value.AsType<TDateTime> >= AStartMigrationDateTime;
                          end
                         );

  if not Assigned(Result) then Result.Sort;
end;

function TMigrationsManager.getMigrations(AMigrationsList: TList<TClass>;
                                          AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                          AReader: IPropertyClassReader;
                                          APropName: string;
                                          APredicate: TPredicate<TValue>): TList<IMigration>;
var
  LClass: TClass;
  Aux: TObject;
  LValue: TValue;
begin
  Result := nil;

  if Assigned(FMigrationsRegister) then
  begin
    for LClass in FMigrationsRegister.Migrations do
    begin
      Aux := LClass.Create;
      try
//        AMethodSetupExecutor.Execute(LClass, Aux);
        (Aux as TInterfacedObject as IMigration).Setup;

        LValue := AReader.PropertyOfMigrationClass(LClass, Aux, APropName).AsInteger;

        if APredicate(LValue) then
        begin
          if not Assigned(Result) then Result := TList<IMigration>.Create;

          Result.Add(Aux as TInterfacedObject as IMigration);
        end;
      finally
        FreeAndNil(Aux);
      end
    end;
  end;

  if not Assigned(Result) then Result.Sort;
end;


function TMigrationsManager.getMigrations(AMigrationsList: TList<TClass>;
                                          AStartSeqMigration: Integer;
                                          AMethodSetupExecutor: IMigrationSetupMethodExecutor;
                                          AReader: IPropertyClassReader): TList<IMigration>;
begin
  Result := getMigrations(AMigrationsList, AMethodSetupExecutor, AReader, PROP_SEQUENCE,
                          function (Value: TValue): boolean
                          begin
                            Result := Value.AsInteger >= AStartSeqMigration;
                          end
                         );

  if not Assigned(Result) then Result.Sort;
end;

procedure TMigrationsManager.RegisterMigration(AMigrationList: TList<TClass>; AMigration: TClass);
begin
  if Assigned(AMigrationList) then
  begin
    AMigrationList.Add(AMigration);
  end;
end;

end.
