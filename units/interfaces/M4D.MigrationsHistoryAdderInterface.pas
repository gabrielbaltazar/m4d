{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 20/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationsHistoryAdderInterface;

interface

uses
  M4D.MigrationsHistoryItem;

type
  {$REGION 'IMigrationsHistoryAdder'}
    /// <Description>
    ///  Standard interface to add migrations into a migrations history.
    /// </Description>
  {$ENDREGION}
  IMigrationsHistoryAdder = interface
  ['{82C95471-F422-4E14-B6D8-BA61C2969805}']
    {$REGION 'IMigrationsHistoryAdder.Add'}
      /// <Description>
      ///  Add a migration into the migration´s history.
      /// </Description>
    {$ENDREGION}
    procedure Add(AItem: TMigrationsHistoryItem);
  end;

implementation

end.
