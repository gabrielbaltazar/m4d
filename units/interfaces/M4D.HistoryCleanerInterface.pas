{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.HistoryCleanerInterface;

interface

type
  {$REGION 'IHistoryCleaner'}
    /// <Description>
    ///  Standard interface to clear migrations´s executions history.
    /// </Description>
  {$ENDREGION}
  IHistoryCleaner = interface
  ['{C7C5EEB3-9C17-4C95-9CE4-7A4DED0E1AA6}']
    {$REGION 'IHistoryCleaner.Clear'}
      /// <Description>
      ///  Clear the history info.
      /// </Description>
    {$ENDREGION}
    procedure Clear;
  end;

implementation

end.
