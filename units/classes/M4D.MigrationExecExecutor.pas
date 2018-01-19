{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 19/09/2017
Use licence: See the license file

######################################################################################}
unit M4D.MigrationExecExecutor;

interface

uses
  Generics.Collections, M4D.MigrationsHistoryFacadeInterface, M4D.MigrationExecExecutorInterface;

type
  {$REGION 'TMigrationExecExecutor'}
    /// <Description>
    ///  Standard class to execute migrations.
    /// <Responsability>
    ///  Execute the up method of a migration.
    /// </Responsability>
    /// </Description>
  {$ENDREGION}
  TMigrationExecExecutor = class(TInterfacedObject, IMigrationExecExecutor)
    {$REGION 'TMigrationExecExecutor.Execute'}
      /// <Description>
      ///  Performs the migration forward.
      /// </Description>
      /// <InputParameters>
      ///  AMigrationsList - The list all the migrations that will be considered for the execution.
      /// </InputParameters>
    {$ENDREGION}
    procedure Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AChangeHistory: Boolean = True);
  end;

implementation

uses
  M4D.MigrationsHistoryItem,
  M4D.MigrationsInterface,
  System.SysUtils,
  M4D.Migrations;

{ TMigrationExecExecutor }

procedure TMigrationExecExecutor.Execute(AMigrationsList: TList<TClass>; AMigrationHistoryFacade: IMigrationsHistoryFacade; AChangeHistory: Boolean = True);
var
  VersionProp: string;
  SequenceProp: Integer;
  DatetimeProp: TDateTime;
  LClass: TClass;
  Item: TMigrationsHistoryItem;
  Aux: TObject;
  HadMigration: Boolean;
  LMigration: IMigration;
begin
  HadMigration := False;

  if Assigned(AMigrationsList) and
     Assigned(AMigrationHistoryFacade)
  then
  begin
    AMigrationsList.Sort;

    for LClass in AMigrationsList do
    begin
      Aux := LClass.Create;

      LMigration := (Aux as TInterfacedObject as IMigration);

      //First, call for setup to load informations
      (Aux as TInterfacedObject as IMigration).Setup;

      //then, get the info from the props
      VersionProp := (Aux as TInterfacedObject as IMigration).Version;
      SequenceProp := (Aux as TInterfacedObject as IMigration).SeqVersion;
      DatetimeProp := (Aux as TInterfacedObject as IMigration).DateTime;

      //Decide if the migration must be executed
      if (Aux as TInterfacedObject as IMigration).UpWillExecute then
      begin
        if AChangeHistory then
        begin
          Item := TMigrationsHistoryItem.Create;
          try
            Item.MigrationVersion := VersionProp;
            Item.MigrationSeq := SequenceProp;
            Item.MigrationDateTime := DatetimeProp;

            Item.StartOfExecution := Now;

            //Execute the migration
            (Aux as TInterfacedObject as IMigration).Up;

            Item.EndOfExecution := Now;
            Item.DurationOfExecution := Item.EndOfExecution - Item.StartOfExecution;
          finally
            AMigrationHistoryFacade.Add(Item);
            HadMigration := True;
          end;
        end
        else
        begin
          //Execute the migration
          (Aux as TInterfacedObject as IMigration).Up;
        end;
      end;
    end;
  end;

  if HadMigration and AChangeHistory then
  begin
    AMigrationHistoryFacade.Save;
  end;
end;

end.

