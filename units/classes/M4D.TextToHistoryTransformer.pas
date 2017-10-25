{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.TextToHistoryTransformer;

interface

uses
  M4D.TextToHistoryTransformerInterface, M4D.MigrationsHistoryItem;

type
  {$REGION 'TTextToHistoryTransformer'}
    /// <Description>
    ///  Standard class to convert from string value to history item.
    /// </Description>
    /// <Responsability>
    ///  Performs converters between string values to history items.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TTextToHistoryTransformer = class(TInterfacedObject, ITextToHistoryTransformer)
  public
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;

implementation

uses
  Data.DBXJSONReflect, System.JSON, System.SysUtils;

{ TTextToHistoryTransformer }

function TTextToHistoryTransformer.TextToHistory(AValue: string): TMigrationsHistoryItem;
var
  Marshal: TJSONUnMarshal;
  Aux: TJSONObject;
begin
  if AValue = '' then
  begin
    raise Exception.Create('Invalid value to TMigrationSerializer.TextToHistory.');
  end
  else
  begin
    Marshal := TJSONUnMarshal.Create;
    try
      Aux := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AValue), 0) as TJSONObject;
      try
         Result := Marshal.UnMarshal(Aux) as TMigrationsHistoryItem;
      finally
        Aux.Free;
      end;
    finally
      Marshal.Free;
    end;
  end;
end;

end.
