{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 18/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.SequenceMigrationsGetter;

interface

uses
  Generics.Collections, M4D.MigrationsInterface,
  M4D.MainMigrationsGetterInterface, M4D.SequenceMigrationsGetterInterface;

type
  {$REGION 'TSequenceMigrationsGetter'}
    /// <Description>
    ///  Standard class to get a list of registered´s migration base on the sequence.
    /// </Description>
    /// <Responsability>
    ///  Get a subset os items from a inputted list, based on the start parameter.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TSequenceMigrationsGetter = class(TInterfacedObject, ISequenceMigrationsGetter)
  public
    {$REGION 'TSequenceMigrationsGetter.getMigrations'}
      /// <Description>
      ///  Method that returns migrations from a list of migrations based on the sequence.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - List of migrations being considered for return.
      ///  AStartMigrationSeq - The sequence used to choose the migrations.
      ///  AMainMigrationsGetter - Main interface to choose the migrations.
      /// </InputParameters>
      /// <OutputParameters>
      ///  Result - The list of migrations determined by the sequence.
      /// </OutputParameters>
    {$ENDREGION}
    function getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
  end;

implementation

uses
  System.SysUtils;

{ TSequenceMigrationsGetter }

function TSequenceMigrationsGetter.getMigrations(AMigrationsList: TList<IMigration>; AStartMigrationSeq: Integer; AMainMigrationsGetter: IMainMigrationsGetter): TList<IMigration>;
begin
  if not Assigned(AMainMigrationsGetter) then
  begin
    raise Exception.Create('The parameter AMainMigrationsGetter must not be nil.');
  end
  else
  begin
    Result := AMainMigrationsGetter.getMigrations(AMigrationsList, function(AMigration: IMigration): Boolean
                                                                   begin
                                                                     Result := AMigration.SeqVersion >= AStartMigrationSeq;
                                                                   end);
  end;
end;

end.
