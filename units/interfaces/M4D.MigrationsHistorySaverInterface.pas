{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistorySaverInterface;

interface

type
  {$REGION 'IMigrationsHistorySaver'}
    /// <Description>
    ///  Standard interface to save the migrations history.
    /// </Description>
  {$ENDREGION}
  IMigrationsHistorySaver = interface
  ['{9D801497-2331-4CF8-BE3C-F32683B2A741}']
    {$REGION 'IMigrationsHistorySaver.Save'}
      /// <Description>
      ///  Save the migration´s history.
      /// </Description>
    {$ENDREGION}
    procedure Save;
  end;

implementation

end.
