unit frmManufacture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ExtCtrls, mbus;

type
  TfrmManu = class(TForm)
    grp1: TGroupBox;
    grp2: TGroupBox;
    grp3: TGroupBox;
    shpXuanzhuanZhicheng: TShape;
    lbl1: TLabel;
    lbl2: TLabel;
    shpShangliao: TShape;
    lbl3: TLabel;
    btnZilunMoveLeft: TButton;
    btnZilunMoveright: TButton;
    edtZilunMove: TAdvEdit;
    shpZilunMove: TShape;
    lbl4: TLabel;
    lbl5: TLabel;
    btnZilunRoundLeft: TButton;
    btnZilunRoundright: TButton;
    lbl6: TLabel;
    shpZilunRound: TShape;
    lbl7: TLabel;
    btnProductMoveleft: TButton;
    edtProductMove: TAdvEdit;
    btnProductMoveright: TButton;
    lbl8: TLabel;
    shpProductMove: TShape;
    lbl9: TLabel;
    btnProductRoundleft: TButton;
    btnProductRoundright: TButton;
    lbl10: TLabel;
    shpProductRound: TShape;
    edtProductRound: TAdvEdit;
    btnLiaojiaUp: TButton;
    btnLiaojiaDown: TButton;
    shpLiaojiaUp: TShape;
    shpLiaojiaDown: TShape;
    shpProductUp: TShape;
    btnProductUp: TButton;
    btnProductDown: TButton;
    shpProductDown: TShape;
    shpProductJia: TShape;
    btnProductJia: TButton;
    btnProductSong: TButton;
    shpProductSong: TShape;
    shpZhichengkuai1: TShape;
    btnZhichengkuaiUp: TButton;
    btnZhichengkuaiDown: TButton;
    shpZhichengkuai14: TShape;
    shpZhichengkuai2: TShape;
    shpZhichengkuai3: TShape;
    shpZhichengkuai4: TShape;
    shpZhichengkuai11: TShape;
    shpZhichengkuai12: TShape;
    shpZhichengkuai13: TShape;
    shpZilunDown: TShape;
    btnZilunDown: TButton;
    btnZilunUp: TButton;
    shpZilunUp: TShape;
    shp14: TShape;
    lbl11: TLabel;
    shpXialiao: TShape;
    lbl12: TLabel;
    btnExit: TButton;
    lbl13: TLabel;
    lbl14: TLabel;
    tmr1: TTimer;
    btnZilunMoveReset: TButton;
    btnZilunRoundReset: TButton;
    btnProRoundReset: TButton;
    btnProMoveRight: TButton;
    edtYali: TAdvEdit;
    btnZilunHightUp: TButton;
    btnZilunHightDown: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btnZilunMoverightClick(Sender: TObject);
    procedure btnZilunMoveLeftClick(Sender: TObject);
    procedure btnZilunRoundLeftClick(Sender: TObject);
    procedure btnZilunRoundrightClick(Sender: TObject);
    procedure btnProductMoveleftClick(Sender: TObject);
    procedure btnProductMoverightClick(Sender: TObject);
    procedure btnProductRoundleftClick(Sender: TObject);
    procedure btnProductRoundrightClick(Sender: TObject);
    procedure btnLiaojiaUpClick(Sender: TObject);
    procedure btnLiaojiaDownClick(Sender: TObject);
    procedure btnProductUpClick(Sender: TObject);
    procedure btnProductDownClick(Sender: TObject);
    procedure btnProductJiaClick(Sender: TObject);
    procedure btnProductSongClick(Sender: TObject);
    procedure btnZhichengkuaiUpClick(Sender: TObject);
    procedure btnZhichengkuaiDownClick(Sender: TObject);
    procedure btnZilunDownClick(Sender: TObject);
    procedure btnZilunUpClick(Sender: TObject);
    procedure btnZilunMoveResetClick(Sender: TObject);
    procedure btnZilunRoundResetClick(Sender: TObject);
    procedure btnProRoundResetClick(Sender: TObject);
    procedure btnProMoveLeftClick(Sender: TObject);
    procedure btnProMoveRightClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnZilunHightDownClick(Sender: TObject);
    procedure btnZilunHightUpClick(Sender: TObject);
  private
    //m_param : TModParam;

    function SetParam: Boolean;
    function CheckValid: Boolean;
    function CheckMinMax(var Sender: TAdvEdit; min, max: single): boolean; overload;
    function CheckMinMax(var Sender: TAdvEdit; min, max: integer): boolean; overload;

  public
    m_pMbus: ^TMBus;

  end;

var
  frmManu: TfrmManu;

implementation

{$R *.dfm}
Function IIF( lExp:boolean; vExp1,vExp2 : variant) : variant; overload ;
begin
  if lExp
  then Result := vExp1
  else Result := vExp2 ;
end;

procedure TfrmManu.btnExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmManu.tmr1Timer(Sender: TObject);
begin
  if m_pMbus = nil then Exit;
  //VW4
  shpZilunMove.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_ZILUN_LEFT) > 0, clRed, clLime);   //字轮移动到原点
  shpZilunRound.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_ZILUN_ROUND) > 0, clRed, clLime);
  shpProductMove.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_PRODUCT_RIGHT) > 0, clRed, clLime);
  shpProductRound.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_PRODUCT_ROUND) >0, clRed, clLime);
  shpShangliao.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_POSITION1_FREE) > 0, clRed, clLime);   //上料位空
  shpXialiao.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_POSITION2_FREE) > 0, clRed, clLime);
  shpZilunDown.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_ZILUN_DOWN) > 0, clRed, clLime);
  shpZilunUp.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_ZILUN_UP) >0, clRed, clLime);
  shpLiaojiaUp.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_RACK_FORWARD) > 0, clRed, clLime);   //料架前移
  shpLiaojiaDown.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_RACK_BACK) > 0, clRed, clLime);
  shpProductUp.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_PRODUCT_UP) > 0, clRed, clLime);
  shpProductDown.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_PRODUCT_DOWN) >0, clRed, clLime);
  shpProductJia.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_PRODUCT_HOLD) > 0, clRed, clLime);   //工件夹紧
  shpProductSong.Brush.Color := IIF((m_pMbus.m_wFlag and FLG_PRODUCT_LOOSE) > 0, clRed, clLime);

  //VW6
  shpXuanzhuanZhicheng.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_PRODUCT) > 0, clRed, clLime);
  shpZhichengkuai1.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_HOLD1) > 0, clRed, clLime);
  shpZhichengkuai2.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_HOLD2) > 0, clRed, clLime);
  shpZhichengkuai3.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_HOLD3) > 0, clRed, clLime);
  shpZhichengkuai4.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_HOLD4) > 0, clRed, clLime);
  shpZhichengkuai11.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_LOOSE1) > 0, clRed, clLime);
  shpZhichengkuai12.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_LOOSE2) > 0, clRed, clLime);
  shpZhichengkuai13.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_LOOSE3) > 0, clRed, clLime);
  shpZhichengkuai14.Brush.Color := IIF((m_pMbus.m_wFlagSupport and FLG_SUPPORT_LOOSE4) > 0, clRed, clLime);
end;

procedure TfrmManu.btnZilunMoverightClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_RMOVE);
end;

procedure TfrmManu.btnZilunMoveLeftClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_LMOVE);
end;

procedure TfrmManu.btnZilunRoundLeftClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_LROUND);
end;

procedure TfrmManu.btnZilunRoundrightClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_RROUND);
end;

procedure TfrmManu.btnProductMoveleftClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_LMOVE);
end;

procedure TfrmManu.btnProductMoverightClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_RMOVE);
end;

procedure TfrmManu.btnProductRoundleftClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_LROUND);
end;
  

procedure TfrmManu.btnProductRoundrightClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_RROUND);
end;

procedure TfrmManu.btnLiaojiaUpClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_RACK_FORWARD);
end;

procedure TfrmManu.btnLiaojiaDownClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_RACK_BACK);
end;

procedure TfrmManu.btnProductUpClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_UP);
end;

procedure TfrmManu.btnProductDownClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_DOWN);
end;

procedure TfrmManu.btnProductJiaClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_HOLD);
end;

procedure TfrmManu.btnProductSongClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_LOOSE);
end;

procedure TfrmManu.btnZhichengkuaiUpClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_SUPPORT_LOOSE);
end;

procedure TfrmManu.btnZhichengkuaiDownClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_SUPPORT_HOLD);
end;

procedure TfrmManu.btnZilunDownClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_DOWN);
end;

procedure TfrmManu.btnZilunUpClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_UP);
end;

procedure TfrmManu.btnZilunMoveResetClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_MOVERESET);
end;

procedure TfrmManu.btnZilunRoundResetClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_command1(CMD_ZILUN_ROUNDRESET);
end;

procedure TfrmManu.btnProRoundResetClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_ROUNDRESET);
end;

procedure TfrmManu.btnProMoveLeftClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_LMOVERESET);
end;

procedure TfrmManu.btnProMoveRightClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_PRODUCT_RMOVERESET);
end;

procedure TfrmManu.FormShow(Sender: TObject);
var
  param: TModParam;
begin
  m_pMbus.CopyParam(param);
  edtZilunMove.Text := IntToStr(param.m_wZiLunLRMoveDistance_test);
  edtProductMove.Text := IntToStr(param.m_wProductMoveDistance_test);
  edtProductRound.Text := FloatToStr(param.m_wProductRoundDegree_test/100.0);
  edtYali.Text := IntToStr(param.m_wZiLunPressure);
end;
function TfrmManu.SetParam : Boolean;
var
  param: TModParam;
begin
  result := false;
  if not CheckValid then Exit;
  m_pMbus.CopyParam(param);
  param.m_wZiLunLRMoveDistance_test := word(StrToInt(edtZilunMove.Text));
  param.m_wProductMoveDistance_test := word(StrToInt(edtProductMove.Text));
  param.m_wProductRoundDegree_test := word(Trunc(StrToFloat(edtProductRound.Text)*100));
  param.m_wZiLunPressure := word(StrToInt(edtYali.Text));
  m_pMbus.SetParam(param);
  result := True;
end;

procedure TfrmManu.btnZilunHightDownClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_ZILUN_HIGHTDOWN);
end;

procedure TfrmManu.btnZilunHightUpClick(Sender: TObject);
begin
  SetParam;
  m_pMbus.Set_commandProduct(CMD_ZILUN_HIGHTUP);
end;

function TfrmManu.CheckMinMax(var Sender: TAdvEdit; min, max: integer): boolean;
var
nTemp: integer;
bRet : Boolean;
begin
   if TryStrToInt(sender.Text, nTemp) then
   begin
      if((nTemp < min) or (nTemp > max)) then
      begin
         bRet := false;
         sender.SetFocus;
      end else
         bRet := true;
   end
   else
   begin
      bRet := False;
      sender.SetFocus;
   end;
   Result := bRet;
end;
function TfrmManu.CheckMinMax(var Sender: TAdvEdit; min, max: single): boolean;
var
fTemp: single;
bRet: Boolean;
begin
   if TryStrToFloat(sender.Text, fTemp) then
   begin
     if((fTemp < min) or (fTemp > max)) then
     begin
        bRet := false;
        sender.SetFocus;
     end else
        bRet := true;
   end
   else
   begin
      bRet := False;
      sender.SetFocus;
   end;
   Result := bRet;
end;

function TfrmManu.CheckValid: Boolean;
label
msg;
begin
   result := false;
   if(not CheckMinMax(edtZilunMove, 1, 200)) then goto msg;
   if(not CheckMinMax(edtProductMove, 1, 999)) then goto msg;
   if(not CheckMinMax(edtProductRound, 1.0, 360.0)) then goto msg;
   if(not CheckMinMax(edtYali, 1, 40)) then goto msg;
   result := true;
   exit;
msg:
   showmessage('请输入正确的值!');
end;

end.
