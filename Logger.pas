unit Logger;
// =======================================================================
// ��־�ࣨTLogger�� ver.1.0
// ����� http://blog.sina.com.cn/hblyuhong
// 2014/06/24
// ����1.0�޸�
// PFeng  (http://www.pfeng.org / xxmc01#gmail.com)
// 2012/11/08
// ��־����Լ����
// 0 - Information
// 1 - Notice
// 2 - Warning
// 3 - Error
// =======================================================================

interface

uses Windows, Classes, SysUtils, StdCtrls, ComCtrls, ComObj, Messages,AdvMemo;

const
  WRITE_LOG_DIR = 'log\'; // ��¼��־Ĭ��Ŀ¼
  WRITE_LOG_MIN_LEVEL = 0; // ��¼��־����ͼ���С�ڴ˼���ֻ��ʾ����¼
  WRITE_LOG_ADD_TIME = True; // ��¼��־�Ƿ�����ʱ��
  WRITE_LOG_TIME_FORMAT = 'hh:nn:ss.zzz'; // ��¼��־����ʱ��ĸ�ʽ
  SHOW_LOG_ADD_TIME = True; // ��־��ʾ�����Ƿ�����ʱ��
  SHOW_LOG_TIME_FORMAT = 'yyyy/mm/dd hh:nn:ss.zzz'; // ��־��ʾ����ʱ��ĸ�ʽ
  SHOW_LOG_CLEAR_COUNT = 1000; // ��־��ʾ���������ʾ����

type
  TLogger = class
  private
    FCSLock: TRTLCriticalSection; // �ٽ���
    FFileStream: TFileStream; // �ļ���
    FLogShower: TComponent; // ��־��ʾ����
    FLogName: String; // ��־����
    FEnabled: Boolean;
    FLogFileDir: string; // ��־Ŀ¼
    procedure SetEnabled(const Value: Boolean);
    procedure SetLogFileDir(const Value: string);
    procedure SetLogShower(const Value: TComponent);
  protected
    procedure ShowLog(Logstr: String; const LogLevel: Integer = 0);
  public
    procedure WriteLog(Logstr: String; const LogLevel: Integer = 0); overload;
    procedure WriteLog(Logstr: String; const Args: array of const; const LogLevel: Integer = 0); overload;

    constructor Create;
    destructor Destroy; override;

    // �Ƿ�������¼��־
    property Enabled: Boolean read FEnabled write SetEnabled;
    // ��־�ļ�Ŀ¼,Ĭ�ϵ�ǰĿ¼��LogĿ¼
    property LogFileDir: string read FLogFileDir write SetLogFileDir;
    // ��ʾ��־�����
    property LogShower: TComponent read FLogShower write SetLogShower;

  end;

implementation

constructor TLogger.Create;
begin
  InitializeCriticalSection(FCSLock);
  FLogShower := nil;
  LogFileDir := ExtractFilePath(ParamStr(0)) + WRITE_LOG_DIR;
end;

procedure TLogger.WriteLog(Logstr: String; const Args: array of const; const LogLevel: Integer = 0);
begin
  WriteLog(Format(Logstr, Args), LogLevel);
end;

procedure TLogger.WriteLog(Logstr: String; const LogLevel: Integer = 0);
var
  logName: String;
  fMode: Word;
begin
  EnterCriticalSection(FCSLock);
  try
    if not Enabled then
      Exit;

    ShowLog(Logstr, LogLevel); // ��ʾ��־������
    if LogLevel >= WRITE_LOG_MIN_LEVEL then
    begin
      logName := FormatDateTime('yyyymmdd', Now) + '.log';
      if FLogName <> logName then
      begin
        FLogName := logName;
        if FileExists(FLogFileDir + FLogName) then // ����������־�ļ�����
          fMode := fmOpenWrite or fmShareDenyNone
        else
          fMode := fmCreate or fmShareDenyNone;

        if Assigned(FFileStream) then
          FreeAndNil(FFileStream);
        FFileStream := TFileStream.Create(FLogFileDir + FLogName, fMode);
      end;

      FFileStream.Position := FFileStream.Size; // ׷�ӵ����
      case LogLevel of
        0:
          Logstr := '[Information] ' + Logstr;
        1:
          Logstr := '[Notice] ' + Logstr;
        2:
          Logstr := '[Warning] ' + Logstr;
        3:
          Logstr := '[Error] ' + Logstr;
      end;
      if WRITE_LOG_ADD_TIME then
        Logstr := FormatDateTime(WRITE_LOG_TIME_FORMAT, Now) + ' ' + Logstr + #13#10;

      FFileStream.Write( Logstr[1], length(Logstr));

    end;
  finally
    LeaveCriticalSection(FCSLock);
  end;
end;

procedure TLogger.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TLogger.SetLogFileDir(const Value: string);
begin
  FLogFileDir := Value;
  if not DirectoryExists(FLogFileDir) then
    if not ForceDirectories(FLogFileDir) then
    begin
      raise Exception.Create('��־·��������־������ܱ�����');
    end;
end;

procedure TLogger.SetLogShower(const Value: TComponent);
begin
  FLogShower := Value;
end;

procedure TLogger.ShowLog(Logstr: String; const LogLevel: Integer = 0);
var
  lineCount: Integer;
  listItem: TListItem;
begin
  if FLogShower = nil then
    Exit;
  if (FLogShower is TMemo) then
  begin
    if SHOW_LOG_ADD_TIME then
      Logstr := FormatDateTime(SHOW_LOG_TIME_FORMAT, Now) + ' ' + Logstr;
    lineCount := TMemo(FLogShower).Lines.Add(Logstr);
    // ���������һ��
    SendMessage(TMemo(FLogShower).Handle, WM_VSCROLL, SB_LINEDOWN, 0);
    if lineCount >= SHOW_LOG_CLEAR_COUNT then
      TMemo(FLogShower).Clear;
  end
  else if (FLogShower is TAdvMemo) then
  begin
    if SHOW_LOG_ADD_TIME then
      Logstr := FormatDateTime(SHOW_LOG_TIME_FORMAT, Now) + ' ' + Logstr;
    lineCount := TAdvMemo(FLogShower).Lines.Add(Logstr);

    if lineCount >= SHOW_LOG_CLEAR_COUNT then
      TAdvMemo(FLogShower).Clear;
    // ���������һ��
    //TAdvMemo(FLogShower).Lines.Add(#0);
    //TMemo(FLogShower).SelLength := Length(TMemo(FLogShower).text);
    SendMessage(TAdvMemo(FLogShower).Handle, WM_VSCROLL, SB_BOTTOM, 0);
  end
  else if (FLogShower is TListBox) then
  begin
    if SHOW_LOG_ADD_TIME then
      Logstr := FormatDateTime(SHOW_LOG_TIME_FORMAT, Now) + ' ' + Logstr;
    lineCount := TListBox(FLogShower).Items.Add(Logstr);
    SendMessage(TListBox(FLogShower).Handle, WM_VSCROLL, SB_LINEDOWN, 0);
    if lineCount >= SHOW_LOG_CLEAR_COUNT then
      TListBox(FLogShower).Clear;
  end
  else if (FLogShower is TListView) then
  begin
    listItem := TListView(FLogShower).Items.Add;
    if SHOW_LOG_ADD_TIME then
      listItem.Caption := FormatDateTime(SHOW_LOG_TIME_FORMAT, Now);
    if Assigned(TListView(FLogShower).SmallImages) and (TListView(FLogShower).SmallImages.Count - 1 >= LogLevel) then
      listItem.ImageIndex := LogLevel; // ���Ը��ݲ�ͬ�ȼ���ʾ��ͬͼƬ
    listItem.SubItems.Add(Logstr);
    SendMessage(TListView(FLogShower).Handle, WM_VSCROLL, SB_LINEDOWN, 0);
    if TListView(FLogShower).Items.Count >= SHOW_LOG_CLEAR_COUNT then
      TListView(FLogShower).Items.Clear;
  end
  else
    raise Exception.Create('��־�������Ͳ�֧��:' + FLogShower.ClassName);
end;

destructor TLogger.Destroy;
begin
  DeleteCriticalSection(FCSLock);
  if Assigned(FFileStream) then
    FreeAndNil(FFileStream);

end;

end.