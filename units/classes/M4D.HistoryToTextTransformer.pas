{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.HistoryToTextTransformer;

interface

uses
  M4D.HistoryToTextTransformerInterface, M4D.MigrationsHistoryItem;

type
  {$REGION 'THistoryToTextTransformer'}
    /// <Description>
    ///  Convert history item to string value.
    /// </Description>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  THistoryToTextTransformer = class(TInterfacedObject, IHistoryToTextTransformer)
  public
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
  end;

implementation

uses
  Data.DBXJSONReflect, System.JSON;

{ THistoryToTextTransformer }

function THistoryToTextTransformer.HistoryToText(AItem: TMigrationsHistoryItem): string;
var
  Marshal: TJSONMarshal;
  Aux: TJSONObject;
begin
  Result := '';

  if Assigned(AItem) then
  begin
    Marshal := TJSONMarshal.Create(TJSONConverter.Create);
    try
      Aux := Marshal.Marshal(AItem) as TJSONObject;
      try
        Result := Aux.ToString;
      finally
        Aux.Free;
      end;
    finally
      Marshal.Free;
    end;
  end;
end;

end.
