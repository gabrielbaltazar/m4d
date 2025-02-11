unit M4DExperts.OTA.Helper;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Menus,
  ToolsAPI;

type
  TM4DExpertsOTAHelper = class
  public
    class function GetMainMenu: TMainMenu;
    class function ProjectOptions: IOTAProjectOptionsConfigurations;
    class function GetAllConfigurations: IOTABuildConfiguration;
  end;

implementation

{ TM4DExpertsOTAHelper }

class function TM4DExpertsOTAHelper.GetAllConfigurations: IOTABuildConfiguration;
begin
  Result := ProjectOptions.BaseConfiguration;
end;

class function TM4DExpertsOTAHelper.GetMainMenu: TMainMenu;
begin
  Result := (BorlandIDEServices as INTAServices).MainMenu;
end;

class function TM4DExpertsOTAHelper.ProjectOptions: IOTAProjectOptionsConfigurations;
begin
  Result := (GetActiveProject.ProjectOptions as IOTAProjectOptionsConfigurations);
end;

end.
