{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryRemover;

interface

uses
  M4D.MigrationsHistoryRemoverInterface, M4D.MigrationsHistoryItem, System.Generics.Collections;

type
  {$REGION 'TMigrationsHistoryRemover'}
    /// <Description>
    ///  Standard class to remove a migration into a migration´s history.
    /// </Description>
    /// <Responsability>
    ///  Remove a migration into the history of migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsHistoryRemover = class(TInterfacedObject, IMigrationsHistoryRemover)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
    procedure Remove(AMigrationSequence: Integer);
  end;

implementation

uses
  System.SysUtils;

{ TMigrationsHistoryRemover }

constructor TMigrationsHistoryRemover.Create(AHistoryList: TObjectList<TMigrationsHistoryItem>);
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

procedure TMigrationsHistoryRemover.Remove(AMigrationSequence: Integer);
var
  Item: TMigrationsHistoryItem;
begin
  for Item in FHistoryList do
  begin
    if Item.MigrationSeq = AMigrationSequence then
    begin
      FHistoryList.Remove(Item);
      FHistoryList.Sort;
      Break;
    end;
  end;
end;

end.
