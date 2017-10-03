{This must be a integration test, but there are same things that must be tested}
unit M4DTest.MigrationsHistoryLoader;

interface

uses
  DUnitX.TestFramework, System.Generics.Collections, M4D.MigrationsHistoryItem,
  System.Classes, M4D.MigrationSerializerInterface;

type
  TestMigrationsHistoryLoader = class
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: string;
    FSerializer: IMigrationSerializer;

    procedure CreateLoaderWithNoHistoryList;
    procedure CreateLoaderWithNoFile;
    procedure CreateLoaderWithNoPath;
    procedure CreateLoaderWithNoSerializer;
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
  M4D.MigrationsHistoryLoaderInterface, M4D.MigrationsHistoryLoader,
  M4D.MigrationSerializer;

{ TestMigrationsHistoryLoader }

procedure TestMigrationsHistoryLoader.CheckIfParameterAFileCouldBeNil;
begin
  Assert.WillRaiseAny(CreateLoaderWithNoFile, 'The parameter AFile must no be nil.');
end;

procedure TestMigrationsHistoryLoader.CheckIfParameterAHistoryListCouldBeNil;
begin
  Assert.WillRaiseAny(CreateLoaderWithNoHistoryList, 'The parameter AHistoryList must no be nil.');
end;

procedure TestMigrationsHistoryLoader.CheckIfParameterAPathCouldBeEmpty;
begin
  Assert.WillRaiseAny(CreateLoaderWithNoPath, 'The parameter APath must no be empty.');
end;

procedure TestMigrationsHistoryLoader.CheckIfParameterSerializerCouldBeNil;
begin
  Assert.WillRaiseAny(CreateLoaderWithNoSerializer, 'The parameter ASerializer must no be nil.');
end;

procedure TestMigrationsHistoryLoader.CreateLoaderWithNoFile;
var
  Loader: IMigrationsHistoryLoader;
begin
  Loader := TMigrationsHistoryLoader.Create(FHistoryList, nil, FPath, FSerializer);
end;

procedure TestMigrationsHistoryLoader.CreateLoaderWithNoHistoryList;
var
  Loader: IMigrationsHistoryLoader;
begin
  Loader := TMigrationsHistoryLoader.Create(nil, FFile, FPath, FSerializer);
end;

procedure TestMigrationsHistoryLoader.CreateLoaderWithNoPath;
var
  Loader: IMigrationsHistoryLoader;
begin
  Loader := TMigrationsHistoryLoader.Create(FHistoryList, FFile, '', FSerializer);
end;

procedure TestMigrationsHistoryLoader.CreateLoaderWithNoSerializer;
var
  Loader: IMigrationsHistoryLoader;
begin
  Loader := TMigrationsHistoryLoader.Create(FHistoryList, FFile, FPath, nil);
end;

procedure TestMigrationsHistoryLoader.Setup;
begin
  FHistoryList := TObjectList<TMigrationsHistoryItem>.Create;
  FFile := TStringList.Create;
  FPath := 'C:\';
  FSerializer := TMigrationSerializer.Create;
end;

procedure TestMigrationsHistoryLoader.TearDown;
begin
  if Assigned(FHistoryList) then FHistoryList.Free;
  if Assigned(FFile) then FFile.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsHistoryLoader);


end.
