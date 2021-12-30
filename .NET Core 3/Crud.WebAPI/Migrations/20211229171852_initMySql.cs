using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Crud.WebAPI.Migrations
{
    public partial class initMySql : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Fornecedor",
                columns: table => new
                {
                    CodigoFornecedor = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    DescricaoFornecedor = table.Column<string>(type: "varchar(200)", nullable: false),
                    CidadeFornecedor = table.Column<string>(type: "varchar(200)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Fornecedor", x => x.CodigoFornecedor);
                });

            migrationBuilder.CreateTable(
                name: "Produtos",
                columns: table => new
                {
                    CodigoProduto = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    DescricaoProduto = table.Column<string>(type: "varchar(200)", nullable: false),
                    SituacaoProduto = table.Column<string>(type: "varchar(1)", nullable: false),
                    DataFabricacao = table.Column<DateTime>(nullable: false),
                    DataValidade = table.Column<DateTime>(nullable: false),
                    CodigoFornecedor = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Produtos", x => x.CodigoProduto);
                    table.ForeignKey(
                        name: "FK_Produtos_Fornecedor_CodigoFornecedor",
                        column: x => x.CodigoFornecedor,
                        principalTable: "Fornecedor",
                        principalColumn: "CodigoFornecedor",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Produtos_CodigoFornecedor",
                table: "Produtos",
                column: "CodigoFornecedor");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Produtos");

            migrationBuilder.DropTable(
                name: "Fornecedor");
        }
    }
}
