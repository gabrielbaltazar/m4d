unit M4DTest.MigrationsHistoryUnloader;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TestMigrationsHistoryUnloader = class
  private
    procedure CreateUnLoaderWithNoFile;
  public
    [Test]
    procedure CheckIfParameterAFileCouldBeNil;
    [Test]
    procedure CheckIfUnloadFile;
  end;

implementation

uses
  M4D.MigrationsHistoryUnloaderInterface, M4D.MigrationsHistoryUnloader,
  System.Classes;

{ TestMigrationsHistoryUnloader }

procedure TestMigrationsHistoryUnloader.CheckIfParameterAFileCouldBeNil;
begin
  Assert.WillRaiseAny(CreateUnLoaderWithNoFile, 'The parameter AFile must no be nil.');
end;

procedure TestMigrationsHistoryUnloader.CheckIfUnloadFile;
var
  LFile: TStringlist;
  UnLoader: IMigrationsHistoryUnLoader;
begin
  LFile := TStringList.Create;
  UnLoader := TMigrationsHistoryUnLoader.Create(LFile);
  UnLoader.UnLoad;
  Assert.IsTrue(Assigned(LFile), 'The LFile should not be assigned after his unload.');
end;

procedure TestMigrationsHistoryUnloader.CreateUnLoaderWithNoFile;
var
  UnLoader: IMigrationsHistoryUnLoader;
begin
  UnLoader := TMigrationsHistoryUnLoader.Create(nil);
end;

initialization
  TDUnitX.RegisterTestFixture(TestMigrationsHistoryUnloader);

end.
