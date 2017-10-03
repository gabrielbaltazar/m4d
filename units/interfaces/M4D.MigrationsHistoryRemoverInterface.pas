{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryRemoverInterface;

interface

type
  {$REGION 'IMigrationsHistoryRemover'}
    /// <Description>
    ///  Standard interface to remove migrations from a migrations history.
    /// </Description>
  {$ENDREGION}
  IMigrationsHistoryRemover = interface
  ['{9DC85F6D-D338-4A00-9365-A3C6E9EBA71D}']
    {$REGION 'IMigrationsHistoryRemover.Remove'}
      /// <Description>
      ///  Remove a migration from the migration´s history.
      /// </Description>
    {$ENDREGION}
    procedure Remove(AMigrationSequence: Integer);
  end;

implementation

end.
