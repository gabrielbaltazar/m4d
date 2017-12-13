unit M4DTest.MigrationsHistorySaver;

interface

uses
  DUnitX.TestFramework, System.Generics.Collections, System.Classes,
  M4D.MigrationSerializerFacadeInterface, M4D.MigrationsHistoryItem;

type
  [TestFixture]
  TestMigrationsHistorySaver = class
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: string;
    FSerializer: IMigrationSerializerFacade;

    procedure CreateSaverWithNoHistoryList;
    procedure CreateSaverWithNoFile;
    procedure CreateSaverWithNoPath;
    procedure CreateSaverWithNoSerializer;
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
    [Test]
    procedure CheckIfParameterSerializerCouldBeNil;
  end;

implementation

uses
  M4D.MigrationSerializerFacade, M4D.MigrationsHistorySaverInterface, M4D.MigrationsHistorySaver;

{ TestMigrationsHistorySaver }

procedure TestMigrationsHistorySaver.CheckIfParameterAFileCouldBeNil;
begin
  Assert.WillRaiseAny(CreateSaverWithNoFile, 'The parameter AFile must no be nil.');
end;

procedure TestMigrationsHistorySaver.CheckIfParameterAHistoryListCouldBeNil;
begin
  Assert.WillRaiseAny(CreateSaverWithNoHistoryList, 'The parameter AHistoryList must no be nil.');
end;

procedure TestMigrationsHistorySaver.CheckIfParameterAPathCouldBeEmpty;
begin
  Assert.WillRaiseAny(CreateSaverWithNoPath, 'The parameter APath must no be empty.');
end;

procedure TestMigrationsHistorySaver.CheckIfParameterSerializerCouldBeNil;
begin
  Assert.WillRaiseAny(CreateSaverWithNoSerializer, 'The parameter ASerializer must no be nil.');
end;

procedure TestMigrationsHistorySaver.CreateSaverWithNoFile;
var
  Saver: IMigrationsHistorySaver;
begin
  Saver := TMigrationsHistorySaver.Create(FHistoryList, nil, FPath, FSerializer);
end;

procedure TestMigrationsHistorySaver.CreateSaverWithNoHistoryList;
var
  Saver: IMigrationsHistorySaver;
begin
  Saver := TMigrationsHistorySaver.Create(nil, FFile, FPath, FSerializer);
end;

procedure TestMigrationsHistorySaver.CreateSaverWithNoPath;
var
  Saver: IMigrationsHistorySaver;
begin
  Saver := TMigrationsHistorySaver.Create(FHistoryList, FFile, '', FSerializer);
end;

procedure TestMigrationsHistorySaver.CreateSaverWithNoSerializer;
var
  Saver: IMigrationsHistorySaver;
begin
  Saver := TMigrationsHistorySaver.Create(FHistoryList, FFile, FPath, nil);
end;

procedure TestMigrationsHistorySaver.Setup;
begin
  FHistoryList := TObjectList<TMigrationsHistoryItem>.Create;
  FFile := TStringList.Create;
  FPath := 'C:\';
  FSerializer := TMigrationSerializerFacade.Create;
end;

procedure TestMigrationsHistorySaver.TearDown;
begin
  if Assigned(FHistoryList) then FHistoryList.Free;
  if Assigned(FFile) then FFile.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsHistorySaver);

end.
