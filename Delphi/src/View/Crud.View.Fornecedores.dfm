object frmFornecedores: TfrmFornecedores
  Left = 0
  Top = 0
  Caption = 'Cadastro de Fornecedores'
  ClientHeight = 164
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gbDescricao: TGroupBox
    Left = 20
    Top = 15
    Width = 305
    Height = 41
    Caption = 'Descricao do Fornecedor'
    TabOrder = 0
    object edtDescricao: TEdit
      Left = 10
      Top = 15
      Width = 286
      Height = 21
      TabOrder = 0
    end
  end
  object gbCidade: TGroupBox
    Left = 20
    Top = 64
    Width = 305
    Height = 41
    Caption = 'Cidade do Fornecedor'
    TabOrder = 1
    object edtCidade: TEdit
      Left = 10
      Top = 15
      Width = 286
      Height = 21
      TabOrder = 0
    end
  end
  object btnSalvar: TButton
    Left = 83
    Top = 125
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 188
    Top = 125
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object edtCodigo: TEdit
    Left = 304
    Top = 127
    Width = 33
    Height = 21
    Enabled = False
    TabOrder = 4
    Visible = False
  end
end
