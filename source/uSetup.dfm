object FormSetup: TFormSetup
  Left = 369
  Top = 211
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 156
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 337
    Height = 105
    ActivePage = tabLayer1
    TabIndex = 0
    TabOrder = 0
    object tabLayer1: TTabSheet
      Caption = '1st layer'
      object lbName1: TLabel
        Left = 12
        Top = 16
        Width = 28
        Height = 13
        Caption = 'Name'
      end
      object lbEditorColor1: TLabel
        Left = 196
        Top = 16
        Width = 64
        Height = 13
        Caption = 'Color in editor'
      end
      object lbDefaultTransparency1: TLabel
        Left = 12
        Top = 48
        Width = 98
        Height = 13
        Caption = 'Default transparency'
      end
      object lbDefaultColor1: TLabel
        Left = 196
        Top = 48
        Width = 60
        Height = 13
        Caption = 'Default color'
      end
      object edName1: TEdit
        Left = 68
        Top = 12
        Width = 105
        Height = 21
        TabOrder = 0
      end
      object pnlDefaultColor1: TPanel
        Left = 282
        Top = 44
        Width = 35
        Height = 22
        TabOrder = 1
        object shpDefaultColor1: TShape
          Left = 3
          Top = 2
          Width = 29
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
      object cbDefaultTransparency1: TComboBox
        Left = 124
        Top = 44
        Width = 49
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        TabStop = False
        Items.Strings = (
          '0 %'
          '10 %'
          '20 %'
          '30 %'
          '40 %'
          '50 %'
          '60 %'
          '70 %'
          '80 %'
          '90 %')
      end
      object pnlEditorColor1: TPanel
        Left = 282
        Top = 12
        Width = 35
        Height = 22
        TabOrder = 3
        object shpEditorColor1: TShape
          Left = 2
          Top = 2
          Width = 30
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
    end
    object tabLayer2: TTabSheet
      Caption = '2nd layer'
      ImageIndex = 1
      object lbName2: TLabel
        Left = 12
        Top = 16
        Width = 28
        Height = 13
        Caption = 'Name'
      end
      object lbEditorColor2: TLabel
        Left = 196
        Top = 16
        Width = 64
        Height = 13
        Caption = 'Color in editor'
      end
      object lbDefaultTransparency2: TLabel
        Left = 12
        Top = 48
        Width = 98
        Height = 13
        Caption = 'Default transparency'
      end
      object lbDefaultColor2: TLabel
        Left = 196
        Top = 48
        Width = 60
        Height = 13
        Caption = 'Default color'
      end
      object edName2: TEdit
        Left = 68
        Top = 12
        Width = 105
        Height = 21
        TabOrder = 0
      end
      object pnlDefaultColor2: TPanel
        Left = 282
        Top = 44
        Width = 35
        Height = 22
        TabOrder = 1
        object shpDefaultColor2: TShape
          Left = 3
          Top = 2
          Width = 29
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
      object cbDefaultTransparency2: TComboBox
        Left = 124
        Top = 44
        Width = 49
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        TabStop = False
        Items.Strings = (
          '0 %'
          '10 %'
          '20 %'
          '30 %'
          '40 %'
          '50 %'
          '60 %'
          '70 %'
          '80 %'
          '90 %')
      end
      object pnlEditorColor2: TPanel
        Left = 282
        Top = 12
        Width = 35
        Height = 22
        TabOrder = 3
        object shpEditorColor2: TShape
          Left = 2
          Top = 2
          Width = 30
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
    end
    object tabLayer3: TTabSheet
      Caption = '3rd layer'
      ImageIndex = 2
      object lbName3: TLabel
        Left = 12
        Top = 16
        Width = 28
        Height = 13
        Caption = 'Name'
      end
      object lbEditorColor3: TLabel
        Left = 196
        Top = 16
        Width = 64
        Height = 13
        Caption = 'Color in editor'
      end
      object lbDefaultTransparency3: TLabel
        Left = 12
        Top = 48
        Width = 98
        Height = 13
        Caption = 'Default transparency'
      end
      object lbDefaultColor3: TLabel
        Left = 196
        Top = 48
        Width = 60
        Height = 13
        Caption = 'Default color'
      end
      object edName3: TEdit
        Left = 68
        Top = 12
        Width = 105
        Height = 21
        TabOrder = 0
      end
      object pnlDefaultColor3: TPanel
        Left = 282
        Top = 44
        Width = 35
        Height = 22
        TabOrder = 1
        object shpDefaultColor3: TShape
          Left = 3
          Top = 2
          Width = 29
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
      object cbDefaultTransparency3: TComboBox
        Left = 124
        Top = 44
        Width = 49
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        TabStop = False
        Items.Strings = (
          '0 %'
          '10 %'
          '20 %'
          '30 %'
          '40 %'
          '50 %'
          '60 %'
          '70 %'
          '80 %'
          '90 %')
      end
      object pnlEditorColor3: TPanel
        Left = 282
        Top = 12
        Width = 35
        Height = 22
        TabOrder = 3
        object shpEditorColor3: TShape
          Left = 2
          Top = 2
          Width = 30
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
    end
    object tabLayer4: TTabSheet
      Caption = '4th layer'
      ImageIndex = 3
      object lbName4: TLabel
        Left = 12
        Top = 16
        Width = 28
        Height = 13
        Caption = 'Name'
      end
      object lbEditorColor4: TLabel
        Left = 196
        Top = 16
        Width = 64
        Height = 13
        Caption = 'Color in editor'
      end
      object lbDefaultTransparency4: TLabel
        Left = 12
        Top = 48
        Width = 98
        Height = 13
        Caption = 'Default transparency'
      end
      object lbDefaultColor4: TLabel
        Left = 196
        Top = 48
        Width = 60
        Height = 13
        Caption = 'Default color'
      end
      object edName4: TEdit
        Left = 68
        Top = 12
        Width = 105
        Height = 21
        TabOrder = 0
      end
      object pnlDefaultColor4: TPanel
        Left = 282
        Top = 44
        Width = 35
        Height = 22
        TabOrder = 1
        object shpDefaultColor4: TShape
          Left = 3
          Top = 2
          Width = 29
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
      object cbDefaultTransparency4: TComboBox
        Left = 124
        Top = 44
        Width = 49
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        TabStop = False
        Items.Strings = (
          '0 %'
          '10 %'
          '20 %'
          '30 %'
          '40 %'
          '50 %'
          '60 %'
          '70 %'
          '80 %'
          '90 %')
      end
      object pnlEditorColor4: TPanel
        Left = 282
        Top = 12
        Width = 35
        Height = 22
        TabOrder = 3
        object shpEditorColor4: TShape
          Left = 2
          Top = 2
          Width = 30
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
    end
    object tabLayer5: TTabSheet
      Caption = '5th layer'
      ImageIndex = 4
      object lbName5: TLabel
        Left = 12
        Top = 16
        Width = 28
        Height = 13
        Caption = 'Name'
      end
      object lbEditorColor5: TLabel
        Left = 196
        Top = 16
        Width = 64
        Height = 13
        Caption = 'Color in editor'
      end
      object lbDefaultTransparency5: TLabel
        Left = 12
        Top = 48
        Width = 98
        Height = 13
        Caption = 'Default transparency'
      end
      object lbDefaultColor5: TLabel
        Left = 196
        Top = 48
        Width = 60
        Height = 13
        Caption = 'Default color'
      end
      object edName5: TEdit
        Left = 68
        Top = 12
        Width = 105
        Height = 21
        TabOrder = 0
      end
      object pnlDefaultColor5: TPanel
        Left = 282
        Top = 44
        Width = 35
        Height = 22
        TabOrder = 1
        object shpDefaultColor5: TShape
          Left = 3
          Top = 2
          Width = 29
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
      object cbDefaultTransparency5: TComboBox
        Left = 124
        Top = 44
        Width = 49
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        TabStop = False
        Items.Strings = (
          '0 %'
          '10 %'
          '20 %'
          '30 %'
          '40 %'
          '50 %'
          '60 %'
          '70 %'
          '80 %'
          '90 %')
      end
      object pnlEditorColor5: TPanel
        Left = 282
        Top = 12
        Width = 35
        Height = 22
        TabOrder = 3
        object shpEditorColor5: TShape
          Left = 2
          Top = 2
          Width = 30
          Height = 18
          OnMouseDown = shpMouseDown
        end
      end
    end
  end
  object btnOK: TButton
    Left = 177
    Top = 123
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 265
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
