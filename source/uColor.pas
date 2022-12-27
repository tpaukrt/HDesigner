// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2006 Tomas Paukrt

unit uColor;

interface

uses
  Windows, Forms, Classes, Controls, StdCtrls, ExtCtrls, SysUtils, Graphics;

// *****************************************************************************
// *****************************************************************************

type
  TSTOColor = record
    Number : Integer;
    Color  : TColor;
  end;

type
  TFormColor = class(TForm)
    pboxColors  : TPaintBox;
    stBasic     : TStaticText;
    lbBasic     : TLabel;
    //
    pboxDetails : TPaintBox;
    //
    btnOK       : TButton;
    btnCancel   : TButton;
    //
    procedure pboxColorsPaint(Sender : TObject);
    procedure pboxColorsMouseDown(Sender : TObject; Button : TMouseButton;
                                  Shift : TShiftState; X, Y : Integer);
    procedure FormKeyPress(Sender : TObject; var Key : Char);
    procedure FormShow(Sender : TObject);
    procedure FormCreate(Sender : TObject);
  private
    STOColor       : array of TSTOColor;
    SelectedNumber : Integer;
    //
    function GetColor(Number : Integer): TColor;
    function GetNumber(Color : TColor): Integer;
    procedure SelectColor(Number : Integer);
    procedure CreatePanels();
    procedure LoadColors();
    function GetIndexOnPos(X, Y : Integer): Integer;
    procedure PanelClick(Sender : TObject);
  public
    function Execute(var Color : TColor): Boolean;
  end;

var
  FormColor : TFormColor;

// *****************************************************************************
// *****************************************************************************

implementation

{$R *.DFM}

// *****************************************************************************
// *******************************  KONSTANTY  *********************************
// *****************************************************************************

const
  // vychozi paleta barev
  DEFAULT_COLORS : array [0..799] of TSTOColor = (
    (Number : 31100; Color : $40BCBE),
    (Number : 31101; Color : $4FC9CC),
    (Number : 31102; Color : $5ECFD0),
    (Number : 31103; Color : $7ADEDE),
    (Number : 31104; Color : $90E5E6),
    (Number : 31105; Color : $A7EBEB),
    (Number : 31106; Color : $B0EDEE),
    (Number : 31107; Color : $C6F2F3),
    (Number : 31108; Color : $D0F5F4),
    (Number : 31109; Color : $DCF5F5),
    (Number : 31110; Color : $60B5BA),
    (Number : 31111; Color : $7CC7CE),
    (Number : 31112; Color : $8ED2D5),
    (Number : 31113; Color : $A7DEE1),
    (Number : 31114; Color : $B3E4E8),
    (Number : 31115; Color : $C4EAEC),
    (Number : 31116; Color : $D1EFF0),
    (Number : 31120; Color : $609799),
    (Number : 31121; Color : $7CADB0),
    (Number : 31122; Color : $91BABD),
    (Number : 31123; Color : $A3C2C5),
    (Number : 31130; Color : $5B7374),
    (Number : 31131; Color : $738E90),
    (Number : 31132; Color : $869F9E),
    (Number : 31133; Color : $9BB2B2),
    (Number : 31134; Color : $AFC5C4),
    (Number : 31135; Color : $C0D2D3),
    (Number : 31136; Color : $CDDDDE),
    (Number : 31137; Color : $D8E5E6),
    (Number : 31140; Color : $419A9F),
    (Number : 31141; Color : $487E7F),
    (Number : 31142; Color : $476866),
    (Number : 31143; Color : $506060),
    (Number : 31200; Color : $44CFF2),
    (Number : 31201; Color : $55D7F4),
    (Number : 31202; Color : $68DEF5),
    (Number : 31203; Color : $85E8F7),
    (Number : 31204; Color : $93EBF9),
    (Number : 31205; Color : $B0F1F9),
    (Number : 31206; Color : $BCF4FA),
    (Number : 31207; Color : $C9F5F8),
    (Number : 31208; Color : $D6F4F6),
    (Number : 31209; Color : $E0F6F9),
    (Number : 31210; Color : $6CCEE3),
    (Number : 31211; Color : $84D9E9),
    (Number : 31212; Color : $94DFEF),
    (Number : 31213; Color : $AAE8F5),
    (Number : 31214; Color : $B5EAF6),
    (Number : 31215; Color : $C7F0F8),
    (Number : 31216; Color : $D4F3F9),
    (Number : 31220; Color : $72BFD4),
    (Number : 31221; Color : $8BCBD8),
    (Number : 31222; Color : $9ED0D7),
    (Number : 31223; Color : $B4D5D7),
    (Number : 31224; Color : $C2D8D8),
    (Number : 31230; Color : $50666E),
    (Number : 31231; Color : $6E868D),
    (Number : 31232; Color : $7B959D),
    (Number : 31233; Color : $8FA7B1),
    (Number : 31234; Color : $A6BEC5),
    (Number : 31235; Color : $B7CBD3),
    (Number : 31236; Color : $C4D6DE),
    (Number : 31237; Color : $D3E2E9),
    (Number : 31240; Color : $58C1DA),
    (Number : 31241; Color : $429CB1),
    (Number : 31242; Color : $41899E),
    (Number : 31243; Color : $416870),
    (Number : 31244; Color : $415054),
    (Number : 31300; Color : $3BAFDE),
    (Number : 31301; Color : $53C0F1),
    (Number : 31302; Color : $65CAF3),
    (Number : 31303; Color : $7AD7F9),
    (Number : 31304; Color : $91DFFA),
    (Number : 31305; Color : $A6E5FC),
    (Number : 31306; Color : $B7EAF8),
    (Number : 31307; Color : $CDEEFA),
    (Number : 31308; Color : $D6F0F7),
    (Number : 31309; Color : $DDF2F9),
    (Number : 31310; Color : $5EB8DB),
    (Number : 31311; Color : $7BCBE8),
    (Number : 31312; Color : $8ED3ED),
    (Number : 31313; Color : $A6E1F5),
    (Number : 31314; Color : $B7E6F8),
    (Number : 31315; Color : $C6EDF9),
    (Number : 31316; Color : $D1EFF9),
    (Number : 31320; Color : $6FB7D5),
    (Number : 31321; Color : $83C3DA),
    (Number : 31322; Color : $96C9DA),
    (Number : 31323; Color : $A8CCD3),
    (Number : 31324; Color : $BED6DE),
    (Number : 31330; Color : $526471),
    (Number : 31331; Color : $6E828D),
    (Number : 31332; Color : $7D929E),
    (Number : 31333; Color : $92A8B2),
    (Number : 31334; Color : $A3B7C2),
    (Number : 31335; Color : $B8C9D5),
    (Number : 31336; Color : $C6D6DE),
    (Number : 31337; Color : $D2E2EA),
    (Number : 31340; Color : $3DA2CB),
    (Number : 31341; Color : $4295B2),
    (Number : 31342; Color : $40849B),
    (Number : 31343; Color : $406B7A),
    (Number : 31344; Color : $435C6A),
    (Number : 31400; Color : $45A7ED),
    (Number : 31401; Color : $5AB1EF),
    (Number : 31402; Color : $6ABBF5),
    (Number : 31403; Color : $88CDF9),
    (Number : 31404; Color : $9FDAFD),
    (Number : 31405; Color : $B3E1FC),
    (Number : 31406; Color : $BFE8FF),
    (Number : 31407; Color : $CFEEFE),
    (Number : 31408; Color : $DBF3FE),
    (Number : 31409; Color : $E2F5FE),
    (Number : 31410; Color : $69B2E3),
    (Number : 31411; Color : $7EC2EE),
    (Number : 31412; Color : $98CFF1),
    (Number : 31413; Color : $ACDBF9),
    (Number : 31414; Color : $C2E5FA),
    (Number : 31415; Color : $CCE9F8),
    (Number : 31416; Color : $D5EDF8),
    (Number : 31420; Color : $5C9EC7),
    (Number : 31421; Color : $74B0D5),
    (Number : 31422; Color : $8FBFDA),
    (Number : 31423; Color : $A8CCE0),
    (Number : 31424; Color : $C3D9E4),
    (Number : 31430; Color : $4F5F6D),
    (Number : 31431; Color : $6D7E8F),
    (Number : 31432; Color : $778999),
    (Number : 31433; Color : $8EA0B1),
    (Number : 31434; Color : $A4B4C2),
    (Number : 31435; Color : $B4C4D2),
    (Number : 31436; Color : $C2D0DA),
    (Number : 31437; Color : $D2E1ED),
    (Number : 31440; Color : $4E9BD0),
    (Number : 31441; Color : $4289BC),
    (Number : 31442; Color : $3E7AA0),
    (Number : 31443; Color : $40687B),
    (Number : 32100; Color : $3D98F9),
    (Number : 32101; Color : $4DA4F9),
    (Number : 32102; Color : $5EB2FE),
    (Number : 32103; Color : $7BC5FF),
    (Number : 32104; Color : $8CCDFF),
    (Number : 32105; Color : $A2D9FF),
    (Number : 32106; Color : $ADDFFF),
    (Number : 32107; Color : $C2E9FF),
    (Number : 32108; Color : $CDEEFF),
    (Number : 32109; Color : $DBF3FE),
    (Number : 32110; Color : $54A3E2),
    (Number : 32111; Color : $70BBF2),
    (Number : 32112; Color : $91CDF6),
    (Number : 32113; Color : $9FD7FA),
    (Number : 32114; Color : $BEE5FC),
    (Number : 32120; Color : $77A3CD),
    (Number : 32121; Color : $8FB6D5),
    (Number : 32122; Color : $A6C7DB),
    (Number : 32123; Color : $C0D3DF),
    (Number : 32130; Color : $475D76),
    (Number : 32131; Color : $607890),
    (Number : 32132; Color : $66829B),
    (Number : 32133; Color : $849BB3),
    (Number : 32134; Color : $92ADC3),
    (Number : 32135; Color : $A8C0D3),
    (Number : 32136; Color : $B9CEE0),
    (Number : 32137; Color : $CBDDEC),
    (Number : 32138; Color : $D8E9F3),
    (Number : 32140; Color : $3F8DC9),
    (Number : 32141; Color : $3E7EB0),
    (Number : 32142; Color : $47739E),
    (Number : 32143; Color : $415C7B),
    (Number : 32144; Color : $48576A),
    (Number : 32200; Color : $4184F3),
    (Number : 32201; Color : $5193F7),
    (Number : 32202; Color : $5D9BF9),
    (Number : 32203; Color : $7DB5FF),
    (Number : 32204; Color : $8CC0FF),
    (Number : 32205; Color : $A1CCFF),
    (Number : 32206; Color : $B1D7FF),
    (Number : 32207; Color : $C1E0FD),
    (Number : 32208; Color : $D1EAFF),
    (Number : 32209; Color : $DBEFFB),
    (Number : 32210; Color : $6091D9),
    (Number : 32211; Color : $7CAAE8),
    (Number : 32212; Color : $8EB8ED),
    (Number : 32213; Color : $A4C9F3),
    (Number : 32214; Color : $B3D3F7),
    (Number : 32215; Color : $C2DDFA),
    (Number : 32216; Color : $D0E5F8),
    (Number : 32220; Color : $7594B8),
    (Number : 32221; Color : $8DA8C5),
    (Number : 32222; Color : $9DB4CB),
    (Number : 32223; Color : $C0CDD8),
    (Number : 32230; Color : $4E596D),
    (Number : 32231; Color : $6D798B),
    (Number : 32232; Color : $7A879B),
    (Number : 32233; Color : $8E9CB0),
    (Number : 32234; Color : $A7B2C5),
    (Number : 32235; Color : $B5C0CF),
    (Number : 32236; Color : $C2CFDC),
    (Number : 32237; Color : $D2DEE8),
    (Number : 32240; Color : $4173C2),
    (Number : 32241; Color : $43679E),
    (Number : 32242; Color : $4F6582),
    (Number : 32243; Color : $3D4554),
    (Number : 32300; Color : $3F6BF0),
    (Number : 32301; Color : $4F7FF9),
    (Number : 32302; Color : $5E8CFC),
    (Number : 32303; Color : $77A2FF),
    (Number : 32304; Color : $8BAEFF),
    (Number : 32305; Color : $A3C1FF),
    (Number : 32306; Color : $AFCAFF),
    (Number : 32307; Color : $C1D6FF),
    (Number : 32308; Color : $D0E2FF),
    (Number : 32309; Color : $DCEAFF),
    (Number : 32310; Color : $5F87DD),
    (Number : 32311; Color : $799FED),
    (Number : 32312; Color : $92B0F6),
    (Number : 32313; Color : $A5C2FC),
    (Number : 32314; Color : $B1CBFE),
    (Number : 32315; Color : $C5D9FF),
    (Number : 32316; Color : $D1E1FF),
    (Number : 32320; Color : $768FC2),
    (Number : 32321; Color : $8FA7D2),
    (Number : 32322; Color : $A4B6D7),
    (Number : 32323; Color : $C3D1E4),
    (Number : 32330; Color : $526891),
    (Number : 32331; Color : $657AA3),
    (Number : 32332; Color : $7D92B9),
    (Number : 32333; Color : $91A5CB),
    (Number : 32334; Color : $A6BBD9),
    (Number : 32335; Color : $B5CAE4),
    (Number : 32336; Color : $CBDCEF),
    (Number : 32337; Color : $D2E2F2),
    (Number : 32340; Color : $3E62BD),
    (Number : 32341; Color : $485E91),
    (Number : 32342; Color : $41547D),
    (Number : 32343; Color : $404C67),
    (Number : 32400; Color : $3D56E7),
    (Number : 32401; Color : $4D66F0),
    (Number : 32402; Color : $5B75F8),
    (Number : 32403; Color : $748CFF),
    (Number : 32404; Color : $889BFF),
    (Number : 32405; Color : $A3B2FF),
    (Number : 32406; Color : $ADBBFF),
    (Number : 32407; Color : $C1C9FF),
    (Number : 32408; Color : $CFD9FF),
    (Number : 32409; Color : $DAE1FF),
    (Number : 32410; Color : $5970DC),
    (Number : 32411; Color : $7389ED),
    (Number : 32412; Color : $899BF5),
    (Number : 32413; Color : $9FAEFD),
    (Number : 32414; Color : $ABBBFF),
    (Number : 32420; Color : $7C89C6),
    (Number : 32421; Color : $98A5D5),
    (Number : 32422; Color : $AAB3D8),
    (Number : 32423; Color : $B7C0DC),
    (Number : 32424; Color : $C3C8DA),
    (Number : 32430; Color : $4D5B94),
    (Number : 32431; Color : $606FA5),
    (Number : 32432; Color : $7D8AB8),
    (Number : 32433; Color : $93A2CD),
    (Number : 32434; Color : $A4AFD6),
    (Number : 32435; Color : $BCC8E7),
    (Number : 32436; Color : $C3CCE3),
    (Number : 32440; Color : $364CBC),
    (Number : 32441; Color : $4B5BA2),
    (Number : 33100; Color : $3A41D8),
    (Number : 33101; Color : $4750E1),
    (Number : 33102; Color : $595FEF),
    (Number : 33103; Color : $747BFC),
    (Number : 33104; Color : $8A8DFF),
    (Number : 33105; Color : $9FA1FF),
    (Number : 33106; Color : $ADAEFF),
    (Number : 33107; Color : $BCBEFF),
    (Number : 33108; Color : $CCCDFF),
    (Number : 33109; Color : $D9DAFF),
    (Number : 33110; Color : $5D6DBC),
    (Number : 33111; Color : $7382CB),
    (Number : 33112; Color : $92A0E2),
    (Number : 33113; Color : $A3AFEA),
    (Number : 33114; Color : $BFCAF6),
    (Number : 33115; Color : $CBD7FD),
    (Number : 33116; Color : $D6E3FE),
    (Number : 33120; Color : $6A78BF),
    (Number : 33121; Color : $818ECD),
    (Number : 33122; Color : $9AA5D5),
    (Number : 33123; Color : $B6BFDE),
    (Number : 33130; Color : $5F6271),
    (Number : 33131; Color : $767987),
    (Number : 33132; Color : $868B96),
    (Number : 33133; Color : $9EA1AC),
    (Number : 33134; Color : $A6ABB7),
    (Number : 33135; Color : $BCBFC9),
    (Number : 33136; Color : $CCCFD9),
    (Number : 33137; Color : $D4D9DF),
    (Number : 33140; Color : $4858A9),
    (Number : 33141; Color : $32468E),
    (Number : 33142; Color : $3E4876),
    (Number : 33143; Color : $374160),
    (Number : 33144; Color : $353D52),
    (Number : 33200; Color : $3840C7),
    (Number : 33201; Color : $4D52CE),
    (Number : 33202; Color : $5C5FDC),
    (Number : 33203; Color : $7879EE),
    (Number : 33204; Color : $8E8BF7),
    (Number : 33205; Color : $A2A2FE),
    (Number : 33206; Color : $B0B0FF),
    (Number : 33207; Color : $C0C0FF),
    (Number : 33208; Color : $CECFFF),
    (Number : 33209; Color : $DBDBFF),
    (Number : 33210; Color : $5D64A9),
    (Number : 33211; Color : $7B80BF),
    (Number : 33212; Color : $8D90CC),
    (Number : 33213; Color : $A6A9DD),
    (Number : 33214; Color : $B3B6E4),
    (Number : 33215; Color : $C3C6ED),
    (Number : 33216; Color : $D1D5F4),
    (Number : 33220; Color : $6F74AE),
    (Number : 33221; Color : $9194C3),
    (Number : 33222; Color : $AAAED1),
    (Number : 33223; Color : $BABDD7),
    (Number : 33224; Color : $C9CBDC),
    (Number : 33230; Color : $474D72),
    (Number : 33231; Color : $595E7F),
    (Number : 33232; Color : $757B98),
    (Number : 33233; Color : $868AA5),
    (Number : 33234; Color : $9DA0B8),
    (Number : 33235; Color : $B1B4C8),
    (Number : 33236; Color : $C9CDD9),
    (Number : 33237; Color : $D7DAE3),
    (Number : 33240; Color : $38438C),
    (Number : 33241; Color : $35417D),
    (Number : 33300; Color : $464898),
    (Number : 33301; Color : $5959B1),
    (Number : 33302; Color : $6A68C3),
    (Number : 33303; Color : $827FD7),
    (Number : 33304; Color : $9492E3),
    (Number : 33305; Color : $ABA8F1),
    (Number : 33306; Color : $B4B2F4),
    (Number : 33307; Color : $C3C0F9),
    (Number : 33308; Color : $D5D5FF),
    (Number : 33309; Color : $E0E0FF),
    (Number : 33310; Color : $5D609E),
    (Number : 33311; Color : $7C7FB7),
    (Number : 33312; Color : $8F90C6),
    (Number : 33313; Color : $A3A6D3),
    (Number : 33314; Color : $B0B1DC),
    (Number : 33315; Color : $C1C3E8),
    (Number : 33316; Color : $D1D4ED),
    (Number : 33317; Color : $DCE1F6),
    (Number : 33320; Color : $7174A7),
    (Number : 33321; Color : $9091B9),
    (Number : 33322; Color : $A9ABCC),
    (Number : 33323; Color : $BABBD4),
    (Number : 33324; Color : $C7C8D9),
    (Number : 33330; Color : $54567F),
    (Number : 33331; Color : $6C6E98),
    (Number : 33332; Color : $8081A8),
    (Number : 33333; Color : $9697BA),
    (Number : 33334; Color : $A3A5C8),
    (Number : 33335; Color : $B8BBD6),
    (Number : 33336; Color : $C7C9E3),
    (Number : 33337; Color : $D5D8EA),
    (Number : 33340; Color : $38438D),
    (Number : 33341; Color : $3E477E),
    (Number : 33342; Color : $3A406A),
    (Number : 33400; Color : $544D7F),
    (Number : 33401; Color : $6A6097),
    (Number : 33402; Color : $7C72AA),
    (Number : 33403; Color : $958ABF),
    (Number : 33404; Color : $A79ED0),
    (Number : 33405; Color : $BBB3DD),
    (Number : 33406; Color : $C3BCE4),
    (Number : 33407; Color : $D1CCEE),
    (Number : 33408; Color : $DAD9F4),
    (Number : 33409; Color : $E3E4F8),
    (Number : 33410; Color : $716690),
    (Number : 33411; Color : $867AA7),
    (Number : 33412; Color : $9A90B9),
    (Number : 33413; Color : $ADA4CA),
    (Number : 33414; Color : $BEB8DB),
    (Number : 33420; Color : $736F90),
    (Number : 33421; Color : $938EAC),
    (Number : 33422; Color : $AFACC0),
    (Number : 33423; Color : $BDBDCF),
    (Number : 33424; Color : $C8C7D1),
    (Number : 33430; Color : $625C70),
    (Number : 33431; Color : $797188),
    (Number : 33432; Color : $898098),
    (Number : 33433; Color : $9A95AD),
    (Number : 33434; Color : $B1ACBF),
    (Number : 33435; Color : $BFBCD0),
    (Number : 33436; Color : $CBCBDC),
    (Number : 33437; Color : $DADDEA),
    (Number : 33440; Color : $5F597E),
    (Number : 33441; Color : $544F5A),
    (Number : 34100; Color : $6B5569),
    (Number : 34101; Color : $836B80),
    (Number : 34102; Color : $957D91),
    (Number : 34103; Color : $AD99AB),
    (Number : 34104; Color : $BDA8B9),
    (Number : 34105; Color : $CCBCCC),
    (Number : 34106; Color : $D3C6D4),
    (Number : 34107; Color : $DCD4DF),
    (Number : 34108; Color : $E5E0EA),
    (Number : 34109; Color : $EBE8F1),
    (Number : 34110; Color : $826C76),
    (Number : 34111; Color : $9E8794),
    (Number : 34112; Color : $AF9AA6),
    (Number : 34113; Color : $B6A4B0),
    (Number : 34114; Color : $BEAFBB),
    (Number : 34115; Color : $D2C9D1),
    (Number : 34116; Color : $D9D5DC),
    (Number : 34120; Color : $85757B),
    (Number : 34121; Color : $95868D),
    (Number : 34122; Color : $AB9DA5),
    (Number : 34123; Color : $BEB3BD),
    (Number : 34124; Color : $CAC4CC),
    (Number : 34130; Color : $5D5A60),
    (Number : 34131; Color : $6E6B71),
    (Number : 34132; Color : $827C83),
    (Number : 34133; Color : $928F95),
    (Number : 34134; Color : $A7A4A8),
    (Number : 34135; Color : $B2B0B3),
    (Number : 34136; Color : $C5C2C6),
    (Number : 34137; Color : $D1D0D3),
    (Number : 34138; Color : $DCDBDE),
    (Number : 34140; Color : $6C5862),
    (Number : 34141; Color : $4C4353),
    (Number : 34200; Color : $6B505C),
    (Number : 34201; Color : $896B75),
    (Number : 34202; Color : $9B7D86),
    (Number : 34203; Color : $B99FA9),
    (Number : 34204; Color : $C3AEB6),
    (Number : 34205; Color : $D0C0C9),
    (Number : 34206; Color : $D7C9D0),
    (Number : 34207; Color : $E2D8DE),
    (Number : 34208; Color : $E9E3EA),
    (Number : 34209; Color : $EBEAED),
    (Number : 34210; Color : $77646F),
    (Number : 34211; Color : $947E87),
    (Number : 34212; Color : $A49099),
    (Number : 34213; Color : $BBACB1),
    (Number : 34214; Color : $C7BBC2),
    (Number : 34215; Color : $D5D0D6),
    (Number : 34216; Color : $DFDEE5),
    (Number : 34220; Color : $97868E),
    (Number : 34221; Color : $AD9DA5),
    (Number : 34222; Color : $BAAFB5),
    (Number : 34230; Color : $665A5D),
    (Number : 34231; Color : $7F7073),
    (Number : 34232; Color : $948589),
    (Number : 34233; Color : $A29498),
    (Number : 34234; Color : $B6ABAB),
    (Number : 34235; Color : $CDC5C8),
    (Number : 34236; Color : $D2CBCE),
    (Number : 34237; Color : $DCDBDE),
    (Number : 34240; Color : $806D74),
    (Number : 34241; Color : $6A595F),
    (Number : 34242; Color : $625559),
    (Number : 34243; Color : $554C4E),
    (Number : 34300; Color : $7A5451),
    (Number : 34301; Color : $9A736C),
    (Number : 34302; Color : $AB867C),
    (Number : 34303; Color : $C4A59C),
    (Number : 34304; Color : $CDB3AD),
    (Number : 34305; Color : $D9C6C1),
    (Number : 34306; Color : $E0D1CE),
    (Number : 34307; Color : $E0D1CE),
    (Number : 34308; Color : $EAE5E2),
    (Number : 34309; Color : $EEEEEE),
    (Number : 34310; Color : $9F837C),
    (Number : 34311; Color : $B49B92),
    (Number : 34312; Color : $C3AEA7),
    (Number : 34313; Color : $CEBBB6),
    (Number : 34314; Color : $E0C9C7),
    (Number : 34315; Color : $E0D4D2),
    (Number : 34320; Color : $98837F),
    (Number : 34321; Color : $B1A09B),
    (Number : 34322; Color : $CABEB9),
    (Number : 34323; Color : $D3CCCA),
    (Number : 34330; Color : $6F6262),
    (Number : 34331; Color : $7A6C6C),
    (Number : 34332; Color : $9A8C8C),
    (Number : 34333; Color : $AB9FA0),
    (Number : 34334; Color : $BFB5B7),
    (Number : 34335; Color : $C8C0C3),
    (Number : 34336; Color : $D5D1D1),
    (Number : 34337; Color : $DEDBDE),
    (Number : 34340; Color : $6B5452),
    (Number : 34341; Color : $635655),
    (Number : 34400; Color : $8C5B48),
    (Number : 34401; Color : $AB7B60),
    (Number : 34402; Color : $BB8D72),
    (Number : 34403; Color : $D2AE96),
    (Number : 34404; Color : $D9BAA7),
    (Number : 34405; Color : $E2CCBC),
    (Number : 34406; Color : $E4D3C6),
    (Number : 34407; Color : $EDE1D7),
    (Number : 34408; Color : $F0E9E4),
    (Number : 34409; Color : $F0EFEB),
    (Number : 34410; Color : $B28E74),
    (Number : 34411; Color : $C9AB94),
    (Number : 34412; Color : $D4BBA7),
    (Number : 34413; Color : $DECCBC),
    (Number : 34414; Color : $E5D6CA),
    (Number : 34420; Color : $9A837C),
    (Number : 34421; Color : $B7A49C),
    (Number : 34422; Color : $C5B9B3),
    (Number : 34423; Color : $D3CCCA),
    (Number : 34430; Color : $736660),
    (Number : 34431; Color : $81726B),
    (Number : 34432; Color : $9C8D89),
    (Number : 34433; Color : $AFA49E),
    (Number : 34434; Color : $C2B9B5),
    (Number : 34435; Color : $C8C1BE),
    (Number : 34436; Color : $D7D2D0),
    (Number : 34437; Color : $E3E0DE),
    (Number : 34440; Color : $7A5848),
    (Number : 34441; Color : $6E5648),
    (Number : 34442; Color : $544946),
    (Number : 35100; Color : $B36612),
    (Number : 35101; Color : $CE893C),
    (Number : 35102; Color : $D69A5A),
    (Number : 35103; Color : $E2B385),
    (Number : 35104; Color : $EAC39B),
    (Number : 35105; Color : $EED4B5),
    (Number : 35106; Color : $F1DAC2),
    (Number : 35107; Color : $F1E3D0),
    (Number : 35108; Color : $F2EBDE),
    (Number : 35109; Color : $F2EFE9),
    (Number : 35110; Color : $C09263),
    (Number : 35111; Color : $D5B189),
    (Number : 35112; Color : $DCBD9C),
    (Number : 35113; Color : $E6CFB7),
    (Number : 35114; Color : $EBD8C1),
    (Number : 35120; Color : $AC8B67),
    (Number : 35121; Color : $C2A98E),
    (Number : 35122; Color : $D0BFAC),
    (Number : 35123; Color : $D4CBC2),
    (Number : 35124; Color : $D4D0CB),
    (Number : 35130; Color : $78695D),
    (Number : 35131; Color : $82726A),
    (Number : 35132; Color : $A3958C),
    (Number : 35133; Color : $AFA59B),
    (Number : 35134; Color : $BFB4AD),
    (Number : 35135; Color : $CCC4BE),
    (Number : 35136; Color : $D7D2CD),
    (Number : 35137; Color : $E3E0DC),
    (Number : 35140; Color : $915F2F),
    (Number : 35141; Color : $664630),
    (Number : 35200; Color : $AB6E0C),
    (Number : 35201; Color : $C38B3D),
    (Number : 35202; Color : $CF9C53),
    (Number : 35203; Color : $E0B784),
    (Number : 35204; Color : $E6C498),
    (Number : 35205; Color : $EDD4B2),
    (Number : 35206; Color : $EDDCBF),
    (Number : 35207; Color : $F4E8D5),
    (Number : 35208; Color : $F2EDE0),
    (Number : 35209; Color : $F6F5EE),
    (Number : 35210; Color : $BB945F),
    (Number : 35211; Color : $CFB188),
    (Number : 35212; Color : $DCC19D),
    (Number : 35213; Color : $E4D1B3),
    (Number : 35220; Color : $A78859),
    (Number : 35221; Color : $C0A67F),
    (Number : 35222; Color : $CEBCA3),
    (Number : 35223; Color : $D5CAB7),
    (Number : 35224; Color : $D9D1C5),
    (Number : 35230; Color : $69645D),
    (Number : 35231; Color : $7A7874),
    (Number : 35232; Color : $84827D),
    (Number : 35233; Color : $9E9A92),
    (Number : 35234; Color : $B7B4AE),
    (Number : 35235; Color : $C5C4C1),
    (Number : 35236; Color : $D5D5D2),
    (Number : 35237; Color : $DFE6E5),
    (Number : 35240; Color : $865E2D),
    (Number : 35241; Color : $63482A),
    (Number : 35242; Color : $5A4E41),
    (Number : 35300; Color : $95720C),
    (Number : 35301; Color : $A48226),
    (Number : 35302; Color : $BA9A51),
    (Number : 35303; Color : $CFB578),
    (Number : 35304; Color : $DBC492),
    (Number : 35305; Color : $DFD0AB),
    (Number : 35306; Color : $E4D7B7),
    (Number : 35307; Color : $EBE1C8),
    (Number : 35308; Color : $EBE6D5),
    (Number : 35309; Color : $F0F0E7),
    (Number : 35310; Color : $A08955),
    (Number : 35311; Color : $AE9966),
    (Number : 35312; Color : $C4B38A),
    (Number : 35313; Color : $D1C19D),
    (Number : 35314; Color : $DCD0B5),
    (Number : 35315; Color : $E1D9C1),
    (Number : 35320; Color : $938364),
    (Number : 35321; Color : $A7997A),
    (Number : 35322; Color : $B0A58A),
    (Number : 35323; Color : $C4BDA5),
    (Number : 35324; Color : $CECAB8),
    (Number : 35330; Color : $7C6F55),
    (Number : 35331; Color : $98886C),
    (Number : 35332; Color : $A7987E),
    (Number : 35333; Color : $AC9E88),
    (Number : 35334; Color : $BFB5A0),
    (Number : 35335; Color : $CCC4B3),
    (Number : 35336; Color : $D6D2C4),
    (Number : 35337; Color : $E3E4DD),
    (Number : 35340; Color : $8A723D),
    (Number : 35341; Color : $857755),
    (Number : 35342; Color : $706452),
    (Number : 35400; Color : $837728),
    (Number : 35401; Color : $9E9248),
    (Number : 35402; Color : $ACA15E),
    (Number : 35403; Color : $C1B782),
    (Number : 35404; Color : $D0C697),
    (Number : 35405; Color : $DBD5B2),
    (Number : 35406; Color : $E2DCBF),
    (Number : 35407; Color : $E7E4CF),
    (Number : 35408; Color : $EAECDD),
    (Number : 35409; Color : $F0F2EA),
    (Number : 35410; Color : $A19967),
    (Number : 35411; Color : $BCB58C),
    (Number : 35412; Color : $C8C39D),
    (Number : 35413; Color : $D4D1B5),
    (Number : 35414; Color : $DCD9C1),
    (Number : 35415; Color : $E3E3D2),
    (Number : 35420; Color : $92895C),
    (Number : 35421; Color : $AEA781),
    (Number : 35422; Color : $C1BCA0),
    (Number : 35423; Color : $CECAB8),
    (Number : 35430; Color : $7E7963),
    (Number : 35431; Color : $9A957F),
    (Number : 35432; Color : $ACA794),
    (Number : 35433; Color : $C0BBAC),
    (Number : 35434; Color : $C7C3B7),
    (Number : 35435; Color : $D5D3CA),
    (Number : 35436; Color : $DEDDD8),
    (Number : 35437; Color : $E5E6E1),
    (Number : 35440; Color : $918752),
    (Number : 35441; Color : $746B37),
    (Number : 35442; Color : $5A5130),
    (Number : 36100; Color : $617C34),
    (Number : 36101; Color : $718C45),
    (Number : 36102; Color : $8BA569),
    (Number : 36103; Color : $A5BC89),
    (Number : 36104; Color : $B4C89B),
    (Number : 36105; Color : $C7D7B6),
    (Number : 36106; Color : $CEDDC3),
    (Number : 36107; Color : $D9E5CF),
    (Number : 36108; Color : $E3ECDF),
    (Number : 36109; Color : $E8F0E9),
    (Number : 36110; Color : $839577),
    (Number : 36111; Color : $9FAE95),
    (Number : 36112; Color : $AEBDA7),
    (Number : 36113; Color : $C4D0BF),
    (Number : 36114; Color : $CDD9C9),
    (Number : 36115; Color : $D6DFD5),
    (Number : 36120; Color : $838F6E),
    (Number : 36121; Color : $9FAC8F),
    (Number : 36122; Color : $B9C0AC),
    (Number : 36123; Color : $C5CABC),
    (Number : 36124; Color : $D0D4CA),
    (Number : 36130; Color : $717965),
    (Number : 36131; Color : $8D9583),
    (Number : 36132; Color : $A1A894),
    (Number : 36133; Color : $B5BCAD),
    (Number : 36134; Color : $BEC5B6),
    (Number : 36135; Color : $D0D4CA),
    (Number : 36136; Color : $DBE2D8),
    (Number : 36137; Color : $E4EAE4),
    (Number : 36140; Color : $677658),
    (Number : 36141; Color : $526340),
    (Number : 36142; Color : $515946),
    (Number : 36200; Color : $598C50),
    (Number : 36201; Color : $6BA06D),
    (Number : 36202; Color : $7CAF81),
    (Number : 36203; Color : $94C39B),
    (Number : 36204; Color : $A6CFAF),
    (Number : 36205; Color : $B9DEC6),
    (Number : 36206; Color : $C3E2CF),
    (Number : 36207; Color : $CFE9DC),
    (Number : 36208; Color : $DEF3EA),
    (Number : 36209; Color : $E6F5F3),
    (Number : 36210; Color : $679076),
    (Number : 36211; Color : $84A996),
    (Number : 36212; Color : $A1C3B3),
    (Number : 36213; Color : $B6D3C8),
    (Number : 36214; Color : $C5DDD5),
    (Number : 36215; Color : $D7EAE6),
    (Number : 36216; Color : $DFEFED),
    (Number : 36217; Color : $E8F4F5),
    (Number : 36220; Color : $789E8C),
    (Number : 36221; Color : $92B1A1),
    (Number : 36222; Color : $A7C2B6),
    (Number : 36223; Color : $BACDC5),
    (Number : 36230; Color : $5B655F),
    (Number : 36231; Color : $7B867F),
    (Number : 36232; Color : $87938B),
    (Number : 36233; Color : $9CA7A3),
    (Number : 36234; Color : $B4BDB8),
    (Number : 36235; Color : $C8D0CD),
    (Number : 36236; Color : $D4DDDC),
    (Number : 36237; Color : $DCE6E7),
    (Number : 36240; Color : $577762),
    (Number : 36241; Color : $546B59),
    (Number : 36300; Color : $53A073),
    (Number : 36301; Color : $60AE8A),
    (Number : 36302; Color : $6EBC98),
    (Number : 36303; Color : $88D0B4),
    (Number : 36304; Color : $9BDAC1),
    (Number : 36305; Color : $ADE2D3),
    (Number : 36306; Color : $B8E8DC),
    (Number : 36307; Color : $C9EFE6),
    (Number : 36308; Color : $D6F3EE),
    (Number : 36309; Color : $E0F5F4),
    (Number : 36310; Color : $6E9B86),
    (Number : 36311; Color : $84AE9D),
    (Number : 36312; Color : $A7C5BA),
    (Number : 36313; Color : $B0D3CA),
    (Number : 36314; Color : $CCE5E3),
    (Number : 36320; Color : $6B9783),
    (Number : 36321; Color : $87AE9E),
    (Number : 36322; Color : $A1BFB5),
    (Number : 36323; Color : $ACC5C1),
    (Number : 36324; Color : $C2D1CD),
    (Number : 36330; Color : $627D71),
    (Number : 36331; Color : $758F85),
    (Number : 36332; Color : $8AA39A),
    (Number : 36333; Color : $A2BBB4),
    (Number : 36334; Color : $B2C9C3),
    (Number : 36335; Color : $C4D7D2),
    (Number : 36336; Color : $D0E1E1),
    (Number : 36337; Color : $D7E9EA),
    (Number : 36340; Color : $59846A),
    (Number : 36341; Color : $4F6D5B),
    (Number : 36342; Color : $434E46),
    (Number : 36400; Color : $46B4A2),
    (Number : 36401; Color : $4DB9A9),
    (Number : 36402; Color : $62C8BC),
    (Number : 36403; Color : $7BDAD3),
    (Number : 36404; Color : $93E1DB),
    (Number : 36405; Color : $A9E9E5),
    (Number : 36406; Color : $B0EFEC),
    (Number : 36407; Color : $C5F3F1),
    (Number : 36408; Color : $D3F6F6),
    (Number : 36409; Color : $DCF7F8),
    (Number : 36410; Color : $6AB3AA),
    (Number : 36411; Color : $85C5BF),
    (Number : 36412; Color : $9AD3CE),
    (Number : 36413; Color : $AEDDDA),
    (Number : 36414; Color : $BCE5E3),
    (Number : 36415; Color : $CCEDEA),
    (Number : 36416; Color : $DBF5F6),
    (Number : 36420; Color : $6D9B9A),
    (Number : 36421; Color : $85AEAB),
    (Number : 36422; Color : $9ABDBE),
    (Number : 36423; Color : $AEC8C8),
    (Number : 36424; Color : $CADBDB),
    (Number : 36430; Color : $5D8279),
    (Number : 36431; Color : $6C908B),
    (Number : 36432; Color : $86A8A3),
    (Number : 36433; Color : $9DBBB6),
    (Number : 36434; Color : $B1CBCA),
    (Number : 36435; Color : $BED6D4),
    (Number : 36436; Color : $CCE1E0),
    (Number : 36437; Color : $D9EAEA),
    (Number : 36440; Color : $459386),
    (Number : 36441; Color : $507A76),
    (Number : 36442; Color : $4B6E66),
    (Number : 36443; Color : $3F5451),
    (Number : 37100; Color : $3F4040),
    (Number : 37101; Color : $4D4E4C),
    (Number : 37102; Color : $5E5E5D),
    (Number : 37103; Color : $676664),
    (Number : 37104; Color : $747572),
    (Number : 37105; Color : $838481),
    (Number : 37106; Color : $90918F),
    (Number : 37107; Color : $9D9E9D),
    (Number : 37108; Color : $AFB1B0),
    (Number : 37109; Color : $C4C7C5),
    (Number : 37110; Color : $D0D2D0),
    (Number : 37111; Color : $D2DDDE),
    (Number : 37200; Color : $6A6662),
    (Number : 37201; Color : $7A7874),
    (Number : 37202; Color : $86827C),
    (Number : 37203; Color : $9F9C96),
    (Number : 37204; Color : $BAB9B6),
    (Number : 37205; Color : $C5C4C1),
    (Number : 37206; Color : $D5D5D2),
    (Number : 37207; Color : $DFE3E3),
    (Number : 37300; Color : $666364),
    (Number : 37301; Color : $6E6A6B),
    (Number : 37302; Color : $7C7879),
    (Number : 37303; Color : $8F8B8C),
    (Number : 37304; Color : $A19E9F),
    (Number : 37305; Color : $B8B6B7),
    (Number : 37306; Color : $CACACA),
    (Number : 37307; Color : $D6D6D6)
  );

// *****************************************************************************
// ****************************  POMOCNE FUNKCE  *******************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// ziskani jednoho tokenu ze zadaneho retezce
function GetToken(var S : String) : String;
var
  P1, P2 : Integer;
begin
  S := Trim(S);
  P1 := Pos(' ', S);
  P2 := Pos(#9, S);
  if (P2 > 0) and (P2 < P1) then
    P1 := P2;
  if P1 = 0 then begin
    Result := S;
    S      := '';
  end else begin
    Result := Copy(S, 1, P1-1);
    S      := Copy(S, P1, Length(S));
  end;
end;

// -----------------------------------------------------------------------------
// prevod radianu na stupne
function ToDeg(Angle : Double) : Integer;
begin
  Result := Round(180 * Angle / Pi);
end;

// -----------------------------------------------------------------------------
// prevod stupnu na radiany
function ToRad(Angle : Double) : Double;
begin
  Result := Pi * Angle / 180;
end;

// *****************************************************************************
// ******************  TRIDA TFormColor - PRIVATNI METODY  *********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// ziskani barvy podle cisla
function TFormColor.GetColor(Number : Integer) : TColor;
var
  I : Integer;
begin
  for I := 0 to Length(STOColor) - 1 do
    if STOColor[I].Number = Number then begin
      Result := STOColor[I].Color;
      Exit;
    end;
  Result := clBlack;
end;

// -----------------------------------------------------------------------------
// ziskani indexu barvy
function TFormColor.GetNumber(Color : TColor) : Integer;
var
  MinDiff, Diff : Real;
  Index, I      : Integer;
begin
  Index   := 0;
  MinDiff := MaxLongint;
  for I := 0 to Length(STOColor) - 1 do begin
    Diff := Sqr(((STOColor[I].Color and $FF0000) shr 16) - ((Color and $FF0000) shr 16)) +
            Sqr(((STOColor[I].Color and $FF00) shr 8) - ((Color and $FF00) shr 8)) +
            Sqr((STOColor[I].Color and $FF) - (Color and $FF));
    if Diff < MinDiff then begin
      MinDiff := Diff;
      Index   := I;
    end;
  end;
  Result := STOColor[Index].Number;
end;

// -----------------------------------------------------------------------------
// vyber barvy se zadanym indexem
procedure TFormColor.SelectColor(Number : Integer);
var
  Panel      : TPanel;
  Color      : TColor;
  X, Y       : Integer;
  BaseNumber : Integer;
begin
  SelectedNumber := Number;
  BaseNumber     := 100 * (Number div 100);
  for X := 0 to 5 do begin
    for Y := 0 to 9 do begin
      Number := BaseNumber + X * 10 + Y;
      Color := GetColor(Number);
      Panel := FormColor.FindChildControl('PNL' + IntToStr(X) + IntToStr(Y)) as TPanel;
      if Panel <> nil then
        if Color <> clBlack then begin
          if Number = SelectedNumber then begin
            Panel.BevelInner  := bvLowered;
            Panel.BevelOuter  := bvRaised;
            Panel.BevelWidth  := 2;
          end else begin
            Panel.BevelInner  := bvRaised;
            Panel.BevelOuter  := bvLowered;
            Panel.BevelWidth  := 1;
          end;
          Panel.Color   := Color;
          Panel.Caption := IntToStr(Number);
          Panel.Visible := True;
        end else begin
          Panel.Visible := False;
        end;
    end;
  end;
  stBasic.Caption := IntToStr(BaseNumber);
end;

// -----------------------------------------------------------------------------
// vytvoreni panelu pro vyber barev
procedure TFormColor.CreatePanels();
var
  X, Y  : Integer;
  Panel : TPanel;
begin
  for X := 0 to 5 do begin
    for Y := 0 to 9 do begin
      Panel            := TPanel.Create(FormColor);
      Panel.Width      := 45;
      Panel.Height     := 25;
      Panel.Top        := pboxDetails.Top + Y * 30;
      Panel.Left       := pboxDetails.Left + X * 50;
      Panel.BevelInner := bvRaised;
      Panel.BevelOuter := bvLowered;
      Panel.Name       := 'PNL' + IntToStr(X) + IntToStr(Y);
      Panel.OnClick    := PanelClick;
      Panel.Visible    := False;
      Panel.Parent     := FormColor;
    end;
  end;
end;

// -----------------------------------------------------------------------------
// nacteni palety barev ze souboru
procedure TFormColor.LoadColors();
var
  F          : TextFile;
  S          : String;
  I, R, G, B : Integer;
  Count      : Integer;
begin
  AssignFile(F, ChangeFileExt(ParamStr(0), '.pal'));
  {$I-}
  Reset(F);
  {$I+}
  if IOResult = 0 then begin
    Count := 0;
    while not Eof(F) do begin
      Readln(F, S);
      if (S[1] = 'S') then begin
        GetToken(S);
        GetToken(S);
        I := StrToIntDef(GetToken(S), 0);
        R := StrToIntDef(GetToken(S), 0);
        G := StrToIntDef(GetToken(S), 0);
        B := StrToIntDef(GetToken(S), 0);
        SetLength(STOColor, Count + 1);
        STOColor[Count].Number := I;
        STOColor[Count].Color  := (B shl 16) + (G shl 8) + R;
        Inc(Count);
      end;
    end;
    CloseFile(F);
  end else begin
    SetLength(STOColor, Length(DEFAULT_COLORS));
    for I := Low(STOColor) to High(STOColor) do begin
      STOColor[I].Number := DEFAULT_COLORS[I].Number;
      STOColor[I].Color  := DEFAULT_COLORS[I].Color;
    end;
  end;
end;

// -----------------------------------------------------------------------------
// zjisteni indexu barvy na pozici [X,Y]
function TFormColor.GetIndexOnPos(X, Y : Integer) : Integer;
var
  Angle : Integer;
  Index : Integer;
begin
  with pboxColors do begin
    X := X - Width div 2;
    Y := Y - Height div 2;
    if Y = 0 then Inc(Y);
    Angle := 390 - ToDeg(ArcTan(X / Y));
    if Y > 0 then
      Angle := Angle + 180;
    Angle := Angle mod 360;
    Index := 31100 + 1000 * (Angle div 60) + 100 * ((Angle mod 60) div 15);
    stBasic.Caption := IntToStr(Index);
    Result := Index;
  end;
end;

// -----------------------------------------------------------------------------
// udalost - vykresleni obsahu PaintBoxu
procedure TFormColor.pboxColorsPaint(Sender : TObject);

  procedure CPie(AFrom, ATo : Double; C : TColor);
  var
    X1, Y1, X2, Y2 : Integer;
  begin
    with pboxColors, Canvas do begin
      Brush.Color := C;
      Pen.Width   := 1;
      X1 := Round(Width / 2  + 100 * Cos(ToRad(AFrom)));
      Y1 := Round(Height / 2 - 100 * Sin(ToRad(AFrom)));
      X2 := Round(Width / 2  + 100 * Cos(ToRad(ATo + 0.2)));
      Y2 := Round(Height / 2 - 100 * Sin(ToRad(ATo + 0.2)));
      Pie(1, 1, Width, Height, X1, Y1, X2, Y2);
    end;
  end;

var
  I : Integer;
begin
  with pboxColors, Canvas do begin
    for I := 1 to 6 do begin
      CPie(120 - I * 60, 135 - I * 60, GetColor(30400 + I * 1000));
      CPie(135 - I * 60, 150 - I * 60, GetColor(30300 + I * 1000));
      CPie(150 - I * 60, 165 - I * 60, GetColor(30200 + I * 1000));
      CPie(165 - I * 60, 180 - I * 60, GetColor(30100 + I * 1000));
    end;
    Brush.Color := clBtnFace;
    Ellipse(Width div 2 - 50, Height div 2 - 50, Width div 2 + 50, Height div 2 + 50);
  end;
end;

// -----------------------------------------------------------------------------
// udalost - vyber zakladni barvy
procedure TFormColor.pboxColorsMouseDown(Sender : TObject; Button : TMouseButton;
                                         Shift : TShiftState; X, Y : Integer);
begin
  SelectColor(GetIndexOnPos(X, Y));
end;

// -----------------------------------------------------------------------------
// udalost - vyber zakladni barvy
procedure TFormColor.PanelClick(Sender : TObject);
var
  Index : Integer;
begin
  Index := StrToInt(Copy((Sender as TPanel).Name, 4, 2));
  SelectColor(100 * (SelectedNumber div 100) + Index);
end;

// -----------------------------------------------------------------------------
// udalost - stisk klavesy
procedure TFormColor.FormKeyPress(Sender : TObject; var Key : Char);
begin
  if Key = Chr(VK_ESCAPE) then
    Close();
end;

// -----------------------------------------------------------------------------
// udalost - zobrazeni formulare
procedure TFormColor.FormShow(Sender : TObject);
begin
  btnOK.SetFocus();
end;

// -----------------------------------------------------------------------------
// udalost - vytvoreni formulare
procedure TFormColor.FormCreate(Sender : TObject);
begin
  CreatePanels();
  LoadColors();
end;

// *****************************************************************************
// ******************  TRIDA TFormColor - VEREJNE METODY  **********************
// *****************************************************************************

// -----------------------------------------------------------------------------
// otevreni dialogu
function TFormColor.Execute(var Color : TColor) : Boolean;
begin
  Position := poMainFormCenter;
  SelectColor(GetNumber(Color));
  if ShowModal() = mrOk then begin
    Color  := GetColor(SelectedNumber);
    Result := True;
  end else begin
    Result := False;
  end;
end;

// *****************************************************************************
// *****************************************************************************

end.
