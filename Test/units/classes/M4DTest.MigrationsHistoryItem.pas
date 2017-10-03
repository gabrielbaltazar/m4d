unit M4DTest.MigrationsHistoryItem;

interface

uses
  DUnitX.TestFramework;

type
  TestMigrationsHistoryItem = class
  private
    const
      VERSION = '1.00';
      SEQUENCE = 1;
      DATETIME = '27/09/2017';
      START_OF_EXECUTION = '27/09/2017 07:00:00';
      END_OF_EXECUTION = '28/09/2017 07:00:00';
      DURATION = 1.0;
  public
  [Test]
  procedure CheckConsistencyOfInformation;
  end;

implementation

uses
  M4D.MigrationsHistoryItem, System.SysUtils;

{ TestMigrationsHistoryItem }

procedure TestMigrationsHistoryItem.CheckConsistencyOfInformation;
var
  Item: TMigrationsHistoryItem;
  isOk: Boolean;
begin
  Item := TMigrationsHistoryItem.Create;
  try
    Item.MigrationVersion := VERSION;
    Item.MigrationSeq := SEQUENCE;
    Item.MigrationDateTime := StrToDateTime(DATETIME);
    Item.StartOfExecution := StrToDateTime(START_OF_EXECUTION);
    Item.EndOfExecution := StrToDateTime(END_OF_EXECUTION);
    Item.DurationOfExecution := DURATION;

    isOk := Item.MigrationVersion = VERSION;
    if isOk then isOk := Item.MigrationSeq = SEQUENCE;
    if isOk then isOk := DateTimeToStr(Item.MigrationDateTime) = DATETIME;
    if isOk then isOk := DateTimeToStr(Item.StartOfExecution) = START_OF_EXECUTION;
    if isOk then isOk := DateTimeToStr(Item.EndOfExecution) = END_OF_EXECUTION;
    if isOk then isOk := Item.DurationOfExecution = DURATION;

    Assert.IsTrue(isOk, 'The consistency of the information in the migration item is not coherent.');
  finally
    Item.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsHistoryItem);

end.
