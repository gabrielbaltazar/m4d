{######################################################################################

                                      M4D Framework

Author: Edgar Borges Pavão
Date of creation:
Use licence: Free

######################################################################################}

program M4DProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UGetterMigrationsInterface in 'units\interfaces\UGetterMigrationsInterface.pas',
  URegisterMigrationInterface in 'units\interfaces\URegisterMigrationInterface.pas',
  UMigrations in 'units\classes\UMigrations.pas',
  UMigrationsManager in 'units\classes\UMigrationsManager.pas',
  UMigrationExecutorInterface in 'units\interfaces\UMigrationExecutorInterface.pas',
  UGetterMigrations in 'units\classes\UGetterMigrations.pas',
  UMigrationsInterface in 'units\interfaces\UMigrationsInterface.pas',
  URegisterMigration in 'units\classes\URegisterMigration.pas',
  UMigrationExecutor in 'units\classes\UMigrationExecutor.pas',
  UMigrationsHistoryItem in 'units\classes\UMigrationsHistoryItem.pas',
  UMigrationsHistory in 'units\classes\UMigrationsHistory.pas',
  UMigrationsHistoryInterface in 'units\interfaces\UMigrationsHistoryInterface.pas',
  UMigrationSerializerInterface in 'units\interfaces\UMigrationSerializerInterface.pas',
  UMigrationSerializer in 'units\classes\UMigrationSerializer.pas',
  M4D in 'units\classes\M4D.pas',
  UDefs in 'units\types\UDefs.pas',
  UMigrationListOrder in 'units\classes\UMigrationListOrder.pas',
  UMigrationListOrderInterface in 'units\interfaces\UMigrationListOrderInterface.pas',
  UPropertyClassReader in 'units\classes\UPropertyClassReader.pas',
  UPropertyClassReaderInterface in 'units\interfaces\UPropertyClassReaderInterface.pas',
  USetupExecutor in 'units\classes\USetupExecutor.pas',
  USetupExecutorInterface in 'units\interfaces\USetupExecutorInterface.pas',
  UMigrationMethodExecutorInterface in 'units\interfaces\UMigrationMethodExecutorInterface.pas',
  UMigrationUpMethodExecutorInterface in 'units\interfaces\UMigrationUpMethodExecutorInterface.pas',
  UMigrationMethodExecutor in 'units\classes\UMigrationMethodExecutor.pas',
  UMigrationUpMethodExecutor in 'units\classes\UMigrationUpMethodExecutor.pas',
  UMigrationDownMethodExecutor in 'units\classes\UMigrationDownMethodExecutor.pas',
  UMigrationDownMethodExecutorInterface in 'units\interfaces\UMigrationDownMethodExecutorInterface.pas',
  UMigrationsRegisterInterface in 'units\interfaces\UMigrationsRegisterInterface.pas',
  UMigrationsRegister in 'units\classes\UMigrationsRegister.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
