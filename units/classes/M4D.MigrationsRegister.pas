{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsRegister;

interface
  uses
    System.Generics.Collections, M4D.MigrationsRegisterInterface,
    M4D.MigrationListOrderInterface, System.Generics.Defaults;

type
  {$M+}
  {$REGION 'TMigrationsRegister'}
    /// <Description>
    ///  Standard implementation of the migration´s register.
    /// </Description>
    /// <Responsability>
    ///  Register a migration.
    /// </Responsability>
    /// <Note>
    ///  A migration register is responsible for registering the migration within
    ///  the migration management class. Thus, the migration becomes known by the
    ///  migration management class and can be used when needed.
    ///
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsRegister = class(TInterfacedObject, IMigrationsRegister)
  private
    FMigrationsList: TList<TClass>;
    FCompare: IComparer<TClass>;
  public
    constructor Create(AComparison: IMigrationListOrder);
    destructor Destroy; override;

    procedure RegisterMigration(AMigration: TClass);
    function getMigrationsRegister: TList<TClass>;
  published
    property Migrations: TList<TClass> read getMigrationsRegister;
  end;

implementation

uses
  System.SysUtils;

{ TMigrationsRegister }

constructor TMigrationsRegister.Create(AComparison: IMigrationListOrder);
begin
   if not Assigned(AComparison) then
   begin
     raise Exception.Create('The parameter AComparison must not be nil.');
   end
   else
   begin
     {$IF CompilerVersion <= 34.0}
     FCompare := TComparer<TClass>.Construct(AComparison.Comparison) as TDelegatedComparer<TClass>;
     {$ELSE}
     FCompare := TComparer<TClass>.Construct(AComparison.Comparison);
     {$ENDIF}
     FMigrationsList := TList<TClass>.Create(FCompare);
   end;
end;

destructor TMigrationsRegister.Destroy;
begin
  if Assigned(FMigrationsList) then FreeAndNil(FMigrationsList);

  inherited;
end;

function TMigrationsRegister.getMigrationsRegister: TList<TClass>;
begin
  Result := FMigrationsList;
end;

procedure TMigrationsRegister.RegisterMigration(AMigration: TClass);
begin
  if not Assigned(FMigrationsList) then FMigrationsList.Create;

  FMigrationsList.Add(AMigration);
end;

end.

