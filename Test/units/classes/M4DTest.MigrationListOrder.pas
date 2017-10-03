unit M4DTest.MigrationListOrder;

interface

uses
  DUnitX.TestFramework;

type
  TestMigrationListOrder = class
  public
    [Test]
    procedure CheckComparison;
  end;

implementation

uses
  M4D.MigrationListOrderInterface, M4D.MigrationListOrder;

{ TestMigrationListOrder }

procedure TestMigrationListOrder.CheckComparison;
var
  MigrationListOrder: IMigrationListOrder;
begin
  MigrationListOrder := TMigrationListOrder.Create;
  Assert.IsTrue(Assigned(MigrationListOrder.Comparison), 'The funcion TMigrationListOrder.Comparison must return a assigned method.');
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationListOrder);

end.
