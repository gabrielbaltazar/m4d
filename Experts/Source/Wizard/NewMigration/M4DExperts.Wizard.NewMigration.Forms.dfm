object FrmM4DExpertsWizarNewMigrationForms: TFrmM4DExpertsWizarNewMigrationForms
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'New Migration'
  ClientHeight = 300
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'New Migration'
    Color = 11962426
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 651
    Height = 259
    Align = alClient
    BevelOuter = bvNone
    Color = 16117996
    ParentBackground = False
    TabOrder = 1
    object Label3: TLabel
      AlignWithMargins = True
      Left = 20
      Top = 10
      Width = 628
      Height = 16
      Margins.Left = 20
      Margins.Top = 10
      Align = alTop
      Caption = 'Info Migration'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3355443
      Font.Height = -13
      Font.Name = 'Sergoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 88
    end
    object BtnCancel: TShape
      Left = 152
      Top = 208
      Width = 111
      Height = 33
      Brush.Color = 2439639
      Pen.Color = 11962426
      Pen.Style = psClear
      Shape = stRoundRect
    end
    object BtnConfirm: TShape
      Left = 20
      Top = 208
      Width = 111
      Height = 33
      Brush.Color = 11962426
      Pen.Color = 11962426
      Pen.Style = psClear
      Shape = stRoundRect
    end
    object LblConfirm: TLabel
      Left = 20
      Top = 208
      Width = 111
      Height = 31
      Alignment = taCenter
      AutoSize = False
      Caption = 'Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Sergoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      OnClick = LblConfirmClick
    end
    object LblCancel: TLabel
      Left = 152
      Top = 208
      Width = 110
      Height = 30
      Alignment = taCenter
      AutoSize = False
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Sergoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      OnClick = LblCancelClick
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 20
      Top = 32
      Width = 611
      Height = 161
      Margins.Left = 20
      Margins.Right = 20
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      object LblDescription: TLabel
        Left = 16
        Top = 17
        Width = 63
        Height = 14
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblName: TLabel
        Left = 16
        Top = 61
        Width = 31
        Height = 14
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPrimaryKey: TLabel
        Left = 447
        Top = 61
        Width = 79
        Height = 14
        Caption = 'Migration Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object Label4: TLabel
        Left = 447
        Top = 17
        Width = 55
        Height = 14
        Caption = 'Sequence'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 16
        Top = 109
        Width = 44
        Height = 14
        Caption = 'Save As'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 447
        Top = 109
        Width = 32
        Height = 14
        Caption = 'Prefix'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 611
        Height = 6
        Align = alTop
        BevelOuter = bvNone
        Color = 11962426
        ParentBackground = False
        TabOrder = 5
      end
      object EdtDescription: TEdit
        Left = 16
        Top = 33
        Width = 417
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = EdtDescriptionChange
      end
      object EdtName: TEdit
        Left = 16
        Top = 77
        Width = 417
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object EdtSequence: TEdit
        Left = 447
        Top = 33
        Width = 94
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 1
      end
      object EdtMigrationDate: TDateTimePicker
        Left = 447
        Top = 77
        Width = 143
        Height = 21
        Date = 44172.000000000000000000
        Format = 'dd/MM/yyyy hh:mm:ss'
        Time = 0.582490219909232100
        DateFormat = dfLong
        TabOrder = 4
      end
      object EdtSaveAs: TEdit
        Left = 16
        Top = 125
        Width = 385
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object EdtPrefix: TEdit
        Left = 447
        Top = 125
        Width = 94
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object BtnPath: TButton
        Left = 405
        Top = 123
        Width = 28
        Height = 25
        Caption = '...'
        TabOrder = 7
        OnClick = BtnPathClick
      end
    end
  end
end
