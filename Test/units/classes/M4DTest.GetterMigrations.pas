unit M4DTest.GetterMigrations;

interface

uses
  DUnitX.TestFramework, M4D.GetterMigrations, M4D.GetterMigrationsInterface, Generics.Collections,
  M4D.MigrationsInterface;

type
  [TestFixture]
  TestGetterMigrations = class(TObject)
  private
    FMigrationsList: TList<IMigration>;
    FGetterMigrations: IGetterMigrations;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CheckIfReturnedCorretNumberOfMigrationBySequence;
    [Test]
    procedure CheckThePositiveEndOfMigrationBySequence;
    [Test]
    procedure CheckTheNegativeEndOfMigrationBySequence;
    [Test]
    procedure CheckTheNegativeValueOfMigrationBySequence;

    [Test]
    procedure CheckIfReturnedCorretNumberOfMigrationByDateTime;
    [Test]
    procedure CheckThePositiveEndOfMigrationByDateTime;
    [Test]
    procedure CheckTheNegativeEndOfMigrationByDateTime;
  end;



implementation

uses
  System.SysUtils,
  M4DTest.MStubMigrationToTest;

{ TestGetterMigrations }

procedure TestGetterMigrations.CheckIfReturnedCorretNumberOfMigrationByDateTime;
var
  List: TList<IMigration>;
begin
  List := FGetterMigrations.getMigrations(FMigrationsList, StrToDateTime('15/05/2017'));
  try
    Assert.IsTrue(List.Count = 2, 'The return of TGetterMigrations.getMigrations returned a wrong value. Expected 2, get ' + List.Count.ToString);
  finally
    List.Free;
  end;
end;

procedure TestGetterMigrations.CheckIfReturnedCorretNumberOfMigrationBySequence;
var
  List: TList<IMigration>;
begin
  List := FGetterMigrations.getMigrations(FMigrationsList, 2);
  try
    Assert.IsTrue(List.Count = 2, 'The return of TGetterMigrations.getMigrations returned a wrong value. Expected 2, get ' + List.Count.ToString);
  finally
    List.Free;
  end;
end;

procedure TestGetterMigrations.CheckTheNegativeEndOfMigrationByDateTime;
var
  List: TList<IMigration>;
begin
  List := FGetterMigrations.getMigrations(FMigrationsList, StrToDateTime('30/12/1899'));
  try
    Assert.IsTrue(List.Count = 3, 'The return of TGetterMigrations.getMigrations returned a wrong value. Expected 3, get ' + List.Count.ToString);
  finally
    List.Free;
  end;
end;

procedure TestGetterMigrations.CheckTheNegativeEndOfMigrationBySequence;
var
  List: TList<IMigration>;
begin
  List := FGetterMigrations.getMigrations(FMigrationsList, 0);
  try
    Assert.IsTrue(List.Count = 3, 'The return of TGetterMigrations.getMigrations returned a wrong value. Expected 3, get ' + List.Count.ToString);
  finally
    List.Free;
  end;
end;

procedure TestGetterMigrations.CheckTheNegativeValueOfMigrationBySequence;
var
  List: TList<IMigration>;
begin
  List := FGetterMigrations.getMigrations(FMigrationsList, -1);
  try
    Assert.IsTrue(List.Count = 3, 'The return of TGetterMigrations.getMigrations returned a wrong value. Expected 3, get ' + List.Count.ToString);
  finally
    List.Free;
  end;
end;

procedure TestGetterMigrations.CheckThePositiveEndOfMigrationByDateTime;
var
  List: TList<IMigration>;
begin
  List := FGetterMigrations.getMigrations(FMigrationsList, StrToDateTime('31/12/9999'));
  try
    if not Assigned(List) then
    begin
      Assert.Pass('The list must not be nil here!');
    end;
  finally
    List.Free;
  end;
end;

procedure TestGetterMigrations.CheckThePositiveEndOfMigrationBySequence;
var
  List: TList<IMigration>;
begin
  List := FGetterMigrations.getMigrations(FMigrationsList, MAXINT);
  try
    if not Assigned(List) then
    begin
      Assert.Pass('The list must not be nil here!');
    end;
  finally
    List.Free;
  end;
end;

procedure TestGetterMigrations.Setup;
var
  Item: IMigration;
begin
  FGetterMigrations := TGetterMigrations.Create;

  FMigrationsList := TList<IMigration>.Create;

  Item := TestStubClass.Create;
  Item.SeqVersion := 1;
  Item.DateTime := StrToDateTime('01/01/2017');
  FMigrationsList.Add(Item);

  Item := TestStubClass.Create;
  Item.SeqVersion := 2;
  Item.DateTime := StrToDateTime('15/05/2017');
  FMigrationsList.Add(Item);

  Item := TestStubClass.Create;
  Item.SeqVersion := 3;
  Item.DateTime := StrToDateTime('22/09/2017');
  FMigrationsList.Add(Item);
end;

procedure TestGetterMigrations.TearDown;
begin
  if Assigned(FMigrationsList) then FMigrationsList.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(TestGetterMigrations);

end.
