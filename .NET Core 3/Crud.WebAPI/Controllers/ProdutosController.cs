using System.Collections.Generic;
using Crud.WebAPI.Data;
using Crud.WebAPI.Dtos;
using Microsoft.AspNetCore.Mvc;

namespace Crud.WebAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProdutosController : ControllerBase
    {
        private readonly IPersistentObject _persistent;

        public ProdutosController(IPersistentObject persistent)
        {
            _persistent = persistent;
        }

        [HttpGet]
        public IActionResult Get()
        {
            var produtos = _persistent.GetAllProdutos();
            var produtosRetorno = new List<ProdutosDto>();

            foreach(var produto in produtos)
            {
                produtosRetorno.Add(new ProdutosDto() {
                    CodigoProduto = produto.CodigoProduto,
                    DescricaoProduto = produto.DescricaoProduto,
                    SituacaoProduto = produto.SituacaoProduto == "A" ? "Ativo" : "Inativo",
                    DataFabricacao = produto.DataFabricacao.ToString("dd/MM/yyyy"),
                    DataValidade = produto.DataValidade.ToString("dd/MM/yyyy"),
                    DescricaoFornecedor = produto.Fornecedor.DescricaoFornecedor,
                    CidadeFornecedor = produto.Fornecedor.CidadeFornecedor
                });
            }

            return Ok(produtosRetorno);   
        }
    }
}