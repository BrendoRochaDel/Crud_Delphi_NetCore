object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Tela Inicial'
  ClientHeight = 580
  ClientWidth = 769
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pagPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 769
    Height = 580
    ActivePage = tabProdutos
    Align = alClient
    TabOrder = 0
    object tabProdutos: TTabSheet
      Caption = 'Produtos'
      object lbTituloProdutos: TLabel
        Left = 12
        Top = 26
        Width = 116
        Height = 32
        Caption = 'Produtos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object dbgProdutos: TDBGrid
        Left = 11
        Top = 87
        Width = 646
        Height = 449
        DataSource = dtsProdutos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CodigoProduto'
            Title.Caption = 'C'#243'digo'
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoProduto'
            Title.Caption = 'Descri'#231#227'o do Produto'
            Width = 317
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SituacaoProduto'
            Title.Caption = 'Situa'#231#227'o do Produto'
            Width = 105
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DataFabricacao'
            Title.Caption = 'Data de Fabrica'#231#227'o'
            Width = 108
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DataValidade'
            Title.Caption = 'Data de Validade'
            Width = 87
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoFornecedor'
            Title.Caption = 'Descricao do Fornecedor'
            Width = 185
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CidadeFornecedor'
            Title.Caption = 'Cidade do Fornecedor'
            Width = 206
            Visible = True
          end>
      end
      object btnInserirProdutos: TButton
        Left = 672
        Top = 95
        Width = 75
        Height = 25
        Caption = 'Inserir'
        TabOrder = 1
        OnClick = btnInserirProdutosClick
      end
      object btnEditarProdutos: TButton
        Left = 672
        Top = 146
        Width = 75
        Height = 25
        Caption = 'Editar'
        TabOrder = 2
        OnClick = btnEditarProdutosClick
      end
      object btnExcluirProdutos: TButton
        Left = 672
        Top = 198
        Width = 75
        Height = 25
        Caption = 'Excluir'
        TabOrder = 3
        OnClick = btnExcluirProdutosClick
      end
    end
    object tabFornecedores: TTabSheet
      Caption = 'Fornecedores'
      ImageIndex = 1
      object lbTituloFornecedores: TLabel
        Left = 12
        Top = 26
        Width = 176
        Height = 32
        Caption = 'Fornecedores:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object dbgFornecedores: TDBGrid
        Left = 11
        Top = 87
        Width = 646
        Height = 449
        DataSource = dtsFornecedores
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CodigoFornecedor'
            Title.Caption = 'C'#243'digo'
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoFornecedor'
            Title.Caption = 'Descri'#231#227'o do Fornecedor'
            Width = 317
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CidadeFornecedor'
            Title.Caption = 'Cidade do Fornecedor'
            Width = 242
            Visible = True
          end>
      end
      object brnInserirFornecedor: TButton
        Left = 672
        Top = 95
        Width = 75
        Height = 25
        Caption = 'Inserir'
        TabOrder = 1
        OnClick = brnInserirFornecedorClick
      end
      object btnEditarFornecedor: TButton
        Left = 672
        Top = 146
        Width = 75
        Height = 25
        Caption = 'Editar'
        TabOrder = 2
        OnClick = btnEditarFornecedorClick
      end
      object btnExcluirFornecedor: TButton
        Left = 672
        Top = 198
        Width = 75
        Height = 25
        Caption = 'Excluir'
        TabOrder = 3
        OnClick = btnExcluirFornecedorClick
      end
    end
  end
  object dtsFornecedores: TDataSource
    Left = 692
    Top = 304
  end
  object dtsProdutos: TDataSource
    Left = 692
    Top = 360
  end
end
