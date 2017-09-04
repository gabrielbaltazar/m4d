unit UMigrationListOrderInterface;

interface

uses
  UMigrationsInterface, System.Generics.Defaults;

type
  {$REGION 'IMigrationListOrder'}
    /// <Description>
    ///  Standard method to sort the migration list.
    /// </Description>
  {$ENDREGION}
  IMigrationListOrder = interface
    ['{34BA6E20-B893-4665-B6EE-E72A6640E17D}']
    {$REGION 'IMigrationListOrder.Comparison'}
      /// <Description>
      ///  Sorts the list of migrations.
      /// </Description>
      /// <Note>
      ///  This method will define the order of the migration´s executions and rollbacks.
      /// </Note>
    {$ENDREGION}
    function Comparison: TComparison<TClass>;
  end;

implementation

end.
