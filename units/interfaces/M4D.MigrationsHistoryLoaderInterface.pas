{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryLoaderInterface;

interface

type
  {$REGION 'IMigrationsHistoryLoader'}
    /// <Description>
    ///  Standard interface to load migrations history.
    /// </Description>
  {$ENDREGION}
  IMigrationsHistoryLoader = interface
  ['{6CBBDDB8-01B2-41C9-9366-BE39930D7A43}']
    {$REGION 'IMigrationsHistoryLoader.Load'}
      /// <Description>
      ///  Load the migration´s history.
      /// </Description>
    {$ENDREGION}
    procedure Load;
  end;

implementation

end.
