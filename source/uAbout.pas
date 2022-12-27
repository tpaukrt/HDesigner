// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2006 Tomas Paukrt

unit uAbout;

interface

uses
  Windows, Forms, Classes, Controls, StdCtrls, SysUtils;

// *****************************************************************************
// *****************************************************************************

type
  TFormAbout = class(TForm)
    GroupBox    : TGroupBox;
    lbName      : TLabel;
    lbVersion   : TLabel;
    //
    btnOK       : TButton;
    //
    procedure FormKeyPress(Sender : TObject; var Key : Char);
    procedure FormCreate(Sender : TObject);
  public
    procedure Execute();
  end;

var
  FormAbout : TFormAbout;

// *****************************************************************************
// *****************************************************************************

implementation

{$R *.DFM}

// *****************************************************************************
// ****************************  POMOCNE FUNKCE  *******************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// zjisteni verze souboru (programu)
function GetFileVersion() : String;
var
  Size   : Cardinal;
  Length : Cardinal;
  Temp   : Cardinal;
  Buffer : Pointer;
  Value  : Pointer;
begin
  Result := '';
  Size := GetFileVersionInfoSize(PChar(Application.ExeName), Temp);
  if Size > 0 then
    try
      GetMem(Buffer, Size);
      try
        GetFileVersionInfo(PChar(Application.ExeName), 0, Size, Buffer);
        VerQueryValue(Buffer, '\', Value, Length);
        if Assigned(Value) then
          with TVSFixedFileInfo(Value^) do
            Result := Format('%u.%u.%u', [HiWord(dwFileVersionMS),
                                          LoWord(dwFileVersionMS),
                                          HiWord(dwFileVersionLS)]);
      finally
        FreeMem(Buffer, Size);
      end;
    except
    end;
end;

// *****************************************************************************
// ******************  TRIDA TFormAbout - PRIVATNI METODY  *********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// udalost - stisk klavesy
procedure TFormAbout.FormKeyPress(Sender : TObject; var Key : Char);
begin
  if Key = Chr(VK_ESCAPE) then
    Close();
end;

// -----------------------------------------------------------------------------
// udalost - vytvoreni formulare
procedure TFormAbout.FormCreate(Sender : TObject);
var
  Version : String;
begin
  Version := GetFileVersion();
  if Version <> '' then
    lbVersion.Caption := 'version ' + Version;
end;

// *****************************************************************************
// ******************  TRIDA TFormAbout - VEREJNE METODY  **********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// otevreni dialogu
procedure TFormAbout.Execute();
begin
  Position := poMainFormCenter;
  ShowModal();
end;

// *****************************************************************************
// *****************************************************************************

end.
