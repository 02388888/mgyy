unit Logger;
// =======================================================================
// 日志类（TLogger） ver.1.0
// 红鱼儿 http://blog.sina.com.cn/hblyuhong
// 2014/06/24
// 基于1.0修改
// PFeng  (http://www.pfeng.org / xxmc01#gmail.com)
// 2012/11/08
// 日志级别约定：
// 0 - Information
// 1 - Notice
// 2 - Warning
// 3 - Error
// =======================================================================

interface

uses Windows, Classes, SysUtils, StdCtrls, ComCtrls, ComObj, Messages,AdvMemo;

const
  WRITE_LOG_DIR = 'log\'; // 记录日志默认目录
  WRITE_LOG_MIN_LEVEL = 0; // 记录日志的最低级别，小于此级别只显示不记录
  WRITE_LOG_ADD_TIME = True; // 记录日志是否添加时间
  WRITE_LOG_TIME_FORMAT = 'hh:nn:ss.zzz'; // 记录日志添加时间的格式
  SHOW_LOG_ADD_TIME = True; // 日志显示容器是否添加时间
  SHOW_LOG_TIME_FORMAT = 'yyyy/mm/dd hh:nn:ss.zzz'; // 日志显示添加时间的格式
  SHOW_LOG_CLEAR_COUNT = 1000; // 日志显示容器最大显示条数

type
  TLogger = class
  private
    FCSLock: TRTLCriticalSection; // 临界区
    FFileStream: TFileStream; // 文件流
    FLogShower: TComponent; // 日志显示容器
    FLogName: String; // 日志名称
    FEnabled: Boolean;
    FLogFileDir: string; // 日志目录
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

    // 是否允许记录日志
    property Enabled: Boolean read FEnabled write SetEnabled;
    // 日志文件目录,默认当前目录的Log目录
    property LogFileDir: string read FLogFileDir write SetLogFileDir;
    // 显示日志的组件
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

    ShowLog(Logstr, LogLevel); // 显示日志到容器
    if LogLevel >= WRITE_LOG_MIN_LEVEL then
    begin
      logName := FormatDateTime('yyyymmdd', Now) + '.log';
      if FLogName <> logName then
      begin
        FLogName := logName;
        if FileExists(FLogFileDir + FLogName) then // 如果当天的日志文件存在
          fMode := fmOpenWrite or fmShareDenyNone
        else
          fMode := fmCreate or fmShareDenyNone;

        if Assigned(FFileStream) then
          FreeAndNil(FFileStream);
        FFileStream := TFileStream.Create(FLogFileDir + FLogName, fMode);
      end;

      FFileStream.Position := FFileStream.Size; // 追加到最后
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
      raise Exception.Create('日志路径错误，日志类对象不能被创建');
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
    // 滚屏到最后一行
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
    // 滚屏到最后一行
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
      listItem.ImageIndex := LogLevel; // 可以根据不同等级显示不同图片
    listItem.SubItems.Add(Logstr);
    SendMessage(TListView(FLogShower).Handle, WM_VSCROLL, SB_LINEDOWN, 0);
    if TListView(FLogShower).Items.Count >= SHOW_LOG_CLEAR_COUNT then
      TListView(FLogShower).Items.Clear;
  end
  else
    raise Exception.Create('日志容器类型不支持:' + FLogShower.ClassName);
end;

destructor TLogger.Destroy;
begin
  DeleteCriticalSection(FCSLock);
  if Assigned(FFileStream) then
    FreeAndNil(FFileStream);

end;

end.
