unit Crud.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Crud.Controller.Produtos,
  Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Crud.Controller.Fornecedor,
  Vcl.Forms;

type
  TfrmPrincipal = class(TForm)
    pagPrincipal: TPageControl;
    tabProdutos: TTabSheet;
    tabFornecedores: TTabSheet;
    dbgFornecedores: TDBGrid;
    lbTituloFornecedores: TLabel;
    brnInserirFornecedor: TButton;
    btnEditarFornecedor: TButton;
    btnExcluirFornecedor: TButton;
    dtsFornecedores: TDataSource;
    lbTituloProdutos: TLabel;
    dbgProdutos: TDBGrid;
    btnInserirProdutos: TButton;
    btnEditarProdutos: TButton;
    btnExcluirProdutos: TButton;
    dtsProdutos: TDataSource;
    procedure brnInserirFornecedorClick(Sender: TObject);
    procedure btnEditarFornecedorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirFornecedorClick(Sender: TObject);
    procedure btnInserirProdutosClick(Sender: TObject);
    procedure btnEditarProdutosClick(Sender: TObject);
    procedure btnExcluirProdutosClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objFornecedor: TFornecedorController;
    objProdutos: TProdutosController;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  Crud.View.Fornecedores, Crud.View.Produtos, Crud.Data.Conexao;

procedure TfrmPrincipal.brnInserirFornecedorClick(Sender: TObject);
begin
  if TfrmFornecedores.Execute() then
   objFornecedor.FindAll(dtsFornecedores);
end;

procedure TfrmPrincipal.btnEditarFornecedorClick(Sender: TObject);
begin
  if (dtsFornecedores.DataSet.State <> dsInactive) and (dtsFornecedores.DataSet.RecordCount > 0) and
  (TfrmFornecedores.Execute(dtsFornecedores.DataSet.FieldByName('CodigoFornecedor').AsInteger, false)) then
   begin
    objFornecedor.FindAll(dtsFornecedores);
    objProdutos.FindAll(dtsProdutos);
   end;
end;

procedure TfrmPrincipal.btnEditarProdutosClick(Sender: TObject);
begin
  if (dtsProdutos.DataSet.State <> dsInactive) and (dtsProdutos.DataSet.RecordCount > 0) and
   (TfrmProdutos.Execute(dtsProdutos.DataSet.FieldByName('CodigoProduto').AsInteger, false)) then
   objProdutos.FindAll(dtsProdutos);
end;

procedure TfrmPrincipal.btnExcluirFornecedorClick(Sender: TObject);
begin
  if (dtsFornecedores.DataSet.State <> dsInactive) and (dtsFornecedores.DataSet.RecordCount > 0) then
   begin
    objFornecedor.Delete(dtsFornecedores.DataSet.FieldByName('CodigoFornecedor').AsInteger);
    objFornecedor.FindAll(dtsFornecedores);
    objProdutos.FindAll(dtsProdutos);
   end;
end;

procedure TfrmPrincipal.btnExcluirProdutosClick(Sender: TObject);
begin
  if (dtsProdutos.DataSet.State <> dsInactive) and (dtsProdutos.DataSet.RecordCount > 0) then
   begin
    objProdutos.Delete(dtsProdutos.DataSet.FieldByName('CodigoProduto').AsInteger);
    objProdutos.FindAll(dtsProdutos);
   end;
end;

procedure TfrmPrincipal.btnInserirProdutosClick(Sender: TObject);
begin
  if TfrmProdutos.Execute() then
   objProdutos.FindAll(dtsProdutos);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  objProdutos := TProdutosController.Create;
  objFornecedor := TFornecedorController.Create;

  objProdutos.FindAll(dtsProdutos);
  objFornecedor.FindAll(dtsFornecedores);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  objProdutos.Free;
  objFornecedor.Free;
end;

end.
