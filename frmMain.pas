unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, MBAXPLib_TLB, AdvMemo, StdCtrls, Buttons,StrUtils,Logger,
  inifile, Menus, cxLookAndFeelPainters, cxButtons, AdvEdit, ActnList,
  AdvMenus, WinSkinData, SkinCaption, frmManufacture,Setfrom, mbus, DB,
  ADODB, font, Math, ExtCtrls, ComCtrls;

type
  TMainFrm = class(TForm)
    mbxp1: TMbaxp;
    grp1: TGroupBox;
    btnSet: TSpeedButton;
    btnReset: TSpeedButton;
    btnExit: TSpeedButton;
    btnShoudong: TSpeedButton;
    btnStart: TcxButton;
    btnStop: TcxButton;
    pnl1: TPanel;
    lblVIN: TLabel;
    advmnmn1: TAdvMainMenu;
    N1: TMenuItem;
    menuStart: TMenuItem;
    menuStop: TMenuItem;
    menuManu: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    menuReset: TMenuItem;
    menuSet: TMenuItem;
    N2: TMenuItem;
    menuExit: TMenuItem;
    N5: TMenuItem;
    menuGumian: TMenuItem;
    menuWangmian: TMenuItem;
    actlst1: TActionList;
    actManu: TAction;
    actSet: TAction;
    actStart: TAction;
    actStop: TAction;
    actReset: TAction;
    actReStart: TAction;
    actExit: TAction;
    edtValue: TAdvEdit;
    lblModel: TLabel;
    qry1: TADOQuery;
    conSave: TADOConnection;
    grp2: TGroupBox;
    lbl1: TLabel;
    edtProName: TAdvEdit;
    lbl5: TLabel;
    edtProPos: TAdvEdit;
    lbl3: TLabel;
    edtZilunPos: TAdvEdit;
    lbl6: TLabel;
    edt1: TAdvEdit;
    lbl4: TLabel;
    edtFontSpace: TAdvEdit;
    lbl7: TLabel;
    edtProductDiameter: TAdvEdit;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    advmWorkLog: TAdvMemo;
    mmoPrintLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actManuExecute(Sender: TObject);
    procedure menuGumianClick(Sender: TObject);
    procedure menuWangmianClick(Sender: TObject);
    procedure actStartExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure actSetExecute(Sender: TObject);
    procedure actResetExecute(Sender: TObject);
    procedure mbxp1ResultOk(ASender: TObject; Handle: Smallint);
    procedure mbxp1ResultError(ASender: TObject; Handle, Error: Smallint);
    procedure FormActivate(Sender: TObject);
    procedure edtProPosChange(Sender: TObject);
    procedure edtZilunPosChange(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure edtFontSpaceChange(Sender: TObject);
    procedure edtProductDiameterChange(Sender: TObject);

  private

    log: TLogger ;
    ini: CMarkIniFile;
    m_strJin: string;     //字库字串， 静平衡标志符
    m_dBuchangAngle: Single;    //工件角度补偿
    m_nModbusPort, m_nSlaveId: integer;
    m_wModel: Word;  //为0为测试，1则毂面，2为辋面

    procedure LoadIni;
    procedure SaveIni;
    function GetFontPos(c: string; var pressure: Byte): Byte;
    procedure SetModel(wModel: Word);
    procedure SaveMarked(ProName, strPrintValue: string);
  public
    m_mbus: TMbus;
    m_arFont: TCollection;//array of TFont; //array[2, 0..39] of Integer;

    function CheckVIN(var strVIN: string): string;
  end;
type
  TVinAddWeight = array[0..16] of Integer;
var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}
   //校验VIN第九位
function TMainFrm.CheckVIN(var strVIN: string): string;
var
  strCharNumb, strEqualValue: string;
  vinweight : TVinAddWeight;
  strTemp, strDigit: string;
  nTotal, nTemp: Integer;
  i: integer;
  c: string;
begin
   //填充m_vinweight, m_strCharNumb, m_strEqualValue值
   strCharNumb := '0123456789ABCDEFGHJKLMNPRSTUVWXYZ';
   strEqualValue:= '012345678912345678123457923456789';
   for i := 0 to 6 do
   begin
     vinweight[i] := 8 - i;
   end;
   vinweight[7] := 10;
   vinweight[8] := 0;
   for i := 9 to 16 do
   begin
     vinweight[i] := 18 - i;
   end;

   strTemp:= strVIN;
   strVIN := '';
   result := '';
   nTotal := 0;
   try
     if(length(strTemp) <> 17) then exit;
     for i := 0 to 16 do
     begin
        strDigit := strEqualValue[Pos(strTemp[i+1], strCharNumb)];
        if(strDigit = '') then exit;
        nTemp := vinweight[i] * StrToInt(strDigit);
        nTotal := nTotal + nTemp;
     end;
     nTotal := nTotal mod 11;
     if(nTotal = 10) then
        c := 'X'
     else
        c := IntToStr(nTotal);
     strVIN := LeftStr(strTemp, 8) + c + RightStr(strTemp, 8);
   except
      raise ERangeError.CreateFmt('生成VIN校验位时错,原VIN:%s',[strTemp]);
   end;
   result := strVIN;
end;


procedure TMainFrm.FormCreate(Sender: TObject);
begin
  Ini := CMarkIniFile.Init;
  LoadIni;
  Log := TLogger.create;
  log.LogShower := mmoPrintLog;//advmWorkLog;
  log.Enabled := True;
  menuGumian.Checked := (m_wModel = 1);
  menuWangmian.Checked := (m_wModel = 2);
  pgc1.ActivePage := ts1;
end;


procedure TMainFrm.LoadIni;
begin
  m_strJin := ini.GetProfileString('Machine', 'JPHBZ', '*');
  SetModel(ini.GetProfileInt('Machine', 'Model', 1));
  m_nModbusPort := ini.GetProfileInt('Machine', 'ModbusPort', 1);
  m_nSlaveId := ini.GetProfileInt('Machine', 'SlaveId', 1);
  m_dBuchangAngle := ini.GetProfileFloat('Machine', 'BuChang', 0.0);
  edtProPos.Text := ini.GetProfileString('settings', 'ProductMoveDistance', '500');
  edtZilunPos.Text := ini.GetProfileString('settings', 'zilunPosX', '30');
  edt1.Text := ini.GetProfileString('settings', 'ProductRoundPos', '30.1');
  edtFontSpace.Text := ini.GetProfileString('settings', 'ProductFontSpace', '1.2');
  edtProductDiameter.Text := ini.GetProfileString('settings', 'ProductDiameter', '420');
  edtValue.Text := ini.GetProfileString('settings', 'PrintValue', '2017-06-20 AGLKJAEP-Ⅲ');
end;
procedure TMainFrm.SaveIni;
begin
  ini.WriteProfileString('Machine', 'JPHBZ', m_strJin);
  ini.WriteProfileInt('Machine', 'Model', m_wModel);
  ini.WriteProfileFloat('Machine', 'BuChang', m_dBuchangAngle);
  ini.WriteProfileString('settings', 'ProductMoveDistance', edtProPos.Text);
  ini.WriteProfileString('settings', 'zilunPosX', edtZilunPos.Text);
  ini.WriteProfileString('settings', 'ProductRoundPos',edt1.Text);
  ini.WriteProfileString('settings', 'ProductFontSpace',edtFontSpace.Text);
  ini.WriteProfileString('settings', 'ProductDiameter', edtProductDiameter.Text);
  ini.WriteProfileString('settings', 'PrintValue', edtValue.Text);
end;
//从m_strFontPol中找到c字符处在此串中的位置并返回
function TMainFrm.GetFontPos(c: string; var pressure: byte): byte;
var
  strCon: string;
  strPath: string;
begin
  strPath := ExtractFilePath(Application.Exename) + 'data.mdb';
  strCon := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + strPath + ';Persist Security Info=False';
  qry1.ConnectionString := strCon;
  qry1.SQL.Clear;
  qry1.SQL.Add('select * from Fonts where Font = ''' + c + '''');
  qry1.Open;
  if(qry1.RecordCount > 0) then
  begin
    Result := qry1.FieldValues['Index'];
    pressure := qry1.FieldValues['Pressure'];
  end else begin
    Result := 0;
    pressure := 0;
  end;
  qry1.Close;
end;
procedure TMainFrm.FormDestroy(Sender: TObject);
begin
  SaveIni;
  m_mbus.Destroy;
  ini.Free;
  log.Destroy;
end;

procedure TMainFrm.actExitExecute(Sender: TObject);
begin
  application.Terminate;
end;

procedure TMainFrm.actManuExecute(Sender: TObject);
var
  oldModel: Integer;
begin
  frmManu.m_pMbus := @m_mbus;
  //手动测试模式
  oldModel := m_wModel;
  setModel(0);

  //弹出
  frmManu.ShowModal;

  setModel(oldModel);
end;

procedure TMainFrm.menuGumianClick(Sender: TObject);
begin
  menuGumian.Checked := True;
  menuWangmian.Checked := False;
  SetModel(1);
end;

procedure TMainFrm.menuWangmianClick(Sender: TObject);
begin
  menuGumian.Checked := False;
  menuWangmian.Checked := True;
  SetModel(2);
end;
procedure TMainFrm.SetModel(wModel: Word);
var
  param: TModParam;
begin
  m_wModel := wModel;
  if m_wModel = 1 then
    lblModel.Caption := '毂面模式'
  else if m_wModel = 2 then
    lblModel.Caption := '辋面模式'
  else
    lblModel.Caption := '测试模式';
  //FormActivate(nil);
  if m_mbus <> nil then begin
    m_mbus.CopyParam(param);
    param.m_wPlcMode := m_wModel;
    //log.WriteLog('设备工作模式更改为:%d', [m_wModel]);
    m_mbus.SetParam(param);
    //Sleep(1010);
  end;
end;

procedure TMainFrm.actStartExecute(Sender: TObject);
var
  param: TModParam;
  strPrintValue, c: string;
  nPrintLength, i, nPressure, nPos: Byte;
  aValue: array[0..50] of word;
  nLen: Word;
  sTemp, sTemp2, sArc: single;
begin
  //检测下位机状态，如果为空闲则继续，还有可能的状态是正在工作，报警等
  if(m_mbus.m_Param.m_wPlcCurState <> 0) then
  begin
    log.WriteLog('下位机状态为%d,不能继续压印!', [m_mbus.m_Param.m_wPlcCurState]);
    Exit;
  end;
  //发送打印内容
  strPrintValue := edtValue.Text;
  nPrintLength := Length(strPrintValue);
  if nPrintLength > 50 then nPrintLength := 50;
  nLen := 0;
  for i := 1 to nPrintLength do
  begin
    c := MidStr(strPrintValue, i, 1);
    if(Length(c)=1)then begin
      nPos := GetFontPos(c, nPressure);
      nLen := nLen + 1;
      aValue[nLen] := makeword(nPos, nPressure);
    end;
  end;
  aValue[0] := nLen;
  m_mbus.SendPrintValue(aValue);

  //发送参数
  m_mbus.CopyParam(param);
  param.m_wProductMoveDistance := word(StrToInt(edtProPos.Text));
  param.m_wZiLunPosX := word(StrToInt(edtZilunPos.text));
  param.m_wProductRoundPos := word(Trunc(StrToFloat(edt1.Text)*100));
  TryStrToFloat(edtFontSpace.Text, sTemp);
  TryStrToFloat(edtProductDiameter.Text, sTemp2);
  sArc := ArcSin(sTemp/sTemp2) * 2.0 * (180.0 / 3.14);     //转换成角度值
  param.m_wProductFontSpace := word(trunc(sArc * 100));
  m_mbus.SetParam(param);
  //发送启动命令
  m_mbus.Set_command1(CMD_START);

end;

procedure TMainFrm.actStopExecute(Sender: TObject);
begin
  //发送中止命令
  m_mbus.Set_command1(CMD_STOP);
end;

procedure TMainFrm.actSetExecute(Sender: TObject);
begin
  frmSet.m_pMbus := @m_mbus;
  frmset.m_strJin := m_strJin;
  frmset.ShowModal;
end;

procedure TMainFrm.actResetExecute(Sender: TObject);
begin
  //只发送一个复位指令，具体工作由下位机自动完成
  m_mbus.Set_command1(CMD_RESET);
end;

procedure TMainFrm.mbxp1ResultOk(ASender: TObject; Handle: Smallint);
begin
   m_mbus.ResultOk(ASender, Handle);
end;

procedure TMainFrm.mbxp1ResultError(ASender: TObject; Handle, Error: Smallint);
begin
   m_mbus.ResultError(ASender, Handle, Error);
end;


procedure TMainFrm.FormActivate(Sender: TObject);
begin
  //这个控件在OnCreate里面创建不行
  if m_mbus = nil then
    m_mbus := TMBus.Create(@mbxp1, Log, m_nSlaveId, m_nModbusPort);
end;
procedure TMainFrm.SaveMarked(ProName, strPrintValue: string);
var
  strDateTime: string;
  strCon, strSQL: string;
  strPath: string;
begin
  //保存打印内容到数据库的marked表，（ProName, MarkValue, MarkDateTime）
  strPath := ExtractFilePath(Application.Exename) + 'data.mdb';
  strCon := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + strPath + ';Persist Security Info=False';
  strDateTime := FormatDateTime('YYYY-mm-DD HH:MM:SS', Now);
  conSave.Connected := false;
  conSave.ConnectionString := strCon;
  conSave.Connected := true;
  strSQL := Format('insert into Marked (ProName, MarkValue, MarkDataTime) values(''%s'', ''%s'', ''%s'')', [ProName, strPrintValue, strDateTime]);
  conSave.Execute(strSQL);
  conSave.Connected := false;
end;

procedure TMainFrm.edtProPosChange(Sender: TObject);
var
  nTemp: Integer;
begin
  if (not TryStrToInt(TAdvEdit(Sender).Text, nTemp)) or ((nTemp > 2280) or (nTemp < 0)) then
  begin
    PostMessage(TAdvEdit(Sender).Handle, WM_UNDO, 0, 0);
  end;
end;

procedure TMainFrm.edtZilunPosChange(Sender: TObject);
var
  nTemp: Integer;
begin
  if (not TryStrToInt(TAdvEdit(Sender).Text, nTemp)) or ((nTemp > 320) or (nTemp < 0)) then
  begin
    PostMessage(TAdvEdit(Sender).Handle, WM_UNDO, 0, 0);
  end;
end;

procedure TMainFrm.edt1Change(Sender: TObject);
var
  sTemp: Single;
begin
  if (not TryStrToFloat(TAdvEdit(Sender).Text, sTemp)) or ((sTemp > 360.0) or (sTemp < 360.0)) then
  begin
    PostMessage(TAdvEdit(Sender).Handle, WM_UNDO, 0, 0);
  end;
end;

procedure TMainFrm.edtFontSpaceChange(Sender: TObject);
var
  sTemp: single;
begin
  if (not TryStrToFloat(TAdvEdit(Sender).Text, sTemp)) or ((sTemp > 50.0) or (sTemp < 0)) then
  begin
    PostMessage(TAdvEdit(Sender).Handle, WM_UNDO, 0, 0);
  end;
end;

procedure TMainFrm.edtProductDiameterChange(Sender: TObject);
var
  nTemp: Integer;
begin
  if (not TryStrToInt(TAdvEdit(Sender).Text, nTemp)) or ((nTemp > 1000) or (nTemp < 0)) then
  begin
    PostMessage(TAdvEdit(Sender).Handle, WM_UNDO, 0, 0);
  end;
end;

end.
