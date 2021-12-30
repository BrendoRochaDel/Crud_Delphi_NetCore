object frmProdutos: TfrmProdutos
  Left = 0
  Top = 0
  Caption = 'Cadastro de Produto'
  ClientHeight = 228
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object gbDescricao: TGroupBox
    Left = 12
    Top = 20
    Width = 305
    Height = 41
    Caption = 'Descri'#231#227'o do Produto'
    TabOrder = 0
    object edtDescricao: TEdit
      Left = 10
      Top = 15
      Width = 286
      Height = 21
      TabOrder = 0
    end
  end
  object gbSituacao: TGroupBox
    Left = 324
    Top = 20
    Width = 119
    Height = 41
    Caption = 'Situa'#231#227'o do Produto'
    TabOrder = 1
    object cbSituacao: TComboBox
      Left = 10
      Top = 15
      Width = 99
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = 'Ativo'
      OnExit = cbSituacaoExit
      Items.Strings = (
        'Ativo'
        'Inativo')
    end
  end
  object edtCodigo: TEdit
    Left = 422
    Top = 207
    Width = 33
    Height = 21
    Enabled = False
    TabOrder = 7
    Visible = False
  end
  object btnCancelar: TButton
    Left = 243
    Top = 189
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 6
    OnClick = btnCancelarClick
  end
  object btnSalvar: TButton
    Left = 138
    Top = 189
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object gbFabricacao: TGroupBox
    Left = 12
    Top = 71
    Width = 210
    Height = 41
    Caption = 'Data de Fabrica'#231#227'o'
    TabOrder = 2
    object dtaFabricacao: TDateTimePicker
      Left = 10
      Top = 15
      Width = 190
      Height = 21
      Date = 44197.000000000000000000
      Time = 44197.000000000000000000
      TabOrder = 0
      OnExit = ValidarDatas
    end
  end
  object gbFornecedor: TGroupBox
    Left = 12
    Top = 121
    Width = 431
    Height = 41
    Caption = 'Fornecedor'
    TabOrder = 4
    object dcbFornecedor: TDBLookupComboBox
      Left = 68
      Top = 15
      Width = 353
      Height = 21
      KeyField = 'CodigoFornecedor'
      ListField = 'DescricaoFornecedor'
      ListSource = dtsFornecedor
      TabOrder = 1
      OnExit = dcbFornecedorExit
    end
    object edtCodigoFornecedor: TNumberBox
      Left = 10
      Top = 15
      Width = 50
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      TabOrder = 0
      OnExit = edtCodigoFornecedorExit
    end
  end
  object gbValidade: TGroupBox
    Left = 233
    Top = 71
    Width = 210
    Height = 41
    Caption = 'Data de Validade'
    TabOrder = 3
    object dtaValidade: TDateTimePicker
      Left = 10
      Top = 15
      Width = 190
      Height = 21
      Date = 44561.000000000000000000
      Time = 44561.000000000000000000
      TabOrder = 0
      OnExit = ValidarDatas
    end
  end
  object dtsFornecedor: TDataSource
    Left = 56
    Top = 176
  end
end
