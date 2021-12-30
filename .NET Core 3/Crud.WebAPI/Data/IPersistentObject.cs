using Crud.WebAPI.Models;

namespace Crud.WebAPI.Data
{
    public interface IPersistentObject
    {
        void Add<T>(T entity) where T : class;
        void Update<T>(T entity) where T : class;
        void Delete<T>(T entity) where T : class; 
        bool SaveChange<T>(T entity) where T : class; 
        
        Produtos[] GetAllProdutos();
        Fornecedor[] GetAllFornecedor();
    }
}