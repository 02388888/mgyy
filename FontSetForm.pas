unit FontSetForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DB, ADODB;

type
  TfrmFontSet = class(TForm)
    btnExit: TButton;
    btnOk: TButton;
    grid: TStringGrid;
    qry1: TADOQuery;
    procedure btnExitClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFontSet: TfrmFontSet;

implementation

{$R *.dfm}

procedure TfrmFontSet.btnExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmFontSet.btnOkClick(Sender: TObject);
var
  strCon: string;
  strPath, strSQL: string;
  i: Integer;
begin
  strPath := ExtractFilePath(Application.Exename) + 'data.mdb';
  strCon := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + strPath + ';Persist Security Info=False';
  qry1.ConnectionString := strCon;
  qry1.Close;
  for i := 1 to grid.RowCount-1 do begin
    qry1.SQL.Clear;
    strSQL := 'update Fonts set Pressure = ' + grid.cells[1,i] + ' where Font=''' + grid.Cells[0,i] + '''';
    qry1.SQL.Add(strSQL);
    qry1.ExecSQL;
  end;
  qry1.Close;
  close;
end;

procedure TfrmFontSet.FormShow(Sender: TObject);
var
  strCon: string;
  strPath: string;
  nFontCount,i: Integer;
begin
  strPath := ExtractFilePath(Application.Exename) + 'data.mdb';
  strCon := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + strPath + ';Persist Security Info=False';
  qry1.ConnectionString := strCon;
  qry1.SQL.Clear;
  qry1.SQL.Add('select * from Fonts order by index');
  qry1.Open;
  nFontCount := qry1.RecordCount;
  grid.RowCount := nFontCount+1;
  qry1.First;
  grid.Cells[0,0] := '�ַ�';
  grid.Cells[1,0] := 'ѹ���ٷֱ�';
  i:=1;
  while not qry1.eof do
  begin
    grid.Cells[0,i] := qry1.FieldValues['Font'];
    grid.Cells[1,i] := qry1.FieldValues['Pressure'];
    qry1.Next;
    i := i + 1;
  end;
  qry1.Close;
  grid.Options := grid.Options + [goEditing];
end;

end.
