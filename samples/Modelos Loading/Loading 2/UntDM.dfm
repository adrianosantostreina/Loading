object DM: TDM
  OldCreateOrder = False
  Height = 207
  Width = 304
  object fdConn: TFDConnection
    Params.Strings = (
      
        'Database=D:\Temp\52. Boas Pr'#225'ticas - Loadings Diferentes\Loading' +
        ' 2\database\cpvendas.db'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = fdConnBeforeConnect
    Left = 56
    Top = 16
  end
  object QryCidades: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      
        'SELECT COUNT(*) FROM MOB006 WHERE CID_ESTADO IN (23, 29, 31, 33,' +
        ' 35, 55)')
    Left = 56
    Top = 80
    object QryCidadesCID_ID: TFDAutoIncField
      FieldName = 'CID_ID'
      Origin = 'CID_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryCidadesCID_CODIBGE: TIntegerField
      FieldName = 'CID_CODIBGE'
      Origin = 'CID_CODIBGE'
      Required = True
    end
    object QryCidadesCID_NOME: TStringField
      FieldName = 'CID_NOME'
      Origin = 'CID_NOME'
      Size = 100
    end
    object QryCidadesCID_LATITUDE: TFMTBCDField
      FieldName = 'CID_LATITUDE'
      Origin = 'CID_LATITUDE'
      Precision = 18
      Size = 10
    end
    object QryCidadesCID_LONGITUDE: TFMTBCDField
      FieldName = 'CID_LONGITUDE'
      Origin = 'CID_LONGITUDE'
      Precision = 18
      Size = 10
    end
    object QryCidadesCID_CAPITAL: TBooleanField
      FieldName = 'CID_CAPITAL'
      Origin = 'CID_CAPITAL'
      Required = True
    end
    object QryCidadesCID_ESTADO: TIntegerField
      FieldName = 'CID_ESTADO'
      Origin = 'CID_ESTADO'
      Required = True
    end
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 184
    Top = 16
  end
end
