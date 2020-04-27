object FormMain: TFormMain
  Left = 971
  Top = 244
  Width = 641
  Height = 359
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1044#1077#1088#1077#1074#1086
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TV1: TTreeView
    Left = 177
    Top = 0
    Width = 224
    Height = 320
    Align = alLeft
    Indent = 19
    TabOrder = 0
  end
  object TV2: TTreeView
    Left = 401
    Top = 0
    Width = 224
    Height = 320
    Align = alClient
    Indent = 19
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 320
    Align = alLeft
    TabOrder = 2
    object Razmer: TLabel
      Left = 40
      Top = 16
      Width = 39
      Height = 13
      Caption = #1056#1072#1079#1084#1077#1088
    end
    object BtnOd: TButton
      Left = 32
      Top = 80
      Width = 113
      Height = 33
      Caption = #1054#1076#1080#1085#1072#1082#1086#1074#1099#1077
      TabOrder = 0
      OnClick = BtnOdClick
    end
    object BtnRand: TButton
      Left = 32
      Top = 128
      Width = 113
      Height = 33
      Caption = #1056#1072#1085#1076#1086#1084#1085#1099#1077
      TabOrder = 1
      OnClick = BtnRandClick
    end
    object btnRez: TButton
      Left = 32
      Top = 176
      Width = 113
      Height = 33
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      TabOrder = 2
      OnClick = btnRezClick
    end
    object edRez: TLabeledEdit
      Left = 32
      Top = 232
      Width = 113
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
      TabOrder = 3
    end
    object btnClear: TButton
      Left = 32
      Top = 272
      Width = 113
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 4
    end
  end
end
