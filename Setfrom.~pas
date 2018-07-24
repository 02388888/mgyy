unit Setfrom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ExtCtrls, InspectorBar, INIInspectorBar, StyleSetForm,
  FontSetForm, mbus, DB, ADODB;

type
  TfrmSet = class(TForm)
    edtJPHBZ: TAdvEdit;
    lbl9: TLabel;
    edtZilunMoveSpeed: TAdvEdit;
    lbl1: TLabel;
    edtFontCount: TAdvEdit;
    lbl2: TLabel;
    edtZilunRoundSpeed: TAdvEdit;
    lbl4: TLabel;
    edtProductMoveSpeed: TAdvEdit;
    lbl5: TLabel;
    edtProductRoundSpeed: TAdvEdit;
    lbl6: TLabel;
    edtZiLunAcce: TAdvEdit;
    lbl7: TLabel;
    edtZilunRoundAcce: TAdvEdit;
    lbl8: TLabel;
    edtProductMoveAcce: TAdvEdit;
    lbl10: TLabel;
    edtProductRoundAcce: TAdvEdit;
    lbl11: TLabel;
    btnExit: TButton;
    btnStyleSet: TButton;
    btnOk: TButton;
    btnFontSet: TButton;
    edtBuChangAngle: TAdvEdit;
    lbl3: TLabel;
    lbl12: TLabel;
    edtHightPressure: TAdvEdit;
    edtPressureTime: TAdvEdit;
    lbl13: TLabel;
    edtZiLunRoundFix: TAdvEdit;
    lbl14: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure btnStyleSetClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnFontSetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    m_param : TModParam;

    function CheckValid: Boolean;
    function CheckMinMax(var Sender: TAdvEdit; min, max: single): boolean; overload;
    function CheckMinMax(var Sender: TAdvEdit; min, max: integer): boolean; overload;
    procedure DXChange(var edt: TEdit; var nVar: Integer; bSave: Boolean); overload;
    procedure DXChange(var edt: TEdit; var fVar: Single; bSave: Boolean);overload;
    procedure DXChange(var chk: TCheckBox; var bVar, bSave: Boolean);overload;

  public
    m_pMbus: ^TMBus;
    m_strJin: string;    //字库字串， 静平衡标志符
    m_dBuchangAngle : Single;      //车轮角度补偿
  end;

var
  frmSet: TfrmSet;

implementation

{$R *.dfm}

procedure TfrmSet.btnExitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Self.Close;
end;

procedure TfrmSet.btnStyleSetClick(Sender: TObject);
begin
  frmstyleset.ShowModal;
end;

procedure TfrmSet.btnOkClick(Sender: TObject);
begin
  if( not CheckValid) then
  begin
    ModalResult := mrNone;
    exit;   //输入非法的值，要求重新输入
  end;
  //保存退出
  m_param.m_wZilunMoveSpeed := StrToInt(edtZilunMoveSpeed.Text);
  m_param.m_wZiLunAcce := StrToInt(edtZiLunAcce.Text);
  m_param.m_wZiLunRoundSpeed := StrToInt(edtZilunRoundSpeed.Text);
  m_param.m_wZiLunRoundAcce := StrToInt(edtZilunRoundAcce.Text);
  m_param.m_wProductMoveSpeed := StrToInt(edtProductMoveSpeed.Text);
  m_param.m_wProductAcce := StrToInt(edtProductMoveAcce.Text);
  m_param.m_wProductRoundSpeed := StrToInt(edtProductRoundSpeed.Text);
  m_param.m_wProductRoundAcce := StrToInt(edtProductRoundAcce.Text);
  m_param.m_wFontCount := StrToInt(edtFontCount.Text);
  m_param.m_wZiLunPressure := StrToInt(edtHightPressure.Text);
  m_param.m_wPressureTime := StrToInt(edtPressureTime.Text);
  m_param.m_wZilunRoundFix := word(Trunc(strtofloat(edtZiLunRoundFix.Text) * 100));
  m_pMbus.SetParam(m_param);
  m_strJin := edtJPHBZ.Text;
  m_dBuchangAngle := strtofloat(edtBuChangAngle.Text);
  close;

  ModalResult := mrOk;
end;

procedure TfrmSet.btnFontSetClick(Sender: TObject);
begin
   frmFontset.ShowModal;
end;

procedure TfrmSet.FormShow(Sender: TObject);
begin
  m_pMbus.CopyParam(m_param);
  edtZilunMoveSpeed.Text := IntToStr(m_param.m_wZilunMoveSpeed);
  edtZiLunAcce.Text := IntToStr(m_param.m_wZiLunAcce);
  edtZilunRoundSpeed.Text := IntToStr(m_param.m_wZiLunRoundSpeed);
  edtZilunRoundAcce.Text := IntToStr(m_param.m_wZiLunRoundAcce);
  edtProductMoveSpeed.Text := IntToStr(m_param.m_wProductMoveSpeed);
  edtProductMoveAcce.Text := IntToStr(m_param.m_wProductAcce);
  edtProductRoundSpeed.Text := IntToStr(m_param.m_wProductRoundSpeed);
  edtProductRoundAcce.Text := IntToStr(m_param.m_wProductRoundAcce);
  edtFontCount.Text := IntToStr(m_param.m_wFontCount);
  edtJPHBZ.Text := m_strJin;
  edtBuChangAngle.Text := FloatToStr(m_dBuchangAngle);
  edtHightPressure.Text := IntToStr(m_param.m_wZiLunPressure);
  edtPressureTime.Text := IntToStr(m_param.m_wPressureTime);
  edtZiLunRoundFix.Text := FloatToStr(m_param.m_wZilunRoundFix / 100.0)
end;











//******************************************************************************************************
//当bSave为True时，将edt中的值赋给nVar
//否则反之。
procedure TfrmSet.DXChange(var edt: TEdit; var nVar: Integer; bSave: Boolean);
begin
   if bSave then
      TryStrToInt(edt.Text, nVar)
   else
      edt.Text := IntToStr(nVar);
end;
procedure TfrmSet.DXChange(var edt: TEdit; var fVar: Single; bSave: Boolean);
begin
   if bSave then
      TryStrToFloat(edt.Text, fVar)
   else
      edt.Text := FloatToStr(fVar);
end;
procedure TfrmSet.DXChange(var chk: TCheckBox; var bVar, bSave: Boolean);
begin
   if bSave then
      bVar := chk.Checked
   else
      chk.Checked := bVar;
end;

function TfrmSet.CheckMinMax(var Sender: TAdvEdit; min, max: integer): boolean;
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
function TfrmSet.CheckMinMax(var Sender: TAdvEdit; min, max: single): boolean;
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

function TfrmSet.CheckValid: Boolean;
label
msg;
begin
   result := false;
   if(not CheckMinMax(edtZilunMoveSpeed, 1, 200)) then goto msg;
   if(not CheckMinMax(edtZiLunAcce, 1, 100)) then goto msg;
   if(not CheckMinMax(edtZilunRoundSpeed, 1, 230)) then goto msg;
   if(not CheckMinMax(edtZilunRoundAcce, 1, 100)) then goto msg;
   if(not CheckMinMax(edtProductMoveSpeed, 1, 200)) then goto msg;
   if(not CheckMinMax(edtProductMoveAcce, 1, 100)) then goto msg;
   if not CheckMinMax(edtProductRoundSpeed, 1, 20) then goto msg;
   if not CheckMinMax(edtProductRoundAcce, 1, 100) then goto msg;
   if not CheckMinMax(edtHightPressure, 0, 40) then goto msg;
   if not CheckMinMax(edtFontCount, 20, 50) then goto msg;
   if not CheckMinMax(edtPressureTime, 0, 1000) then goto msg;
   if not CheckMinMax(edtzilunroundfix, 0.0, 10.0) then goto msg;
   result := true;
   exit;
msg:
   showmessage('请输入正确的值!');
end;


end.
