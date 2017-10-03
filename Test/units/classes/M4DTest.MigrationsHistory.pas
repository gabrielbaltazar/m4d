{TO be done. I believe this must be a integration test, not only a unitary test.
I could do this on my own computer, but it may not have a sense in others computers}

unit M4DTest.MigrationsHistory;

interface

uses
  DUnitX.TestFramework, M4D.MigrationSerializerInterface;

type
  TestMigrationsHistory = class
  private
    FSerializer: IMigrationSerializer;
  public
    [Setup]
    procedure Setup;
  end;

implementation

uses
  M4D.MigrationsHistoryInterface, M4D.MigrationsHistory, M4D.MigrationSerializer;

{ TestMigrationsHistory }

procedure TestMigrationsHistory.Setup;
begin
  FSerializer := TMigrationSerializer.Create;
end;

initialization
//  TDUnitX.RegisterTestFixture(TestMigrationsHistory);

end.
