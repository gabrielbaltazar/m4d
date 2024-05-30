object DMDBDemo: TDMDBDemo
  Height = 241
  Width = 317
  object SQLiteConection: TFDConnection
    Params.Strings = (
      'Database=Demo.db3'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = SQLiteConectionBeforeConnect
    Left = 87
    Top = 30
  end
  object FDQMigration: TFDQuery
    Connection = SQLiteConection
    Left = 144
    Top = 104
  end
end
