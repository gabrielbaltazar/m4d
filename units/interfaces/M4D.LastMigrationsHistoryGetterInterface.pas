{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.LastMigrationsHistoryGetterInterface;

interface

uses
  M4D.MigrationsHistoryItem;

type
  {$REGION 'ILastMigrationsHistoryGetter'}
    /// <Description>
    ///  Standard interface to get the last migration from a migrations history.
    /// </Description>
  {$ENDREGION}
  ILastMigrationsHistoryGetter = interface
  ['{BF1B62A9-2531-434F-A070-605BC10C6ADB}']
    {$REGION 'ILastMigrationsHistoryGetter.LastMigration'}
      /// <Description>
      ///  Get the last migration from the migration´s history.
      /// </Description>
    {$ENDREGION}
    function LastMigration: TMigrationsHistoryItem;
  end;

implementation

end.
