{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.GetterMigrations;

interface

uses
  Generics.Collections, M4D.GetterMigrationsInterface, M4D.MainMigrationsGetterInterface,
  M4D.MigrationsInterface, M4D.SequenceMigrationsGetterInterface,
  M4D.DatetimeMigrationsGetterInterface;

type
  {$REGION 'TGetterMigrations'}
    /// <Description>
    ///  Standard class to get a list of registered´s migration.
    /// </Description>
    /// <Responsability>
    ///  Get a subset os items from a inputted list, based on the start parameter.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TGetterMigrations = class(TInterfacedObject, IGetterMigrations)
  private
    FMainMigrationGetter: IMainMigrationsGetter;
    FSequenceMigrationGetter: ISequenceMigrationsGetter;
    FDatetimeMigrationGetter: IDatetimeMigrationsGetter;

  public
    constructor Create; reintroduce;

    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer): TList<IMigration>; overload;
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDateTime): TList<IMigration>; overload;
  end;

implementation

uses
  System.SysUtils, M4D.MainMigrationsGetter, M4D.SequenceMigrationsGetter,
  M4D.DatetimeMigrationsGetter;

{ TGetterMigrations }

constructor TGetterMigrations.Create;
begin
  inherited Create;

  FMainMigrationGetter := TMainMigrationsGetter.Create;
  FSequenceMigrationGetter := TSequenceMigrationsGetter.Create;
  FDatetimeMigrationGetter := TDatetimeMigrationsGetter.Create;
end;

function TGetterMigrations.getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer): TList<IMigration>;
begin
  Result := FSequenceMigrationGetter.getMigrations(AMigrationsList, AStartMigrationSeq, FMainMigrationGetter);
end;

function TGetterMigrations.getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationDateTime: TDateTime): TList<IMigration>;
begin
  Result := FDatetimeMigrationGetter.getMigrations(AMigrationsList, AStartMigrationDateTime, FMainMigrationGetter);
end;

end.
