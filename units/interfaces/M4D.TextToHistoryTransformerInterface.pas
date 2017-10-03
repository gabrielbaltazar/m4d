{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.TextToHistoryTransformerInterface;

interface

uses
  M4D.MigrationsHistoryItem;

type
  {$REGION 'ITextToHistoryTransformer'}
    /// <Description>
    ///  Standard interface to convert from string value to history item.
    /// </Description>
  {$ENDREGION}
  ITextToHistoryTransformer = interface
  ['{0B3B46FA-BBA3-4AF9-B499-517E45281509}']
    {$REGION 'ITextToHistoryTransformer.TextToHistory'}
      /// <Description>
      ///  Convert a string value to a history item.
      /// </Description>
      /// <InputParameters>
      ///  AItem - The string value that will be converted.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Result - History item from conversion of the string value.
      /// </OutputParameters>
    {$ENDREGION}
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;

implementation

end.
