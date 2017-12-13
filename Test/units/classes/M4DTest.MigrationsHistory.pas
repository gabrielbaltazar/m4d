{TO be done. I believe this must be a integration test, not only a unitary test.
I could do this on my own computer, but it may not have a sense in others computers}

unit M4DTest.MigrationsHistory;

interface

uses
  DUnitX.TestFramework, M4D.MigrationSerializerFacadeInterface;

type
  [TestFixture]
  TestMigrationsHistory = class
  private
    FSerializer: IMigrationSerializerFacade;
  public
    [Setup]
    procedure Setup;
  end;

implementation

uses
  M4D.MigrationsHistoryFacadeInterface, M4D.MigrationsHistoryFacade, M4D.MigrationSerializerFacade;

{ TestMigrationsHistory }

procedure TestMigrationsHistory.Setup;
begin
  FSerializer := TMigrationSerializerFacade.Create;
end;

initialization
//  TDUnitX.RegisterTestFixture(TestMigrationsHistory);

end.
