object FormAbout: TFormAbout
  Left = 230
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 126
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 72
    Top = 92
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object GroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 73
    TabOrder = 1
    object lbName: TLabel
      Left = 16
      Top = 16
      Width = 166
      Height = 27
      Alignment = taCenter
      Caption = 'Home Designer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lbVersion: TLabel
      Left = 16
      Top = 48
      Width = 169
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'version A.B.C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
