{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryLoader;

interface

uses
  M4D.MigrationsHistoryLoaderInterface, System.Classes,
  System.Generics.Collections, M4D.MigrationsHistoryItem,
  M4D.MigrationSerializerInterface;

type
  {$REGION 'TMigrationsHistoryLoader'}
    /// <Description>
    ///  Standard class to load migration´s history.
    /// </Description>
    /// <Responsability>
    ///  Load the history of migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsHistoryLoader = class(TInterfacedObject, IMigrationsHistoryLoader)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: String;
    FSerializer: IMigrationSerializer;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string; ASerializer: IMigrationSerializer); reintroduce;
    procedure Load;
  end;

implementation

uses
  System.SysUtils;

{ TMigrationsHistoryLoader }

constructor TMigrationsHistoryLoader.Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string; ASerializer: IMigrationSerializer);
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
        if not Assigned(ASerializer) then
        begin
          raise Exception.Create('The parameter ASerializer must not be nil.');
        end
        else
        begin
          inherited Create;

          FHistoryList:= AHistoryList;
          FFile := AFile;
          FPath:= APath;
          FSerializer := ASerializer;
        end;
      end;
    end;
  end;
end;

procedure TMigrationsHistoryLoader.Load;
var
  I: Integer;
  Aux: string;
begin
//  FFile := TStringList.Create;
  FFile.Clear;
  if FileExists(FPath) then FFile.LoadFromFile(FPAth);

  FHistoryList.Clear;
  for I := 0 to FFile.Count - 1 do
  begin
    Aux := FFile.Strings[I];
    FHistoryList.Add(FSerializer.TextToHistory(Aux));
  end;

//  Self.FLoaded := True;
end;

end.
