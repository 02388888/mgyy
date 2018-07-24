program AGYYPRO;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainFrm},
  inifile in 'inifile.pas',
  checknet in 'checknet.pas',
  Logger in 'Logger.pas',
  dict in 'dict.pas',
  FontSetForm in 'FontSetForm.pas' {frmFontSet},
  StyleSetForm in 'StyleSetForm.pas' {frmStyleSet},
  mbus in 'mbus.pas',
  frmManufacture in 'frmManufacture.pas' {frmManu},
  Setfrom in 'Setfrom.pas' {frmSet},
  font in 'font.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '安钢轮圈压印专用系统';
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TfrmFontSet, frmFontSet);
  Application.CreateForm(TfrmStyleSet, frmStyleSet);
  Application.CreateForm(TfrmManu, frmManu);
  Application.CreateForm(TfrmSet, frmSet);
  Application.Run;
end.
