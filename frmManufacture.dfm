object frmManu: TfrmManu
  Left = 411
  Top = 224
  BorderStyle = bsDialog
  Caption = #27979#35797#27169#24335
  ClientHeight = 316
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object shp14: TShape
    Left = 168
    Top = 56
    Width = 25
    Height = 17
    Brush.Color = clLime
    Shape = stCircle
  end
  object lbl11: TLabel
    Left = 64
    Top = 56
    Width = 64
    Height = 16
    Caption = #19978#26009#20301#31354
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object grp1: TGroupBox
    Left = 8
    Top = 0
    Width = 345
    Height = 169
    Caption = #20282#26381#30005#26426#31867
    TabOrder = 0
    object lbl3: TLabel
      Left = 16
      Top = 27
      Width = 128
      Height = 16
      Caption = #23383#36718#24038#21491#31227#21160'(mm)'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object shpZilunMove: TShape
      Left = 306
      Top = 26
      Width = 25
      Height = 17
      Brush.Color = clRed
      Shape = stCircle
    end
    object lbl4: TLabel
      Left = 273
      Top = 27
      Width = 32
      Height = 16
      Caption = #21407#28857
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 16
      Top = 62
      Width = 128
      Height = 16
      Caption = #23383#36718#26059#36716#19968#20010#23383#20301
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 273
      Top = 62
      Width = 32
      Height = 16
      Caption = #21407#28857
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object shpZilunRound: TShape
      Left = 306
      Top = 61
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object lbl7: TLabel
      Left = 16
      Top = 96
      Width = 128
      Height = 16
      Caption = #24037#20214#24038#21491#31227#21160'(mm)'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 273
      Top = 96
      Width = 32
      Height = 16
      Caption = #21407#28857
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object shpProductMove: TShape
      Left = 306
      Top = 95
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object lbl9: TLabel
      Left = 16
      Top = 131
      Width = 128
      Height = 16
      Caption = #24037#20214#26059#36716#25351#23450#35282#24230
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 273
      Top = 131
      Width = 32
      Height = 16
      Caption = #21407#28857
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object shpProductRound: TShape
      Left = 306
      Top = 130
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object btnZilunMoveLeft: TButton
      Left = 152
      Top = 22
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 0
      OnClick = btnZilunMoveLeftClick
    end
    object btnZilunMoveright: TButton
      Left = 224
      Top = 22
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 1
      OnClick = btnZilunMoverightClick
    end
    object edtZilunMove: TAdvEdit
      Left = 176
      Top = 23
      Width = 49
      Height = 24
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      Text = '10'
      Visible = True
      Version = '2.8.6.1'
    end
    object btnZilunRoundLeft: TButton
      Left = 152
      Top = 57
      Width = 49
      Height = 25
      Caption = '<'
      TabOrder = 3
      OnClick = btnZilunRoundLeftClick
    end
    object btnZilunRoundright: TButton
      Left = 200
      Top = 57
      Width = 49
      Height = 25
      Caption = '>'
      TabOrder = 4
      OnClick = btnZilunRoundrightClick
    end
    object btnProductMoveleft: TButton
      Left = 152
      Top = 91
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 5
      OnClick = btnProductMoveleftClick
    end
    object edtProductMove: TAdvEdit
      Left = 176
      Top = 92
      Width = 49
      Height = 24
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 7
      Text = '10'
      Visible = True
      Version = '2.8.6.1'
    end
    object btnProductMoveright: TButton
      Left = 224
      Top = 91
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 6
      OnClick = btnProductMoverightClick
    end
    object btnProductRoundleft: TButton
      Left = 152
      Top = 126
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 8
      OnClick = btnProductRoundleftClick
    end
    object btnProductRoundright: TButton
      Left = 224
      Top = 126
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 9
      OnClick = btnProductRoundrightClick
    end
    object edtProductRound: TAdvEdit
      Left = 176
      Top = 127
      Width = 49
      Height = 24
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 10
      Text = '10'
      Visible = True
      Version = '2.8.6.1'
    end
  end
  object grp2: TGroupBox
    Left = 368
    Top = 8
    Width = 345
    Height = 241
    Caption = #30005#30913#38400#65292#27668#32568#31867
    TabOrder = 2
    object shpLiaojiaUp: TShape
      Left = 34
      Top = 34
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpLiaojiaDown: TShape
      Left = 266
      Top = 34
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpProductUp: TShape
      Left = 34
      Top = 66
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpProductDown: TShape
      Left = 266
      Top = 66
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpProductJia: TShape
      Left = 34
      Top = 98
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpProductSong: TShape
      Left = 266
      Top = 98
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai1: TShape
      Left = 42
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai14: TShape
      Left = 258
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai2: TShape
      Left = 69
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai3: TShape
      Left = 95
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai4: TShape
      Left = 122
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai11: TShape
      Left = 178
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai12: TShape
      Left = 205
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZhichengkuai13: TShape
      Left = 231
      Top = 154
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZilunDown: TShape
      Left = 26
      Top = 178
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpZilunUp: TShape
      Left = 186
      Top = 178
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object lbl13: TLabel
      Left = 225
      Top = 179
      Width = 32
      Height = 16
      Caption = #21387#21147
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl14: TLabel
      Left = 313
      Top = 179
      Width = 24
      Height = 16
      Caption = 'MPa'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object btnLiaojiaUp: TButton
      Left = 72
      Top = 30
      Width = 81
      Height = 25
      Caption = #26009#26550#21069#31227
      TabOrder = 0
      OnClick = btnLiaojiaUpClick
    end
    object btnLiaojiaDown: TButton
      Left = 168
      Top = 30
      Width = 81
      Height = 25
      Caption = #26009#26550#21518#31227
      TabOrder = 1
      OnClick = btnLiaojiaDownClick
    end
    object btnProductUp: TButton
      Left = 72
      Top = 62
      Width = 81
      Height = 25
      Caption = #24037#20214#19978#21319
      TabOrder = 2
      OnClick = btnProductUpClick
    end
    object btnProductDown: TButton
      Left = 168
      Top = 62
      Width = 81
      Height = 25
      Caption = #24037#20214#19979#38477
      TabOrder = 3
      OnClick = btnProductDownClick
    end
    object btnProductJia: TButton
      Left = 72
      Top = 94
      Width = 81
      Height = 25
      Caption = #24037#20214#22841#32039
      TabOrder = 4
      OnClick = btnProductJiaClick
    end
    object btnProductSong: TButton
      Left = 168
      Top = 94
      Width = 81
      Height = 25
      Caption = #24037#20214#26494#24320
      TabOrder = 5
      OnClick = btnProductSongClick
    end
    object btnZhichengkuaiUp: TButton
      Left = 40
      Top = 126
      Width = 113
      Height = 25
      Caption = #25903#25215#22359#20280#20986
      TabOrder = 6
      OnClick = btnZhichengkuaiUpClick
    end
    object btnZhichengkuaiDown: TButton
      Left = 168
      Top = 126
      Width = 121
      Height = 25
      Caption = #25903#25215#22359#32553#22238
      TabOrder = 7
      OnClick = btnZhichengkuaiDownClick
    end
    object btnZilunDown: TButton
      Left = 56
      Top = 174
      Width = 65
      Height = 25
      Caption = #23383#36718#19979#21387
      TabOrder = 8
      OnClick = btnZilunDownClick
    end
    object btnZilunUp: TButton
      Left = 120
      Top = 174
      Width = 65
      Height = 25
      Caption = #23383#36718#19978#21319
      TabOrder = 9
      OnClick = btnZilunUpClick
    end
    object edtYali: TAdvEdit
      Left = 264
      Top = 175
      Width = 41
      Height = 24
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
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 10
      Text = '10'
      Visible = True
      Version = '2.8.6.1'
    end
    object btnZilunHightUp: TButton
      Left = 120
      Top = 198
      Width = 65
      Height = 25
      Caption = #22686#21387#19978#21319
      TabOrder = 11
      OnClick = btnZilunHightUpClick
    end
    object btnZilunHightDown: TButton
      Left = 56
      Top = 198
      Width = 65
      Height = 25
      Caption = #22686#21387#19979#21387
      TabOrder = 12
      OnClick = btnZilunHightDownClick
    end
  end
  object grp3: TGroupBox
    Left = 8
    Top = 176
    Width = 225
    Height = 129
    Caption = #20854#23427#20256#24863#22120#29366#24577
    TabOrder = 1
    object shpXuanzhuanZhicheng: TShape
      Left = 168
      Top = 32
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object lbl1: TLabel
      Left = 16
      Top = 32
      Width = 128
      Height = 16
      Caption = #26059#36716#30424#25509#35302#25903#25215#22359
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 72
      Top = 56
      Width = 64
      Height = 16
      Caption = #19978#26009#20301#31354
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object shpShangliao: TShape
      Left = 168
      Top = 56
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object shpXialiao: TShape
      Left = 168
      Top = 80
      Width = 25
      Height = 17
      Brush.Color = clLime
      Shape = stCircle
    end
    object lbl12: TLabel
      Left = 72
      Top = 80
      Width = 64
      Height = 16
      Caption = #19979#26009#20301#31354
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
  end
  object btnExit: TButton
    Left = 464
    Top = 262
    Width = 113
    Height = 51
    Caption = #36864#20986
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnExitClick
  end
  object btnZilunMoveReset: TButton
    Left = 248
    Top = 182
    Width = 105
    Height = 25
    Caption = #23383#36718#31227#21160#22797#20301
    TabOrder = 4
    OnClick = btnZilunMoveResetClick
  end
  object btnZilunRoundReset: TButton
    Left = 248
    Top = 214
    Width = 105
    Height = 25
    Caption = #23383#36718#26059#36716#22797#20301
    TabOrder = 5
    OnClick = btnZilunRoundResetClick
  end
  object btnProRoundReset: TButton
    Left = 248
    Top = 246
    Width = 105
    Height = 25
    Caption = #24037#20214#26059#36716#22797#20301
    TabOrder = 6
    OnClick = btnProRoundResetClick
  end
  object btnProMoveRight: TButton
    Left = 248
    Top = 278
    Width = 105
    Height = 25
    Caption = #24037#20214#31227#21160#22797#20301
    TabOrder = 7
    OnClick = btnProMoveRightClick
  end
  object tmr1: TTimer
    Interval = 300
    OnTimer = tmr1Timer
    Left = 8
    Top = 312
  end
end
