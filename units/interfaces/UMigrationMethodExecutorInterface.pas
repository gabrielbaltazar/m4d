unit UMigrationMethodExecutorInterface;

interface

type
  IMigrationMethodExecutor = interface
  ['{AB24C2FD-5B7C-46BA-AF94-D8A45176D3A8}']
    function Execute(AClass: TClass; AInstance: TObject; ANameOfMethod: string): boolean;
  end;

implementation

end.
