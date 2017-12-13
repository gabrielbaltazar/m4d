{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.Defaults;

interface

uses
  M4D.MigrationSerializerFacadeInterface, M4D.MigrationsHistoryFacadeInterface,
  M4D.MigrationListOrderInterface, M4D.MigrationExecutorFacadeInterface,
  M4D.GetterMigrationsInterface, M4D.MigrationsRegisterInterface;

type
  {$REGION 'TDefaultInstanceOfMigrationsSerializerFacadeCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationSerializerFacade.
    /// </Description>
    /// <Responsability>
    ///  Get the default instance of migration´s serializer facade object.
    /// </Responsability>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationsSerializerFacadeCreator = class
  private
    class var FMigrationSerializerFacade: IMigrationSerializerFacade;
  public
    {$REGION 'TDefaultInstanceOfMigrationsSerializerFacadeCreator.instanceOfMigrationsSerializer'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationSerializerFacade interface.
    ///  For more information, see the IMigrationSerializerFacade documentation.
    /// </Description>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationSerializerFacade.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance: IMigrationSerializerFacade;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationsHistoryCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationsHistory.
    /// </Description>
    /// <Responsability>
    ///  Get the default instance of migration´s history object.
    /// </Responsability>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationsHistoryCreator = class
  private
    const CFILE_NAME = 'history.m4d';
    class var FMigrationsHistoryFacade: IMigrationsHistoryFacade;
  public
    {$REGION 'TDefaultInstanceOfMigrationsHistoryCreator.instanceOfMigrationsHistory'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationsHistory interface.
    ///  For more information, see the IMigrationsHistory documentation.
    /// </Description>
    /// <InputParameters>
    ///  AMigrationSerializer - A instance of a IMigrationSerializer. This is a
    ///  necessary parameter for the creation of IMigrationsHistory.
    /// </InputParameters>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationsHistory.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance(AMigrationSerializerFacade: IMigrationSerializerFacade): IMigrationsHistoryFacade;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationGetterCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IGetterMigrations.
    /// </Description>
    /// <Responsability>
    ///  Get the default instance of migration´s getter object.
    /// </Responsability>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationGetterCreator = class
  private
    class var FMigrationGetter: IGetterMigrations;
  public
    {$REGION 'TDefaultInstanceOfMigrationGetterCreator.instanceOfMigrationGetter'}
    /// <Description>
    ///  Factory from the default instance of the IGetterMigrations interface.
    ///  For more information, see the IGetterMigrations documentation.
    /// </Description>
    /// <OutputParameters>
    ///  Result - Default instance of IGetterMigrations.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance: IGetterMigrations;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationListOrderCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationListOrder.
    /// </Description>
    /// <Responsability>
    ///  Get the default instance of migration´s list order object.
    /// </Responsability>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationListOrderCreator = class
  private
    class var FMigrationListOrder: IMigrationListOrder;
  public
    {$REGION 'TDefaultInstanceOfMigrationListOrderCreator.instanceOfMigrationListOrder'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationListOrder interface.
    ///  For more information, see the IMigrationListOrder documentation.
    /// </Description>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationListOrder.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance: IMigrationListOrder;
  end;

type
  {$REGION 'TDefaultInstanceOfMigrationsRegisterCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationsRegister.
    /// </Description>
    /// <Responsability>
    ///  Get the default instance of migration´s register object.
    /// </Responsability>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
  TDefaultInstanceOfMigrationsRegisterCreator = class
  private
    class var FMigrationsRegister: IMigrationsRegister;
  public
    {$REGION 'TDefaultInstanceOfMigrationsRegisterCreator.instanceOfMigrationsRegister'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationsRegister interface.
    ///  For more information, see the IMigrationsRegister documentation.
    /// </Description>
    /// <InputParameters>
    ///  AMigrationListOrder - A instance of a IMigrationListOrder. This is a
    ///  necessary parameter for the creation of IMigrationsRegister.
    /// </InputParameters>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationsRegister.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance(AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;
  end;

  {$REGION 'TDefaultInstanceOfMigrationExecutorCreator'}
    /// <Description>
    ///  This is a class used to provide a default instance of IMigrationExecutor.
    /// </Description>
    /// <Responsability>
    ///  Get the default instance of migration´s executor object.
    /// </Responsability>
    /// <KeyWords>Default</KeyWords>
  {$ENDREGION}
type
  TDefaultInstanceOfMigrationExecutorCreator = class
  private
    class var FExecutorFacade: IMigrationExecutorFacade;
  public
    {$REGION 'TDefaultInstanceOfMigrationExecutorCreator.instanceOfMigrationExecutor'}
    /// <Description>
    ///  Factory from the default instance of the IMigrationExecutor interface.
    ///  For more information, see the IMigrationExecutor documentation.
    /// </Description>
    /// <InputParameters>
    ///  AMigrationsHistory - A instance of a IMigrationsHistory. This is a
    ///  necessary parameter for the creation of IMigrationExecutor.
    /// </InputParameters>
    /// <OutputParameters>
    ///  Result - Default instance of IMigrationExecutor.
    /// </OutputParameters>
    {$ENDREGION}
    class function getInstance(AMigrationsHistoryFacade: IMigrationsHistoryFacade): IMigrationExecutorFacade;
  end;

implementation

uses
  M4D.MigrationSerializerFacade, M4D.MigrationsHistoryFacade, System.SysUtils,
  M4D.MigrationListOrder, M4D.MigrationExecutorFacade, M4D.GetterMigrations,
  M4D.MigrationsRegister;

{ TDefaultInstanceOfMigrationsSerializer }

class function TDefaultInstanceOfMigrationsSerializerFacadeCreator.getInstance: IMigrationSerializerFacade;
begin
  if Assigned(FMigrationSerializerFacade) then
  begin
    Result := FMigrationSerializerFacade;
  end
  else
  begin
    FMigrationSerializerFacade := TMigrationSerializerFacade.Create;
    Result := FMigrationSerializerFacade;
  end;
end;

{ TDefaultInstanceOfMigrationsHistoryCreator }

class function TDefaultInstanceOfMigrationsHistoryCreator.getInstance(AMigrationSerializerFacade: IMigrationSerializerFacade): IMigrationsHistoryFacade;
var
  LPath: String;
begin
  if Assigned(FMigrationsHistoryFacade) then
  begin
    Result := FMigrationsHistoryFacade;
  end
  else
  begin
    LPath := ExtractFilePath(ParamStr(0)) + CFILE_NAME;
    Result := TMigrationsHistoryFacade.Create(LPath, AMigrationSerializerFacade);
  end;
end;

{ TDefaultInstanceOfMigrationGetterCreator }

class function TDefaultInstanceOfMigrationGetterCreator.getInstance: IGetterMigrations;
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

{ TDefaultInstanceOfMigrationListOrderCreator }

class function TDefaultInstanceOfMigrationListOrderCreator.getInstance: IMigrationListOrder;
begin
 if Assigned(FMigrationListOrder) then
  begin
    Result := FMigrationListOrder;
  end
  else
  begin
    Result := TMigrationListOrder.Create;
  end;
end;

{ TDefaultInstanceOfMigrationsRegisterCreator }

class function TDefaultInstanceOfMigrationsRegisterCreator.getInstance(AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;
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

{ TDefaultInstanceOfMigrationExecutorCreator }

class function TDefaultInstanceOfMigrationExecutorCreator.getInstance(AMigrationsHistoryFacade: IMigrationsHistoryFacade): IMigrationExecutorFacade;
begin
 if Assigned(FExecutorFacade) then
  begin
    Result := FExecutorFacade;
  end
  else
  begin
    Result := TMigrationExecutorFacade.Create(AMigrationsHistoryFacade);
  end;
end;

end.
