program M4DTest;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  M4DTest.DatetimeMigrationsGetter in 'units\classes\M4DTest.DatetimeMigrationsGetter.pas',
  M4DTest.Defaults in 'units\classes\M4DTest.Defaults.pas',
  M4DTest.GetterMigrations in 'units\classes\M4DTest.GetterMigrations.pas',
  M4DTest.MainMigrationsGetter in 'units\classes\M4DTest.MainMigrationsGetter.pas',
  M4DTest.MigrationExecExecutor in 'units\classes\M4DTest.MigrationExecExecutor.pas',
  M4DTest.MStubMigrationToTest in 'units\migrations\M4DTest.MStubMigrationToTest.pas',
  M4DTest.MigrationsHistoryMock in 'units\classes\M4DTest.MigrationsHistoryMock.pas',
  M4DTest.MigrationExecPendingExecutor in 'units\classes\M4DTest.MigrationExecPendingExecutor.pas',
  M4DTest.MigrationExecUntilExecutor in 'units\classes\M4DTest.MigrationExecUntilExecutor.pas',
  M4DTest.MigrationExecutor in 'units\classes\M4DTest.MigrationExecutor.pas',
  M4DTest.MigrationListOrder in 'units\classes\M4DTest.MigrationListOrder.pas',
  M4DTest.MigrationRollbackExecutor in 'units\classes\M4DTest.MigrationRollbackExecutor.pas',
  M4DTest.Migrations in 'units\classes\M4DTest.Migrations.pas',
  M4DTest.MigrationSerializer in 'units\classes\M4DTest.MigrationSerializer.pas',
  M4DTest.MigrationsHistory in 'units\classes\M4DTest.MigrationsHistory.pas',
  M4DTest.MigrationsHistoryItem in 'units\classes\M4DTest.MigrationsHistoryItem.pas',
  M4DTest.MigrationsManager in 'units\classes\M4DTest.MigrationsManager.pas',
  M4DTest.MigrationsRegister in 'units\classes\M4DTest.MigrationsRegister.pas',
  M4DTestUnit in 'M4DTestUnit.pas',
  M4DTest.SequenceMigrationsGetter in 'units\classes\M4DTest.SequenceMigrationsGetter.pas',
  M4DTest.HistoryToTextTransformer in 'units\classes\M4DTest.HistoryToTextTransformer.pas',
  M4DTest.TextToHistoryTransformer in 'units\classes\M4DTest.TextToHistoryTransformer.pas',
  M4DTest.HistoryCleaner in 'units\classes\M4DTest.HistoryCleaner.pas',
  M4DTest.MigrationsHistoryLoader in 'units\classes\M4DTest.MigrationsHistoryLoader.pas',
  M4DTest.MigrationsHistoryUnloader in 'units\classes\M4DTest.MigrationsHistoryUnloader.pas',
  M4DTest.MigrationsHistoryAdder in 'units\classes\M4DTest.MigrationsHistoryAdder.pas',
  M4DTest.MigrationsHistoryRemover in 'units\classes\M4DTest.MigrationsHistoryRemover.pas',
  M4DTest.MigrationsHistorySaver in 'units\classes\M4DTest.MigrationsHistorySaver.pas',
  M4DTest.LastMigrationsHistoryGetter in 'units\classes\M4DTest.LastMigrationsHistoryGetter.pas',
  M4DTest.HistoryGetter in 'units\classes\M4DTest.HistoryGetter.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
  ReportMemoryLeaksOnShutdown := True;

{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
