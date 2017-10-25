{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MainMigrationsGetter;

interface

uses
  Generics.Collections, System.SysUtils, M4D.MigrationsInterface,
  M4D.MainMigrationsGetterInterface;

type
  {$REGION 'TMainMigrationsGetter'}
    /// <Description>
    ///  Standard base class to get a list of registered´s migration.
    /// </Description>
    /// <Responsability>
    ///  Be a base class to get a subset os items from a inputted list, based on the start parameter.
    /// </Responsability>
    /// <Note>
    ///  There are other specialized classes that use this class as the default search..
    /// </Note>
  {$ENDREGION}
  TMainMigrationsGetter = class(TInterfacedObject, IMainMigrationsGetter)
  public
    {$REGION 'TMainMigrationsGetter.getMigrations'}
      /// <Description>
      ///  Method that returns migrations from a list of migrations based on the rules of the predicate.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - List of migrations being considered for return.
      ///  APredicate - The predicate is used to determine which migrations will be returned.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Result - The list of migrations determined by the predicate.
      /// </OutputParameters>
    {$ENDREGION}
    function getMigrations(AMigrationsList: TList<IMigration>; APredicate: TPredicate<IMigration>): TList<IMigration>;
  end;

implementation


{ TMainMigrationsGetter }

function TMainMigrationsGetter.getMigrations(AMigrationsList: TList<IMigration>; APredicate: TPredicate<IMigration>): TList<IMigration>;
var
  I: Integer;
begin
  Result := nil;

  if Assigned(AMigrationsList) then
  begin
    for I := 0 to AMigrationsList.Count - 1 do
    begin
      if APredicate(AMigrationsList[I]) then
      begin
        if not Assigned(Result) then Result := TList<IMigration>.Create;

        Result.Add(AMigrationsList[I]);
      end;
    end;
  end;
end;

end.
