program Crud;

uses
  Vcl.Forms,
  Crud.View.Principal in 'src\View\Crud.View.Principal.pas' {frmPrincipal},
  Crud.Models.Produtos in 'src\Models\Crud.Models.Produtos.pas',
  Crud.Data.PersistentObject in 'src\Data\Crud.Data.PersistentObject.pas',
  Crud.Models.Fornecedor in 'src\Models\Crud.Models.Fornecedor.pas',
  Crud.Data.Conexao in 'src\Data\Crud.Data.Conexao.pas' {dmConexao: TDataModule},
  Crud.View.Fornecedores in 'src\View\Crud.View.Fornecedores.pas' {frmFornecedores},
  Crud.Controller.Fornecedor in 'src\Controller\Crud.Controller.Fornecedor.pas',
  Crud.Controller.Produtos in 'src\Controller\Crud.Controller.Produtos.pas',
  Crud.View.Produtos in 'src\View\Crud.View.Produtos.pas' {frmProdutos},
  Crud.Data.PersistentAPI in 'src\Data\Crud.Data.PersistentAPI.pas',
  Crud.Data.CrudTypes in 'src\Data\Crud.Data.CrudTypes.pas',
  Crud.Data.RTTIHelper in 'src\Data\Crud.Data.RTTIHelper.pas',
  Crud.Data.CrudInterface in 'src\Data\Crud.Data.CrudInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
