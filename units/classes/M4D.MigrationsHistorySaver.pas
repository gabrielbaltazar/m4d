{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistorySaver;

interface

uses
  M4D.MigrationsHistorySaverInterface, M4D.MigrationsHistoryItem, System.Classes,
  System.Generics.Collections, M4D.MigrationSerializerFacadeInterface;

type
  {$REGION 'TMigrationsHistorySaver'}
    /// <Description>
    ///  Standard class to save the migration´s history.
    /// </Description>
    /// <Responsability>
    ///  Save the history of migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsHistorySaver = class(TInterfacedObject, IMigrationsHistorySaver)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: string;
    FSerializerFacade: IMigrationSerializerFacade;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string; ASerializerFacade: IMigrationSerializerFacade); reintroduce;
    procedure Save;
  end;

implementation

uses
  {$IF Defined(POSIX)} Posix.Unistd, {$ENDIF}
  System.SysUtils;

{ TMigrationsHistorySaver }

constructor TMigrationsHistorySaver.Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string; ASerializerFacade: IMigrationSerializerFacade);
begin
  if not Assigned(AHistoryList) then
  begin
    raise Exception.Create('The parameter AHistoryList must not be nil.');
  end
  else
  begin
    if not Assigned(AFile) then
    begin
      raise Exception.Create('The parameter AFile must not be nil.');
    end
    else
    begin
      if Trim(APath) = '' then
      begin
        raise Exception.Create('The parameter APath must not be empty.');
      end
      else
      begin
        if not Assigned(ASerializerFacade) then
        begin
          raise Exception.Create('The parameter ASerializer must not be nil.');
        end
        else
        begin
          inherited Create;

          FHistoryList:= AHistoryList;
          FFile := AFile;
          FPath:= APath;
          FSerializerFacade := ASerializerFacade;
        end;
      end;
    end;
  end;
end;

procedure TMigrationsHistorySaver.Save;
var
  Item: TMigrationsHistoryItem;
  Continue: Boolean;
begin
  FFile.Clear;

  for Item in FHistoryList do
  begin
    FFile.Add(FSerializerFacade.HistoryToText(Item));
  end;

  Continue := True;

  if FileExists(FPAth) then
  begin
    Continue := DeleteFile(FPath);
    if not Continue then
    begin
      raise Exception.Create('An error occurred while trying to delete the file ' + FPath);
    end
  end;

  if Continue then
  begin
    FFile.SaveToFile(FPath);
  end;
end;

end.
