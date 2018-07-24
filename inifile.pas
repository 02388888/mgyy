{*******************************************************}
{                                                       }
{       INI文件读写类                                   }
{                                                       }
{       版权所有 (C) 2009 重庆华普公司                  }
{                                                       }
{  作者：贺兴伟                                         }
{  QQ: 45668152   Email: 02388888@163.com               }
{  时间: 2009-1-6                                       }
{*******************************************************}

unit inifile;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, IniFiles, Forms;

type

  CMarkIniFile = class(TObject)
  private

  protected
    AppIni: TIniFile;

  public
    constructor Init();
    destructor Free();
    function GetProfileInt(strSection, strKeyName : string; nDefault: integer) : integer; overload;
    function GetProfileInt(strSection, strKeyName : string; strDefault: string) : string; overload;
    function GetProfileString(strSection, strKeyName, strDefault: string) : string;
    function GetProfileFloat(strSection, strKeyName: string; default: Double) : Double; overload;
    function GetProfileFloat(strSection, strKeyName: string; default: string) : string; overload;
    function GetProfileBool(strSection, strKeyName: string; default: bool) : Bool;

    procedure WriteProfileInt(strSection, strKeyName: string; nValue: integer); overload;
    procedure WriteProfileInt(strSection, strKeyName: string; strValue: string); overload;
    procedure WriteProfileString(strSection, strKeyName, strValue: string);
    procedure WriteProfileFloat(strSection, strKeyName: string; fValue: Double); overload;
    procedure WriteProfileFloat(strSection, strKeyName: string; strValue: string); overload;
    procedure WriteProfileBool(strSection, strKeyName: string; bValue: bool);
  published

  end;


implementation

//构造函数
constructor CMarkIniFile.Init();
var
  strIniFile: string;
begin
  strIniFile := ExtractFileDir(Application.ExeName) + '\config.ini';
  AppIni := TIniFile.Create(strIniFile);
end;
//析构函数
destructor CMarkIniFile.Free();
begin
  AppIni.Free;
end;

function CMarkIniFile.GetProfileInt(strSection, strKeyName : string; nDefault: integer) : integer;
begin
  result := AppIni.ReadInteger(strSection, strKeyName, nDefault);
end;
function CMarkIniFile.GetProfileInt(strSection, strKeyName : string; strDefault: string) : string;
var
  nDefault: integer;
begin
  nDefault := StrToInt(strDefault);
  result := IntToStr(AppIni.ReadInteger(strSection, strKeyName, nDefault));
end;

function CMarkIniFile.GetProfileString(strSection, strKeyName, strDefault: string) : string;
begin
  result := AppIni.ReadString(strSection, strKeyName, strDefault);
end;

function CMarkIniFile.GetProfileFloat(strSection, strKeyName: string; default: Double) : Double;
begin
  result := AppIni.ReadFloat(strSection, strKeyName, default);
end;
function CMarkIniFile.GetProfileFloat(strSection, strKeyName: string; default: string) : string;
var
  fValue: Double;
begin
  fValue := StrToFloat(default);
  result := FloatToStr(GetProfileFloat(strSection, strKeyName, fValue));
end;

function CMarkIniFile.GetProfileBool(strSection, strKeyName: string; default: bool) : Bool;
begin
  result := AppIni.ReadBool(strSection, strKeyName, default);
end;

procedure CMarkIniFile.WriteProfileInt(strSection, strKeyName: string; nValue: integer);
begin
  AppIni.WriteInteger(strSection, strKeyName, nValue);
end;
procedure CMarkIniFile.WriteProfileInt(strSection, strKeyName: string; strValue: string);
var
  nValue: integer;
begin
  nValue := StrToInt(strValue);
  WriteProfileInt(strSection, strKeyName, nValue);
end;
procedure CMarkIniFile.WriteProfileString(strSection, strKeyName, strValue: string);
begin
  AppIni.WriteString(strSection, strKeyName, strValue);
end;

procedure CMarkIniFile.WriteProfileFloat(strSection, strKeyName: string; fValue: Double);
begin
  AppIni.WriteFloat(strSection, strKeyName, fValue);
end;
procedure CMarkIniFile.WriteProfileFloat(strSection, strKeyName: string; strValue: string);
var
  fValue: Double;
begin
  fValue := strToFloat(strValue);
  WriteProfileFloat(strSection, strKeyName, fValue);
end;

procedure CMarkIniFile.WriteProfileBool(strSection, strKeyName: string; bValue: bool);
begin
  AppIni.WriteBool(strSection, strKeyName, bValue);
end;

end.

