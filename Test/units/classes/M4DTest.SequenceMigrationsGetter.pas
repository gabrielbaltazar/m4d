unit M4DTest.SequenceMigrationsGetter;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MigrationsInterface,
  M4D.MainMigrationsGetterInterface;

type
  TestSequenceMigrationsGetter = class
  private
    FAux: TObject;
    FMigrationList: TList<IMigration>;
    FMainMigrationGetter: IMainMigrationsGetter;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckGetMigrations;
  end;

implementation

uses
  M4D.SequenceMigrationsGetterInterface, M4D.SequenceMigrationsGetter,
  M4DTest.MStubMigrationToTest, System.SysUtils, M4D.MainMigrationsGetter;

{ TestSequenceMigrationsGetter }

procedure TestSequenceMigrationsGetter.CheckGetMigrations;
var
  SequenceMigrationsGetter: ISequenceMigrationsGetter;
  List: TList<IMigration>;
begin
  SequenceMigrationsGetter := TSequenceMigrationsGetter.Create;
  List := SequenceMigrationsGetter.getMigrations(FMigrationList, 1, FMainMigrationGetter);
  try
    Assert.IsTrue(Assigned(List), 'The migration getter must return a assigned list.');
  finally
    List.Free;
  end;
end;

procedure TestSequenceMigrationsGetter.Setup;
begin
  FAux := TestStubClass.Create;
  (FAux as TInterfacedObject as IMigration).Version := '1.00';
  (FAux as TInterfacedObject as IMigration).SeqVersion := 1;
  (FAux as TInterfacedObject as IMigration).DateTime := Now;

  FMigrationList := TList<IMigration>.Create;
  FMigrationList.Add((FAux as TInterfacedObject as IMigration));

  FMainMigrationGetter := TMainMigrationsGetter.Create;
end;

procedure TestSequenceMigrationsGetter.TearDown;
begin
//  if Assigned(FAux) then FAux.Free;

  if Assigned(FMigrationList) then FMigrationList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestSequenceMigrationsGetter);

end.
