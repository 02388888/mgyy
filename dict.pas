unit dict;

interface
uses Windows, Classes, SysUtils, StrUtils;

type
  TDictionary=class
  private
    m_strs: string;

    procedure SetValues(str: string);


  public
    constructor Create;
    destructor Destroy; override;

    property values: string write SetValues;
end;

implementation

constructor TDictionary.Create;
begin

end;
destructor TDictionary.Destroy;
begin

end;
procedure TDictionary.SetValues(str: string);
begin

end;

end.
 