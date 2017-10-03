{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.HistoryGetterInterface;

interface

uses
  System.SysUtils, Generics.Collections, M4D.MigrationsHistoryItem;

type
  {$REGION 'IMigrationHistoryGetter'}
    /// <Description>
    ///  Standard interface to get a migration from a migrations history.
    /// </Description>
  {$ENDREGION}
  IMigrationHistoryGetter = interface
  ['{DC1023F7-5698-4754-AF3C-FF9FBDB1FD88}']
    {$REGION 'IMigrationHistoryGetter.getHistory'}
      /// <Description>
      ///  Get a migration from the migration´s history.
      /// </Description>
    {$ENDREGION}
    function getHistory(APredicate: TPredicate<TMigrationsHistoryItem>): TList<TMigrationsHistoryItem>; overload;
  end;

implementation

end.
