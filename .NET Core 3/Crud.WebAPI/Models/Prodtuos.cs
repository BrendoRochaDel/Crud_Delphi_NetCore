using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Crud.WebAPI.Models
{

  public class Produtos
  {
      public Produtos() { }
      public Produtos(int codigoProduto, string descricaoProduto, string situacaoProduto, DateTime dataFabricacao, DateTime dataValidade, int codigoFornecedor)
      {
          this.CodigoProduto = codigoProduto;
          this.DescricaoProduto = descricaoProduto;
          this.SituacaoProduto = situacaoProduto;
          this.DataFabricacao = dataFabricacao;
          this.DataValidade = dataValidade;
          this.CodigoFornecedor = codigoFornecedor;
      }
      [Key]
      public int CodigoProduto { get; set; }
      [Column(TypeName = "varchar(200)"), Required]
      public string DescricaoProduto { get; set; }
      [Column(TypeName = "varchar(1)"), Required]
      public string SituacaoProduto { get; set; }
      public DateTime DataFabricacao { get; set; }
      public DateTime DataValidade { get; set; }
      public int CodigoFornecedor { get; set; }
      public Fornecedor Fornecedor { get; set; }
  }
}