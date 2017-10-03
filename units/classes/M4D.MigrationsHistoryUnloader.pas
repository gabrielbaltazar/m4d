{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryUnloader;

interface

uses
  M4D.MigrationsHistoryUnloaderInterface, System.Classes;

type
  {$REGION 'TMigrationsHistoryUnloader'}
    /// <Description>
    ///  Standard class to unload migration´s history.
    /// </Description>
    /// <Responsability>
    ///  Unload the history of migrations.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsHistoryUnloader = class(TInterfacedObject, IMigrationsHistoryUnloader)
  private
    FFile: TStringList;
  public
    constructor Create(AFile: TStringList); reintroduce;
    procedure UnLoad;
  end;

implementation

uses
  System.SysUtils;

{ TMigrationsHistoryUnloader }

constructor TMigrationsHistoryUnloader.Create(AFile: TStringList);
begin
  if not Assigned(AFile) then
  begin
    raise Exception.Create('The parameter AFile must not be nil.');
  end
  else
  begin
    inherited Create;

    FFile := AFile;
  end;
end;

procedure TMigrationsHistoryUnloader.UnLoad;
begin
  if Assigned(FFile) then FreeAndNil(FFile);
//  Self.FLoaded := False;
end;

end.
