{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 31/08/2017
Use licence: See the license file

######################################################################################}

unit M4D.MigrationSerializerFacade;

interface

uses
  M4D.MigrationSerializerFacadeInterface, M4D.MigrationsHistoryItem, Data.DBXJSONReflect,
  M4D.HistoryToTextTransformerInterface, M4D.TextToHistoryTransformerInterface;

type
  {$REGION 'TMigrationSerializerFacade'}
    /// <Description>
    ///  Standard class to convert between string values and history items.
    /// </Description>
    /// <Responsability>
    ///  Performs converters between string values and history items.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrationSerializerFacade = class(TInterfacedObject, IMigrationSerializerFacade)
  private
    FHistoryToTextTransformer: IHistoryToTextTransformer;
    FTextToHistoryTransformer: ITextToHistoryTransformer;
  public
    constructor Create; reintroduce;
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;

implementation

uses
  System.JSON, System.SysUtils, M4D.HistoryToTextTransformer,
  M4D.TextToHistoryTransformer;

{ TMigrationSerializerFacade }

constructor TMigrationSerializerFacade.Create;
begin
  inherited Create;

  FHistoryToTextTransformer := THistoryToTextTransformer.Create;
  FTextToHistoryTransformer := TTextToHistoryTransformer.Create;
end;

function TMigrationSerializerFacade.HistoryToText(AItem: TMigrationsHistoryItem): string;
begin
  Result := FHistoryToTextTransformer.HistoryToText(AItem);
end;

function TMigrationSerializerFacade.TextToHistory(AValue: string): TMigrationsHistoryItem;
begin
  Result := FTextToHistoryTransformer.TextToHistory(AValue);
end;

end.
