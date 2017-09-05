unit UMigrationsRegister;

interface
  uses
    System.Generics.Collections, UMigrationsRegisterInterface,
  UMigrationListOrderInterface, System.Generics.Defaults;

type
  {$M+}
  TMigrationsRegister = class(TInterfacedObject, IMigrationsRegister)
  private
    FMigrationsList: TList<TClass>;
    FCompare: IComparer<TClass>;
  public
    constructor Create(AComparison: IMigrationListOrder);

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
   if not Assigned(FCompare) then
   begin
     raise Exception.Create('The parameter ACompare must not be nil.');
   end
   else
   begin
     FCompare := TComparer<TClass>.Construct(AComparison.Comparison) as TDelegatedComparer<TClass>;
     FMigrationsList := TList<TClass>.Create(TComparer<TClass>.Construct(AComparison.Comparison));
   end;
end;

function TMigrationsRegister.getMigrationsRegister: TList<TClass>;
begin
  Result := FMigrationsList;
end;

procedure TMigrationsRegister.RegisterMigration(AMigration: TClass);
begin
  if not Assigned(FMigrationsList) then FMigrationsList.Create;
end;

end.

