unit mbus;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Forms,MBAXPLib_TLB, Logger;
type
   TModParam = record
    m_wPlcErrCode: Word;
    m_wPlcCurState: Word;  //工作1，空闲0，中止2等
    m_wPlcMode: Word;  //0为测试1为毂面2为辋面
    m_wFontCount: Word;  //字轮字库数量

    m_wZiLunMoveSpeed, m_wZiLunAcce, m_wZiLunRoundSpeed, m_wZiLunRoundAcce: Word;
    m_wZiLunLRMoveDistance_test: Word;
    m_wZiLunPosX: Word;  //字轮作业开始X位置
    m_wZiLunPressure: Word;  //字轮设置100%压力
    m_wProductMoveSpeed, m_wProductAcce, m_wProductRoundSpeed, m_wProductRoundAcce: Word;
    m_wProductMoveDistance_test: Word;  //工件测试时左右一次性移动的距离
    m_wProductRoundPos: Word;  //工件作业前旋转的角度
    m_wProductMoveDistance: Word;  //工件作业前从上料位移到打印位的距离
    m_wProductRoundDegree_test: Word;  //工件测试时旋转一次的角度
    m_wProductFontSpace: Word;  //工件上的字符间隔
    m_wPressureTime: Word; //增压保持时间
    m_wZilunRoundFix: Word;   //字轮旋转原点修正值
end ;
type
  TMBus = class(TObject)
  private
    m_pMBus: ^TMbaxp;
    m_pLog: ^TLogger;
    m_nSlaveID: integer;  //PLC从机号
    m_port : integer;  //485口的计算机端串口端口号

    
    procedure WriteCommand;
  public
    m_wCommand1, m_wCmdProduct: Word;
    m_wFlag, m_wFlagSupport: Word;

    m_Param: TModParam;

        m_wTemp: Word;  //这个用来检查模式怎么被变更了，后期需要删除

    procedure ResultOk(ASender: TObject; Handle: Smallint);
    procedure ResultError(ASender: TObject; Handle, Error: Smallint);
    constructor Create(pMbus: Pointer ; var Log: TLogger; nSlaveID, nPort: Integer);
    destructor Destroy; override;

    procedure Set_command1(wCmd: Word);
    procedure Rst_command1(wCmd:word);
    procedure Set_commandProduct(wCmd: Word);
    procedure Rst_commandProduct(wCmd:word);
    procedure SetParam(param: TModParam);  //发送参数
    procedure CopyParam(var pDest: TModParam);
    procedure LetParam(param: TModParam);
    procedure SendPrintValue(aValue: array of word);
  end;

const
  CMD_START             :Word = $100;
  CMD_STOP              :Word = $200;
  CMD_RESET             :Word = $400;
  CMD_RACK_FORWARD      :Word = $800;
  CMD_RACK_BACK         :Word = $1000;
  CMD_SUPPORT_HOLD      :Word = $2000;
  CMD_SUPPORT_LOOSE     :Word = $4000;
  CMD_ZILUN_DOWN        :Word = $8000;
  CMD_ZILUN_UP          :Word = $1;
  CMD_ZILUN_MOVERESET   :Word = $2;
  CMD_ZILUN_ROUNDRESET  :Word = $4;
  CMD_ZILUN_LMOVE       :Word = $8;
  CMD_ZILUN_RMOVE       :Word = $10;
  CMD_ZILUN_LROUND      :Word = $20;
  CMD_ZILUN_RROUND      :Word = $40;

  CMD_PRODUCT_LMOVE     :Word = $100;
  CMD_PRODUCT_RMOVE     :Word = $200;
  CMD_PRODUCT_LROUND    :Word = $400;
  CMD_PRODUCT_RROUND    :Word = $800;
  CMD_PRODUCT_UP        :Word = $1000;
  CMD_PRODUCT_DOWN      :Word = $2000;
  CMD_PRODUCT_HOLD      :Word = $4000;
  CMD_PRODUCT_LOOSE     :Word = $8000;
  CMD_PRODUCT_LMOVERESET:Word = $1;
  CMD_PRODUCT_RMOVERESET:Word = $2;
  CMD_PRODUCT_ROUNDRESET:Word = $4;
  CMD_ZILUN_HIGHTDOWN   :Word = $8;
  CMD_ZILUN_HIGHTUP     :Word = $10;

  FLG_ZILUN_LEFT      :Word = $100;
  FLG_ZILUN_ROUND     :Word = $200;
  FLG_ZILUN_DOWN      :Word = $400;
  FLG_ZILUN_UP        :Word = $800;
  FLG_RACK_FORWARD    :Word = $1000;
  FLG_RACK_BACK       :Word = $2000;
  FLG_PRODUCT_UP      :Word = $4000;
  FLG_PRODUCT_DOWN    :Word = $8000;
  FLG_PRODUCT_RIGHT   :Word = $1;
  FLG_PRODUCT_ROUND   :Word = $2;
  FLG_PRODUCT_HOLD    :Word = $4;
  FLG_PRODUCT_LOOSE   :Word = $8;
  FLG_POSITION1_FREE  :Word = $10;
  FLG_POSITION2_FREE  :Word = $20;

  FLG_SUPPORT_HOLD1   :Word = $100;
  FLG_SUPPORT_HOLD2   :Word = $200;
  FLG_SUPPORT_HOLD3   :Word = $400;
  FLG_SUPPORT_HOLD4   :Word = $800;
  FLG_SUPPORT_LOOSE1  :Word = $1000;
  FLG_SUPPORT_LOOSE2  :Word = $2000;
  FLG_SUPPORT_LOOSE3  :Word = $4000;
  FLG_SUPPORT_LOOSE4  :Word = $8000;
  FLG_SUPPORT_PRODUCT :Word = $1;

  //读写MODBUS控件时作HANDLE用
  HANDLE_GETCMD       = 1;
  HANDLE_GETFLAG      = 2;
  HANDLE_WRITECMD     = 3;
  HANDLE_GETPARAM     = 4;
  HANDLE_WRITEPARAM   = 5;
  HANDLE_WRITEFONT    = 6;   //写字库及其压力

implementation

  //g_bWriteState: Boolean;  //此值在程序向下写时保证不能读下位机内容，互斥




constructor TMBus.Create(pMbus: Pointer; var Log: TLogger; nSlaveID, nPort: Integer );
begin
  m_pMBus := pMbus;
  m_pLog := @Log;
  m_wCommand1 := 0;
  m_wCmdProduct := 0;
  m_wFlag := 0;
  m_wFlagSupport := 0;

  m_nSlaveID := nSlaveID;
  m_port := nPort;

  m_pMBus.Connection := m_port;
  m_pMBus.BaudRate := 5;  //9600
  m_pMBus.DataBits := 1;  //8 data bits
  m_pMBus.Parity := 0;    //None parity
  m_pMBus.StopBits := 0;  //1 Stop bits
  m_pMBus.ProtocolMode := 0;  //RTU Mode
  m_pMBus.Timeout := 1000;
  if m_pMBus.OpenConnection = False then
    Application.MessageBox('端口未打开，请检查与控制器连接线缆！', '提示', MB_OK + MB_ICONQUESTION + MB_TOPMOST)
  else
  begin
    m_pMBus.ReadHoldingRegisters(HANDLE_GETFLAG, m_nSlaveID, 2, 2, 500);
    m_pMBus.ReadHoldingRegisters(HANDLE_GETPARAM, m_nSlaveID, 5, 23, 500);
    m_pMBus.ReadHoldingRegisters(HANDLE_GETCMD, m_nSlaveID, 0, 2, 500);
    m_pMBus.UpdateEnable(HANDLE_GETFLAG);
    m_pMBus.UpdateEnable(HANDLE_GETCMD);
    m_pMBus.UpdateEnable(HANDLE_GETPARAM);
  end;
end;

destructor TMBus.Destroy;
begin
  m_pMBus.CloseConnection;
end;

procedure TMBus.SetParam(param: TModParam);
begin
  LetParam(param);
  m_pMBus.PresetMultipleRegisters(HANDLE_WRITEPARAM, m_nSlaveID, 7, 21, 100);
  m_pMBus.Register[HANDLE_WRITEPARAM, 0]   := param.m_wPlcMode;
  if (param.m_wPlcMode <> m_wTemp) then begin
    m_wTemp := param.m_wPlcMode;
    m_pLog.WriteLog('写入模式为:%d',[param.m_wPlcMode]);
  end;
  m_pMBus.Register[HANDLE_WRITEPARAM, 1]   := param.m_wFontCount;
  m_pMBus.Register[HANDLE_WRITEPARAM, 2]   := 0;
  m_pMBus.Register[HANDLE_WRITEPARAM, 3]   := param.m_wZiLunMoveSpeed;
  m_pMBus.Register[HANDLE_WRITEPARAM, 4]   := param.m_wZiLunAcce;
  m_pMBus.Register[HANDLE_WRITEPARAM, 5]   := param.m_wZiLunRoundSpeed;
  m_pMBus.Register[HANDLE_WRITEPARAM, 6]   := param.m_wZiLunRoundAcce;
  m_pMBus.Register[HANDLE_WRITEPARAM, 7]   := param.m_wZiLunLRMoveDistance_test;
  m_pMBus.Register[HANDLE_WRITEPARAM, 8]   := param.m_wZiLunPosX;
  m_pMBus.Register[HANDLE_WRITEPARAM, 9]   := param.m_wZiLunPressure;
  m_pMBus.Register[HANDLE_WRITEPARAM, 10]  := param.m_wProductMoveSpeed;
  m_pMBus.Register[HANDLE_WRITEPARAM, 11]  := param.m_wProductAcce;
  m_pMBus.Register[HANDLE_WRITEPARAM, 12]  := param.m_wProductRoundSpeed;
  m_pMBus.Register[HANDLE_WRITEPARAM, 13]  := param.m_wProductRoundAcce;
  m_pMBus.Register[HANDLE_WRITEPARAM, 14]  := param.m_wProductMoveDistance_test;
  m_pMBus.Register[HANDLE_WRITEPARAM, 15]  := param.m_wProductRoundPos;
  m_pMBus.Register[HANDLE_WRITEPARAM, 16]  := param.m_wProductMoveDistance;
  m_pMBus.Register[HANDLE_WRITEPARAM, 17]  := param.m_wProductRoundDegree_test;
  m_pMBus.Register[HANDLE_WRITEPARAM, 18]  := param.m_wProductFontSpace;
  m_pMBus.Register[HANDLE_WRITEPARAM, 19]  := param.m_wPressureTime;
  m_pMBus.Register[HANDLE_WRITEPARAM, 20]  := param.m_wZilunRoundFix;
  m_pMBus.UpdateOnce(HANDLE_WRITEPARAM);
end;
procedure TMBus.LetParam(param: TModParam);
begin
  m_Param.m_wPlcErrCode := param.m_wPlcErrCode;
  m_Param.m_wPlcCurState := param.m_wPlcCurState;
  m_Param.m_wPlcMode := param.m_wPlcMode;

  m_Param.m_wFontCount := param.m_wFontCount;
  m_Param.m_wZiLunMoveSpeed := param.m_wZiLunMoveSpeed;
  m_Param.m_wZiLunAcce := param.m_wZiLunAcce;
  m_Param.m_wZiLunRoundSpeed := param.m_wZiLunRoundSpeed;
  m_Param.m_wZiLunRoundAcce := param.m_wZiLunRoundAcce;
  m_Param.m_wZiLunLRMoveDistance_test := param.m_wZiLunLRMoveDistance_test;
  m_Param.m_wZiLunPosX := param.m_wZiLunPosX;
  m_Param.m_wZiLunPressure := param.m_wZiLunPressure;
  m_Param.m_wProductMoveSpeed := param.m_wProductMoveSpeed;
  m_Param.m_wProductAcce := param.m_wProductAcce;
  m_Param.m_wProductRoundSpeed := param.m_wProductRoundSpeed;
  m_Param.m_wProductRoundAcce := param.m_wProductRoundAcce;
  m_Param.m_wProductMoveDistance_test := param.m_wProductMoveDistance_test;
  m_Param.m_wProductRoundPos := param.m_wProductRoundPos;
  m_Param.m_wProductMoveDistance := param.m_wProductMoveDistance;
  m_Param.m_wProductRoundDegree_test := param.m_wProductRoundDegree_test;
  m_Param.m_wProductFontSpace := param.m_wProductFontSpace;
  m_Param.m_wPressureTime := param.m_wPressureTime;
  m_Param.m_wZilunRoundFix := param.m_wZilunRoundFix;
end;
procedure TMBus.CopyParam(var pDest: TModParam);
begin
  pDest.m_wPlcErrCode := m_Param.m_wPlcErrCode;
  pDest.m_wPlcCurState := m_Param.m_wPlcCurState;
  pDest.m_wPlcMode := m_Param.m_wPlcMode;

  pDest.m_wFontCount := m_Param.m_wFontCount;
  pDest.m_wZiLunMoveSpeed := m_Param.m_wZiLunMoveSpeed;
  pDest.m_wZiLunAcce := m_Param.m_wZiLunAcce;
  pDest.m_wZiLunRoundSpeed := m_Param.m_wZiLunRoundSpeed;
  pDest.m_wZiLunRoundAcce := m_Param.m_wZiLunRoundAcce;
  pDest.m_wZiLunLRMoveDistance_test := m_Param.m_wZiLunLRMoveDistance_test;
  pDest.m_wZiLunPosX := m_Param.m_wZiLunPosX;
  pDest.m_wZiLunPressure := m_Param.m_wZiLunPressure;
  pDest.m_wProductMoveSpeed := m_Param.m_wProductMoveSpeed;
  pDest.m_wProductAcce := m_Param.m_wProductAcce;
  pDest.m_wProductRoundSpeed := m_Param.m_wProductRoundSpeed;
  pDest.m_wProductRoundAcce := m_Param.m_wProductRoundAcce;
  pDest.m_wProductMoveDistance_test := m_Param.m_wProductMoveDistance_test;
  pDest.m_wProductRoundPos := m_Param.m_wProductRoundPos;
  pDest.m_wProductMoveDistance := m_Param.m_wProductMoveDistance;
  pDest.m_wProductRoundDegree_test := m_Param.m_wProductRoundDegree_test;
  pDest.m_wProductFontSpace := m_Param.m_wProductFontSpace;
  pDest.m_wPressureTime := m_Param.m_wPressureTime;
  pDest.m_wZilunRoundFix := m_Param.m_wZilunRoundFix;
end;
procedure TMBus.WriteCommand;
begin
  m_pMBus.PresetMultipleRegisters(HANDLE_WRITECMD, m_nSlaveID, 0, 2, 100);
  m_pMBus.Register[HANDLE_WRITECMD, 0] := m_wCommand1;
  m_pMBus.Register[HANDLE_WRITECMD, 1] := m_wCmdProduct;
  m_pMBus.UpdateOnce(HANDLE_WRITECMD);
end;
procedure TMBus.Set_command1(wCmd: Word);
begin
  m_wCommand1 := (m_wCommand1 or wCmd);
  WriteCommand;
end;
procedure TMBus.Rst_command1(wCmd:word);
begin
  m_wCommand1 := (m_wCommand1 and (not wCmd));
  WriteCommand;
end;
procedure TMBus.Set_commandProduct(wCmd: Word);
begin
  m_wCmdProduct := (m_wCmdProduct or wCmd);
  WriteCommand;
end;
procedure TMBus.Rst_commandProduct(wCmd:word);
begin
  m_wCmdProduct := (m_wCmdProduct and (not wCmd));
  WriteCommand;
end;
procedure TMBus.ResultOk(ASender: TObject; Handle: Smallint);
begin
  case Handle of
    HANDLE_GETCMD:
      begin
      m_wCommand1                 := m_pMBus.Register[Handle, 0];
      m_wCmdProduct               := m_pMBus.Register[Handle, 1];
      end;
    HANDLE_GETFLAG:
      begin
      m_wFlag                     := m_pMBus.Register[Handle, 0];
      m_wFlagSupport              := m_pMBus.Register[Handle, 1];
      end;
    HANDLE_GETPARAM:
    begin
      m_Param.m_wPlcErrCode               := m_pMBus.Register[Handle, 0];
      m_Param.m_wPlcCurState              := m_pMBus.Register[Handle, 1];
      m_Param.m_wPlcMode                  := m_pMBus.Register[Handle, 2];
      if m_Param.m_wPlcMode <> m_wTemp then begin
        m_wTemp := m_Param.m_wPlcMode;
        m_pLog.WriteLog('模式读出时变为:%d',[m_Param.m_wPlcMode]);
      end;
      m_Param.m_wFontCount                := m_pMBus.Register[Handle, 3];
      m_Param.m_wZiLunMoveSpeed           := m_pMBus.Register[Handle, 5];
      m_Param.m_wZiLunAcce                := m_pMBus.Register[Handle, 6];
      m_Param.m_wZiLunRoundSpeed          := m_pMBus.Register[Handle, 7];
      m_Param.m_wZiLunRoundAcce           := m_pMBus.Register[Handle, 8];
      m_Param.m_wZiLunLRMoveDistance_test := m_pMBus.Register[Handle, 9];
      m_Param.m_wZiLunPosX                := m_pMBus.Register[Handle, 10];
      m_Param.m_wZiLunPressure            := m_pMBus.Register[Handle, 11];
      m_Param.m_wProductMoveSpeed         := m_pMBus.Register[Handle, 12];
      m_Param.m_wProductAcce              := m_pMBus.Register[Handle, 13];
      m_Param.m_wProductRoundSpeed        := m_pMBus.Register[Handle, 14];
      m_Param.m_wProductRoundAcce         := m_pMBus.Register[Handle, 15];
      m_Param.m_wProductMoveDistance_test := m_pMBus.Register[Handle, 16];
      m_Param.m_wProductRoundPos          := m_pMBus.Register[Handle, 17];
      m_Param.m_wProductMoveDistance      := m_pMBus.Register[Handle, 18];
      m_Param.m_wProductRoundDegree_test  := m_pMBus.Register[Handle, 19];
      m_Param.m_wProductFontSpace         := m_pmbus.Register[Handle, 20];
      m_Param.m_wPressureTime             := m_pmbus.Register[Handle, 21];
      m_Param.m_wZilunRoundFix            := m_pmbus.Register[Handle, 22];
    end;
  end;
end;
procedure TMBus.ResultError(ASender: TObject; Handle, Error: Smallint);
var
  str: string;
begin
  str := Format('下位机返回%d与信息错误，错误号:%d', [Handle, Error]);
  m_pLog.WriteLog(str);
end;
procedure TMbus.SendPrintValue(aValue: array of word);
var
  i: Integer;
  wLength : word;
begin
  wLength := aValue[0]+1;
  m_pMBus.PresetMultipleRegisters(HANDLE_WRITEFONT, m_nSlaveID, 49, wLength, 100);
  for i := 0 to wLength do
  begin
    m_pMBus.Register[HANDLE_WRITEFONT, i] := avalue[i];
  end;
  m_pMBus.UpdateOnce(HANDLE_WRITEFONT);
end;

end.
