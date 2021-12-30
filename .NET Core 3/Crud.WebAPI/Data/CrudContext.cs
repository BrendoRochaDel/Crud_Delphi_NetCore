using Crud.WebAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace Crud.WebAPI.Data
{
    public class CrudContext : DbContext
    {
        public CrudContext(DbContextOptions<CrudContext> options) : base(options) { }
        public DbSet<Produtos> Produtos { get; set; }
        public DbSet<Fornecedor> Fornecedor { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Produtos>()
                .HasOne(p => p.Fornecedor)
                .WithMany(b => b.Produtos)
                .HasForeignKey(p => p.CodigoFornecedor);
        }    
    }
}