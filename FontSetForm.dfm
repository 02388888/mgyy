object frmFontSet: TfrmFontSet
  Left = 466
  Top = 177
  BorderStyle = bsSingle
  Caption = #23383#24211#21442#25968
  ClientHeight = 446
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnExit: TButton
    Left = 160
    Top = 368
    Width = 129
    Height = 57
    Cancel = True
    Caption = #36864#20986
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnExitClick
  end
  object btnOk: TButton
    Left = 16
    Top = 368
    Width = 129
    Height = 57
    Caption = #30830#23450
    Default = True
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnOkClick
  end
  object grid: TStringGrid
    Left = 8
    Top = 8
    Width = 297
    Height = 329
    ColCount = 2
    DefaultColWidth = 135
    RowCount = 40
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    TabOrder = 2
  end
  object qry1: TADOQuery
    Parameters = <>
    Left = 16
    Top = 344
  end
end
