unit Crud.Data.PersistentObject;

interface

uses
  FireDAC.Stan.Param, FireDAC.Comp.Client, Data.DB,
  Crud.Data.PersistentAPI, Crud.Data.CrudInterface, Crud.Data.CrudTypes;

type
  TMethod = (tmINSERT, tmUPDATE);

  TPersistentObject<T: class, constructor> = class (TInterfacedObject, iPersistentObject<T>)
    private
      PersistenAPI: iPersistentAPI;
      Qry: TFDQuery;
      function LoadData: T;
      procedure LoadParams(aEntity: T);
      function LoadFields(aMethod: TMethod): String;
      function WherePK: String;
      function NomeTabela: String;
    public
      constructor Create;
      destructor Destroy; override;

      class function New: iPersistentObject<T>;
      function Insert(aEntity: T): iPersistentObject<T>;
      function Update(aEntity: T): iPersistentObject<T>;
      function Delete(aEntity: T): iPersistentObject<T>;
      function FindId(aEntity: T): T;
      function FindAll(aDataSource: TDataSource): iPersistentObject<T>; overload;
      function FindAll(sEndPoint: string; aDataSource: TDataSource): iPersistentObject<T>; overload;
      function GetIdField: TArrayStr; virtual;

  end;

implementation

uses
  System.TypInfo, System.SysUtils, System.Rtti, System.DateUtils,
  System.Math, System.Classes, REST.Types, Crud.Data.Conexao,
  Crud.Data.RTTIHelper;

{ TPersistentObject }

constructor TPersistentObject<T>.Create;
begin
  Qry := TFDQuery.Create(nil);
  Qry.Connection := dmConexao.Conecta;

  PersistenAPI := TPersistentAPI.Create;
end;


function TPersistentObject<T>.FindAll(aDataSource: TDataSource): iPersistentObject<T>;
begin
  Result := Self;

  Qry.SQL.Clear;
  Qry.SQL.Add('SELECT * FROM ' + NomeTabela);
  Qry.Open;

  aDataSource.DataSet := Qry;
end;

destructor TPersistentObject<T>.Destroy;
begin
  Qry.Free;
  inherited;
end;

function TPersistentObject<T>.FindAll(sEndPoint: string;
  aDataSource: TDataSource): iPersistentObject<T>;
begin
  Result := Self;
  PersistenAPI.FindAll(sEndPoint, aDataSource);
end;

function TPersistentObject<T>.FindId(aEntity: T): T;
begin
  Qry.SQL.Clear;

  Qry.SQL.Add('SELECT * FROM ' + NomeTabela);
  Qry.SQL.Add(WherePK);
  LoadParams(aEntity);

  Qry.Open;
  aEntity := LoadData;

  Result := aEntity;
end;

function TPersistentObject<T>.Insert(aEntity: T): iPersistentObject<T>;
begin
  Qry.SQL.Clear;
  Qry.SQL.Add('INSERT INTO ' + NomeTabela);
  Qry.SQL.Add(LoadFields(tmINSERT));
  LoadParams(aEntity);

  Qry.ExecSQL;
end;

function TPersistentObject<T>.Update(aEntity: T): iPersistentObject<T>;
begin
   Qry.SQL.Clear;
   Qry.SQL.Add('UPDATE ' + NomeTabela + ' SET ');
   Qry.SQL.Add(Self.LoadFields(tmUPDATE));
   Qry.SQL.Add(Self.WherePK);
   Self.LoadParams(aEntity);

   Qry.ExecSQL;
end;

function TPersistentObject<T>.Delete(aEntity: T): iPersistentObject<T>;
begin
  Qry.SQL.Clear;
  Qry.SQL.Add('DELETE FROM ' + NomeTabela);

  Qry.SQL.Add(Self.WherePK);
  Self.LoadParams(aEntity);

  Qry.ExecSQL;
end;

function TPersistentObject<T>.LoadData: T;
var
  i, x: Integer;
  aEntity: T;
begin
  aEntity := T.Create;

  for i := 0 to Qry.FieldCount - 1 do
   if IsPublishedProp(aEntity, Qry.Fields[i].FieldName) then
    if not Qry.Fields[i].IsNull then
     SetPropValue(aEntity, Qry.Fields[i].FieldName, Qry.Fields[i].Value);

  Result := aEntity;
end;

function TPersistentObject<T>.LoadFields(aMethod: TMethod): String;
var
  iQtdProp, i, x: Integer;
  PropList: TPropList;
  bFieldId: Boolean;
  sAux: String;
  aEntity: T;
  aIdField: TArrayStr;
begin
  aEntity := T.Create;

  try
   iQtdProp   := GetPropList(aEntity.ClassInfo, tkProperties, @PropList);
   Result := '';
   sAux   := '';
   aIdField := GetIdField;

   for i := 0 to Pred(iQtdProp) do
    begin
     bFieldId := false;

     for x := Low(aIdField) to High(aIdField) do
      begin
       if (PropList[i].Name = aIdField[x]) or
          (PropList[i].Name = 'NomeTabela') then
        begin
         bFieldId := true;
         break;
        end;
      end;

     if bFieldId then continue;

     if aMethod = tmUPDATE then
       Result := Result + PropList[i].Name + ' = ' + ':' + PropList[i].Name + ','
     else
      begin
       Result := Result + PropList[i].Name + ',';
       sAux   := sAux + ':' + PropList[i].Name + ',';
      end;
    end;

   if aMethod = tmINSERT then
    Result := '(' + Copy(Result, 0, Length(Result) - 1) + ') VALUES (' + Copy(sAux, 0, Length(sAux) - 1) + ')'
   else
    Result := Copy(Result, 0, Length(Result) - 1);
  finally
   aEntity.Free;
  end;

end;

procedure TPersistentObject<T>.LoadParams(aEntity: T);
var
  i: integer;
  sParam, sSql: String;
  aValue: TValue;
  PropInfo: PPropInfo;
  StringStream: TStringStream;
  Params: TFDParams;
begin
  Params := Qry.Params;
  sSql   := Qry.SQL.Text;

  for i := 0 to Params.Count - 1 do
   begin
    sParam := Params[i].Name;

    case PropType(aEntity, sParam) of
     tkInteger:
       aValue := GetOrdProp(aEntity, sParam).ToString;
     tkFloat:
      begin
       PropInfo := GetPropInfo(aEntity, sParam);
       aValue   := GetFloatProp(aEntity, sParam);
       if SameText(PropInfo^.PropType^.Name, 'TDateTime') then
        begin
         if TimeOf(RoundTo(aValue.AsExtended, -8)) > 0 then
          aValue := QuotedStr(FormatDateTime('YYYY-MM-DD', aValue.AsExtended))
         else aValue := QuotedStr(FormatDateTime('YYYY-MM-DD', aValue.AsExtended));
        end
       else if SameText(PropInfo^.PropType^.Name, 'TDate') then
        aValue := QuotedStr(FormatDateTime('YYYY-MM-DD', aValue.AsExtended))
       else if SameText(PropInfo^.PropType^.Name, 'TTime') then
        aValue := QuotedStr(FormatDateTime('YYYY-MM-DD', aValue.AsExtended))
       else
        aValue := StringReplace(aValue.ToString, ',', '.', []);
      end;
     tkChar, tkString, tkLString, tkUString:
      begin
       PropInfo := GetPropInfo(aEntity, sParam);
       if SameText(PropInfo^.PropType^.Name, 'TMemoString') then
        begin
         try
          StringStream := TStringStream.Create(GetStrProp(aEntity, sParam));
          aValue := QuotedStr(StringStream.DataString);
         finally
          StringStream.Free;
         end;
        end
       else
        aValue := QuotedStr(GetStrProp(aEntity, sParam));
      end;
     else
      aValue := String(GetVariantProp(aEntity, sParam));

    end;
    PropInfo := GetPropInfo(aEntity, sParam);
    sSql := StringReplace(sSql, Concat(':', PropInfo.Name), aValue.AsString, []);
   end;

   Qry.Sql.Text := sSql;
end;

class function TPersistentObject<T>.New: iPersistentObject<T>;
begin
  Result := self.Create;
end;

function TPersistentObject<T>.NomeTabela: String;
var
  aEntity: T;
  Contexto: TRttiContext;
  Tipo: TRttiType;
begin
  aEntity := T.Create;

  try
   Tipo := Contexto.GetType(aEntity.ClassInfo);

   Result := Tipo.TabelaName;
  finally
   aEntity.Free;
  end;
end;

function TPersistentObject<T>.WherePK: String;
var
  i: Integer;
  aIdField: TArrayStr;
begin
  aIdField := GetIdField;

  for i := Low(aIdField) to High(aIdField) do
   begin
    if i = Low(aIdField) then
     Result := Result + ' WHERE ';

    Result := Result + Format('`%s` = :%s', [aIdField[i], aIdField[i]]);

    if i <> High(aIdField) then
     Result := Result + ' AND ';
   end;
end;

function TPersistentObject<T>.GetIdField: TArrayStr;
var
  aEntity: T;
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Prop: TRttiProperty;
  Chaves: TStrings;
  i: Integer;
begin
  aEntity := T.Create;
  Chaves  := TStringList.Create;

  try
   Tipo := Contexto.GetType(aEntity.ClassInfo);

   for Prop in Tipo.GetProperties do
    if Prop.PrimaryKey then
     Chaves.Add(Prop.Name);

   SetLength(Result, Chaves.Count);

   for i := 0 to Chaves.Count - 1 do
    Result[i] := Chaves[i];
  finally
   aEntity.Free;
   Chaves.Free;
  end;
end;
end.
