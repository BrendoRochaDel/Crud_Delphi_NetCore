using System.Linq;
using Crud.WebAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace Crud.WebAPI.Data
{
  public class PersistentObject : IPersistentObject
  {
      private readonly CrudContext _context;

      public PersistentObject(CrudContext context)
      {
          _context = context;
      }

      public void Add<T>(T entity) where T : class
      {
          _context.Add(entity);
      }

      public void Update<T>(T entity) where T : class
      {
          _context.Update(entity);
      }

      public void Delete<T>(T entity) where T : class
      {
          _context.Remove(entity);
      }

      public bool SaveChange<T>(T entity) where T : class
      {
          return (_context.SaveChanges() > 0);
      }

      public Produtos[] GetAllProdutos()
      {
          IQueryable<Produtos> query = _context.Produtos;
          query = query.Include(p => p.Fornecedor);

          return query.ToArray();
      }

      public Fornecedor[] GetAllFornecedor()
      {
          IQueryable<Fornecedor> query = _context.Fornecedor;
          //query = query.Include(f => f.Produtos);

          return query.ToArray();
      }
  }
}