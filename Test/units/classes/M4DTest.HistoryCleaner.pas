{This must be a integration test, but there are same things that must be tested}
unit M4DTest.HistoryCleaner;

interface

uses
  DUnitX.TestFramework, System.Classes, System.Generics.Collections,
  M4D.MigrationsHistoryItem;

type
  TestHistoryCleaner = class
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: string;

    procedure CreateCleanerWithNoHistoryList;
    procedure CreateCleanerWithNoFile;
    procedure CreateCleanerWithNoPath;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckIfParameterAHistoryListCouldBeNil;
    [Test]
    procedure CheckIfParameterAFileCouldBeNil;
    [Test]
    procedure CheckIfParameterAPathCouldBeEmpty;
  end;

implementation

uses
  M4D.HistoryCleaner, M4D.HistoryCleanerInterface;

{ TestHistoryCleaner }

procedure TestHistoryCleaner.CheckIfParameterAFileCouldBeNil;
begin
  Assert.WillRaiseAny(CreateCleanerWithNoFile, 'The parameter AFile must no be nil.');
end;

procedure TestHistoryCleaner.CheckIfParameterAHistoryListCouldBeNil;
begin
  Assert.WillRaiseAny(CreateCleanerWithNoHistoryList, 'The parameter AHistoryList must no be nil.');
end;

procedure TestHistoryCleaner.CheckIfParameterAPathCouldBeEmpty;
begin
  Assert.WillRaiseAny(CreateCleanerWithNoPath, 'The parameter APath must no be empty.');
end;

procedure TestHistoryCleaner.CreateCleanerWithNoFile;
var
  Cleaner: IHistoryCleaner;
begin
  Cleaner := THistoryCleaner.Create(FHistoryList, nil, FPath);
end;

procedure TestHistoryCleaner.CreateCleanerWithNoHistoryList;
var
  Cleaner: IHistoryCleaner;
begin
  Cleaner := THistoryCleaner.Create(nil, FFile, FPath);
end;

procedure TestHistoryCleaner.CreateCleanerWithNoPath;
var
  Cleaner: IHistoryCleaner;
begin
  Cleaner := THistoryCleaner.Create(FHistoryList, FFile, '');
end;

procedure TestHistoryCleaner.Setup;
begin
  FHistoryList := TObjectList<TMigrationsHistoryItem>.Create;
  FFile := TStringList.Create;
  FPath := 'C:\';
end;

procedure TestHistoryCleaner.TearDown;
begin
  if Assigned(FHistoryList) then FHistoryList.Free;
  if Assigned(FFile) then FFile.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestHistoryCleaner);

end.
