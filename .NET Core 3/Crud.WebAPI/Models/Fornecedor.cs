using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Crud.WebAPI.Models
{

  public class Fornecedor
  {
      public Fornecedor() { }
      public Fornecedor(int codigoFornecedor, string descricaoFornecedor, string cidadeFornecedor)
      {
          this.CodigoFornecedor = codigoFornecedor;
          this.DescricaoFornecedor = descricaoFornecedor;
          this.CidadeFornecedor = cidadeFornecedor;
      }
      [Key]
      public int CodigoFornecedor { get; set; }
      [Column(TypeName = "varchar(200)"), Required]
      public string DescricaoFornecedor { get; set; }
      [Column(TypeName = "varchar(200)"), Required]
      public string CidadeFornecedor { get; set; }

      public List<Produtos> Produtos { get; set; }
  }
}