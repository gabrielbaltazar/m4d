{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.LastMigrationsHistoryGetter;

interface

uses
  M4D.LastMigrationsHistoryGetterInterface, M4D.MigrationsHistoryItem,
  System.Generics.Collections;

type
  {$REGION 'TLastMigrationsHistoryGetter'}
    /// <Description>
    ///  Standard class to get the last migration from the migration´s history.
    /// </Description>
    /// <Responsability>
    ///  Get the last migration from the history of migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TLastMigrationsHistoryGetter = class(TInterfacedObject, ILastMigrationsHistoryGetter)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
    function LastMigration: TMigrationsHistoryItem;
  end;

implementation

uses
  System.SysUtils;

{ TLastMigrationsHistoryGetter }

constructor TLastMigrationsHistoryGetter.Create(AHistoryList: TObjectList<TMigrationsHistoryItem>);
begin
  if not Assigned(AHistoryList) then
  begin
    raise Exception.Create('The parameter AHistoryList must not be nil.');
  end
  else
  begin
    inherited Create;

    FHistoryList := AHistoryList;
  end;
end;

function TLastMigrationsHistoryGetter.LastMigration: TMigrationsHistoryItem;
begin
  Result := nil;

  if Assigned(FHistoryList) then
  begin
    if FHistoryList.Count > 0 then
    begin
      FHistoryList.Sort;
      Result := FHistoryList.Last;
    end;
  end;
end;

end.
