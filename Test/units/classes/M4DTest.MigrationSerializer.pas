unit M4DTest.MigrationSerializer;

interface

uses
  DUnitX.TestFramework, M4D.MigrationsHistoryItem,
  M4D.MigrationSerializerFacadeInterface;

type
  [TestFixture]
  TestMigrationSerializer = class
  private
    const
      VERSION = '1.00';
      SEQUENCE = 1;
      DATETIME = '27/09/2017';
      START_OF_EXECUTION = '27/09/2017 07:00:00';
      END_OF_EXECUTION = '28/09/2017 07:00:00';
      DURATION = 1.0;

    var
      FMigrationSerializer: IMigrationSerializerFacade;
      FText: string;

//    procedure Aux(AItem: TMigrationsHistoryItem);
  public
    [Setup]
    procedure Setup;
    [Test]
    procedure CheckHistoryToText;
    [Test]
    procedure CheckTextToHistory;
  end;

implementation

uses
  System.SysUtils, M4D.MigrationSerializerFacade,

  System.JSON, Data.DBXJSONReflect, Vcl.Dialogs;


{ TestMigrationSerializer }
{
procedure TestMigrationSerializer.Aux(AItem: TMigrationsHistoryItem);
var
  Marshal: TJSONMarshal;
  Aux: TJSONObject;
begin
  if Assigned(AItem) then
  begin
    Marshal := TJSONMarshal.Create(TJSONConverter.Create);
    try
      Aux := Marshal.Marshal(AItem) as TJSONObject;
      try
        ShowMessage(Aux.ToString);
      finally
        Aux.Free;
      end;
    finally
      Marshal.Free;
    end;
  end;
end;
 }
procedure TestMigrationSerializer.CheckHistoryToText;
var
  LItem: TMigrationsHistoryItem;
begin
  LItem := TMigrationsHistoryItem.Create;
  try
    LItem.MigrationVersion := VERSION;
    LItem.MigrationSeq := SEQUENCE;
    LItem.MigrationDateTime := StrToDateTime(DATETIME);
    LItem.StartOfExecution := StrToDateTime(START_OF_EXECUTION);
    LItem.EndOfExecution := StrToDateTime(END_OF_EXECUTION);
    LItem.DurationOfExecution := DURATION;

    Assert.IsTrue(FMigrationSerializer.HistoryToText(LItem) = FText, 'The conversion of the object to text is not coherent.');
  finally
    LItem.Free;
  end;
end;

procedure TestMigrationSerializer.CheckTextToHistory;
var
  LItem: TMigrationsHistoryItem;
  isOk: Boolean;
begin
  LItem := FMigrationSerializer.TextToHistory(FText);
  try
    isOk := LItem.MigrationVersion = VERSION;
    if isOk then isOk := LItem.MigrationSeq = SEQUENCE;
    if isOk then isOk := DateTimeToStr(LItem.MigrationDateTime) = DATETIME;
    if isOk then isOk := DateTimeToStr(LItem.StartOfExecution) = START_OF_EXECUTION;
    if isOk then isOk := DateTimeToStr(LItem.EndOfExecution) = END_OF_EXECUTION;
    if isOk then isOk := LItem.DurationOfExecution = DURATION;
  finally
    LItem.Free;
  end;

  Assert.IsTrue(isOk, 'The conversion of the text to object is not coherent.');
end;

procedure TestMigrationSerializer.Setup;
begin
  FMigrationSerializer := TMigrationSerializerFacade.Create;
  
  FText := '{"type":"M4D.MigrationsHistoryItem.TMigrationsHistoryItem","id":1,"fields":{"FMigrationVersion":"1.00","FMigrationSeq":1,"FMigrationDateTime":43005,"FStartOfExecution":43005.2916666667,"FEndOfExecution":43006.2916666667,"FDurationOfExecution":1}}';
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationSerializer);

end.
