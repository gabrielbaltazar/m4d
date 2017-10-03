{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: Free for any use. You can change the code, but if you do, you should no
             longer reference the M4D name.

######################################################################################}
unit M4D.MigrationUpMethodExecutorInterface;

interface

type
  IMigrationUpMethodExecutor = interface
  ['{48B88AFD-4CCE-487B-B444-AFD198A36B6F}']
    function Execute(AClass: TClass; AInstance: TObject): boolean;
  end;

implementation

end.
