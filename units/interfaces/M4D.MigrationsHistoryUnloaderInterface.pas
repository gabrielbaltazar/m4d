{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryUnloaderInterface;

interface

type
  {$REGION 'IMigrationsHistoryUnloader'}
    /// <Description>
    ///  Standard interface to unload migrations history.
    /// </Description>
  {$ENDREGION}
  IMigrationsHistoryUnloader = interface
  ['{097139C8-CFBA-4542-BB72-ECD3821A6713}']
    {$REGION 'IMigrationsHistoryUnloader.UnLoad'}
      /// <Description>
      ///  Unload the migration´s history.
      /// </Description>
    {$ENDREGION}
    procedure UnLoad;
  end;

implementation

end.
