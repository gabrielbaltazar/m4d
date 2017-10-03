{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: Free for any use. You can change the code, but if you do, you should no
             longer reference the M4D name.

######################################################################################}
unit M4D.SetupExecutorInterface;

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
