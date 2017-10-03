unit M4DTest.MainMigrationsGetter;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MainMigrationsGetter,
  System.SysUtils, M4D.MigrationsInterface;

type
  [TestFixture]
  TestMainMigrationsGetter = class(TObject)
  private
    FMigrationsList: TList<IMigration>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckTheReturnOfGetMigrationsWhenPredicateIsTrue;
    [Test]
    procedure CheckTheReturnOfGetMigrationsWhenPredicateIsFalse;
  end;

implementation

uses
  M4D.Migrations, M4D.MainMigrationsGetterInterface;

{ TestMainMigrationsGetter }

procedure TestMainMigrationsGetter.CheckTheReturnOfGetMigrationsWhenPredicateIsFalse;
var
  LMainMigrationsGetter: IMainMigrationsGetter;
  List: TList<IMigration>;
begin
  LMainMigrationsGetter := TMainMigrationsGetter.Create;
  List := LMainMigrationsGetter.getMigrations(FMigrationsList, function(Value: IMigration): Boolean
                                                               begin
                                                                 Result := False;
                                                               end);
  try
    Assert.IsFalse(Assigned(List), 'The List must not be assigned here!');
  finally
    if Assigned(List) then List.Free;
  end;
end;

procedure TestMainMigrationsGetter.CheckTheReturnOfGetMigrationsWhenPredicateIsTrue;
var
  LMainMigrationsGetter: IMainMigrationsGetter;
  List: TList<IMigration>;
begin
  LMainMigrationsGetter := TMainMigrationsGetter.Create;
  List := LMainMigrationsGetter.getMigrations(FMigrationsList, function(Value: IMigration): Boolean
                                                               begin
                                                                 Result := True;
                                                               end);
  try
    Assert.IsTrue(List.Count = FMigrationsList.Count, 'Expected ' + FMigrationsList.Count.ToString + ', but get only ' + List.Count.ToString);
  finally
    List.Free;
  end;
end;

procedure TestMainMigrationsGetter.Setup;
var
  Item: IMigration;
begin
  FMigrationsList := TList<IMigration>.Create;

  Item := TMigrations.Create;
  FMigrationsList.Add(Item);

  Item := TMigrations.Create;
  FMigrationsList.Add(Item);

  Item := TMigrations.Create;
  FMigrationsList.Add(Item);
end;

procedure TestMainMigrationsGetter.TearDown;
begin
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestMainMigrationsGetter);

end.
