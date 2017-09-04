unit USetupExecutorInterface;

interface

type
  {$REGION 'ISetupExecutor'}
    /// <Description>
    ///  Standard method to execute a "setup" method on a class.
    /// </Description>
  {$ENDREGION}
  IMigrationSetupMethodExecutor = interface
  ['{6DC508CE-F526-40F2-B88E-C8353ED82DC2}']
    {$REGION 'ISetupExecutor.ExecuteSetup'}
      /// <Description>
      ///  Standard method to execute the "setup" method of a class.
      /// </Description>
      /// <InputParameters>
      ///  AClass - The class type to be inspected.
      ///  AInstance - A instance of the class type inputted. Must not be nil.
      /// </InputParameters>
    {$ENDREGION}
    function Execute(AClass: TClass; AInstance: TObject): boolean;
  end;

implementation

end.
