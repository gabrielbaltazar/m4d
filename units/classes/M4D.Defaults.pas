unit M4D.Defaults;

interface

uses
  UMigrationSerializerInterface, UMigrationsHistoryInterface,
  UMigrationMethodExecutorInterface, USetupExecutorInterface,
  UMigrationUpMethodExecutorInterface, UMigrationDownMethodExecutorInterface,
  UMigrationListOrderInterface, UMigrationExecutorInterface,
  UGetterMigrationsInterface, UMigrationsRegisterInterface,
  UPropertyClassReaderInterface;

type
  TDefaults = class
  private
    class var FMigrationSerializer: IMigrationSerializer;
    class var FMigrationGetter: IGetterMigrations;
    class var FMigrationsHistory: IMigrationsHistory;
    class var FExecutor: IMigrationExecutor;
    class var FMigrationListOrder: IMigrationListOrder;
    class var FMigrationsRegister: IMigrationsRegister;
    class var FMigrationMethodExecutor: IMigrationMethodExecutor;
    class var FMethodUpExecutor: IMigrationUpMethodExecutor;
    class var FMethodDownExecutor: IMigrationDownMethodExecutor;
    class var FMethodSetupExecutor: IMigrationSetupMethodExecutor;
    class var FReader: IPropertyClassReader;
  public
    class function instanceOfMigrationsSerializer: IMigrationSerializer;
    class function instanceOfMigrationsHistory(AMigrationSerializer: IMigrationSerializer): IMigrationsHistory;
    class function instanceOfMigrationGetter: IGetterMigrations;
    class function instanceOfMigrationMethodExecutor: IMigrationMethodExecutor;
    class function instanceOfMigrationSetupMethodExecutor(AMethodExecutor: IMigrationMethodExecutor): IMigrationSetupMethodExecutor;
    class function instanceOfMigrationUpMethodExecutor(AMethodExecutor: IMigrationMethodExecutor): IMigrationUpMethodExecutor;
    class function instanceOfMigrationDownMethodExecutor(AMethodExecutor: IMigrationMethodExecutor): IMigrationDownMethodExecutor;
    class function instanceOfMigrationListOrder(AMethodExecutor: IMigrationMethodExecutor): IMigrationListOrder;
    class function instanceOfMigrationsRegister(AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;
    class function instanceOfMigrationExecutor(AMigrationsHistory: IMigrationsHistory;
                                               AMethodUpExecutor: IMigrationUpMethodExecutor;
                                               AMethodDownExecutor: IMigrationDownMethodExecutor;
                                               AMethodSetupExecutor: IMigrationSetupMethodExecutor): IMigrationExecutor;
    class function instanceOfPropertyClassReader: IPropertyClassReader;
  end;

implementation

uses
  UDefs, UMigrationSerializer, UMigrationsHistory, System.SysUtils,
  UMigrationMethodExecutor, USetupExecutor, UMigrationUpMethodExecutor,
  UMigrationDownMethodExecutor, UMigrationListOrder, UMigrationExecutor,
  UGetterMigrations, UMigrationsRegister, UPropertyClassReader;

{ Defaults }

class function TDefaults.instanceOfMigrationsSerializer: IMigrationSerializer;
begin
  if Assigned(FMigrationSerializer) then
  begin
    Result := FMigrationSerializer;
  end
  else
  begin
    FMigrationSerializer := TMigrationSerializer.Create;
    Result := FMigrationSerializer;
  end;
end;

class function TDefaults.instanceOfMigrationsHistory(AMigrationSerializer: IMigrationSerializer): IMigrationsHistory;
var
  LPath: String;
begin
  if Assigned(FMigrationsHistory) then
  begin
    Result := FMigrationsHistory;
  end
  else
  begin
    LPath := ExtractFilePath(ParamStr(0)) + CFILE_NAME;
    Result := TMigrationsHistory.Create(LPath, AMigrationSerializer);
  end;
end;

class function TDefaults.instanceOfMigrationGetter: IGetterMigrations;
begin
  if Assigned(FMigrationGetter) then
  begin
    Result := FMigrationGetter;
  end
  else
  begin
    Result := TGetterMigrations.Create;
  end;
end;

class function TDefaults.instanceOfMigrationMethodExecutor: IMigrationMethodExecutor;
begin
  if Assigned(FMigrationMethodExecutor) then
  begin
    Result := FMigrationMethodExecutor;
  end
  else
  begin
    Result := TMigrationMethodExecutor.Create;
  end;
end;

class function TDefaults.instanceOfMigrationSetupMethodExecutor(AMethodExecutor: IMigrationMethodExecutor): IMigrationSetupMethodExecutor;
begin
 if Assigned(FMethodSetupExecutor) then
  begin
    Result := FMethodSetupExecutor;
  end
  else
  begin
    Result := TMigrationSetupMethodExecutor.Create(AMethodExecutor);
  end;
end;

class function TDefaults.instanceOfMigrationUpMethodExecutor(AMethodExecutor: IMigrationMethodExecutor): IMigrationUpMethodExecutor;
begin
 if Assigned(FMethodUpExecutor) then
  begin
    Result := FMethodUpExecutor;
  end
  else
  begin
    Result := TMigrationUpMethodExecutor.Create(AMethodExecutor);
  end;
end;

class function TDefaults.instanceOfMigrationDownMethodExecutor(AMethodExecutor: IMigrationMethodExecutor): IMigrationDownMethodExecutor;
begin
 if Assigned(FMethodDownExecutor) then
  begin
    Result := FMethodDownExecutor;
  end
  else
  begin
    Result := TMigrationDownMethodExecutor.Create(AMethodExecutor);
  end;
end;

class function TDefaults.instanceOfMigrationListOrder(AMethodExecutor: IMigrationMethodExecutor): IMigrationListOrder;
begin
 if Assigned(FMigrationListOrder) then
  begin
    Result := FMigrationListOrder;
  end
  else
  begin
    Result := TMigrationListOrder.Create(AMethodExecutor);
  end;
end;

class function TDefaults.instanceOfMigrationsRegister(AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;
begin
 if Assigned(FMigrationsRegister) then
  begin
    Result := FMigrationsRegister;
  end
  else
  begin
    Result := TMigrationsRegister.Create(AMigrationListOrder);
  end;
end;

class function TDefaults.instanceOfMigrationExecutor(AMigrationsHistory: IMigrationsHistory;
                                                     AMethodUpExecutor: IMigrationUpMethodExecutor;
                                                     AMethodDownExecutor: IMigrationDownMethodExecutor;
                                                     AMethodSetupExecutor: IMigrationSetupMethodExecutor): IMigrationExecutor;
begin
 if Assigned(FExecutor) then
  begin
    Result := FExecutor;
  end
  else
  begin
    Result := TMigrationExecutor.Create(AMigrationsHistory, AMethodUpExecutor, AMethodDownExecutor, AMethodSetupExecutor);
  end;
end;

class function TDefaults.instanceOfPropertyClassReader: IPropertyClassReader;
begin
 if Assigned(FReader) then
  begin
    Result := FReader;
  end
  else
  begin
    Result := TPropertyClassReader.Create;
  end;
end;

end.
