unit Crud.Models.Produtos;

interface

uses
  Crud.Data.RTTIHelper;

type
  [Tabela('Produtos')]
  TProdutos = class
    private
    FCodigoProduto: Integer;
    FDescricaoProduto: String;
    FSituacaoProduto: String;
    FDataFabricacao: TDate;
    FDataValidade: TDate;
    FCodigoFornecedor: Integer;

    public
    published
      [PK]
      property CodigoProduto: Integer    read FCodigoProduto    write FCodigoProduto;
      property DescricaoProduto: String  read FDescricaoProduto write FDescricaoProduto;
      property SituacaoProduto: String   read FSituacaoProduto  write FSituacaoProduto;
      property DataFabricacao: TDate     read FDataFabricacao   write FDataFabricacao;
      property DataValidade: TDate       read FDataValidade     write FDataValidade;
      property CodigoFornecedor: Integer read FCodigoFornecedor write FCodigoFornecedor;
  end;

implementation

{ TProdutos }


end.
