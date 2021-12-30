unit Crud.Controller.Fornecedor;

interface

uses
  Crud.Models.Fornecedor, Data.DB, Crud.Data.CrudInterface,
  Crud.Data.PersistentObject;

type
  TFornecedorController = class
    private
      objPersistent: IPersistentObject<TFornecedor>;
    public
      constructor Create;
      destructor Destroy; override;

      procedure FindAll(aDataSource: TDataSource);
      function FindId(iCodigoFornecedor: Integer): TFornecedor;
      procedure Inserir(sDescricaoFornecedor, sCidadeFornecedor: String);
      procedure Update(iCodigoFornecedor: Integer; sDescricaoFornecedor, sCidadeFornecedor: String);
      procedure Delete(iCodigoFornecedor: Integer);
  end;

implementation

uses
  System.SysUtils;

{ TFornecedor }

constructor TFornecedorController.Create;
begin
  objPersistent := TPersistentObject<TFornecedor>.New;
end;

destructor TFornecedorController.Destroy;
begin

  inherited;
end;

procedure TFornecedorController.FindAll(aDataSource: TDataSource);
begin
  objPersistent.FindAll(aDataSource);
end;

function TFornecedorController.FindId(iCodigoFornecedor: Integer): TFornecedor;
var
  Fornecedor: TFornecedor;
begin
  Fornecedor := TFornecedor.Create;

  try
   Fornecedor.CodigoFornecedor := iCodigoFornecedor;
   Result := objPersistent.FindId(Fornecedor);
  finally
   FreeAndNil(Fornecedor);
  end;
end;

procedure TFornecedorController.Inserir(sDescricaoFornecedor,
  sCidadeFornecedor: String);
var
  Fornecedor: TFornecedor;
begin
  Fornecedor := TFornecedor.Create;

  try
   Fornecedor.DescricaoFornecedor := sDescricaoFornecedor;
   Fornecedor.CidadeFornecedor    := sCidadeFornecedor;
   objPersistent.Insert(Fornecedor);
  finally
   FreeAndNil(Fornecedor);
  end;
end;

procedure TFornecedorController.Update(iCodigoFornecedor: Integer;
  sDescricaoFornecedor, sCidadeFornecedor: String);
var
  Fornecedor: TFornecedor;
begin
  Fornecedor := TFornecedor.Create;

  try
   Fornecedor.CodigoFornecedor := iCodigoFornecedor;
   Fornecedor.DescricaoFornecedor := sDescricaoFornecedor;
   Fornecedor.CidadeFornecedor    := sCidadeFornecedor;
   objPersistent.Update(Fornecedor);
  finally
   Fornecedor.Free;
  end;
end;

procedure TFornecedorController.Delete(iCodigoFornecedor: Integer);
var
  Fornecedor: TFornecedor;
begin
  Fornecedor := TFornecedor.Create;

  try
   Fornecedor.CodigoFornecedor := iCodigoFornecedor;
   objPersistent.Delete(Fornecedor);
  finally
  Fornecedor.Free;
  end;
end;

end.
