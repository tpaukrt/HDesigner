// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2006 Tomas Paukrt

unit uArea;

interface

uses
  Windows, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, SysUtils,
  uConfig;

// *****************************************************************************
// *****************************************************************************

type
  TFormArea = class(TForm)
    imgLayer1 : TImage;
    pnlLayer1 : TPanel;
    edLayer1  : TEdit;
    lbLayer1a : TLabel;
    lbLayer1b : TLabel;
    //
    imgLayer2 : TImage;
    pnlLayer2 : TPanel;
    edLayer2  : TEdit;
    lbLayer2a : TLabel;
    lbLayer2b : TLabel;
    //
    imgLayer3 : TImage;
    pnlLayer3 : TPanel;
    edLayer3  : TEdit;
    lbLayer3a : TLabel;
    lbLayer3b : TLabel;
    //
    imgLayer4 : TImage;
    pnlLayer4 : TPanel;
    edLayer4  : TEdit;
    lbLayer4a : TLabel;
    lbLayer4b : TLabel;
    //
    imgLayer5 : TImage;
    pnlLayer5 : TPanel;
    edLayer5  : TEdit;
    lbLayer5a : TLabel;
    lbLayer5b : TLabel;
    //
    lbInfo    : TLabel;
    //
    btnClose  : TButton;
    //
    procedure FormShow(Sender : TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  public
    procedure Execute(Config : TConfig; S1, S2, S3, S4, S5 : Real);
  end;

var
  FormArea : TFormArea;

// *****************************************************************************
// *****************************************************************************

implementation

{$R *.DFM}

// *****************************************************************************
// ******************  TRIDA TFormArea - PRIVATNI METODY  **********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// udalost - stisk klavesy
procedure TFormArea.FormKeyPress(Sender : TObject; var Key : Char);
begin
  if Key = Chr(VK_ESCAPE) then
    Close();
end;

// -----------------------------------------------------------------------------
// udalost - zobrazeni formulare
procedure TFormArea.FormShow(Sender : TObject);
begin
  btnClose.SetFocus();
end;

// *****************************************************************************
// ******************  TRIDA TFormArea - VEREJNE METODY  ***********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// otevreni dialogu
procedure TFormArea.Execute(Config : TConfig; S1, S2, S3, S4, S5 : Real);
begin
  pnlLayer1.Caption := Config.LayerName[slLayer1];
  pnlLayer2.Caption := Config.LayerName[slLayer2];
  pnlLayer3.Caption := Config.LayerName[slLayer3];
  pnlLayer4.Caption := Config.LayerName[slLayer4];
  pnlLayer5.Caption := Config.LayerName[slLayer5];

  edLayer1.Text := FloatToStrF(S1, ffFixed, 7, 2);
  edLayer2.Text := FloatToStrF(S2, ffFixed, 7, 2);
  edLayer3.Text := FloatToStrF(S3, ffFixed, 7, 2);
  edLayer4.Text := FloatToStrF(S4, ffFixed, 7, 2);
  edLayer5.Text := FloatToStrF(S5, ffFixed, 7, 2);

  Position := poMainFormCenter;
  ShowModal();
end;

// *****************************************************************************
// *****************************************************************************

end.
