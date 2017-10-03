unit M4DTest.DatetimeMigrationsGetter;

interface

uses
  DUnitX.TestFramework, Generics.Collections, M4D.MigrationsInterface, M4D.MainMigrationsGetterInterface;

type
  [TestFixture]
  TestDatetimeMigrationsGetterClass = class(TObject)
  private
    List: TList<IMigration>;
    MainMigrationsGetter: IMainMigrationsGetter;

    procedure TestCheckTheInputParameterAMigrationsListExceptionCallAuxMethod;
    procedure TestCheckTheInputParameterAMainMigrationsGetterExceptionCallAuxMethod;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestCheckTheInputParameterAMigrationsListExceptionCall;

    [Test]
    procedure TestCheckTheInputParameterAMainMigrationsGetterExceptionCall;

    [Test]
    procedure CheckTheCorrectFunctionReturn;

    [Test]
    procedure CheckThePositiveEnd;

    [Test]
    procedure CheckTheNegativeEnd;
  end;

implementation

uses
  M4D.DatetimeMigrationsGetter, M4D.Migrations, System.SysUtils, M4D.MainMigrationsGetter;

{ TestCheckTheInputParameterExceptionCall }

procedure TestDatetimeMigrationsGetterClass.TestCheckTheInputParameterAMigrationsListExceptionCallAuxMethod;
var
  Aux: TDatetimeMigrationsGetter;
begin
  Aux := TDatetimeMigrationsGetter.Create;
  try
    Aux.getMigrations(nil, 0, MainMigrationsGetter);
  finally
    Aux.Free;
  end;
end;

procedure TestDatetimeMigrationsGetterClass.TestCheckTheInputParameterAMainMigrationsGetterExceptionCall;
begin
  Assert.WillRaiseAny(Self.TestCheckTheInputParameterAMainMigrationsGetterExceptionCallAuxMethod, 'Exception for the nil parameter AMigrationsList on TDatetimeMigrationsGetter.getMigrations not happens.');
end;

procedure TestDatetimeMigrationsGetterClass.TestCheckTheInputParameterAMainMigrationsGetterExceptionCallAuxMethod;
var
  Aux: TDatetimeMigrationsGetter;
begin
  Aux := TDatetimeMigrationsGetter.Create;
  try
    Aux.getMigrations(List, 0, nil);
  finally
    Aux.Free;
  end;
end;

procedure TestDatetimeMigrationsGetterClass.TestCheckTheInputParameterAMigrationsListExceptionCall;
begin
  Assert.WillRaiseAny(Self.TestCheckTheInputParameterAMigrationsListExceptionCallAuxMethod, 'Exception for the nil parameter AMigrationsList on TDatetimeMigrationsGetter.getMigrations not happens.');
end;

procedure TestDatetimeMigrationsGetterClass.CheckTheNegativeEnd;
var
  Aux: TDatetimeMigrationsGetter;
  LReturn: TList<IMigration>;
begin
  Aux := TDatetimeMigrationsGetter.Create;
  try
    LReturn := Aux.getMigrations(List, StrToDateTime('30/12/1899'), MainMigrationsGetter);
    try
      Assert.IsTrue(LReturn.Count = 3, 'Was a error checking the return of getMigrations. The function must return 3 itens, but it retuned ' + LReturn.Count.ToString + '.');
    finally
      LReturn.Free;
    end;
  finally
    Aux.Free;
  end;
end;

procedure TestDatetimeMigrationsGetterClass.CheckThePositiveEnd;
var
  Aux: TDatetimeMigrationsGetter;
  LReturn: TList<IMigration>;
begin
  Aux := TDatetimeMigrationsGetter.Create;
  try
    LReturn := Aux.getMigrations(List, StrToDateTime('31/12/9999'), MainMigrationsGetter);
    try
      if not Assigned(LReturn) then
      begin
        Assert.Pass('The list was not assigned, what is a good thingh in this case.');
      end
      else
      begin
        Assert.IsTrue(LReturn.Count = 0, 'Was a error checking the return of getMigrations. The function must return 0 itens, but it retuned ' + LReturn.Count.ToString + '.');
      end;
    finally
      LReturn.Free;
    end;
  finally
    Aux.Free;
  end;
end;

procedure TestDatetimeMigrationsGetterClass.Setup;
var
  Item: IMigration;
begin
  List := TList<IMigration>.Create;

  Item := TMigrations.Create;
  Item.DateTime := StrToDateTime('01/01/2017');
  List.Add(Item);

  Item := TMigrations.Create;
  Item.DateTime := StrToDateTime('15/07/2017');
  List.Add(Item);

  Item := TMigrations.Create;
  Item.DateTime := StrToDateTime('21/09/2017');
  List.Add(Item);

  MainMigrationsGetter := TMainMigrationsGetter.Create;
end;

procedure TestDatetimeMigrationsGetterClass.TearDown;
begin
  if Assigned(List) then
  begin
    List.Clear;
    List.Free;
  end;
end;

procedure TestDatetimeMigrationsGetterClass.CheckTheCorrectFunctionReturn;
var
  Aux: TDatetimeMigrationsGetter;
  LReturn: TList<IMigration>;
begin
  Aux := TDatetimeMigrationsGetter.Create;
  try
    LReturn := Aux.getMigrations(List, StrToDateTime('15/07/2017'), MainMigrationsGetter);
    try
      Assert.IsTrue(LReturn.Count = 2, 'Was a error checking the return of getMigrations. The function must return 2 itens, but it retuned ' + LReturn.Count.ToString + '.');
    finally
      LReturn.Free;
    end;
  finally
    Aux.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TestDatetimeMigrationsGetterClass);

end.

