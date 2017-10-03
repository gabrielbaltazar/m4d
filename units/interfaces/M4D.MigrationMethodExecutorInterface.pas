{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: Free for any use. You can change the code, but if you do, you should no
             longer reference the M4D name.

######################################################################################}
unit M4D.MigrationMethodExecutorInterface;

interface

type
  IMigrationMethodExecutor = interface
  ['{AB24C2FD-5B7C-46BA-AF94-D8A45176D3A8}']
    function Execute(AClass: TClass; AInstance: TObject; ANameOfMethod: string): boolean;
  end;

implementation

end.
