{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.HistoryToTextTransformerInterface;

interface

uses
  M4D.MigrationsHistoryItem;

type
  {$REGION 'IHistoryToTextTransformer'}
    /// <Description>
    ///  Standard interface to convert from history item to string value.
    /// </Description>
  {$ENDREGION}
  IHistoryToTextTransformer = interface
  ['{F9650EEC-B3D0-47E7-994B-46D7B8DFDB2B}']
    {$REGION 'IHistoryToTextTransformer.HistoryToText'}
      /// <Description>
      ///  Convert a history item to a string value.
      /// </Description>
      /// <InputParameters>
      ///  AItem - The history item that will be converted.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Result - String value of conversion of the history item.
      /// </OutputParameters>
    {$ENDREGION}
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
  end;

implementation

end.
