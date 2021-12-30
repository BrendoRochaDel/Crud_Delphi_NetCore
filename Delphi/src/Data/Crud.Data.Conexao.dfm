object dmConexao: TdmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 134
  Width = 273
  object Conecta: TFDConnection
    Params.Strings = (
      'Database=crud'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object FDMySql: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Projetos\Delphi\Crud\libmysql.dll'
    Left = 104
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 176
    Top = 40
  end
end
