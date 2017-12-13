{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationSerializerFacadeInterface;

interface

uses
  M4D.MigrationsHistoryItem;

type
  {$REGION 'IMigrationSerializerFacade'}
    /// <Description>
    ///  Standard method to serialize informations of the items of migrations.
    /// </Description>
  {$ENDREGION}
  IMigrationSerializerFacade = interface
  ['{1E3E8A3D-4994-4C4C-8911-2A4C2371B4A9}']
    {$REGION 'IMigrationSerializerFacade.HistoryToText'}
      /// <Description>
      ///  Convert the type TMigrationsHistoryItem into string.
      /// </Description>
      /// <InputParameters>
      ///  AItem - The history item that will be converted to string.
      ///  Return - A string value converted from the history item.
      /// </InputParameters>
    {$ENDREGION}
    function HistoryToText(AItem: TMigrationsHistoryItem): string;
    {$REGION 'IMigrationSerializerFacade.TextToHistory'}
      /// <Description>
      ///  Convert the string value into a history item.
      /// </Description>
      /// <InputParameters>
      ///  AValue - String value that will be converted to history item.
      ///  Return - A history item converted from the string value.
      /// </InputParameters>
    {$ENDREGION}
    function TextToHistory(AValue: string): TMigrationsHistoryItem;
  end;

implementation

end.
