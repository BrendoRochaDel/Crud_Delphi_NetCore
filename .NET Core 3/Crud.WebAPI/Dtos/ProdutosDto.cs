using System;

namespace Crud.WebAPI.Dtos
{
    public class ProdutosDto
    {
        public int CodigoProduto { get; set; }
        public string DescricaoProduto { get; set; }
        public string SituacaoProduto { get; set; }
        public string DataFabricacao { get; set; }
        public string DataValidade { get; set; }
        public string DescricaoFornecedor { get; set; }
        public string CidadeFornecedor { get; set; }     
    }
}