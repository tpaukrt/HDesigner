// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2006 Tomas Paukrt

unit uConfig;

interface

uses
  Windows, SysUtils, Graphics, Registry, Math;

// *****************************************************************************
// *****************************************************************************

type
  TLayer         = (slLayer1, slLayer2, slLayer3, slLayer4, slLayer5);
  TAName         = array [TLayer] of String;
  TAColor        = array [TLayer] of TColor;
  TATransparency = array [TLayer] of Byte;

  TConfig = record
    LayerName                : TAName;          // jmeno hladiny
    LayerEditColor           : TAColor;         // barva hladiny v editoru
    LayerDefaultColor        : TAColor;         // vychozi barva hladiny
    LayerDefaultTransparency : TATransparency;  // vychozi pruhlednost hladiny
  end;

// nacteni konfigurace z registru
procedure LoadConfig(var Config : TConfig);
// ulozeni konfigurace z registru
procedure SaveConfig(var Config : TConfig);

// *****************************************************************************
// *****************************************************************************

implementation

// *****************************************************************************
// *******************************  KONSTANTY  *********************************
// *****************************************************************************

const
  REGISTRY_KEY                             = '\Software\Home Designer';
  REGISTRY_ITEM_LAYER_NAME                 = 'LayerName';
  REGISTRY_ITEM_LAYER_EDITOR_COLOR         = 'LayerEditorColor';
  REGISTRY_ITEM_LAYER_DEFAULT_COLOR        = 'LayerDefaultColor';
  REGISTRY_ITEM_LAYER_DEFAULT_TRANSPARENCY = 'LayerDefaultTransparency';

// *****************************************************************************
// ********************************  FUNKCE  ***********************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// nacteni vychozich hodnot
procedure LoadDefaults(var Config : TConfig);
begin
  with Config do begin
    LayerName[slLayer1]                := 'Roof';
    LayerEditColor[slLayer1]           := $3A41D8;
    LayerDefaultColor[slLayer1]        := $3A41D8;
    LayerDefaultTransparency[slLayer1] := 40;
    //
    LayerName[slLayer2]                := 'Window';
    LayerEditColor[slLayer2]           := $8C5B48;
    LayerDefaultColor[slLayer2]        := $8C5B48;
    LayerDefaultTransparency[slLayer2] := 40;
    //
    LayerName[slLayer3]                := 'Door';
    LayerEditColor[slLayer3]           := $464898;
    LayerDefaultColor[slLayer3]        := $464898;
    LayerDefaultTransparency[slLayer3] := 40;
    //
    LayerName[slLayer4]                := 'Plaster 1';
    LayerEditColor[slLayer4]           := $44CFF2;
    LayerDefaultColor[slLayer4]        := $44CFF2;
    LayerDefaultTransparency[slLayer4] := 40;
    //
    LayerName[slLayer5]                := 'Plaster 2';
    LayerEditColor[slLayer5]           := $3D98F9;
    LayerDefaultColor[slLayer5]        := $3D98F9;
    LayerDefaultTransparency[slLayer5] := 40;
  end;
end;

// -----------------------------------------------------------------------------
// nacteni konfigurace z registru
procedure LoadConfig(var Config : TConfig);
var
  Reg   : TRegistry;
  Layer : TLayer;
  Sufix : String;
begin
  LoadDefaults(Config);
  Reg := TRegistry.Create();
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    with Config do
      if Reg.KeyExists(REGISTRY_KEY) then
        try
          Reg.OpenKey(REGISTRY_KEY, False);
          for Layer := Low(TLayer) to High(TLayer) do begin
            Sufix := IntToStr(Integer(Layer) + 1);
            if Reg.ValueExists(REGISTRY_ITEM_LAYER_NAME + Sufix) then
              LayerName[Layer] := Trim(Reg.ReadString(REGISTRY_ITEM_LAYER_NAME + Sufix));
            if Reg.ValueExists(REGISTRY_ITEM_LAYER_EDITOR_COLOR + Sufix) then
              LayerEditColor[Layer] := TColor(Reg.ReadInteger(REGISTRY_ITEM_LAYER_EDITOR_COLOR + Sufix));
            if Reg.ValueExists(REGISTRY_ITEM_LAYER_DEFAULT_COLOR + Sufix) then
              LayerDefaultColor[Layer] := TColor(Reg.ReadInteger(REGISTRY_ITEM_LAYER_DEFAULT_COLOR + Sufix));
            if Reg.ValueExists(REGISTRY_ITEM_LAYER_DEFAULT_TRANSPARENCY + Sufix) then
              LayerDefaultTransparency[Layer] := Max(0, Min(90, Reg.ReadInteger(REGISTRY_ITEM_LAYER_DEFAULT_TRANSPARENCY + Sufix)));
          end;
        finally
          Reg.CloseKey();
        end;
  finally
    Reg.Free();
  end;
end;

// -----------------------------------------------------------------------------
// ulozeni konfigurace z registru
procedure SaveConfig(var Config : TConfig);
var
  Reg   : TRegistry;
  Layer : TLayer;
  Sufix : String;
begin
  Reg := TRegistry.Create();
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    with Config do
      try
        Reg.OpenKey(REGISTRY_KEY, True);
        for Layer := Low(TLayer) to High(TLayer) do begin
          Sufix := IntToStr(Integer(Layer) + 1);
          Reg.WriteString(REGISTRY_ITEM_LAYER_NAME + Sufix, LayerName[Layer]);
          Reg.WriteInteger(REGISTRY_ITEM_LAYER_EDITOR_COLOR + Sufix, LayerEditColor[Layer]);
          Reg.WriteInteger(REGISTRY_ITEM_LAYER_DEFAULT_COLOR + Sufix, LayerDefaultColor[Layer]);
          Reg.WriteInteger(REGISTRY_ITEM_LAYER_DEFAULT_TRANSPARENCY + Sufix, LayerDefaultTransparency[Layer]);
        end;
      finally
        Reg.CloseKey();
      end;
  finally
    Reg.Free();
  end;
end;

// *****************************************************************************
// *****************************************************************************

end.
