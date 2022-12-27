// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2006 Tomas Paukrt

unit uMain;

interface

uses
  Windows, Forms, Classes, Controls, StdCtrls, ExtCtrls, ComCtrls, Graphics,
  SysUtils, Menus, ToolWin, Dialogs, ExtDlgs, ImgList, Printers, IniFiles,
  Jpeg, Math, uAbout, uArea, uConfig, uColor, uSetup;

// *****************************************************************************
// *****************************************************************************

type
  TMode = (smOld, smEdit, smNew);
  TTool = (stBrush, stPolygon, stRubber, stDropper, stReplacer, stCalibration);

type
  TFormMain = class(TForm)
    MainMenu            : TMainMenu;
    //
    miFile              : TMenuItem;
    miNewProject        : TMenuItem;
    mi11                : TMenuItem;
    miOpenProject       : TMenuItem;
    mi12                : TMenuItem;
    miSaveProject       : TMenuItem;
    miSaveProjectAs     : TMenuItem;
    miExport            : TMenuItem;
    mi13                : TMenuItem;
    miPrint             : TMenuItem;
    mi14                : TMenuItem;
    miSetup             : TMenuItem;
    mi15                : TMenuItem;
    miExit              : TMenuItem;
    //
    miView              : TMenuItem;
    miImageOld          : TMenuItem;
    miImageEditor       : TMenuItem;
    miImageNew          : TMenuItem;
    //
    miLayer             : TMenuItem;
    miLayer1            : TMenuItem;
    miLayer2            : TMenuItem;
    miLayer3            : TMenuItem;
    miLayer4            : TMenuItem;
    miLayer5            : TMenuItem;
    //
    miEdit              : TMenuItem;
    miBrush             : TMenuItem;
    miPolygon           : TMenuItem;
    miRubber            : TMenuItem;
    miDropper           : TMenuItem;
    miReplacer          : TMenuItem;
    mi41                : TMenuItem;
    miUndo              : TMenuItem;
    //
    miMeasure           : TMenuItem;
    miMArea             : TMenuItem;
    mi51                : TMenuItem;
    miMCalibration      : TMenuItem;
    //
    miHelp              : TMenuItem;
    miAbout             : TMenuItem;
    //
    StatusBar           : TStatusBar;
    //
    ToolBar1            : TToolBar;
    tbNewProject        : TToolButton;
    tbOpenProject       : TToolButton;
    tbSaveProject       : TToolButton;
    tbPrint             : TToolButton;
    tbSeparator11       : TToolButton;
    tbImageNew          : TToolButton;
    tbImageEditor       : TToolButton;
    tbImageOld          : TToolButton;
    tbSeparator12       : TToolButton;
    tbLayer1            : TToolButton;
    tbLayer2            : TToolButton;
    tbLayer3            : TToolButton;
    tbLayer4            : TToolButton;
    tbLayer5            : TToolButton;
    tbSeparator13       : TToolButton;
    lbLColor            : TLabel;
    pnlLColor           : TPanel;
    shpLColor           : TShape;
    lbLTransp           : TLabel;
    cbLTransp           : TComboBox;
    //
    ToolBar2            : TToolBar;
    tbUndo              : TToolButton;
    tbSeparator21       : TToolButton;
    tbBrush             : TToolButton;
    tbPolygon           : TToolButton;
    tbRubber            : TToolButton;
    tbDropper           : TToolButton;
    tbReplacer          : TToolButton;
    tbSeparator22       : TToolButton;
    lbWidth             : TLabel;
    cbWidth             : TComboBox;
    tbSeparator23       : TToolButton;
    lbRColor            : TLabel;
    pnlRColor           : TPanel;
    shpRColor           : TShape;
    lbRSimilarity       : TLabel;
    cbRSimilarity       : TComboBox;
    //
    ScrollBox           : TScrollBox;
    Image               : TImage;
    //
    ImageList           : TImageList;
    //
    OpenDialog          : TOpenDialog;
    SaveDialog          : TSaveDialog;
    OpenPictureDialog   : TOpenPictureDialog;
    SavePictureDialog   : TSavePictureDialog;
    PrintDialog         : TPrintDialog;
    //
    procedure miNewProjectClick(Sender : TObject);
    procedure miOpenProjectClick(Sender : TObject);
    procedure miSaveProjectClick(Sender : TObject);
    procedure miExportClick(Sender : TObject);
    procedure miPrintClick(Sender : TObject);
    procedure miSetupClick(Sender: TObject);
    procedure miExitClick(Sender : TObject);
    //
    procedure miImageOldClick(Sender : TObject);
    procedure miImageEditorClick(Sender : TObject);
    procedure miImageNewClick(Sender : TObject);
    //
    procedure miLayer1Click(Sender : TObject);
    procedure miLayer2Click(Sender : TObject);
    procedure miLayer3Click(Sender : TObject);
    procedure miLayer4Click(Sender : TObject);
    procedure miLayer5Click(Sender : TObject);
    //
    procedure miBrushClick(Sender : TObject);
    procedure miPolygonClick(Sender : TObject);
    procedure miRubberClick(Sender : TObject);
    procedure miDropperClick(Sender : TObject);
    procedure miReplacerClick(Sender : TObject);
    procedure miUndoClick(Sender : TObject);
    //
    procedure miMAreaClick(Sender : TObject);
    procedure miMCalibrationClick(Sender : TObject);
    //
    procedure miAboutClick(Sender : TObject);
    //
    procedure cbWidthChange(Sender : TObject);
    procedure shpLColorMouseDown(Sender: TObject; Button : TMouseButton;
                                 Shift : TShiftState; X, Y : Integer);
    procedure cbLTranspChange(Sender : TObject);
    //
    procedure ImageMouseDown(Sender : TObject; Button : TMouseButton;
                             Shift: TShiftState; X, Y : Integer);
    procedure ImageMouseUp(Sender : TObject; Button : TMouseButton;
                           Shift : TShiftState; X, Y : Integer);
    procedure ImageMouseMove(Sender : TObject; Shift : TShiftState;
                             X, Y: Integer);
    //
    procedure FormCreate(Sender : TObject);
  private
    Config       : TConfig;             // konfigurace
    //
    BitmapData   : TBitmap;             // data nacteneho obrazku
    BitmapMask   : TBitmap;             // maska
    BitmapUndo   : TBitmap;             // zaloha masky
    //
    LastX        : Integer;             // posledni X-ova pozice mysi
    LastY        : Integer;             // posledni Y-ova pozice mysi
    Down         : Boolean;             // priznak stisknuti tlacitka
    //
    Mode         : TMode;               // vybrany rezim
    Layer        : TLayer;              // vybrana vrstva
    Tool         : TTool;               // vybrany nastroj
    //
    Poly         : array of TPoint;     // vrcholy polygonu
    //
    PenWidth     : Integer;             // tloustka cary
    RColor       : TColor;              // nahrazovana barva
    LColors      : TAColor;             // barvy vrstev
    LTransp      : TATransparency;      // pruhlednosti vrstev
    //
    PixelSize    : Real;                // velikost pixelu v m2
    //
    FileNamePrj  : String;              // jmeno projektu
    FileNameData : String;              // jmeno obrazku
    //
    // povoleni/zakazani ovladacich prvku
    procedure SetState(const Enabled : Boolean);
    // nastaveni vychozich hodnot ovladacich prvku
    procedure SetDefaults();
    // vyber rezimu zobrazeni obrazku
    procedure SelectMode(const NewMode : TMode);
    // vyber vrstvy
    procedure SelectLayer(const NewLayer : TLayer);
    // vyber nastroje
    procedure SelectTool(const NewTool : TTool);
    // nastaveni jmen vrstev podle konfigurace
    procedure SetLayerNames();
    // nastaveni barev a pruhlednosti vrstev podle konfigurace
    procedure SetLayerProperties();
    // zruseni vsech bitmap
    procedure DiscardBitmaps();
    // prekresleni obrazku
    procedure RedrawImage();
    // nacteni obrazku ze souboru
    function LoadPicture(const FileNameImage, FileNameMask : String) : Boolean;
    // provedeni akce
    procedure DoAction(const X, Y : Integer);
    // provedeni akce (polygon)
    procedure DoPolygon(Button : TMouseButton; X, Y : Integer);
  end;

var
  FormMain : TFormMain;

// *****************************************************************************
// *****************************************************************************

implementation

{$R *.DFM}

// *****************************************************************************
// ****************************  POMOCNE FUNKCE  *******************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// ziskani hodnoty cervene slozky
function GetRed(const Color : TColor) : Byte;
begin
  Result := (Color and $FF);
end;

// -----------------------------------------------------------------------------
// ziskani hodnoty zelene slozky
function GetGreen(const Color : TColor) : Byte;
begin
  Result := (Color and $FF00) shr 8;
end;

// -----------------------------------------------------------------------------
// ziskani hodnoty modre slozky
function GetBlue(const Color : TColor) : Byte;
begin
  Result := (Color and $FF0000) shr 16;
end;

// -----------------------------------------------------------------------------
// urceni podobnosti dvou barev v procentech
function GetSimilarity(const Color : TColor; R, G, B : Byte) : Byte;
begin
  R := Abs(GetRed(Color) - R);
  G := Abs(GetGreen(Color) - G);
  B := Abs(GetBlue(Color) - B);
  Result := (100 * (255 - Max(R, Max(G, B)))) div 255;
end;

// -----------------------------------------------------------------------------
// smichani barevny slozek v pomer Ratio:(100-Ratio)
function Mix(const A, B, Ratio : Byte) : Byte;
begin
  Result := (A * (100 - Ratio) + B * Ratio) div 100;
end;

// *****************************************************************************
// ******************  TRIDA TFormMain - PRIVATNI METODY  **********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// povoleni/zakazani ovladacich prvku
procedure TFormMain.SetState(const Enabled : Boolean);
begin
  miSaveProject.Enabled   := Enabled;
  miSaveProjectAs.Enabled := Enabled;
  miExport.Enabled        := Enabled;
  miPrint.Enabled         := Enabled;
  tbSaveProject.Enabled   := Enabled;
  tbPrint.Enabled         := Enabled;

  miImageOld.Enabled      := Enabled;
  miImageEditor.Enabled   := Enabled;
  miImageNew.Enabled      := Enabled;
  tbImageOld.Enabled      := Enabled;
  tbImageEditor.Enabled   := Enabled;
  tbImageNew.Enabled      := Enabled;

  miLayer1.Enabled        := Enabled;
  miLayer2.Enabled        := Enabled;
  miLayer3.Enabled        := Enabled;
  miLayer4.Enabled        := Enabled;
  miLayer5.Enabled        := Enabled;
  tbLayer1.Enabled        := Enabled;
  tbLayer2.Enabled        := Enabled;
  tbLayer3.Enabled        := Enabled;
  tbLayer4.Enabled        := Enabled;
  tbLayer5.Enabled        := Enabled;

  miBrush.Enabled         := Enabled;
  miPolygon.Enabled       := Enabled;
  miRubber.Enabled        := Enabled;
  miDropper.Enabled       := Enabled;
  miReplacer.Enabled      := Enabled;
  miUndo.Enabled          := False;
  tbBrush.Enabled         := Enabled;
  tbPolygon.Enabled       := Enabled;
  tbRubber.Enabled        := Enabled;
  tbDropper.Enabled       := Enabled;
  tbReplacer.Enabled      := Enabled;
  tbUndo.Enabled          := False;

  miMArea.Enabled         := Enabled and (PixelSize > 0);
  miMCalibration.Enabled  := Enabled;

  lbLColor.Enabled        := Enabled;
  shpLColor.Enabled       := Enabled;
  lbLTransp.Enabled       := Enabled;
  cbLTransp.Enabled       := Enabled;

  lbWidth.Enabled         := Enabled;
  cbWidth.Enabled         := Enabled;
  lbRSimilarity.Enabled   := Enabled;
  cbRSimilarity.Enabled   := Enabled;
  lbRColor.Enabled        := Enabled;

  Image.Enabled           := Enabled;
end;

// -----------------------------------------------------------------------------
// nastaveni vychozich hodnot ovladacich prvku
procedure TFormMain.SetDefaults();
begin
  SelectMode(smEdit);
  SelectLayer(slLayer1);
  SelectTool(stBrush);

  cbRSimilarity.ItemIndex := 0;
  cbWidth.ItemIndex       := 3;
  cbWidthChange(Self);
end;

// -----------------------------------------------------------------------------
// vyber rezimu zobrazeni obrazku
procedure TFormMain.SelectMode(const NewMode : TMode);
begin
  Mode                  := NewMode;

  miImageOld.Checked    := Mode = smOld;
  miImageEditor.Checked := Mode = smEdit;
  miImageNew.Checked    := Mode = smNew;
  tbImageOld.Down       := Mode = smOld;
  tbImageEditor.Down    := Mode = smEdit;
  tbImageNew.Down       := Mode = smNew;

  RedrawImage();
end;

// -----------------------------------------------------------------------------
// vyber vrstvy
procedure TFormMain.SelectLayer(const NewLayer : TLayer);
begin
  Layer            := NewLayer;

  miLayer1.Checked := Layer = slLayer1;
  miLayer2.Checked := Layer = slLayer2;
  miLayer3.Checked := Layer = slLayer3;
  miLayer4.Checked := Layer = slLayer4;
  miLayer5.Checked := Layer = slLayer5;
  tbLayer1.Down    := Layer = slLayer1;
  tbLayer2.Down    := Layer = slLayer2;
  tbLayer3.Down    := Layer = slLayer3;
  tbLayer4.Down    := Layer = slLayer4;
  tbLayer5.Down    := Layer = slLayer5;

  shpLColor.Brush.Color := LColors[Layer];
  cbLTransp.ItemIndex   := LTransp[Layer] div 10;
end;

// -----------------------------------------------------------------------------
// vyber nastroje
procedure TFormMain.SelectTool(const NewTool : TTool);
begin
  Tool               := NewTool;

  miBrush.Checked    := Tool = stBrush;
  miPolygon.Checked  := Tool = stPolygon;
  miRubber.Checked   := Tool = stRubber;
  miDropper.Checked  := Tool = stDropper;
  miReplacer.Checked := Tool = stReplacer;
  tbBrush.Down       := Tool = stBrush;
  tbPolygon.Down     := Tool = stPolygon;
  tbRubber.Down      := Tool = stRubber;
  tbDropper.Down     := Tool = stDropper;
  tbReplacer.Down    := Tool = stReplacer;

  if Length(Poly) > 0 then begin
    SetLength(Poly, 0);
    RedrawImage();
  end;
end;

// -----------------------------------------------------------------------------
// nastaveni jmen vrstev podle konfigurace
procedure TFormMain.SetLayerNames();
begin
  miLayer1.Caption := Config.LayerName[slLayer1];
  miLayer2.Caption := Config.LayerName[slLayer2];
  miLayer3.Caption := Config.LayerName[slLayer3];
  miLayer4.Caption := Config.LayerName[slLayer4];
  miLayer5.Caption := Config.LayerName[slLayer5];

  tbLayer1.Hint    := Config.LayerName[slLayer1];
  tbLayer2.Hint    := Config.LayerName[slLayer2];
  tbLayer3.Hint    := Config.LayerName[slLayer3];
  tbLayer4.Hint    := Config.LayerName[slLayer4];
  tbLayer5.Hint    := Config.LayerName[slLayer5];
end;

// -----------------------------------------------------------------------------
// nastaveni barev a pruhlednosti vrstev podle konfigurace
procedure TFormMain.SetLayerProperties();
begin
  LColors[slLayer1] := Config.LayerDefaultColor[slLayer1];
  LColors[slLayer2] := Config.LayerDefaultColor[slLayer2];
  LColors[slLayer3] := Config.LayerDefaultColor[slLayer3];
  LColors[slLayer4] := Config.LayerDefaultColor[slLayer4];
  LColors[slLayer5] := Config.LayerDefaultColor[slLayer5];

  LTransp[slLayer1] := Config.LayerDefaultTransparency[slLayer1];
  LTransp[slLayer2] := Config.LayerDefaultTransparency[slLayer2];
  LTransp[slLayer3] := Config.LayerDefaultTransparency[slLayer3];
  LTransp[slLayer4] := Config.LayerDefaultTransparency[slLayer4];
  LTransp[slLayer5] := Config.LayerDefaultTransparency[slLayer5];
end;

// -----------------------------------------------------------------------------
// zruseni vsech bitmap
procedure TFormMain.DiscardBitmaps();
begin
  if BitmapData <> nil then begin
    BitmapData.Free();
    BitmapData := nil;
  end;

  if BitmapMask <> nil then begin
    BitmapMask.Free();
    BitmapMask := nil;
  end;

  if BitmapUndo <> nil then begin
    BitmapUndo.Free();
    BitmapUndo := nil;
  end;
end;

// -----------------------------------------------------------------------------
// nacteni obrazku ze souboru
function TFormMain.LoadPicture(const FileNameImage, FileNameMask : String) : Boolean;
var
  P : TPicture;
begin
  Result := False;
  DiscardBitmaps();
  P := TPicture.Create();
  try
    try
      // nacteni obrazku ze souboru
      P.LoadFromFile(FileNameImage);
      // vytvoreni bitmapy pro obrazek
      BitmapData                    := TBitmap.Create();
      BitmapData.PixelFormat        := pf24bit;
      BitmapData.Width              := P.Width;
      BitmapData.Height             := P.Height;
      // vytvoreni bitmapy pro masku
      BitmapMask                    := TBitmap.Create();
      BitmapMask.PixelFormat        := pf8bit;
      BitmapMask.Canvas.Brush.Color := clBlack;
      BitmapMask.Width              := P.Width;
      BitmapMask.Height             := P.Height;
      // vytvoreni bitmapy pro zalohu masky
      BitmapUndo                    := TBitmap.Create();
      BitmapUndo.PixelFormat        := pf8bit;
      BitmapUndo.Canvas.Brush.Color := clBlack;
      BitmapUndo.Width              := P.Width;
      BitmapUndo.Height             := P.Height;
      // vykresleni nacteneho obrazku do bitmapy
      BitmapData.Canvas.Draw(0, 0, P.Graphic);
      // pokud je zadano jmeno souboru s maskou
      if FileNameMask <> '' then begin
        try
          // registrovani formatu HDM
          P.RegisterFileFormat('hdm', '', TBitmap);
          // nacteni masky ze souboru
          P.LoadFromFile(FileNameMask);
          // pokud ma maska stejne rozmery jako obrazek
          if (P.Width = BitmapData.Width) and (P.Height = BitmapData.Height) then begin
            // vykresleni nactene masky do bitmap
            BitmapMask.Canvas.Draw(0, 0, P.Graphic);
            BitmapUndo.Canvas.Draw(0, 0, P.Graphic);
            // nacitani bylo uspesne dokonceno
            Result := True;
          end else begin
            // chyba pri nacitani
            MessageDlg('Image and mask resolution do not match.', mtError, [mbOK], 0);
          end;
        except
          // chyba pri nacitani souboru s maskou
          MessageDlg('Failed to open file ' + FileNameMask, mtError, [mbOK], 0);
        end
      end else begin
        // nacitani bylo uspesne dokonceno
        Result := True;
      end;
    except
      // chyba pri nacitani obrazku
      MessageDlg('Failed to open file ' + FileNameImage, mtError, [mbOK], 0);
    end;
  finally
    // uvolneni pameti
    P.Free();
  end;
end;

// -----------------------------------------------------------------------------
// prekresleni obrazku
procedure TFormMain.RedrawImage();
var
  PD, PM, PT : PByteArray;
  X, Y       : Integer;
  M          : Byte;
  L          : TLayer;
begin
  if (BitmapData <> nil) and (BitmapMask <> nil) and
     (Image.Picture.Bitmap <> nil) then begin
    // vykresleni obrazku do okna
    for Y := 0 to BitmapData.Height-1 do begin
      PD := BitmapData.ScanLine[Y];
      PM := BitmapMask.ScanLine[Y];
      PT := Image.Picture.Bitmap.ScanLine[Y];
      for X := 0 to BitmapData.Width-1 do begin
        M := PM[X];
        if (M >= 1) and (M <= 5) and (Mode = smEdit) then begin
          L := TLayer(M - 1);
          PT[3*X]   := GetBlue(Config.LayerEditColor[L]);
          PT[3*X+1] := GetGreen(Config.LayerEditColor[L]);
          PT[3*X+2] := GetRed(Config.LayerEditColor[L]);
        end else if (M >= 1) and (M <= 5) and (Mode = smNew) then begin
          L := TLayer(M - 1);
          PT[3*X]   := Mix(GetBlue(LColors[L]), PD[3*X], LTransp[L]);
          PT[3*X+1] := Mix(GetGreen(LColors[L]), PD[3*X+1], LTransp[L]);
          PT[3*X+2] := Mix(GetRed(LColors[L]), PD[3*X+2], LTransp[L]);
        end else begin
          PT[3*X]   := PD[3*X];
          PT[3*X+1] := PD[3*X+1];
          PT[3*X+2] := PD[3*X+2];
        end;
      end;
    end;
    // aktualizace zobrazene bitmapy
    Image.Invalidate();
  end;
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// vyber polozky menu 'File - New project'
procedure TFormMain.miNewProjectClick(Sender : TObject);
begin
  // otevreni dialogu pro vyber obrazku
  if OpenPictureDialog.Execute() then begin
    // zruseni aktualniho obrazku v okne
    Image.Picture.Bitmap := nil;
    // zakazani ovladacich prvku
    SetState(False);
    // nacteni obrazku
    if LoadPicture(OpenPictureDialog.FileName, '') then begin
      // urceni jmena obrazku a projektu
      FileNameData := OpenPictureDialog.FileName;
      FileNamePrj  := '';
      // zneplatneni velikosti pixelu
      PixelSize := 0;
      // zobrazeni obrazku v okne
      Image.Picture.Bitmap := BitmapData;
      // nastaveni barev a pruhlednosti vrstev podle konfigurace
      SetLayerProperties();
      // nastaveni vychozich hodnot ovladacich prvku
      SetDefaults();
      // povoleni ovladacich prvku
      SetState(True);
    end;
  end;
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'File - Open project'
procedure TFormMain.miOpenProjectClick(Sender : TObject);
var
  FileNameMask : String;
  Directory    : String;
  Sufix        : String;
  Project      : TIniFile;
  Layer        : TLayer;
begin
  // otevreni dialogu pro vyber projektu
  if OpenDialog.Execute() then begin
    // zruseni aktualniho obrazku v okne
    Image.Picture.Bitmap := nil;
    // zakazani ovladacich prvku
    SetState(False);
    // urceni jmena projektu
    FileNamePrj := OpenDialog.FileName;
    Directory   := ExtractFilePath(FileNamePrj);
    // nacteni projektu
    Project := TIniFile.Create(FileNamePrj);
    try
      // urceni jmena obrazku
      FileNameData := Project.ReadString('FILES', 'Data', '');
      if Pos(':\', FileNameData) = 0 then
        FileNameData := Directory + FileNameData;
      // urceni jmena masky
      FileNameMask := Project.ReadString('FILES', 'Mask', '');
      if Pos(':\', FileNameMask) = 0 then
        FileNameMask := Directory + FileNameMask;
      // nacteni obrazku a masky
      if LoadPicture(FileNameData, FileNameMask) then begin
        // zobrazeni obrazku v okne
        Image.Picture.Bitmap := BitmapData;
        // nacteni barev a pruhlednosti vrstev
        for Layer := Low(Layer) to High(Layer) do begin
          Sufix := IntToStr(Integer(Layer) + 1);
          LColors[Layer] := Project.ReadInteger('Layer' + Sufix, 'Color', Config.LayerDefaultColor[Layer]);
          LTransp[Layer] := Max(0, Min(90, Project.ReadInteger('Layer' + Sufix, 'Tranparency', Config.LayerDefaultTransparency[Layer])));
        end;
        // nacteni velikosti jednoho pixelu v m2
        PixelSize := Project.ReadFloat('Measure', 'PixelSize', 0);
        // nastaveni vychozich hodnot ovladacich prvku
        SetDefaults();
        // povoleni ovladacich prvku
        SetState(True);
      end;
    finally
      // uvolneni pameti
      Project.Free();
    end;
  end;
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'File - Save project'
procedure TFormMain.miSaveProjectClick(Sender : TObject);
var
  FileNameMask : String;
  Directory    : String;
  Sufix        : String;
  Project      : TIniFile;
  Layer        : TLayer;
begin
  try
    // zjisteni jmena projektu
    if (FileNamePrj = '') or (Sender = miSaveProjectAs) then begin
      SaveDialog.FileName := ChangeFileExt(FileNameData, '.hdp');
      if SaveDialog.Execute() then
        FileNamePrj  := SaveDialog.FileName
      else
        Exit;
    end;
    // vytvoreni jmena souboru s maskou
    Directory    := ExtractFilePath(FileNamePrj);
    FileNameMask := ChangeFileExt(FileNamePrj, '.hdm');
    // ulozeni masky
    BitmapMask.SaveToFile(FileNameMask);
    // ulozeni projektu
    Project := TIniFile.Create(FileNamePrj);
    try
      // ulozeni jmen souboru
      Project.WriteString('Files', 'Data', ExtractRelativePath(Directory, FileNameData));
      Project.WriteString('Files', 'Mask', ExtractRelativePath(Directory, FileNameMask));
      // ulozeni barev a pruhlednosti vrstev
      for Layer := Low(Layer) to High(Layer) do begin
        Sufix := IntToStr(Integer(Layer) + 1);
        Project.WriteString('Layer' + Sufix, 'Color', IntToStr(Integer(LColors[Layer])));
        Project.WriteString('Layer' + Sufix, 'Tranparency', IntToStr(LTransp[Layer]));
      end;
      // ulozeni velikosti jednoho pixelu v m2
      Project.WriteString('Measure', 'PixelSize', FloatToStr(PixelSize));
      // zapsani zmen do souboru
      Project.UpdateFile();
    finally
      Project.Free();
    end;
  except
    MessageDlg('Failed to save the project to directory ' + Directory, mtError, [mbOK], 0);
  end;
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'File - Export'
procedure TFormMain.miExportClick(Sender : TObject);
begin
  // otevreni dialogu pro vyber jmena souboru
  if SavePictureDialog.Execute() then
    // ulozeni obrazku do souboru
    Image.Picture.SaveToFile(SavePictureDialog.FileName);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'File - Print'
procedure TFormMain.miPrintClick(Sender : TObject);
var
  AspectRatio, OutputWidth, OutputHeight : Single;
begin
  // otevreni dialogu pro vyber tiskarny
  if PrintDialog.Execute() then begin
    Printer.BeginDoc;
    try
      OutputWidth  := Image.Picture.Width;
      OutputHeight := Image.Picture.Height;
      AspectRatio  := OutputWidth / OutputHeight;
      if (OutputWidth < Printer.PageWidth) and
         (OutputHeight < Printer.PageHeight) then begin
        if OutputWidth < OutputHeight then begin
          OutputHeight := Printer.PageHeight;
          OutputWidth := OutputHeight * AspectRatio;
        end else begin
          OutputWidth := Printer.PageWidth;
          OutputHeight := OutputWidth / AspectRatio;
        end
      end;
      if OutputWidth > Printer.PageWidth then begin
        OutputWidth := Printer.PageWidth;
        OutputHeight := OutputWidth / AspectRatio;
      end;
      if OutputHeight > Printer.PageHeight then begin
        OutputHeight := Printer.PageHeight;
        OutputWidth := OutputHeight * AspectRatio;
      end;
      Printer.Canvas.StretchDraw(Rect(0, 0, Trunc(OutputWidth), Trunc(OutputHeight)),
                                 Image.Picture.Graphic);
    finally
      Printer.EndDoc;
    end;
  end;
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'File - Settings'
procedure TFormMain.miSetupClick(Sender : TObject);
begin
  // otevreni dialogu pro nastaveni konfigurace
  if FormSetup.Execute(Config) then begin
    // ulozeni konfigurace
    SaveConfig(Config);
    // nastaveni jmen vrstev podle konfigurace
    SetLayerNames();
    // prekresleni obrazku
    if Mode = smEdit then
      RedrawImage();
  end;
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'File - Exit'
procedure TFormMain.miExitClick(Sender : TObject);
begin
  Close();
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// vyber polozky menu 'View - Original'
procedure TFormMain.miImageOldClick(Sender : TObject);
begin
  SelectMode(smOld);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'View - Editor'
procedure TFormMain.miImageEditorClick(Sender : TObject);
begin
  SelectMode(smEdit);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'View - New'
procedure TFormMain.miImageNewClick(Sender : TObject);
begin
  SelectMode(smNew);
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// vyber polozky menu 'Layer - Layer 1'
procedure TFormMain.miLayer1Click(Sender : TObject);
begin
  SelectLayer(slLayer1);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Layer - Layer 2'
procedure TFormMain.miLayer2Click(Sender : TObject);
begin
  SelectLayer(slLayer2);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Layer - Layer 3'
procedure TFormMain.miLayer3Click(Sender : TObject);
begin
  SelectLayer(slLayer3);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Layer - Layer 4'
procedure TFormMain.miLayer4Click(Sender : TObject);
begin
  SelectLayer(slLayer4);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Layer - Layer 5'
procedure TFormMain.miLayer5Click(Sender : TObject);
begin
  SelectLayer(slLayer5);
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// vyber polozky menu 'Edit - Brush'
procedure TFormMain.miBrushClick(Sender : TObject);
begin
  SelectTool(stBrush);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Edit - Polgon'
procedure TFormMain.miPolygonClick(Sender : TObject);
begin
  SelectTool(stPolygon);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Edit - Rubber'
procedure TFormMain.miRubberClick(Sender : TObject);
begin
  SelectTool(stRubber);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Edit - Dropper'
procedure TFormMain.miDropperClick(Sender : TObject);
begin
  SelectTool(stDropper);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Edit - Replacer'
procedure TFormMain.miReplacerClick(Sender : TObject);
begin
  SelectTool(stReplacer);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Edit - Undo'
procedure TFormMain.miUndoClick(Sender : TObject);
begin
  // obnoveni masky ze zalohy
  BitmapMask.Canvas.Draw(0, 0, BitmapUndo);

  // prekresleni obrazku
  if Mode <> smOld then
    RedrawImage();

  // zruseni zadaneho polygonu
  SetLength(Poly, 0);

  // zakazani tlacitek
  miUndo.Enabled := False;
  tbUndo.Enabled := False;
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// vyber polozky menu 'Measure - Area'
procedure TFormMain.miMAreaClick(Sender : TObject);
var
  Count   : array [1..5] of Integer;
  PM      : PByteArray;
  X, Y, I : Integer;
begin
  // zjisteni poctu pixelu ve vsech vrstvach
  for I := Low(Count) to High(Count) do begin
    Count[I] := 0;
  end;
  for Y := 0 to BitmapMask.Height-1 do begin
    PM := BitmapMask.ScanLine[Y];
    for X := 0 to BitmapMask.Width-1 do begin
      if (PM[X] >= Low(Count)) and (PM[X] <= High(Count)) then begin
        Inc(Count[PM[X]]);
      end;
    end;
  end;

  // zobrazeni vypoctenych ploch vrstev
  FormArea.Execute(Config,
                   PixelSize * Count[1],
                   PixelSize * Count[2],
                   PixelSize * Count[3],
                   PixelSize * Count[4],
                   PixelSize * Count[5]);
end;

// -----------------------------------------------------------------------------
// vyber polozky menu 'Measure - Calibration'
procedure TFormMain.miMCalibrationClick(Sender : TObject);
begin
  LastX := -1;
  LastY := -1;
  SelectTool(stCalibration);
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// vyber polozky menu 'Help - About'
procedure TFormMain.miAboutClick(Sender : TObject);
begin
  FormAbout.Execute();
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// udalost - zmena tloustky
procedure TFormMain.cbWidthChange(Sender : TObject);
const
  WIDTHS : array [0..8] of Integer = (1, 2, 3, 5, 10, 15, 20, 25, 30);
begin
  PenWidth := WIDTHS[cbWidth.ItemIndex];
end;

// -----------------------------------------------------------------------------
// udalost - zmena barvy vrstvy
procedure TFormMain.shpLColorMouseDown(Sender : TObject; Button : TMouseButton;
                                       Shift : TShiftState; X, Y : Integer);
begin
  if FormColor.Execute(LColors[Layer]) then begin
    shpLColor.Brush.Color := LColors[Layer];
    if Mode = smNew then
      RedrawImage();
  end;
end;

// -----------------------------------------------------------------------------
// udalost - zmena pruhlednosti
procedure TFormMain.cbLTranspChange(Sender : TObject);
begin
  LTransp[Layer] := cbLTransp.ItemIndex * 10;
  if Mode = smNew then
    RedrawImage();
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// provedeni akce
procedure TFormMain.DoAction(const X, Y : Integer);
var
  B                      : TBitmap;
  PT, PD, PM, PS         : PByteArray;
  XT, YT, XS, YS, XA, YA : Integer;
begin
  if Down then begin
    // nastaveni pocatecnich souradnic
    if LastX < 0 then begin
      LastX := X;
      LastY := Y;
    end;

    // pokud je vybrana pipeta
    if Tool = stDropper then begin
      RColor := BitmapData.Canvas.Pixels[X, Y];
      shpRColor.Brush.Color := RColor;

    // pokud je vybran jiny nastroj
    end else begin
      // vytvoreni pomocne bitmapy
      B                    := TBitmap.Create();
      B.PixelFormat        := pf8bit;
      B.Canvas.Brush.Color := clBlack;
      B.Canvas.Pen.Color   := clMaroon;
      B.Canvas.Pen.Width   := PenWidth;
      B.Width              := 30 + 2 * Abs(X - LastX);
      B.Height             := 30 + 2 * Abs(Y - LastY);
      // urceni stredu pomocne bitmapy
      XS := B.Width div 2;
      YS := B.Height div 2;
      // vykresleni usecky do pomocne bitmapy
      B.Canvas.MoveTo(XS + LastX - X, YS + LastY - Y);
      B.Canvas.LineTo(XS, YS);
      // vykresleni usecky do masky a zobrazene bitmapy
      for YT := 0 to B.Height-1 do begin
        YA := Y + YT - YS;
        if (YA >= 0) and (YA < BitmapData.Height) then begin
          PT := B.ScanLine[YT];
          PD := BitmapData.ScanLine[YA];
          PM := BitmapMask.ScanLine[YA];
          PS := Image.Picture.Bitmap.ScanLine[YA];
          for XT := 0 to B.Width-1 do begin
            XA := X + XT - XS;
            if (PT[XT] <> 0) and (XA >= 0) and (XA < BitmapData.Width) then
              case Tool of
                stBrush:
                  begin
                    if Mode = smEdit then begin
                      PS[3*XA]   := GetBlue(Config.LayerEditColor[Layer]);
                      PS[3*XA+1] := GetGreen(Config.LayerEditColor[Layer]);
                      PS[3*XA+2] := GetRed(Config.LayerEditColor[Layer]);
                    end else begin
                      PS[3*XA]   := Mix(GetBlue(LColors[Layer]), PD[3*XA], LTransp[Layer]);
                      PS[3*XA+1] := Mix(GetGreen(LColors[Layer]), PD[3*XA+1], LTransp[Layer]);
                      PS[3*XA+2] := Mix(GetRed(LColors[Layer]), PD[3*XA+2], LTransp[Layer]);
                    end;
                    PM[XA] := Ord(Layer)+1;
                  end;
                stRubber:
                  begin
                    PS[3*XA]   := PD[3*XA];
                    PS[3*XA+1] := PD[3*XA+1];
                    PS[3*XA+2] := PD[3*XA+2];
                    PM[XA]     := 0;
                  end;
                stReplacer:
                  begin
                    if GetSimilarity(RColor, PD[3*XA+2], PD[3*XA+1], PD[3*XA]) >= 95 - 5*cbRSimilarity.ItemIndex then begin
                      if Mode = smEdit then begin
                        PS[3*XA]   := GetBlue(Config.LayerEditColor[Layer]);
                        PS[3*XA+1] := GetGreen(Config.LayerEditColor[Layer]);
                        PS[3*XA+2] := GetRed(Config.LayerEditColor[Layer]);
                      end else begin
                        PS[3*XA]   := Mix(GetBlue(LColors[Layer]), PD[3*XA], LTransp[Layer]);
                        PS[3*XA+1] := Mix(GetGreen(LColors[Layer]), PD[3*XA+1], LTransp[Layer]);
                        PS[3*XA+2] := Mix(GetRed(LColors[Layer]), PD[3*XA+2], LTransp[Layer]);
                      end;
                      PM[XA] := Ord(Layer)+1;
                    end;
                  end;
            end;
          end;
        end;
      end;
      // aktualizace zobrazene bitmapy
      Image.Invalidate();
      // uvolneni pomocne bitmapy
      B.Free();
    end;

    // aktualizace souradnic
    LastX := X;
    LastY := Y;
  end;
end;

// -----------------------------------------------------------------------------
// provedeni akce (polygon)
procedure TFormMain.DoPolygon(Button : TMouseButton; X, Y : Integer);
var
  B                      : TBitmap;
  PT, PM                 : PByteArray;
  XT, YT, XA, YA         : Integer;
  XMin, XMax, YMin, YMax : Integer;
  Count, I               : Integer;
begin
  // zjisteni aktualniho poctu vrcholu polygonu
  Count := Length(Poly);

  // pokud bylo stisknuto leve tlacitko
  if Button = mbLeft then begin
    // ulozeni souradnic noveho vrcholu polygonu
    Inc(Count);
    SetLength(Poly, Count);
    Poly[Count-1].X := X;
    Poly[Count-1].Y := Y;
    // vykresleni obvodu polygonu
    Image.Canvas.Pen.Width := 1;
    Image.Canvas.Pen.Color := clBlack;
    Image.Canvas.Polyline(Poly);

  // pokud bylo stisknuto jine tlacitko a polygon ma alespon 1 vrchol
  end else if Count > 0 then begin
    // zalohovani aktualni masky
    miUndo.Enabled := True;
    tbUndo.Enabled := True;
    BitmapUndo.Canvas.Draw(0, 0, BitmapMask);
    // urceni obalky polygonu
    XMin := Poly[0].X;
    XMax := XMin;
    YMin := Poly[0].Y;
    YMax := YMin;
    for I := 1 to Count-1 do begin
      X := Poly[I].X;
      Y := Poly[I].Y;
      if X > XMax then XMax := X;
      if X < XMin then XMin := X;
      if Y > YMax then YMax := Y;
      if Y < YMin then YMin := Y;
    end;
    // posun polygonu do bodu [0,0]
    for I := 0 to Count-1 do
      with Poly[I] do begin
        X := X - XMin;
        Y := Y - YMin;
      end;
    // vytvoreni pomocne bitmapy
    B                    := TBitmap.Create();
    B.PixelFormat        := pf8bit;
    B.Canvas.Brush.Color := clBlack;
    B.Width              := XMax - XMin + 1;
    B.Height             := YMax - YMin + 1;
    // inicializace pomocne bitmapy
    B.Canvas.MoveTo(0, 0);
    // vykresleni polygonu do pomocne bitmapy
    B.Canvas.Pen.Width   := 1;
    B.Canvas.Pen.Color   := clMaroon;
    B.Canvas.Brush.Color := clMaroon;
    B.Canvas.Polygon(Poly);
    // vykresleni polygonu do masky
    for YT := 0 to B.Height-1 do begin
      YA := YT + YMin;
      if (YA >= 0) and (YA < BitmapData.Height) then begin
        PT := B.ScanLine[YT];
        PM := BitmapMask.ScanLine[YA];
        for XT := 0 to B.Width-1 do begin
          XA := XT + XMin;
          if (PT[XT] <> 0) and (XA >= 0) and (XA < BitmapData.Width) then
            PM[XA] := Ord(Layer)+1;
        end;
      end;
    end;
    // uvolneni pomocne bitmapy
    B.Free();
    // prekresleni obrazku
    RedrawImage();
    // zruseni zadaneho polygonu
    SetLength(Poly, 0);
  end;
end;

// -----------------------------------------------------------------------------
// udalost - stisk tlacitka mysi
procedure TFormMain.ImageMouseDown(Sender : TObject; Button : TMouseButton;
                                   Shift : TShiftState; X, Y : Integer);
var
  Value : String;
  Len   : Real;
begin
  // pokud je vybrana kalibrace
  if Tool = stCalibration then begin
    // pokud neni znam prvni bod
    if LastX < 0 then begin
      // ulozeni souradnic prvniho bodu
      LastX := X;
      LastY := Y;
    // pokud je znam druhy bod
    end else begin
      // vypocet vzdalenosti mezi body
      Len := Sqrt(Sqr(LastX - X) + Sqr(LastY - Y));
      // pokud je vzdalenost mezi body prilis mala
      if Len < 10 then begin
        // zobrazeni hlaseni
        ShowMessage('The distance between points is too small!');
      // pokud uzivatel zada vzdalenost mezi body v metrech
      end else if InputQuery('Calibration', 'Enter the distance between the points in meters', Value) then begin
        try
          // vypocet velikosti jednoho pixelu
          PixelSize := Sqr(StrToFloat(Value) / Len);
          // povoleni polozky menu
          miMArea.Enabled := True;
        except
          // zobrazeni hlaseni
          ShowMessage('Invalid input!');
        end;
      end;
      // prepnuti nastroje na stetec
      SelectTool(stBrush);
    end;

  // pokud neni vybrana kalibrace a neni zobrazen puvodni snimek
  end else if Mode <> smOld then begin
    // pokud je vybran polygon
    if Tool = stPolygon then begin
      // provedeni akce
      DoPolygon(Button, X, Y);
    // pokud je vybran jiny nastroj
    end else begin
      // zalohovani aktualni masky
      if Tool <> stDropper then begin
        miUndo.Enabled := True;
        tbUndo.Enabled := True;
        BitmapUndo.Canvas.Draw(0, 0, BitmapMask);
      end;
      // nastaveni priznaku stisknuti tlacitka
      Down  := True;
      LastX := -1;
      LastY := -1;
      // provedeni akce
      DoAction(X, Y);
    end;
  end;
end;

// -----------------------------------------------------------------------------
// udalost - pusteni tlacitka mysi
procedure TFormMain.ImageMouseUp(Sender : TObject; Button : TMouseButton;
                                 Shift : TShiftState; X, Y : Integer);
begin
  // zruseni priznaku stisknuti tlacitka
  Down := False;
end;

// -----------------------------------------------------------------------------
// udalost - pohyb mysi
procedure TFormMain.ImageMouseMove(Sender : TObject; Shift : TShiftState;
                                   X, Y : Integer);
begin
  // pokud neni vybrana kalibrace
  if Tool <> stCalibration then begin
    // provedeni akce
    DoAction(X, Y);
  end;

  // zobrazeni pozice mysi ve stavovem pruhu
  StatusBar.Panels[0].Text := '(' + IntToStr(X) + ', ' + IntToStr(Y) + ')';
end;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// udalost - vytvoreni formulare
procedure TFormMain.FormCreate(Sender : TObject);
begin
  // zapnuti dvojiteho bufferovani
  ScrollBox.DoubleBuffered := True;

  // nacteni konfigurace z registru
  LoadConfig(Config);

  // nastaveni jmen vrstev podle konfigurace
  SetLayerNames();

  // nastaveni barev a pruhlednosti vrstev podle konfigurace
  SetLayerProperties();

  // nastaveni vychozich hodnot ovladacich prvku
  SetDefaults();
end;

// *****************************************************************************
// *****************************************************************************

end.
