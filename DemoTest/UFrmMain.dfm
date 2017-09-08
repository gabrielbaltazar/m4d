object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Storing the history info on file system'
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
      Top = 192
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
      Top = 223
      Width = 153
      Height = 25
      Caption = 'Rollback Until'
      TabOrder = 4
      OnClick = btnRollbackUntilClick
    end
    object edtSeqToRollback: TEdit
      Left = 18
      Top = 254
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
      Height = 444
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
  end
end
