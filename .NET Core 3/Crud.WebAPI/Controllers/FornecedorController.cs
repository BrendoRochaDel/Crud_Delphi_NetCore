using Crud.WebAPI.Data;
using Microsoft.AspNetCore.Mvc;

namespace Crud.WebAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FornecedorController : ControllerBase
    {
        private readonly IPersistentObject _persistent;

        public FornecedorController(IPersistentObject persistent)
        {
          _persistent = persistent;
        }

        [HttpGet]
        public IActionResult Get()
        {
            var result = _persistent.GetAllFornecedor();
            return Ok(result);   
        }
    }
}