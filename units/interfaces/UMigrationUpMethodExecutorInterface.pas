unit UMigrationUpMethodExecutorInterface;

interface

type
  IMigrationUpMethodExecutor = interface
  ['{48B88AFD-4CCE-487B-B444-AFD198A36B6F}']
    function Execute(AClass: TClass; AInstance: TObject): boolean;
  end;

implementation

end.
