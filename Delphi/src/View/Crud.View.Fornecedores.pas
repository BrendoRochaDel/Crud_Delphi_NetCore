unit Crud.View.Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Crud.Controller.Fornecedor;

type
  TfrmFornecedores = class(TForm)
    gbDescricao: TGroupBox;
    edtDescricao: TEdit;
    gbCidade: TGroupBox;
    edtCidade: TEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    edtCodigo: TEdit;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FNew: Boolean;
    { Private declarations }
    procedure LoadObject(iCodigoFornecedor: integer);
    procedure SalvarFornecedor;
    procedure CamposObrigatorios;
  public
    { Public declarations }
    class function Execute(iCodigoFornecedor: Integer = 0; bNew: Boolean = true): Boolean;
  published
    property New: Boolean read FNew write FNew;
  end;

var
  frmFornecedores: TfrmFornecedores;

implementation

{$R *.dfm}
uses
  Crud.Models.Fornecedor;

{ TfrmFornecedores }

procedure TfrmFornecedores.btnCancelarClick(Sender: TObject);
begin
  Self.Close
end;

procedure TfrmFornecedores.btnSalvarClick(Sender: TObject);
begin
  CamposObrigatorios;
  SalvarFornecedor;
  Self.Close;
  ModalResult := mrOK;
end;

class function TfrmFornecedores.Execute(iCodigoFornecedor: Integer; bNew: Boolean): Boolean;
var
  objForm: TfrmFornecedores;
begin
  objForm := TfrmFornecedores.Create(nil);

  try
   if not bNew then
    objForm.LoadObject(iCodigoFornecedor);

   objForm.New := bNew;
   Result := objForm.ShowModal = mrOK;
  finally
   objForm.Free;
  end;
end;

procedure TfrmFornecedores.CamposObrigatorios;
var
  sNome: String;
  i: integer;
begin

  if edtDescricao.Text = '' then
   begin
    MessageDlg('O campo Descrição do fornecedor é de preenchimento obrigatório.', mtError, [mbOk], 0);
    edtDescricao.Focused;
    Abort;
   end;

  if edtCidade.Text = '' then
   begin
    MessageDlg('O campo cidade é de preenchimento obrigatório.', mtError, [mbOk], 0);
    edtCidade.Focused;
    Abort;
   end;
end;

procedure TfrmFornecedores.LoadObject(iCodigoFornecedor: integer);
var
  objFornecedor: TFornecedorController;
  mFornecedor: TFornecedor;
begin
  objFornecedor := TFornecedorController.Create;

  try
   mFornecedor := objFornecedor.FindId(iCodigoFornecedor);

   edtCodigo.Text    := IntToStr(mFornecedor.CodigoFornecedor);
   edtDescricao.Text := mFornecedor.DescricaoFornecedor;
   edtCidade.Text    := mFornecedor.CidadeFornecedor;
  finally
   mFornecedor.Free;
   objFornecedor.Free;
  end;
end;

procedure TfrmFornecedores.SalvarFornecedor;
var
  objFornecedor: TFornecedorController;
begin
  objFornecedor := TFornecedorController.Create;

  try
   if New then
    objFornecedor.Inserir(
      edtDescricao.Text,
      edtCidade.Text
    )
   else
    objFornecedor.Update(
      StrToInt(edtCodigo.Text),
      edtDescricao.Text,
      edtCidade.Text
    )
  finally
   objFornecedor.Free;
  end;
end;

end.
