// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2006 Tomas Paukrt

program HDesigner;

uses
  Forms,
  uMain in 'uMain.pas' {FormMain},
  uAbout in 'uAbout.pas' {FormAbout},
  uArea in 'uArea.pas' {FormArea},
  uColor in 'uColor.pas' {FormColor},
  uSetup in 'uSetup.pas' {FormSetup},
  uConfig in 'uConfig.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Home Designer';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormArea, FormArea);
  Application.CreateForm(TFormColor, FormColor);
  Application.CreateForm(TFormSetup, FormSetup);
  Application.Run;
end.
