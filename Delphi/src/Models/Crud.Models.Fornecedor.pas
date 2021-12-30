unit Crud.Models.Fornecedor;

interface

uses
  Crud.Data.RTTIHelper;

type
  [Tabela('Fornecedor')]
  TFornecedor = class
    private
    FCodigoFornecedor: Integer;
    FCidadeFornecedor: String;
    FDescricaoFornecedor: String;

    public
    published
      [PK]
      property CodigoFornecedor: Integer read FCodigoFornecedor write FCodigoFornecedor;
      property DescricaoFornecedor: String read FDescricaoFornecedor write FDescricaoFornecedor;
      property CidadeFornecedor: String read FCidadeFornecedor write FCidadeFornecedor;
  end;

implementation

{ TFornecedor }

end.
