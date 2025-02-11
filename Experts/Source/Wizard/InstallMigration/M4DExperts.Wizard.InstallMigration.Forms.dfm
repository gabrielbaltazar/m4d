object FrmM4DExpertsWizardInstallMigrationForms: TFrmM4DExpertsWizardInstallMigrationForms
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Install Migration'
  ClientHeight = 290
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object PnlTop: TPanel
    Left = 0
    Top = 0
    Width = 546
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Install Migration'
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
    Width = 546
    Height = 249
    Align = alClient
    BevelOuter = bvNone
    Color = 16117996
    ParentBackground = False
    TabOrder = 1
    object Label3: TLabel
      AlignWithMargins = True
      Left = 20
      Top = 10
      Width = 523
      Height = 16
      Margins.Left = 20
      Margins.Top = 10
      Align = alTop
      Caption = 'Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3355443
      Font.Height = -13
      Font.Name = 'Sergoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 24
    end
    object BtnCancel: TShape
      Left = 152
      Top = 184
      Width = 111
      Height = 33
      Brush.Color = 2439639
      Pen.Color = 11962426
      Pen.Style = psClear
      Shape = stRoundRect
    end
    object BtnConfirm: TShape
      Left = 20
      Top = 184
      Width = 111
      Height = 33
      Brush.Color = 11962426
      Pen.Color = 11962426
      Pen.Style = psClear
      Shape = stRoundRect
    end
    object LblConfirm: TLabel
      Left = 20
      Top = 184
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
      Top = 184
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
      Width = 506
      Height = 137
      Margins.Left = 20
      Margins.Right = 20
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 77
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
        Left = 16
        Top = 21
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
        Width = 506
        Height = 6
        Align = alTop
        BevelOuter = bvNone
        Color = 11962426
        ParentBackground = False
        TabOrder = 1
      end
      object EdtSaveAs: TEdit
        Left = 16
        Top = 93
        Width = 423
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object EdtPrefix: TEdit
        Left = 16
        Top = 37
        Width = 94
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 3355443
        Font.Height = -11
        Font.Name = 'Sergoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object BtnPath: TButton
        Left = 445
        Top = 91
        Width = 28
        Height = 25
        Caption = '...'
        TabOrder = 3
        OnClick = BtnPathClick
      end
    end
  end
end
