object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Teste de performance'
  ClientHeight = 86
  ClientWidth = 317
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 7
    Width = 122
    Height = 13
    Caption = 'Quantidade de itera'#231#245'es:'
  end
  object Button1: TButton
    Left = 32
    Top = 53
    Width = 113
    Height = 25
    Caption = 'Pela Interface'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 53
    Width = 121
    Height = 25
    Caption = 'Pela RTTI'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 26
    Width = 122
    Height = 21
    TabOrder = 2
    Text = '10000'
  end
end
