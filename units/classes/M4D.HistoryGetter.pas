{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.HistoryGetter;

interface

uses
  M4D.HistoryGetterInterface, Generics.Collections,
  M4D.MigrationsHistoryItem, System.SysUtils;

type
  {$REGION 'TMigrationHistoryGetter'}
    /// <Description>
    ///  Standard class to get a migration from the migration´s history.
    /// </Description>
    /// <Responsability>
    ///  Get a migration from the history of migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationHistoryGetter = class(TInterfacedObject, IMigrationHistoryGetter)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
     function getHistory(APredicate: TPredicate<TMigrationsHistoryItem>): TList<TMigrationsHistoryItem>;
  end;

implementation

{ THistoryGetter }

constructor TMigrationHistoryGetter.Create(AHistoryList: TObjectList<TMigrationsHistoryItem>);
begin
  if not Assigned(AHistoryList) then
  begin
    raise Exception.Create('The parameter AHistoryList mjuust not be nil.');
  end
  else
  begin
    inherited Create;

    FHistoryList := AHistoryList;
  end;
end;

function TMigrationHistoryGetter.getHistory(APredicate: TPredicate<TMigrationsHistoryItem>): TList<TMigrationsHistoryItem>;
var
  Item: TMigrationsHistoryItem;
begin
  Result := nil;

//  if not Self.FLoaded then Self.Load;

  for Item in FHistoryList do
  begin
    if APredicate(Item) then
    begin
      if not Assigned(Result) then Result := TList<TMigrationsHistoryItem>.Create;

      Result.Add(Item);
    end;
  end;
end;

end.
