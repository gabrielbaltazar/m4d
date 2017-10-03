{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: Free for any use. You can change the code, but if you do, you should no
             longer reference the M4D name.

######################################################################################}
unit M4D.MigrationDownMethodExecutorInterface;

interface

type
  IMigrationDownMethodExecutor = interface
  ['{9B2DAFE0-7FC3-4AFE-8446-CE2E090F0AC0}']
    function Execute(AClass: TClass; AInstance: TObject): boolean;
  end;

implementation

end.
