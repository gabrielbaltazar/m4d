object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Storing the history info database'
  ClientHeight = 485
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 485
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 223
      Width = 24
      Height = 13
      Caption = 'Start'
    end
    object Label2: TLabel
      Left = 100
      Top = 223
      Width = 18
      Height = 13
      Caption = 'End'
    end
    object Label3: TLabel
      Left = 18
      Top = 439
      Width = 24
      Height = 13
      Caption = 'Start'
    end
    object Label4: TLabel
      Left = 100
      Top = 439
      Width = 18
      Height = 13
      Caption = 'End'
    end
    object btnExecuteAll: TButton
      Left = 18
      Top = 72
      Width = 153
      Height = 25
      Caption = 'Execute all migrations'
      TabOrder = 0
      OnClick = btnExecuteAllClick
    end
    object btnExecutePending: TButton
      Left = 18
      Top = 161
      Width = 153
      Height = 25
      Caption = 'Execute pending migrations'
      TabOrder = 1
      OnClick = btnExecutePendingClick
    end
    object btnRollbackAll: TButton
      Left = 18
      Top = 288
      Width = 153
      Height = 25
      Caption = 'Rollback all migrations'
      TabOrder = 2
      OnClick = btnRollbackAllClick
    end
    object btnMigrationsList: TButton
      Left = 16
      Top = 41
      Width = 153
      Height = 25
      Caption = '1 - Migrations List'
      TabOrder = 3
      OnClick = btnMigrationsListClick
    end
    object btnRollbackUntil: TButton
      Left = 18
      Top = 319
      Width = 153
      Height = 25
      Caption = 'Rollback Until'
      TabOrder = 4
      OnClick = btnRollbackUntilClick
    end
    object edtSeqToRollback: TEdit
      Left = 18
      Top = 350
      Width = 153
      Height = 21
      TabOrder = 5
    end
    object btnExecuteUntil: TButton
      Left = 18
      Top = 103
      Width = 153
      Height = 25
      Caption = 'Execute migrations until'
      TabOrder = 6
      OnClick = btnExecuteUntilClick
    end
    object edtSeqToExecute: TEdit
      Left = 18
      Top = 134
      Width = 153
      Height = 21
      TabOrder = 7
    end
    object Button2: TButton
      Left = 18
      Top = 377
      Width = 153
      Height = 25
      Caption = 'Rollback pending migrations'
      TabOrder = 8
      OnClick = Button2Click
    end
    object btnExecuteRange: TButton
      Left = 18
      Top = 192
      Width = 153
      Height = 25
      Caption = 'Execute Range'
      TabOrder = 9
      OnClick = btnExecuteRangeClick
    end
    object edtStartExecute: TEdit
      Left = 18
      Top = 241
      Width = 71
      Height = 21
      TabOrder = 10
      Text = '1'
    end
    object edtEndExecute: TEdit
      Left = 100
      Top = 241
      Width = 71
      Height = 21
      TabOrder = 11
      Text = '1'
    end
    object btnRollbackRange: TButton
      Left = 18
      Top = 408
      Width = 153
      Height = 25
      Caption = 'Rollback Range'
      TabOrder = 12
      OnClick = btnRollbackRangeClick
    end
    object edtStartRollback: TEdit
      Left = 18
      Top = 457
      Width = 71
      Height = 21
      TabOrder = 13
      Text = '1'
    end
    object edtEndRollback: TEdit
      Left = 98
      Top = 457
      Width = 71
      Height = 21
      TabOrder = 14
      Text = '1'
    end
  end
  object pnlRigth: TPanel
    Left = 177
    Top = 0
    Width = 536
    Height = 485
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object memInfo: TMemo
      Left = 0
      Top = 41
      Width = 536
      Height = 234
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object pnlHistory: TPanel
      Left = 0
      Top = 0
      Width = 536
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Button4: TButton
        Left = 126
        Top = 10
        Width = 123
        Height = 25
        Caption = 'Get Migration History'
        TabOrder = 0
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 255
        Top = 10
        Width = 138
        Height = 25
        Caption = 'Get Last Migration History'
        TabOrder = 1
        OnClick = Button5Click
      end
      object btnClearHistory: TButton
        Left = 0
        Top = 10
        Width = 121
        Height = 25
        Caption = 'Clear History'
        TabOrder = 2
        OnClick = btnClearHistoryClick
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 275
      Width = 536
      Height = 210
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 536
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Button1: TButton
          Left = 0
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Open Query'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 32
        Width = 536
        Height = 178
        Align = alClient
        DataSource = dtsEmployers
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object qryEmployers: TFDQuery
    Connection = DMDBDemo.SQLiteConection
    SQL.Strings = (
      'SELECT * FROM CUSTOMERS')
    Left = 353
    Top = 379
  end
  object dtsEmployers: TDataSource
    DataSet = qryEmployers
    Left = 401
    Top = 379
  end
end
