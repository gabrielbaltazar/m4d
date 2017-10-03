unit M4DTest.HistoryToTextTransformer;

interface

uses
  DUnitX.TestFramework, M4D.MigrationsHistoryItem;

type
  TestHistoryToTextTransformer = class
  private
    const
      VERSION = '1.00';
      SEQUENCE = 1;
      DATETIME = '27/09/2017';
      START_OF_EXECUTION = '27/09/2017 07:00:00';
      END_OF_EXECUTION = '28/09/2017 07:00:00';
      DURATION = 1.0;

      OBJECT_TEXT = '{"type":"M4D.MigrationsHistoryItem.TMigrationsHistoryItem","id":1,"fields":{"FMigrationVersion":"1.00","FMigrationSeq":1,"FMigrationDateTime":43005,"FStartOfExecution":43005.2916666667,"FEndOfExecution":43006.2916666667,"FDurationOfExecution":1}}';
    var
      FItem: TMigrationsHistoryItem;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckHistoryToText;
  end;

implementation

uses
  M4D.HistoryToTextTransformer, M4D.HistoryToTextTransformerInterface,
  System.SysUtils;

{ TestHistoryToTextTransformer }

procedure TestHistoryToTextTransformer.CheckHistoryToText;
var
  HistoryToTextTransformer: IHistoryToTextTransformer;
  Aux: string;
begin
  HistoryToTextTransformer := THistoryToTextTransformer.Create;
  Aux := HistoryToTextTransformer.HistoryToText(FItem);

  Assert.IsTrue(Aux.Equals(OBJECT_TEXT), 'The value returned is not correct.');
end;

procedure TestHistoryToTextTransformer.Setup;
begin
  FItem := TMigrationsHistoryItem.Create;
  FItem.MigrationVersion := VERSION;
  FItem.MigrationSeq := SEQUENCE;
  FItem.MigrationDateTime := StrToDateTime(DATETIME);
  FItem.StartOfExecution := StrToDateTime(START_OF_EXECUTION);
  FItem.EndOfExecution := StrToDateTime(END_OF_EXECUTION);
  FItem.DurationOfExecution := DURATION;
end;

procedure TestHistoryToTextTransformer.TearDown;
begin
  FItem.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestHistoryToTextTransformer);

end.
