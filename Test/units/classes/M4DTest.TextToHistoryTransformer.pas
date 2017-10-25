unit M4DTest.TextToHistoryTransformer;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TestTextToHistoryTransformer = class
  private
    const
      VERSION = '1.00';
      SEQUENCE = 1;
      DATETIME = '27/09/2017';
      START_OF_EXECUTION = '27/09/2017 07:00:00';
      END_OF_EXECUTION = '28/09/2017 07:00:00';
      DURATION = 1.0;

      OBJECT_TEXT = '{"type":"M4D.MigrationsHistoryItem.TMigrationsHistoryItem","id":1,"fields":{"FMigrationVersion":"1.00","FMigrationSeq":1,"FMigrationDateTime":43005,"FStartOfExecution":43005.2916666667,"FEndOfExecution":43006.2916666667,"FDurationOfExecution":1}}';
  public
    [Test]
    procedure CheckTextToHistory;
    [Test]
    procedure CheckTheVersionInfo;
    [Test]
    procedure CheckSequenceInfo;
    [Test]
    procedure CheckDateTimeInfo;
    [Test]
    procedure CheckStartOfExecutionInfo;
    [Test]
    procedure CheckEndOfExecutionInfo;
    [Test]
    procedure CheckDurationInfo;
  end;

implementation

uses
  M4D.TextToHistoryTransformer, M4D.TextToHistoryTransformerInterface,
  M4D.MigrationsHistoryItem, System.SysUtils;

{ TestTextToHistoryTransformer }

procedure TestTextToHistoryTransformer.CheckDateTimeInfo;
var
  LAux: ITextToHistoryTransformer;
  Item: TMigrationsHistoryItem;
begin
  LAux := TTextToHistoryTransformer.Create;
  Item := LAux.TextToHistory(OBJECT_TEXT);
  try
    Assert.IsTrue(Item.MigrationDateTime = StrToDateTime(DATETIME), 'The datetime value is not valid.');
  finally
    Item.Free;
  end;
end;

procedure TestTextToHistoryTransformer.CheckDurationInfo;
var
  LAux: ITextToHistoryTransformer;
  Item: TMigrationsHistoryItem;
begin
  LAux := TTextToHistoryTransformer.Create;
  Item := LAux.TextToHistory(OBJECT_TEXT);
  try
    Assert.IsTrue(Item.DurationOfExecution = DURATION, 'The duration time value is not valid.');
  finally
    Item.Free;
  end;
end;

procedure TestTextToHistoryTransformer.CheckEndOfExecutionInfo;
var
  LAux: ITextToHistoryTransformer;
  Item: TMigrationsHistoryItem;
begin
  LAux := TTextToHistoryTransformer.Create;
  Item := LAux.TextToHistory(OBJECT_TEXT);
  try
    Assert.IsTrue(DateTimeToStr(Item.EndOfExecution) = END_OF_EXECUTION, 'The end of execution value is not valid.');
  finally
    Item.Free;
  end;
end;

procedure TestTextToHistoryTransformer.CheckSequenceInfo;
var
  LAux: ITextToHistoryTransformer;
  Item: TMigrationsHistoryItem;
begin
  LAux := TTextToHistoryTransformer.Create;
  Item := LAux.TextToHistory(OBJECT_TEXT);
  try
    Assert.IsTrue(Item.MigrationSeq = SEQUENCE, 'The sequence value is not valid.');
  finally
    Item.Free;
  end;
end;

procedure TestTextToHistoryTransformer.CheckStartOfExecutionInfo;
var
  LAux: ITextToHistoryTransformer;
  Item: TMigrationsHistoryItem;
begin
  LAux := TTextToHistoryTransformer.Create;
  Item := LAux.TextToHistory(OBJECT_TEXT);
  try
    Assert.IsTrue(DateTimeToStr(Item.StartOfExecution) = START_OF_EXECUTION, 'The start of execution value is not valid.');
  finally
    Item.Free;
  end;
end;

procedure TestTextToHistoryTransformer.CheckTextToHistory;
var
  LAux: ITextToHistoryTransformer;
  Item: TMigrationsHistoryItem;
begin
  LAux := TTextToHistoryTransformer.Create;
  Item := LAux.TextToHistory(OBJECT_TEXT);
  try
    Assert.IsTrue(Assigned(Item), 'TextToHistory must return a assgined value, but it not happens.');
  finally
    Item.Free;
  end;
end;

procedure TestTextToHistoryTransformer.CheckTheVersionInfo;
var
  LAux: ITextToHistoryTransformer;
  Item: TMigrationsHistoryItem;
begin
  LAux := TTextToHistoryTransformer.Create;
  Item := LAux.TextToHistory(OBJECT_TEXT);
  try
    Assert.IsTrue(Item.MigrationVersion = VERSION, 'The version value is not valid.');
  finally
    Item.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TestTextToHistoryTransformer);

end.
