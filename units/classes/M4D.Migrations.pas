{######################################################################################

                                         M4D

Made with Love

Author: Edgar Borges Pavão
Date of creation: 29/08/2017
Use licence: See the license file

######################################################################################}
unit M4D.Migrations;

interface

uses
  M4D.MigrationsInterface;

type
  {$M+}
  {$REGION 'TMigrations'}
    /// <Description>
    ///  Standard implementation of the migration.
    /// </Description>
    /// <Responsability>
    ///  Be a set of updates.
    /// </Responsability>
    /// <Note>
    ///  Information from undocumented methods can be found directly on the interfaces
    ///  from which they come.
    /// </Note>
  {$ENDREGION}
  TMigrations = class(TInterfacedObject, IMigration)
  private
    FVersion: string;
    FSeqVersion: Integer;
    FDateTime: TDateTime;

    procedure setVersion(AValue: string);
    function getVersion: string;
    procedure setSeqVersion(AValue: Integer);
    function getSeqVersion: Integer;
    procedure setDateTime(AValue: TDateTime);
    function getDateTime: TDateTime;
  public
    procedure Setup; virtual; abstract;
    procedure Up; virtual; abstract;
    procedure Down; virtual; abstract;
  published
    property Version: string read getVersion write setVersion;
    property SeqVersion: Integer read getSeqVersion write setSeqVersion;
    property DateTime: TDateTime read getDateTime write setDateTime;
  end;

implementation

{ TMigrations }

function TMigrations.getDateTime: TDateTime;
begin
  Result := FDateTime;
end;

function TMigrations.getSeqVersion: Integer;
begin
  Result := FSeqVersion;
end;

function TMigrations.getVersion: string;
begin
  Result := FVersion;
end;

procedure TMigrations.setDateTime(AValue: TDateTime);
begin
  FDateTime := AValue;
end;

procedure TMigrations.setSeqVersion(AValue: Integer);
begin
  FSeqVersion := AValue;
end;

procedure TMigrations.setVersion(AValue: string);
begin
  FVersion := AValue;
end;

end.
