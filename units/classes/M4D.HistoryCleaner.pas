{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.HistoryCleaner;

interface

uses
  System.Generics.Collections, M4D.HistoryCleanerInterface, M4D.MigrationsHistoryItem,
  System.Classes;

type
  {$REGION 'THistoryCleaner'}
    /// <Description>
    ///  Standard class for clear the history of migrations´s executions.
    /// </Description>
    /// <Responsability>
    ///  Clear the history of migrations´s executions.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  THistoryCleaner = class(TInterfacedObject, IHistoryCleaner)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FFile: TStringList;
    FPath: string;
  public
    constructor Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string); reintroduce;
    procedure Clear;
  end;

implementation

uses
  {$IF Defined(POSIX)} Posix.Unistd, {$ENDIF}
  System.SysUtils;

{ THistoryCleaner }

procedure THistoryCleaner.Clear;
begin
  FHistoryList.Clear;
  FFile.Clear;
  if FileExists(FPath) then
  begin
    if not DeleteFile(FPath) then
    begin
      raise Exception.Create('Could not delete file ' + FPath);
    end;
  end;
end;

constructor THistoryCleaner.Create(AHistoryList: TObjectList<TMigrationsHistoryItem>; AFile: TStringList; APath: string);
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
        inherited Create;

        FHistoryList := AHistoryList;
        FFile := AFile;
        FPath := APath;
      end;
    end;
  end;
end;

end.
