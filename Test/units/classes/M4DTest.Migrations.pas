unit M4DTest.Migrations;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TestMigrations = class
  public
    [Test]
    procedure CheckVersion;
    [Test]
    procedure CheckSequence;
    [Test]
    procedure CheckDatetime;
  end;

implementation

uses
  M4D.MigrationsInterface,
  System.SysUtils,
  M4DTest.MStubMigrationToTest;

{ TestMigrations }

procedure TestMigrations.CheckDatetime;
var
  DateTime: TDateTime;
  Migration: IMigration;
begin
  DateTime := Now;
  Migration := TestStubClass.Create;
  Migration.DateTime := DateTime;
  Assert.IsTrue(Migration.DateTime = DateTime, 'The migration datetime does not match with the version inputted before.');
end;

procedure TestMigrations.CheckSequence;
const
  SEQUENCE = 1;
var
  Migration: IMigration;
begin
  Migration := TestStubClass.Create;
  Migration.SeqVersion := SEQUENCE;
  Assert.IsTrue(Migration.SeqVersion = SEQUENCE, 'The migration sequence does not match with the version inputted before.');
end;

procedure TestMigrations.CheckVersion;
const
  VERSION = '1.00';
var
  Migration: IMigration;
begin
  Migration := TestStubClass.Create;
  Migration.Version := VERSION;
  Assert.IsTrue(Migration.Version = VERSION, 'The migration version does not match with the version inputted before.');
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrations);

end.
