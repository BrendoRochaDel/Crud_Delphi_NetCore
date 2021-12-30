unit Crud.Controller.Produtos;

interface

uses
  Crud.Models.Produtos, Data.DB, Crud.Data.CrudInterface,
  Crud.Data.PersistentObject;

type
  TProdutosController = class
    private
      objPersistent: IPersistentObject<TProdutos>;
    public
      constructor Create;

      procedure FindAll(aDataSource: TDataSource);
      function FindId(iCodigoProduto: Integer): TProdutos;
      procedure Inserir(sDescricaoProduto, sSituacaoProduto: String; dDataFabricacao, dDataValidade: TDate;
                        iCodigoFornecedor: Integer);
      procedure Update(iCodigoProduto, iCodigoFornecedor: Integer; sDescricaoProduto,
                       sSituacaoProduto: String; dDataFabricacao, dDataValidade: TDate);
      procedure Delete(iCodigoProduto: Integer);
  end;

implementation

{ TProdutos }

uses
  SysUtils;

constructor TProdutosController.Create;
begin
  objPersistent := TPersistentObject<TProdutos>.New;
end;

procedure TProdutosController.FindAll(aDataSource: TDataSource);
begin
  objPersistent.FindAll('api/produtos', aDataSource);
end;

function TProdutosController.FindId(iCodigoProduto: Integer): TProdutos;
var
  Produto: TProdutos;
begin
  Produto := TProdutos.Create;

  try
   Produto.CodigoProduto := iCodigoProduto;
   Result := objPersistent.FindId(Produto);
  finally
   FreeAndNil(Produto);
  end;
end;

procedure TProdutosController.Inserir(sDescricaoProduto,
  sSituacaoProduto: String; dDataFabricacao, dDataValidade: TDate;
  iCodigoFornecedor: Integer);
var
  Produto: TProdutos;
begin
  Produto := TProdutos.Create;

  try
   Produto.DescricaoProduto := sDescricaoProduto;
   Produto.SituacaoProduto  := sSituacaoProduto;
   Produto.DataFabricacao   := dDataFabricacao;
   Produto.DataValidade     := dDataValidade;
   Produto.CodigoFornecedor := iCodigoFornecedor;

   objPersistent.Insert(Produto);
  finally
   FreeAndNil(Produto);
  end;
end;

procedure TProdutosController.Update(iCodigoProduto, iCodigoFornecedor: Integer; sDescricaoProduto,
   sSituacaoProduto: String; dDataFabricacao, dDataValidade: TDate);
var
  Produto: TProdutos;
begin
  Produto := TProdutos.Create;

  try
   Produto.CodigoProduto    := iCodigoProduto;
   Produto.DescricaoProduto := sDescricaoProduto;
   Produto.SituacaoProduto  := sSituacaoProduto;
   Produto.DataFabricacao   := dDataFabricacao;
   Produto.DataValidade     := dDataValidade;
   Produto.CodigoFornecedor := iCodigoFornecedor;

   objPersistent.Update(Produto);
  finally
   FreeAndNil(Produto);
  end;
end;

procedure TProdutosController.Delete(iCodigoProduto: Integer);
var
  Produto: TProdutos;
begin
  Produto := TProdutos.Create;;

  try
   Produto.CodigoProduto := iCodigoProduto;
   objPersistent.Delete(Produto);
  finally
   FreeAndNil(Produto);
  end;
end;

end.
