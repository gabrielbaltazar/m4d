{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 31/08/2017
Use licence: See the license file

######################################################################################}

unit M4D.MigrationSerializer;

interface

uses
  M4D.MigrationSerializerInterface, M4D.MigrationsHistoryItem, Data.DBXJSONReflect,
  M4D.HistoryToTextTransformerInterface, M4D.TextToHistoryTransformerInterface;

type
  {$REGION 'TMigrationSerializer'}
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
  TMigrationSerializer = class(TInterfacedObject, IMigrationSerializer)
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

{ TMigrationSerializer }

constructor TMigrationSerializer.Create;
begin
  inherited Create;

  FHistoryToTextTransformer := THistoryToTextTransformer.Create;
  FTextToHistoryTransformer := TTextToHistoryTransformer.Create;
end;

function TMigrationSerializer.HistoryToText(AItem: TMigrationsHistoryItem): string;
begin
  Result := FHistoryToTextTransformer.HistoryToText(AItem);
end;

function TMigrationSerializer.TextToHistory(AValue: string): TMigrationsHistoryItem;
begin
  Result := FTextToHistoryTransformer.TextToHistory(AValue);
end;

end.
