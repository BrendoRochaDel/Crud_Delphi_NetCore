unit Crud.View.Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.DBCtrls, Crud.Controller.Fornecedor, Vcl.Mask, Vcl.NumberBox;

type
  TfrmProdutos = class(TForm)
    gbDescricao: TGroupBox;
    edtDescricao: TEdit;
    gbSituacao: TGroupBox;
    edtCodigo: TEdit;
    btnCancelar: TButton;
    btnSalvar: TButton;
    gbFabricacao: TGroupBox;
    gbFornecedor: TGroupBox;
    cbSituacao: TComboBox;
    dtaFabricacao: TDateTimePicker;
    gbValidade: TGroupBox;
    dtaValidade: TDateTimePicker;
    dtsFornecedor: TDataSource;
    dcbFornecedor: TDBLookupComboBox;
    edtCodigoFornecedor: TNumberBox;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoFornecedorExit(Sender: TObject);
    procedure dcbFornecedorExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure cbSituacaoExit(Sender: TObject);
    procedure ValidarDatas(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    New: Boolean;
    objFornecedor: TFornecedorController;
    procedure CamposObrigatorios;
    procedure CarregarFormulario(iCodigoProduto: Integer);
    procedure SalvarProduto;
    procedure CarregarFornecedores;
  public
    { Public declarations }
    class function Execute(iCodigoProduto: Integer = 0; bNew: Boolean = true): Boolean;
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

uses
  Math, StrUtils, Crud.Models.Produtos, Crud.Controller.Produtos;

class function TfrmProdutos.Execute(iCodigoProduto: Integer; bNew: Boolean): Boolean;
var
  objForm: TfrmProdutos;
begin
  objForm := TfrmProdutos.Create(nil);

  try
   if not bNew then
    objForm.CarregarFormulario(iCodigoProduto);

   objForm.New := bNew;
   Result := objForm.ShowModal = mrOK;
  finally
   objForm.Free;
  end;
end;

procedure TfrmProdutos.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmProdutos.btnSalvarClick(Sender: TObject);
begin
  CamposObrigatorios;
  SalvarProduto;
  Self.Close;
  ModalResult := mrOK;
end;

procedure TfrmProdutos.CamposObrigatorios;
var
  sNome: String;
  i: integer;
begin

  if edtDescricao.Text = '' then
   begin
    MessageDlg('O campo Descrição do produto é de preenchimento obrigatório.', TMsgDlgType.mtError, [mbOk], 0);
    edtDescricao.Focused;
    Abort;
   end;

  if dcbFornecedor.KeyValue = null then
   begin
    MessageDlg('O campo Fornecedor é de preenchimento obrigatório.', TMsgDlgType.mtError, [mbOk], 0);
    edtCodigoFornecedor.Focused;
    Abort;
   end;
end;

procedure TfrmProdutos.CarregarFornecedores;
begin
  objFornecedor := TFornecedorController.Create;

  objFornecedor.FindAll(dtsFornecedor);
end;

procedure TfrmProdutos.cbSituacaoExit(Sender: TObject);
begin
  if cbSituacao.ItemIndex < 0 then
    cbSituacao.ItemIndex := 0;
end;

procedure TfrmProdutos.dcbFornecedorExit(Sender: TObject);
begin
  if dcbFornecedor.KeyValue <> null then
   edtCodigoFornecedor.Value := dtsFornecedor.
                                   DataSet.
                                   FieldByName('CodigoFornecedor').AsInteger;
end;

procedure TfrmProdutos.edtCodigoFornecedorExit(Sender: TObject);
begin
  if dtsFornecedor.DataSet.Locate('CodigoFornecedor', edtCodigoFornecedor.Value, []) then
   dcbFornecedor.KeyValue := dtsFornecedor.
                                   DataSet.
                                   FieldByName('CodigoFornecedor').AsString
  else if edtCodigoFornecedor.Value <> 0 then
   begin
     MessageDlg('Código de fornecedor não foi encontrado', TMsgDlgType.mtError, [mbOk], 0);
     edtCodigoFornecedor.Value := 0;
     edtCodigoFornecedor.SetFocus;
   end;

end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  CarregarFornecedores;
end;

procedure TfrmProdutos.FormDestroy(Sender: TObject);
begin
  objFornecedor.Free;
end;

procedure TfrmProdutos.CarregarFormulario(iCodigoProduto: Integer);
var
  objProduto: TProdutosController;
  mProduto: TProdutos;
begin
  objProduto := TProdutosController.Create;

  try
   mProduto := objProduto.FindId(iCodigoProduto);

   edtCodigo.Text            := IntToStr(iCodigoProduto);
   edtDescricao.Text         := mProduto.DescricaoProduto;
   cbSituacao.ItemIndex      := IfThen(mProduto.SituacaoProduto = 'A', 0, 1);
   dtaFabricacao.Date        := mProduto.DataFabricacao;
   dtaValidade.Date          := mProduto.DataValidade;
   edtCodigoFornecedor.Value := mProduto.CodigoFornecedor;
   dcbFornecedor.KeyValue    := mProduto.CodigoFornecedor;
  finally
   objProduto.Free;
   mProduto.Free;
  end;
end;

procedure TfrmProdutos.SalvarProduto;
var
  objProduto: TProdutosController;
begin
  objProduto := TProdutosController.Create;

  try
   if New then
    objProduto.Inserir(
      edtDescricao.Text,
      IfThen(cbSituacao.ItemIndex = 0, 'A', 'I'),
      dtaFabricacao.Date,
      dtaValidade.Date,
      StrToInt(edtCodigoFornecedor.Text)
    )
   else
    objProduto.Update(
      StrToInt(edtCodigo.Text),
      StrToInt(edtCodigoFornecedor.Text),
      edtDescricao.Text,
      IfThen(cbSituacao.ItemIndex = 0, 'A', 'I'),
      dtaFabricacao.Date,
      dtaValidade.Date
    );
  finally
   objProduto.Free;
  end;
end;

procedure TfrmProdutos.ValidarDatas(Sender: TObject);
var
  Error: Boolean;
begin
  if ((dtaFabricacao.Date > 0) and (dtaValidade.Date > 0)) then
   begin
    Error := not (dtaFabricacao.Date <= dtaValidade.Date);
    if Error then
     begin
      MessageDlg('A data de fabricação não pode ser maior que a data de validade.', TMsgDlgType.mtError, [mbOk], 0);
      TDateTimePicker(Sender).SetFocus;
     end;
   end;
end;

end.
