object MainFrm: TMainFrm
  Left = 201
  Top = 123
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #39532#38050#36718#22280#19987#29992#21387#21360#25511#21046#31995#32479
  ClientHeight = 604
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = advmnmn1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object mbxp1: TMbaxp
    Left = 696
    Top = 384
    Width = 65
    Height = 25
    TabOrder = 0
    OnResultOk = mbxp1ResultOk
    OnResultError = mbxp1ResultError
    ControlData = {
      04000100B8060000950200000000000001000500010000000000E80300000000
      000000000000}
  end
  object grp1: TGroupBox
    Left = 0
    Top = 272
    Width = 217
    Height = 321
    Caption = #25805#20316
    TabOrder = 1
    object btnSet: TSpeedButton
      Left = 40
      Top = 80
      Width = 153
      Height = 33
      Caption = #21442#25968#35774#32622
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = actSetExecute
    end
    object btnReset: TSpeedButton
      Left = 40
      Top = 224
      Width = 153
      Height = 33
      Caption = #35774#22791#22797#20301
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = actResetExecute
    end
    object btnExit: TSpeedButton
      Left = 40
      Top = 272
      Width = 153
      Height = 33
      Caption = #36864#20986
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = actExitExecute
    end
    object btnShoudong: TSpeedButton
      Left = 40
      Top = 32
      Width = 153
      Height = 33
      Caption = #27979#35797#27169#24335
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = actManuExecute
    end
    object btnStart: TcxButton
      Left = 40
      Top = 128
      Width = 153
      Height = 33
      Caption = #21551#21160
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = actStartExecute
      Colors.Default = clLime
    end
    object btnStop: TcxButton
      Left = 40
      Top = 176
      Width = 153
      Height = 33
      Caption = #20013#27490
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = actStopExecute
      Colors.Default = clRed
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 81
    Align = alTop
    TabOrder = 2
    object lblVIN: TLabel
      Left = 8
      Top = 32
      Width = 100
      Height = 24
      Caption = #21387#21360#21495#30721
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblModel: TLabel
      Left = 792
      Top = 24
      Width = 100
      Height = 24
      Caption = #27586#38754#27169#24335
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtValue: TAdvEdit
      Left = 120
      Top = 24
      Width = 625
      Height = 37
      EditAlign = eaCenter
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = '2017-06-20 AGLKJAEP-'#8546
      Visible = True
      Version = '2.8.6.1'
    end
  end
  object grp2: TGroupBox
    Left = 0
    Top = 88
    Width = 217
    Height = 177
    Caption = #24037#20214#21442#25968
    TabOrder = 3
    object lbl1: TLabel
      Left = 23
      Top = 27
      Width = 63
      Height = 14
      Caption = #36710#36718#22411#21495':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl5: TLabel
      Left = 22
      Top = 51
      Width = 119
      Height = 14
      Caption = #36710#36718#31227#21160#36317#31163'(mm):'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl3: TLabel
      Left = 22
      Top = 75
      Width = 119
      Height = 14
      Caption = #23383#36718#31227#21160#36317#31163'(mm):'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl6: TLabel
      Left = 22
      Top = 99
      Width = 77
      Height = 14
      Caption = #36710#36718#21021#22987#35282':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl4: TLabel
      Left = 22
      Top = 123
      Width = 77
      Height = 14
      Caption = #23383#38388#36317'(mm):'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl7: TLabel
      Left = 22
      Top = 147
      Width = 119
      Height = 14
      Caption = #23383#31526#20998#24067#30452#24452'(mm):'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object edtProName: TAdvEdit
      Left = 88
      Top = 24
      Width = 105
      Height = 21
      EditAlign = eaCenter
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clWindow
      Ctl3D = False
      Enabled = True
      ParentCtl3D = False
      TabOrder = 0
      Text = 'xxxxx'
      Visible = True
      Version = '2.8.6.1'
    end
    object edtProPos: TAdvEdit
      Left = 144
      Top = 48
      Width = 49
      Height = 21
      EditAlign = eaCenter
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clWindow
      Ctl3D = False
      Enabled = True
      ParentCtl3D = False
      TabOrder = 1
      Text = '500'
      Visible = True
      OnChange = edtProPosChange
      Version = '2.8.6.1'
    end
    object edtZilunPos: TAdvEdit
      Left = 144
      Top = 72
      Width = 49
      Height = 21
      EditAlign = eaCenter
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clWindow
      Ctl3D = False
      Enabled = True
      ParentCtl3D = False
      TabOrder = 2
      Text = '50'
      Visible = True
      OnChange = edtZilunPosChange
      Version = '2.8.6.1'
    end
    object edt1: TAdvEdit
      Left = 104
      Top = 96
      Width = 73
      Height = 21
      EditAlign = eaCenter
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clWindow
      Ctl3D = False
      Enabled = True
      ParentCtl3D = False
      TabOrder = 3
      Text = '30.23'
      Visible = True
      OnChange = edt1Change
      Version = '2.8.6.1'
    end
    object edtFontSpace: TAdvEdit
      Left = 104
      Top = 120
      Width = 49
      Height = 21
      EditAlign = eaCenter
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clWindow
      Ctl3D = False
      Enabled = True
      ParentCtl3D = False
      TabOrder = 4
      Text = '0.1'
      Visible = True
      OnChange = edtFontSpaceChange
      Version = '2.8.6.1'
    end
    object edtProductDiameter: TAdvEdit
      Left = 144
      Top = 144
      Width = 49
      Height = 21
      EditAlign = eaCenter
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clWindow
      Ctl3D = False
      Enabled = True
      ParentCtl3D = False
      TabOrder = 5
      Text = '420'
      Visible = True
      OnChange = edtProductDiameterChange
      Version = '2.8.6.1'
    end
  end
  object pgc1: TPageControl
    Left = 232
    Top = 81
    Width = 688
    Height = 523
    ActivePage = ts2
    Align = alRight
    TabOrder = 4
    object ts1: TTabSheet
      Caption = #21387#21360#26085#24535
      object mmoPrintLog: TMemo
        Left = 0
        Top = 0
        Width = 680
        Height = 495
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object ts2: TTabSheet
      Caption = #24037#20316#26085#24535
      ImageIndex = 1
      object advmWorkLog: TAdvMemo
        Left = 0
        Top = 0
        Width = 680
        Height = 495
        Cursor = crIBeam
        ActiveLineSettings.ShowActiveLine = False
        ActiveLineSettings.ShowActiveLineIndicator = False
        Align = alClient
        AutoCompletion.Font.Charset = DEFAULT_CHARSET
        AutoCompletion.Font.Color = clWindowText
        AutoCompletion.Font.Height = -11
        AutoCompletion.Font.Name = 'MS Sans Serif'
        AutoCompletion.Font.Style = []
        AutoCorrect.Active = True
        AutoHintParameterPosition = hpBelowCode
        BorderStyle = bsSingle
        CodeFolding.Enabled = False
        CodeFolding.LineColor = clGray
        Ctl3D = False
        DelErase = True
        EnhancedHomeKey = False
        Gutter.DigitCount = 4
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -13
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'COURIER NEW'
        Font.Style = []
        HiddenCaret = False
        Lines.Strings = (
          '')
        MarkerList.UseDefaultMarkerImageIndex = False
        MarkerList.DefaultMarkerImageIndex = -1
        MarkerList.ImageTransparentColor = 33554432
        PrintOptions.MarginLeft = 0
        PrintOptions.MarginRight = 0
        PrintOptions.MarginTop = 0
        PrintOptions.MarginBottom = 0
        PrintOptions.PageNr = False
        PrintOptions.PrintLineNumbers = False
        RightMarginColor = 14869218
        ScrollBars = ssVertical
        ScrollHint = False
        SelColor = clWhite
        SelBkColor = clNavy
        ShowRightMargin = True
        SmartTabs = False
        TabOrder = 0
        TabSize = 4
        TabStop = True
        TrimTrailingSpaces = False
        UndoLimit = 100
        UrlStyle.TextColor = clBlue
        UrlStyle.BkColor = clWhite
        UrlStyle.Style = [fsUnderline]
        UseStyler = True
        Version = '2.2.5.0'
        WordWrap = wwNone
      end
    end
  end
  object advmnmn1: TAdvMainMenu
    Version = '2.5.3.1'
    Left = 64
    object N1: TMenuItem
      Caption = #31995#32479#21151#33021
      object menuStart: TMenuItem
        Action = actStart
      end
      object menuStop: TMenuItem
        Action = actStop
      end
      object menuManu: TMenuItem
        Action = actManu
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object N3: TMenuItem
        Action = actReStart
      end
      object menuReset: TMenuItem
        Action = actReset
      end
      object menuSet: TMenuItem
        Action = actSet
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object menuExit: TMenuItem
        Action = actExit
      end
    end
    object N5: TMenuItem
      Caption = #21387#21360#27169#24335
      object menuGumian: TMenuItem
        Caption = #27586#38754#27169#24335
        Checked = True
        OnClick = menuGumianClick
      end
      object menuWangmian: TMenuItem
        Caption = #36747#38754#27169#24335
        OnClick = menuWangmianClick
      end
    end
  end
  object actlst1: TActionList
    Left = 96
    object actManu: TAction
      Caption = #27979#35797#27169#24335
      ShortCut = 16468
      OnExecute = actManuExecute
    end
    object actSet: TAction
      Caption = #21442#25968#35774#32622
      ShortCut = 16467
      OnExecute = actSetExecute
    end
    object actStart: TAction
      Caption = #21551#21160
      ShortCut = 120
      OnExecute = actStartExecute
    end
    object actStop: TAction
      Caption = #20013#27490
      ShortCut = 27
      OnExecute = actStopExecute
    end
    object actReset: TAction
      Caption = #35774#22791#22797#20301
      ShortCut = 123
      OnExecute = actResetExecute
    end
    object actReStart: TAction
      Caption = #37325#26032#21387#21360
      ShortCut = 121
    end
    object actExit: TAction
      Caption = #36864#20986
      ShortCut = 16472
      OnExecute = actExitExecute
    end
  end
  object qry1: TADOQuery
    Parameters = <>
    Left = 168
  end
  object conSave: TADOConnection
    Left = 136
  end
end
