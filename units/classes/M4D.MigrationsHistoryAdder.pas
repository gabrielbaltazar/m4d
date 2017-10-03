{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryAdder;

interface

uses
  M4D.MigrationsHistoryAdderInterface, M4D.MigrationsHistoryItem,
  Generics.Collections;

type
  {$REGION 'TMigrationsHistoryAdder'}
    /// <Description>
    ///  Standard class to add a migration into a migration´s history.
    /// </Description>
    /// <Responsability>
    ///  Add a migration into the history of migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsHistoryAdder = class(TInterfacedObject, IMigrationsHistoryAdder)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>); reintroduce;
    procedure Add(AItem: TMigrationsHistoryItem);
  end;

implementation

uses
  System.SysUtils;

{ TMigrationsHistoryAdder }

procedure TMigrationsHistoryAdder.Add(AItem: TMigrationsHistoryItem);
begin
  if not Assigned(AItem) then
  begin
    raise Exception.Create('The parameter AItem must not be nil.');
  end
  else
  begin
    FHistoryList.Add(AItem);
    FHistoryList.Sort;
  end;
end;

constructor TMigrationsHistoryAdder.Create(AHistoryList: TObjectList<TMigrationsHistoryItem>);
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

end.
