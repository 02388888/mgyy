unit checknet;
{*******************************************************}
{                                                       }
{       检查是否与五菱MIS服务器连通                     }
{                                                       }
{       版权所有 (C) 2009 重庆华普公司                  }
{                                                       }
{  作者：贺兴伟                                         }
{  QQ: 45668152   Email: 02388888@163.com               }
{  时间: 2009-1-7                                       }
{*******************************************************}
interface
uses
  ActiveX, Windows, Classes, StdCtrls, SysUtils, StrUtils, ADODB, Forms, Variants,
  Messages, winsock, ComCtrls, Dialogs;
type
  TCheckNet = class(TThread)
  public
      constructor Create(CreateSuspended: Boolean;
            strConServer,strIP: string; PingTimeout, PingInterval: integer); overload;
      destructor Free;
  private
      m_bNetRet: Boolean;
      m_strConServer, m_strIP: string;
      m_PingTimeout, m_PingInterval: Integer;
      function GetNet: Boolean;
  protected
      procedure Execute; override;
  published
      property Connected: Boolean read GetNet;
  end;
//***************************TPing***************************************************************
TPing = class(TObject)
   public
      function Ping(strServer: string): BOOL;
      constructor Init;
      destructor Free;
   protected

   private
      function GetIpByName(str: string): string;
   published
   end;
   //ping专用定义
  PIPOptionInformation = ^TIPOptionInformation;
  TIPOptionInformation = packed record
     TTL:         Byte;      // Time To Live (used for traceroute)
     TOS:         Byte;      // Type Of Service (usually 0)
     Flags:       Byte;      // IP header flags (usually 0)
     OptionsSize: Byte;      // Size of options data (usually 0, max 40)
     OptionsData: PChar;     // Options data buffer
  end;
  PIcmpEchoReply = ^TIcmpEchoReply;
  TIcmpEchoReply = packed record
     Address:       DWord;                // replying address
     Status:        DWord;                // IP status value (see below)
     RTT:           DWord;                // Round Trip Time in milliseconds
     DataSize:      Word;                 // reply data size
     Reserved:      Word;
     Data:          Pointer;              // pointer to reply data buffer
     Options:       TIPOptionInformation; // reply options
  end;
  TIcmpCreateFile = function: THandle; stdcall;
  TIcmpCloseHandle = function(IcmpHandle: THandle): Boolean; stdcall;
  TIcmpSendEcho = function(
     IcmpHandle:          THandle;
     DestinationAddress:  DWord;
     RequestData:         Pointer;
     RequestSize:         Word;
     RequestOptions:      PIPOptionInformation;
     ReplyBuffer:         Pointer;
     ReplySize:           DWord;
     Timeout:             DWord
  ): DWord; stdcall;

//**********************************************************************************************
implementation
{ TMyThread }
var
  hICMPlib: HModule;
  IcmpCreateFile : TIcmpCreateFile;
  IcmpCloseHandle: TIcmpCloseHandle;
  IcmpSendEcho:    TIcmpSendEcho;
  hICMP: THandle;
  ping_state:integer;  // 纪录当前PING的状态。如果为1，就是正在PING


function TCheckNet.GetNet: Boolean;
begin
   result := m_bNetRet;
end;

procedure TCheckNet.Execute;
var
   conServer: TADOConnection;
   ping: TPing;
   bDB: Boolean;
begin
   CoInitialize(nil);
   try
      bDB := (Length(m_strConServer) > 0);
      if bDB then begin
        conServer := TADOConnection.Create(Application);
        conServer.Connected := False;
        conServer.ConnectionString := m_strConServer;
        conServer.Provider := 'SQLOLEDB.1';
        conServer.LoginPrompt := False;
        conServer.Connectiontimeout := m_PingTimeout;
        conserver.LoginPrompt := False;
        conServer.CommandTimeout := 1;
      end;
      ping := TPing.Init;
      while not Terminated do
      begin
         try
            if ping.Ping(m_strIP) = TRUE then
            begin
               if bDB then begin
                  conServer.Connected := True;
                  conServer.Connected := False;
               end;
               m_bNetRet := True;
            end else
               m_bNetRet := False;
         except
            m_bNetRet := False;
         end;
         //每次循环间隔一定时间
         Sleep(m_PingInterval);
      end;
      ping.Free;
      if bDB then begin
         conServer.Connected := False;
         conServer.Free;
      end;
   except
      on e: Exception do begin
         Application.MessageBox(PChar(e.Message), '提示', MB_OK +
             MB_ICONSTOP + MB_TOPMOST);
      end;
   end;
   counInitialize;
end;

destructor TCheckNet.Free;
begin
   inherited Free;
end;

constructor TCheckNet.Create(CreateSuspended: Boolean;
            strConServer,strIP: string; PingTimeout, PingInterval: integer);
begin
  inherited Create(CreateSuspended);
  Priority := tpIdle;
  m_strConServer := strConServer;
  m_strIP := strIP;
  m_bNetRet := False;
  m_PingTimeout := PingTimeout;
  m_PingInterval := PingInterval;
end;



//***************************TPing***************************************************************
constructor TPing.Init;
var
  wsadata: TWSAData;
begin
  if WSAStartup($101,wsadata) <> 0 then begin
    ShowMessage('初始化winsock错误');
    halt;
  end;
  hICMPlib := loadlibrary('icmp.dll');
    @ICMPCreateFile := GetProcAddress(hICMPlib, 'IcmpCreateFile');
    @IcmpCloseHandle:= GetProcAddress(hICMPlib, 'IcmpCloseHandle');
    @IcmpSendEcho:= GetProcAddress(hICMPlib, 'IcmpSendEcho');
    if (@ICMPCreateFile = Nil) or (@IcmpCloseHandle = Nil) or (@IcmpSendEcho = Nil) then begin
      ShowMessage('打开icmp.dll错误');
      halt;
    end;
    hICMP := IcmpCreateFile;
    if hICMP = INVALID_HANDLE_VALUE then begin
      ShowMessage('不能打开PING');
      halt;
    end;
end;

destructor TPing.Free;
begin
  IcmpCloseHandle(hICMP);
  FreeLibrary(hICMPlib);
  if WSACleanup <> 0 then ShowMessage('释放winsock出错');
end;


function TPing.Ping(strServer: string): BOOL;
var
  BufferSize, nPkts: Integer;
  pReqData, pData: Pointer;
  pIPE: PIcmpEchoReply;               // ICMP Echo reply buffer
  IPOpt: TIPOptionInformation;        // IP Options for packet to send
  Size: integer;
  Address: DWORD;
  hp: PHOSTENT;
begin
   strServer := GetIpByName(strServer);
   hp := GetHostByName(PChar(strServer));
   if(hp = nil) then begin
      Result := False;
      Exit;
   end;
   Address := inet_addr(pChar(strServer));
   Size := 2;  //发两个字节来ping
   ping_state := 1;
   BufferSize := SizeOf(TICMPEchoReply) + Size;
   GetMem(pReqData, Size);
   GetMem(pData, Size);
   GetMem(pIPE, BufferSize);
   FillChar(pReqData^, Size, $AA);  pIPE^.Data := pData;
   // Finally Send the packet
   FillChar(IPOpt, SizeOf(IPOpt), 0);
   IPOpt.TTL := 64;
   NPkts := IcmpSendEcho(hICMP, Address, pReqData, Size,
                         @IPOpt, pIPE, BufferSize, 1000);
   ping_state := 0;
   if NPkts = 0 then
      result := FALSE
   else
      result := TRUE;

   FreeMem(pIPE); FreeMem(pData); FreeMem(pReqData);
end;

{这个函数要正确执行，需要在uses里加入winsock}
function TPing.GetIpByName(str: string): string;
var
   WSAData: TWSAData;
   HostEnt: PHostEnt;
begin
   WSAStartup(2, WSAData);
   HostEnt := gethostbyname(PChar(str));
   if HostEnt <> nil then
   begin
      with HostEnt^ do
         result := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
   end;
   WSACleanup;
end;

end.

