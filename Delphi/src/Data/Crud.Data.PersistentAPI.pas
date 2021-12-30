unit Crud.Data.PersistentAPI;

interface

uses
  REST.Types, System.JSON, REST.Client, Data.DB, Datasnap.DBClient,
  Crud.Data.CrudInterface;

type
  TRESTLib = record
    Client:   TRESTClient;
    Request:  TRESTRequest;
    Response: TRESTResponse;

    procedure Free;
  end;

  TPersistentAPI = class (TInterfacedObject, iPersistentAPI)
    private
      aDataSet : TClientDataSet;
      function Requisicao(const EndPoint: String; RequestType: TRESTRequestMethod; const sMensagem: String = ''): String;
      procedure JsonToDataSet(const sJson: String);
    public
      destructor Destroy; override;

      function FindAll(sEndPoint: string; aDataSource: TDataSource): iPersistentAPI;
      function GetRESTLib: TRESTLib;

      class function New: iPersistentAPI;
  end;

const
  URL_BASE = 'http://localhost:5000/';

implementation

uses
  System.SysUtils;

{ TPersistentAPI<T> }

class function TPersistentAPI.New: iPersistentAPI;
begin
  Result := self.Create;
end;

destructor TPersistentAPI.Destroy;
begin
  aDataSet.Free;
  inherited;
end;

function TPersistentAPI.FindAll(sEndPoint: string;
  aDataSource: TDataSource): iPersistentAPI;
var
  sJson: String;
begin
  Result := Self;
  sJson := Requisicao(sEndPoint, rmGET);

  if aDataSet = nil then
   aDataSet := TClientDataSet.Create(nil)
  else
   aDataSet.Close;

  JsonToDataSet(sJson);
  aDataSource.DataSet := aDataSet;
end;

function TPersistentAPI.GetRESTLib: TRESTLib;
begin
  Result.Client   := TRESTClient.Create (nil);
  Result.Response := TRESTResponse.Create(nil);
  Result.Request  := TRESTRequest.Create(nil);

  Result.Client.AutoCreateParams := False;
  Result.Client.AcceptEncoding   := 'UTF-8';

  Result.Request.AcceptEncoding  := 'UTF-8';

  Result.Request.Client   := Result.Client;
  Result.Request.Response := Result.Response;
end;

procedure TPersistentAPI.JsonToDataSet(const sJson: String);
var
  i, x : Integer;
  jObj : TJSONObject;
  jArr : TJSONArray;
begin
  jArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(sJson),0) as TJSONArray;

  try
   if (jArr <> nil) and (jArr.Count > 0) then
    begin
     aDataset.FieldDefs.Clear;

     JObj := TJsonObject(jArr.A[0]);

     for i := 0 to Pred(JObj.Size) do
     begin
       if (Length(JObj.Get(i).JsonValue.Value) > 250) then
       begin
         aDataset.FieldDefs.Add(JObj.Get(i).JsonString.Value, ftBlob);
       end
       else
       begin
         aDataset.FieldDefs.Add(JObj.Get(i).JsonString.Value, ftString, 255);
       end;
     end;

     aDataset.CreateDataSet;


     for i := 0 to Pred(jArr.Count) do
      begin
       JObj := TJsonObject(jArr.A[i]);

       aDataset.Append;
       for x := 0 to Pred(JObj.Size) do
        aDataset.FieldByName(JObj.Get(x).JsonString.Value).AsString := JObj.Get(x).JsonValue.Value;
       aDataset.Post;
      end;
    end;
  finally
   FreeAndNil(jArr);
  end;
end;

function TPersistentAPI.Requisicao(const EndPoint: String;
  RequestType: TRESTRequestMethod; const sMensagem: String): String;
var
  jResult, jObject: TJSONObject;
  RESTLib: TRESTLib;
  bTentarNovamente: Boolean;
  iTentativas: Integer;
begin
  bTentarNovamente := True;
  iTentativas := 0;

  Result := '';

  RESTLib := GetRESTLib;
  RESTLib.Client.BaseURL := URL_BASE;

  RESTLib.Request.Resource := EndPoint;
  RESTLib.Request.Method   := RequestType;
  RESTLib.Request.Timeout  := 120000;

  try
   if sMensagem <> '' then
    begin
     with RESTLib.Request.Params.AddItem do
      begin
       ContentType := ctAPPLICATION_JSON;
       name        := 'body';
       Value       := sMensagem;
       Kind        := pkREQUESTBODY;
      end;
    end;

   while bTentarNovamente do
    begin
     Inc(iTentativas);
     RESTLib.Request.Execute;

     jResult := TJSONObject.Create;

     try
      case RESTLib.Response.StatusCode of
       400:
        begin
         try
          if (iTentativas <= 1) then
           begin
            Sleep(1000);
            Continue;
           end
          else bTentarNovamente := False;

          jObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(RESTLib.Response.Content), 0) as TJSONObject;

          try
           Result := RESTLib.Response.Content;
          finally
           jObject.Free;
          end;
         except
          on E:Exception do
          begin
           jResult.AddPair('erro', RESTLib.Response.Content);

           Result := jResult.ToString;
          end;
         end;
        end;
       404:
        begin
         bTentarNovamente := False;
         if RESTLib.Response.Content = '' then
          jResult.AddPair('erro', Format('O servidor não pôde encontrar o que foi pedido. %s', [EndPoint]))
         else jResult.AddPair('erro', RESTLib.Response.Content);

         Result := jResult.ToString;
        end;
      else
       begin
        Result := RESTLib.Response.Content;
        bTentarNovamente := False;
       end;
      end;
     finally
      jResult.Free;
      RESTLib.Free;
     end;
    end;
  except
   on E:Exception do
   begin
    jResult := TJSONObject.Create;

    jResult.AddPair('erro', E.Message);
    Result := jResult.ToString;
   end;
  end;
end;

{ TRESTLib }

procedure TRESTLib.Free;
begin
  if Assigned(Self.Client)   then Self.Client.Free;
  if Assigned(Self.Request)  then Self.Request.Free;
  if Assigned(Self.Response) then Self.Response.Free;
end;

end.
