// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2006 Tomas Paukrt

unit uSetup;

interface

uses
  Windows, Forms, Classes, Controls, StdCtrls, ExtCtrls, ComCtrls, Graphics,
  uConfig, uColor;

// *****************************************************************************
// *****************************************************************************

type
  TFormSetup = class(TForm)
    PageControl            : TPageControl;
    //
    tabLayer1              : TTabSheet;
    lbName1                : TLabel;
    edName1                : TEdit;
    lbEditorColor1         : TLabel;
    pnlEditorColor1        : TPanel;
    shpEditorColor1        : TShape;
    lbDefaultTransparency1 : TLabel;
    cbDefaultTransparency1 : TComboBox;
    lbDefaultColor1        : TLabel;
    pnlDefaultColor1       : TPanel;
    shpDefaultColor1       : TShape;
    //
    tabLayer2              : TTabSheet;
    lbName2                : TLabel;
    edName2                : TEdit;
    lbEditorColor2         : TLabel;
    pnlEditorColor2        : TPanel;
    shpEditorColor2        : TShape;
    lbDefaultTransparency2 : TLabel;
    cbDefaultTransparency2 : TComboBox;
    lbDefaultColor2        : TLabel;
    pnlDefaultColor2       : TPanel;
    shpDefaultColor2       : TShape;
    //
    tabLayer3              : TTabSheet;
    lbName3                : TLabel;
    edName3                : TEdit;
    lbEditorColor3         : TLabel;
    pnlEditorColor3        : TPanel;
    shpEditorColor3        : TShape;
    lbDefaultTransparency3 : TLabel;
    cbDefaultTransparency3 : TComboBox;
    lbDefaultColor3        : TLabel;
    pnlDefaultColor3       : TPanel;
    shpDefaultColor3       : TShape;
    //
    tabLayer4              : TTabSheet;
    lbName4                : TLabel;
    edName4                : TEdit;
    lbEditorColor4         : TLabel;
    pnlDefaultColor4       : TPanel;
    shpDefaultColor4       : TShape;
    lbDefaultTransparency4 : TLabel;
    cbDefaultTransparency4 : TComboBox;
    lbDefaultColor4        : TLabel;
    pnlEditorColor4        : TPanel;
    shpEditorColor4        : TShape;
    //
    tabLayer5              : TTabSheet;
    lbName5                : TLabel;
    edName5                : TEdit;
    lbEditorColor5         : TLabel;
    pnlEditorColor5        : TPanel;
    shpEditorColor5        : TShape;
    lbDefaultTransparency5 : TLabel;
    cbDefaultTransparency5 : TComboBox;
    lbDefaultColor5        : TLabel;
    pnlDefaultColor5       : TPanel;
    shpDefaultColor5       : TShape;
    //
    btnOK                  : TButton;
    btnCancel              : TButton;
    //
    procedure shpMouseDown(Sender : TObject; Button : TMouseButton;
                           Shift : TShiftState; X, Y : Integer);
    procedure FormKeyPress(Sender : TObject; var Key : Char);
    procedure FormShow(Sender : TObject);
  private
    procedure LoadFromConfig(const Config : TConfig);
    procedure SaveToConfig(var Config : TConfig);
  public
    function Execute(var Config : TConfig): Boolean;
  end;

var
  FormSetup : TFormSetup;

// *****************************************************************************
// *****************************************************************************

implementation

{$R *.DFM}

// *****************************************************************************
// ******************  TRIDA TFormSetup - PRIVATNI METODY  *********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// nacteni obsahu editacnich prvku z konfigurace
procedure TFormSetup.LoadFromConfig(const Config : TConfig);
begin
  with Config do begin
    edName1.Text                     := LayerName[slLayer1];
    edName2.Text                     := LayerName[slLayer2];
    edName3.Text                     := LayerName[slLayer3];
    edName4.Text                     := LayerName[slLayer4];
    edName5.Text                     := LayerName[slLayer5];
    shpEditorColor1.Brush.Color      := LayerEditColor[slLayer1];
    shpEditorColor2.Brush.Color      := LayerEditColor[slLayer2];
    shpEditorColor3.Brush.Color      := LayerEditColor[slLayer3];
    shpEditorColor4.Brush.Color      := LayerEditColor[slLayer4];
    shpEditorColor5.Brush.Color      := LayerEditColor[slLayer5];
    shpDefaultColor1.Brush.Color     := LayerDefaultColor[slLayer1];
    shpDefaultColor2.Brush.Color     := LayerDefaultColor[slLayer2];
    shpDefaultColor3.Brush.Color     := LayerDefaultColor[slLayer3];
    shpDefaultColor4.Brush.Color     := LayerDefaultColor[slLayer4];
    shpDefaultColor5.Brush.Color     := LayerDefaultColor[slLayer5];
    cbDefaultTransparency1.ItemIndex := LayerDefaultTransparency[slLayer1] div 10;
    cbDefaultTransparency2.ItemIndex := LayerDefaultTransparency[slLayer2] div 10;
    cbDefaultTransparency3.ItemIndex := LayerDefaultTransparency[slLayer3] div 10;
    cbDefaultTransparency4.ItemIndex := LayerDefaultTransparency[slLayer4] div 10;
    cbDefaultTransparency5.ItemIndex := LayerDefaultTransparency[slLayer5] div 10;
  end;
end;

// -----------------------------------------------------------------------------
// ulozeni obsahu editacnich prvku do konfigurace
procedure TFormSetup.SaveToConfig(var Config : TConfig);
begin
  with Config do begin
    LayerName[slLayer1]                := edName1.Text;
    LayerName[slLayer2]                := edName2.Text;
    LayerName[slLayer3]                := edName3.Text;
    LayerName[slLayer4]                := edName4.Text;
    LayerName[slLayer5]                := edName5.Text;
    LayerEditColor[slLayer1]           := shpEditorColor1.Brush.Color;
    LayerEditColor[slLayer2]           := shpEditorColor2.Brush.Color;
    LayerEditColor[slLayer3]           := shpEditorColor3.Brush.Color;
    LayerEditColor[slLayer4]           := shpEditorColor4.Brush.Color;
    LayerEditColor[slLayer5]           := shpEditorColor5.Brush.Color;
    LayerDefaultColor[slLayer1]        := shpDefaultColor1.Brush.Color;
    LayerDefaultColor[slLayer2]        := shpDefaultColor2.Brush.Color;
    LayerDefaultColor[slLayer3]        := shpDefaultColor3.Brush.Color;
    LayerDefaultColor[slLayer4]        := shpDefaultColor4.Brush.Color;
    LayerDefaultColor[slLayer5]        := shpDefaultColor5.Brush.Color;
    LayerDefaultTransparency[slLayer1] := cbDefaultTransparency1.ItemIndex * 10;
    LayerDefaultTransparency[slLayer2] := cbDefaultTransparency2.ItemIndex * 10;
    LayerDefaultTransparency[slLayer3] := cbDefaultTransparency3.ItemIndex * 10;
    LayerDefaultTransparency[slLayer4] := cbDefaultTransparency4.ItemIndex * 10;
    LayerDefaultTransparency[slLayer5] := cbDefaultTransparency5.ItemIndex * 10;
  end;
end;

// -----------------------------------------------------------------------------
// udalost - zmena barvy
procedure TFormSetup.shpMouseDown(Sender : TObject; Button : TMouseButton;
                                  Shift : TShiftState; X, Y : Integer);
var
  TempColor : TColor;
begin
  if Sender is TShape then
    with Sender as TShape do begin
      TempColor := Brush.Color;
      if FormColor.Execute(TempColor) then
        Brush.Color := TempColor;
    end;
end;

// -----------------------------------------------------------------------------
// udalost - stisk klavesy
procedure TFormSetup.FormKeyPress(Sender : TObject; var Key : Char);
begin
  if Key = Chr(VK_ESCAPE) then
    Close();
end;

// -----------------------------------------------------------------------------
// udalost - zobrazeni formulare
procedure TFormSetup.FormShow(Sender : TObject);
begin
  PageControl.ActivePageIndex := 0;
  edName1.SetFocus();
end;

// *****************************************************************************
// ******************  TRIDA TFormSetup - VEREJNE METODY  **********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// otevreni dialogu
function TFormSetup.Execute(var Config : TConfig) : Boolean;
begin
  Position := poMainFormCenter;
  LoadFromConfig(Config);
  if ShowModal() = mrOk then begin
    SaveToConfig(Config);
    Result := True;
  end else begin
    Result := False;
  end;
end;

// *****************************************************************************
// *****************************************************************************

end.
