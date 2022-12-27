object FormColor: TFormColor
  Left = 435
  Top = 135
  BorderStyle = bsDialog
  Caption = 'Color'
  ClientHeight = 354
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pboxColors: TPaintBox
    Left = 8
    Top = 8
    Width = 250
    Height = 250
    OnMouseDown = pboxColorsMouseDown
    OnPaint = pboxColorsPaint
  end
  object lbBasic: TLabel
    Left = 97
    Top = 119
    Width = 52
    Height = 13
    Caption = 'Basic color'
  end
  object pboxDetails: TPaintBox
    Left = 280
    Top = 8
    Width = 246
    Height = 299
  end
  object stBasic: TStaticText
    Left = 96
    Top = 134
    Width = 72
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 360
    Top = 320
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 448
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
