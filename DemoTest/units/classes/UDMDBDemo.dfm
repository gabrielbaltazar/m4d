object DMDBDemo: TDMDBDemo
  OldCreateOrder = False
  Height = 241
  Width = 317
  object SQLiteConection: TFDConnection
    Params.Strings = (
      'Database=db.s3db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 39
    Top = 30
  end
end
