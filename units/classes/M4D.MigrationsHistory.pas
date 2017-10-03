{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 31/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistory;

interface

uses
  M4D.MigrationsHistoryInterface, M4D.MigrationsHistoryItem, Generics.Collections,
  M4D.MigrationSerializer, M4D.MigrationSerializerInterface, M4D.MigrationsInterface,
  System.Classes, System.SysUtils, M4D.GetterMigrationsInterface, System.Generics.Defaults,
  M4D.HistoryCleanerInterface, M4D.MigrationsHistoryLoaderInterface,
  M4D.MigrationsHistoryUnloaderInterface, M4D.MigrationsHistoryAdderInterface,
  M4D.MigrationsHistoryRemoverInterface, M4D.MigrationsHistorySaverInterface,
  M4D.LastMigrationsHistoryGetterInterface, M4D.HistoryGetterInterface;

type
  {$M+}
  {$REGION 'TMigrationsHistory'}
    /// <Description>
    ///  Standard class for handling information about the history of migrations´s executions.
    /// </Description>
    /// <Responsability>
    ///  Handle informations about the history of migrations´s executions.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationsHistory = class(TInterfacedObject, IMigrationsHistory)
  private
    FHistoryList: TObjectList<TMigrationsHistoryItem>;
    FPath: string;
    FFile: TStringList;
    FSerializer: IMigrationSerializer;
    FLoaded: Boolean;
    FCompare: IComparer<TMigrationsHistoryItem>;

    FCleaner: IHistoryCleaner;
    FLoader: IMigrationsHistoryLoader;
    FUnLoader: IMigrationsHistoryUnLoader;
    FAdder: IMigrationsHistoryAdder;
    FRemover: IMigrationsHistoryRemover;
    FSaver: IMigrationsHistorySaver;
    FMigrationGetter: IMigrationHistoryGetter;
    FLastMigrationGetter: ILastMigrationsHistoryGetter;

//    function getHistory(APredicate: TPredicate<TMigrationsHistoryItem>): TList<TMigrationsHistoryItem>; overload;
    function getHistory: TList<TMigrationsHistoryItem>; overload;
  public
    constructor Create(APath: string; ASerializer: IMigrationSerializer); reintroduce;
    destructor Destroy; override;

    procedure Clear;
    procedure Load;
    procedure UnLoad;
    procedure Add(AItem: TMigrationsHistoryItem);
    procedure Remove(AMigrationSequence: Integer);
    function getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>; overload;
    function getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>; overload;
    function getHistory(AMigrationVersion: string): TList<TMigrationsHistoryItem>; overload;
    procedure Save;
    function LastMigration: TMigrationsHistoryItem;
  published
    property Path: string read FPath;
    property HistoryList: TList<TMigrationsHistoryItem> read getHistory;
  end;

implementation

uses
  M4D.HistoryCleaner, M4D.MigrationsHistoryLoader,
  M4D.MigrationsHistoryUnloader, M4D.MigrationsHistoryAdder,
  M4D.MigrationsHistoryRemover, M4D.MigrationsHistorySaver,
  M4D.LastMigrationsHistoryGetter, M4D.HistoryGetter;

{ TMigrationsHistory }

procedure TMigrationsHistory.Add(AItem: TMigrationsHistoryItem);
begin
//  if not Assigned(AItem) then
//  begin
//    raise Exception.Create('The parameter AItem must not be nil.');
//  end
//  else
//  begin
//    FHistoryList.Add(AItem);
//    FHistoryList.Sort;
//  end;

  FAdder.Add(AItem);
end;

procedure TMigrationsHistory.Clear;
begin
//  FHistoryList.Clear;
//  FFile.Clear;
//  if FileExists(FPath) then
//  begin
//    if not DeleteFile(FPath) then
//    begin
//      raise Exception.Create('Could not delete file ' + FPath);
//    end;
//  end;

  FCleaner.Clear;
end;

constructor TMigrationsHistory.Create(APath: string; ASerializer: IMigrationSerializer);
var
  LComparison: TComparison<TMigrationsHistoryItem>;
begin
  if APath = '' then
  begin
    raise Exception.Create('The parameter APath must not be empty.');
  end
  else
  begin
    if not Assigned(ASerializer) then
    begin
      raise Exception.Create('Invalida parametrer ASerializer. The parameter must no be nil.');
    end
    else
    begin
      inherited Create;

      Self.FLoaded := False;

      FPath := APath;

      FSerializer := ASerializer;

      LComparison := function(const Left, Right: TMigrationsHistoryItem): Integer
                     begin
                       Result := Left.MigrationSeq - Right.MigrationSeq;
                     end;

      FCompare := TComparer<TMigrationsHistoryItem>.Construct(LComparison) as TDelegatedComparer<TMigrationsHistoryItem>;
      FHistoryList := TObjectList<TMigrationsHistoryItem>.Create(FCompare);

      FFile := TStringList.Create;
      FCleaner := THistoryCleaner.Create(FHistoryList, FFile, FPath);
      FLoader := TMigrationsHistoryLoader.Create(FHistoryList, FFile, FPath, FSerializer);
      FUnLoader := TMigrationsHistoryUnLoader.Create(FFile);
      FAdder := TMigrationsHistoryAdder.Create(FHistoryList);
      FRemover := TMigrationsHistoryRemover.Create(FHistoryList);
      FSaver := TMigrationsHistorySaver.Create(FHistoryList, FFile, FPath, FSerializer);
      FMigrationGetter := TMigrationHistoryGetter.Create(FHistoryList);
      FLastMigrationGetter := TLastMigrationsHistoryGetter.Create(FHistoryList);
    end;
  end;
end;

destructor TMigrationsHistory.Destroy;
begin
  Self.UnLoad;

  if Assigned(FHistoryList) then FreeAndNil(FHistoryList);

  inherited;
end;

function TMigrationsHistory.getHistory(AStartMigrationDateTime: TDateTime): TList<TMigrationsHistoryItem>;
begin
//  Result := Self.getHistory(function(Item: TMigrationsHistoryItem): boolean
//                            begin
//                              Result := Item.MigrationDateTime >= AStartMigrationDateTime;
//                            end);

  Result := FMigrationGetter.getHistory(function(Item: TMigrationsHistoryItem): boolean
                                        begin
                                          Result := Item.MigrationDateTime >= AStartMigrationDateTime;
                                        end);
end;

function TMigrationsHistory.getHistory(AStartMigrationSeq: Integer): TList<TMigrationsHistoryItem>;
begin
//  Result := Self.getHistory(function(Item: TMigrationsHistoryItem): boolean
//                            begin
//                              Result := Item.MigrationSeq >= AStartMigrationSeq;
//                            end);

  Result := FMigrationGetter.getHistory(function(Item: TMigrationsHistoryItem): boolean
                                        begin
                                          Result := Item.MigrationSeq >= AStartMigrationSeq;
                                        end);
end;

function TMigrationsHistory.getHistory: TList<TMigrationsHistoryItem>;
begin
  if not Self.FLoaded then Self.Load;

  FHistoryList.Sort;
  Result := FHistoryList;
end;

function TMigrationsHistory.LastMigration: TMigrationsHistoryItem;
begin
//  Result := nil;
//
//  if Assigned(FHistoryList) then
//  begin
//    if FHistoryList.Count > 0 then
//    begin
//      FHistoryList.Sort;
//      Result := FHistoryList.Last;
//    end;
//  end;

  Result := FLastMigrationGetter.LastMigration;
end;

procedure TMigrationsHistory.Load;
//var
//  I: Integer;
//  Aux: string;
begin
//  FFile := TStringList.Create;
//  FFile.Clear;
//  if FileExists(FPath) then FFile.LoadFromFile(FPAth);
//
//  FHistoryList.Clear;
//  for I := 0 to FFile.Count - 1 do
//  begin
//    Aux := FFile.Strings[I];
//    FHistoryList.Add(FSerializer.TextToHistory(Aux));
//  end;

  FLoader.Load;

  Self.FLoaded := True;
end;

procedure TMigrationsHistory.Remove(AMigrationSequence: Integer);
//var
//  Item: TMigrationsHistoryItem;
begin
//  for Item in FHistoryList do
//  begin
//    if Item.MigrationSeq = AMigrationSequence then
//    begin
//      FHistoryList.Remove(Item);
//      FHistoryList.Sort;
//      Break;
//    end;
//  end;

  FRemover.Remove(AMigrationSequence);
end;

procedure TMigrationsHistory.Save;
//var
//  Item: TMigrationsHistoryItem;
//  Continue: Boolean;
begin
//  FFile.Clear;
//
//  for Item in FHistoryList do
//  begin
//    FFile.Add(FSerializer.HistoryToText(Item));
//  end;
//
//  Continue := True;
//
//  if FileExists(FPAth) then
//  begin
//    Continue := DeleteFile(FPath);
//    if not Continue then
//    begin
//      raise Exception.Create('An error occurred while trying to delete the file ' + FPath);
//    end
//  end;
//
//  if Continue then
//  begin
//    FFile.SaveToFile(FPath);
//  end;
  FSaver.Save;
end;

procedure TMigrationsHistory.UnLoad;
begin
//  if Assigned(FFile) then FreeAndNil(FFile);

  FUnLoader.UnLoad;

  Self.FLoaded := False;
end;

function TMigrationsHistory.getHistory(AMigrationVersion: string): TList<TMigrationsHistoryItem>;
begin
//  Result := Self.getHistory(function(Item: TMigrationsHistoryItem): boolean
//                            begin
//                              Result := Item.MigrationVersion = AMigrationVersion;
//                            end);

  Result := FMigrationGetter.getHistory(function(Item: TMigrationsHistoryItem): boolean
                                        begin
                                          Result := Item.MigrationVersion = AMigrationVersion;
                                        end);
end;

//function TMigrationsHistory.getHistory(APredicate: TPredicate<TMigrationsHistoryItem>): TList<TMigrationsHistoryItem>;
//var
//  Item: TMigrationsHistoryItem;
//begin
//  Result := nil;
//
//  if not Self.FLoaded then Self.Load;
//
//  for Item in FHistoryList do
//  begin
//    if APredicate(Item) then
//    begin
//      if not Assigned(Result) then Result := TList<TMigrationsHistoryItem>.Create;
//
//      Result.Add(Item);
//    end;
//  end;
//end;

end.

