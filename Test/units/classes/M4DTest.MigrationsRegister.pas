unit M4DTest.MigrationsRegister;

interface

uses
  DUnitX.TestFramework;

type
  TestMigrationsRegister = class
  private
    procedure CreateWithRaise;
  public
    [Test]
    procedure CheckTheUninformedParameterPrevention;
    [Test]
    procedure CheckRegisterMechanism;
  end;

implementation

uses
  M4D.MigrationsRegisterInterface, M4D.MigrationsRegister,
  M4DTest.MStubMigrationToTest, Generics.Collections,
  M4D.MigrationListOrderInterface, M4D.MigrationListOrder;

{ TestMigrationsRegister }

procedure TestMigrationsRegister.CheckRegisterMechanism;
var
  MigrationListOrder: IMigrationListOrder;
  MigrationsRegister: IMigrationsRegister;
  List: TList<TClass>;
begin
  MigrationListOrder := TMigrationListOrder.Create;

  MigrationsRegister := TMigrationsRegister.Create(MigrationListOrder);
  MigrationsRegister.RegisterMigration(TestStubClass);
  List := MigrationsRegister.Migrations;

  Assert.IsTrue(List.Count = 1, 'The register mechanism is not working fine.');
end;

procedure TestMigrationsRegister.CheckTheUninformedParameterPrevention;
begin
  Assert.WillRaiseAny(CreateWithRaise, 'The migration register must not accept nil values for migrationlistorder on create.');
end;

procedure TestMigrationsRegister.CreateWithRaise;
var
  MigrationsRegister: IMigrationsRegister;
begin
  MigrationsRegister := TMigrationsRegister.Create(nil);
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsRegister);

end.
