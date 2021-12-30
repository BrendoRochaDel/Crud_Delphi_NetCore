unit Crud.Data.RTTIHelper;

interface

uses
  RTTI;

type
  Tabela = class(TCustomAttribute)
  private
    FName: String;
  public
    constructor Create(aName: string);
    property Name: String read FName;
  end;

  PK = class(TCustomAttribute)
  end;

  TRttiTypeHelper = class helper for TRttiType
  public
    function Tem<T: TCustomAttribute>: Boolean;
    function GetAttribute<T: TCustomAttribute>: T;
    function TabelaName: String;
  end;

  TRttiPropertyHelper = class helper for TRttiProperty
  public
    function Tem<T: TCustomAttribute>: Boolean;
    function GetAttribute<T: TCustomAttribute>: T;
    function PrimaryKey: Boolean;
  end;

implementation

{ Tabela }

constructor Tabela.Create(aName: string);
begin
  FName := aName;
end;

{ TRttiPropertyHelper }

function TRttiTypeHelper.GetAttribute<T>: T;
var
  oAtributo: TCustomAttribute;
begin
  Result := nil;
  for oAtributo in GetAttributes do
    if oAtributo is T then
      Exit((oAtributo as T));
end;

function TRttiTypeHelper.Tem<T>: Boolean;
begin
  Result := GetAttribute<T> <> nil
end;

function TRttiTypeHelper.TabelaName: String;
begin
  Result := '';

  if Tem<Tabela> then
   Result := GetAttribute<Tabela>.Name;
end;


{ TRttiTypeHelper }

function TRttiPropertyHelper.GetAttribute<T>: T;
var
  oAtributo: TCustomAttribute;
begin
  Result := nil;
  for oAtributo in GetAttributes do
    if oAtributo is T then
      Exit((oAtributo as T));
end;

function TRttiPropertyHelper.Tem<T>: Boolean;
begin
  Result := GetAttribute<T> <> nil
end;

function TRttiPropertyHelper.PrimaryKey: Boolean;
begin
  Result := Tem<PK>;
end;

end.
