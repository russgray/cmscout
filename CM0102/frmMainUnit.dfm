object FfrmMain: TFfrmMain
  Left = 192
  Top = 107
  Width = 827
  Height = 480
  Caption = 'CM Scout 2.00'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = FmnuMain
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object FlvPlayers: TVirtualStringTree
    Left = 0
    Top = 26
    Width = 819
    Height = 389
    Align = alClient
    DefaultNodeHeight = 14
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = 41
    Header.Options = [hoColumnResize, hoDrag, hoVisible]
    Header.PopupMenu = FpopHeader
    Header.SortColumn = 41
    HintAnimation = hatNone
    IncrementalSearch = isAll
    Margin = 2
    NodeDataSize = 4
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoScroll, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking]
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect]
    OnDblClick = FlvPlayersDblClick
    OnHeaderClick = FlvPlayersHeaderClick
    Columns = <
      item
        Alignment = taRightJustify
        Position = 4
        WideText = 'Ability'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 9
        Width = 75
        WideText = 'Acceleration'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 10
        Width = 69
        WideText = 'Adaptability'
      end
      item
        Alignment = taRightJustify
        Position = 6
        Width = 40
        WideText = 'Age'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 11
        Width = 68
        WideText = 'Aggression'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 12
        Width = 45
        WideText = 'Agility'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 13
        Width = 55
        WideText = 'Ambition'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 14
        Width = 70
        WideText = 'Anticipation'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 15
        Width = 55
        WideText = 'Balance'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 16
        Width = 55
        WideText = 'Bravery'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 17
        Width = 40
        WideText = 'Caps'
      end
      item
        Position = 2
        Tag = 1
        Width = 110
        WideText = 'Club'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 18
        Width = 65
        WideText = 'Club Rep'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 19
        Width = 70
        WideText = 'Consistency'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 20
        Tag = 2
        Width = 77
        WideText = 'Contract Exp'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 21
        Tag = 1
        Width = 100
        WideText = 'Contract Type'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 22
        Width = 55
        WideText = 'Corners'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 23
        Width = 60
        WideText = 'Creativity'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 24
        Width = 55
        WideText = 'Crossing'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 25
        Width = 70
        WideText = 'Current Rep'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 26
        Tag = 2
        Width = 78
        WideText = 'Date Of Birth'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 27
        Width = 65
        WideText = 'Decisions'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 28
        Width = 80
        WideText = 'Determination'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 29
        Width = 55
        WideText = 'Dirtiness'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 30
        Width = 58
        WideText = 'Dribbling'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 31
        Width = 60
        WideText = 'Finishing'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 32
        Width = 40
        WideText = 'Flair'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 33
        Width = 58
        WideText = 'Handling'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 34
        Width = 60
        WideText = 'Heading'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 35
        Width = 70
        WideText = 'Home Rep'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 36
        Width = 75
        WideText = 'Imp Matches'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 37
        Width = 60
        WideText = 'Influence'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 38
        Width = 72
        WideText = 'Injury Prone'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 39
        Width = 60
        WideText = 'Int Goals'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 40
        Width = 55
        WideText = 'Jumping'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 41
        Width = 58
        WideText = 'Left Foot'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 42
        Width = 70
        WideText = 'Long Shots'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 43
        WideText = 'Loyality'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 44
        Width = 95
        WideText = 'Manager Job Rel'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 45
        WideText = 'Marking'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 46
        Width = 75
        WideText = 'Min Fee Rel'
      end
      item
        Position = 0
        Tag = 1
        Width = 120
        WideText = 'Name'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 47
        Width = 70
        WideText = 'Nat Fitness'
      end
      item
        Position = 1
        Tag = 1
        Width = 100
        WideText = 'Nation'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 48
        Width = 77
        WideText = 'Non Play Rel'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 49
        Width = 105
        WideText = 'Non Promotion Rel'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 50
        Width = 70
        WideText = 'Off The Ball'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 51
        Width = 80
        WideText = 'One On Ones'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 52
        Width = 45
        WideText = 'Pace'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 53
        Width = 55
        WideText = 'Passing'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 54
        Width = 60
        WideText = 'Penalties'
      end
      item
        Position = 3
        Tag = 1
        Width = 65
        WideText = 'Position'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 55
        Width = 70
        WideText = 'Positioning'
      end
      item
        Alignment = taRightJustify
        Position = 5
        Width = 62
        WideText = 'Pot Ability'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 56
        Width = 58
        WideText = 'Pressure'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 57
        Width = 90
        WideText = 'Professionalism'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 58
        Width = 55
        WideText = 'Reflexes'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 59
        Width = 85
        WideText = 'Relegation Rel'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 60
        Width = 67
        WideText = 'Right Foot'
      end
      item
        Alignment = taRightJustify
        Position = 8
        Tag = 3
        Width = 80
        WideText = 'Scout Rating'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 61
        Width = 70
        WideText = 'Set Pieces'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 62
        Width = 85
        WideText = 'Sportsmanship'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 63
        Tag = 1
        Width = 100
        WideText = 'Squad Status'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 64
        Width = 55
        WideText = 'Stamina'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 65
        Width = 55
        WideText = 'Strength'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 66
        Width = 55
        WideText = 'Tackling'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 67
        Width = 65
        WideText = 'Teamwork'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 68
        Width = 65
        WideText = 'Technique'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 69
        Width = 80
        WideText = 'Temperament'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 70
        Width = 60
        WideText = 'Throw Ins'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 71
        Tag = 1
        Width = 100
        WideText = 'Transfer Status'
      end
      item
        Alignment = taRightJustify
        Position = 7
        Width = 65
        WideText = 'Value'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 72
        Width = 60
        WideText = 'Versatility'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 73
        Width = 65
        WideText = 'Wage'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 74
        Width = 70
        WideText = 'Work Rate'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 75
        Width = 70
        WideText = 'World Rep'
      end>
  end
  object FtdTop: TTBDock
    Left = 0
    Top = 0
    Width = 819
    Height = 26
    AllowDrag = False
    object FtbActions: TTBToolbar
      Left = 0
      Top = 0
      BorderStyle = bsNone
      DefaultDock = FtdTop
      DockableTo = [dpTop]
      DockMode = dmCannotFloatOrChangeDocks
      DockPos = -7
      DockRow = 1
      Images = FimglActions
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object FtbtnOpen: TTBItem
        Action = FacOpen
      end
      object FtbtnSave: TTBItem
        Action = FactSave
      end
      object FtbtnSep1: TTBSeparatorItem
      end
      object FtbtnPlayerSearch: TTBItem
        Action = FactPlayerSearch
      end
      object FtbtnTeamSearch: TTBItem
        Action = FactTeamSearch
      end
    end
  end
  object FstbStatus: TdfsStatusBar
    Left = 0
    Top = 415
    Width = 819
    Height = 19
    Panels = <
      item
        BorderWidth = 1
        Enabled = True
        Width = 145
        AutoFit = False
      end
      item
        Alignment = taCenter
        BorderWidth = 1
        Enabled = True
        Width = 390
        AutoFit = False
      end
      item
        BorderWidth = 1
        Enabled = True
        Width = 50
        AutoFit = False
      end>
  end
  object FmnuMain: TMainMenu
    Images = FimglActions
    Left = 72
    Top = 48
    object FmnuiFile: TMenuItem
      Caption = '&File'
      object FmnuiOpen: TMenuItem
        Action = FacOpen
      end
      object FmnuiSave: TMenuItem
        Action = FactSave
      end
      object FmnuiSep1: TMenuItem
        Caption = '-'
      end
      object FmnuiExit: TMenuItem
        Caption = '&Exit'
        OnClick = FmnuiExitClick
      end
    end
    object FmnuiOptions: TMenuItem
      Caption = '&Options'
      object FmnuiPreferences: TMenuItem
        Caption = '&Preferences'
        OnClick = FmnuiPreferencesClick
      end
    end
    object FmnuiSearch: TMenuItem
      Caption = '&Search'
      object FmnuiPlayerSearch: TMenuItem
        Action = FactPlayerSearch
      end
      object FmnuiTeamSearch: TMenuItem
        Action = FactTeamSearch
      end
    end
    object FmnuiHelp: TMenuItem
      Caption = '&Help'
      object FmnuiAbout: TMenuItem
        Caption = '&About'
        OnClick = FmnuiAboutClick
      end
    end
  end
  object FcdData: TCMDatabase
    OnStatus = FcdDataStatus
    OnProgress = FcdDataProgress
    Left = 104
    Top = 48
  end
  object FaclActions: TActionList
    Images = FimglActions
    Left = 40
    Top = 48
    object FacOpen: TAction
      Category = 'File'
      Caption = '&Open'
      Hint = 'Open a saved game'
      ImageIndex = 0
      ShortCut = 16463
      OnExecute = FacOpenExecute
    end
    object FactPlayerSearch: TAction
      Category = 'Search'
      Caption = '&Player Search'
      Enabled = False
      Hint = 'Search for a player'
      ImageIndex = 1
      ShortCut = 16464
      OnExecute = FactPlayerSearchExecute
    end
    object FactTeamSearch: TAction
      Category = 'Search'
      Caption = '&Team Search'
      Enabled = False
      Hint = 'List the players of a team'
      ImageIndex = 2
      ShortCut = 16468
      OnExecute = FactTeamSearchExecute
    end
    object FactSave: TAction
      Category = 'File'
      Caption = '&Save'
      Enabled = False
      ImageIndex = 3
      ShortCut = 16467
      OnExecute = FactSaveExecute
    end
  end
  object FimglActions: TTBImageList
    Left = 8
    Top = 48
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001001000000000000018
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E34DE34DE34DE34DE34D
      E34DE34DE34DE34DE34D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000636263626362636263626362
      63626362636263626362E34D0000000000000000000000000000000000002925
      0000000000000000000000000000000000000000000000000000000000000000
      2925000000000000000000000000000000000000000029252925292529252925
      29252925292529252925292529252925000063626362F37F8F7F8F7F8F7F8F7F
      8F7F8F7F8F7F8F7F8F7F6362E34D000000000000000000000000000000002925
      2925292500000000000000000000000000000000000000000000000000000000
      2925000000000000000000000000000000000000292589528952292529252925
      292529252925000000002925895229250000636263628F7FF37F8F7F8F7F8F7F
      8F7F8F7F8F7F8F7F8F7FE76AE34D000000002925292529252925292500002925
      0000292500002925292529252925292500002925292529252925292500000000
      2925000000002925292529252925292500000000292589528952292529252925
      29252925292500000000292589522925000063628466E76AF37FD17FD17FD17F
      D17FD17FD17FD17F907F0A77E34D000000002925FF7F29252925292500002925
      2925292500002925FF7F29252925292500002925FF7F29252925292500002925
      2925292500002925FF7F29252925292500000000292589528952292529252925
      29252925292500000000292589522925000063620A778466F47FF37FF37FF37F
      F37FF37FF37FF37FF37F0A77EB66E34D00002925FF7F29252925292500000000
      0000000000002925FF7F29252925292500002925FF7F29252925292500000000
      0000000000002925FF7F29252925292500000000292589528952292529252925
      29252925292529252925292589522925000063628F7F6362D17FF37FF37FF37F
      F37FF37FF37FF37FF37F0A77F37FE34D00002925292529252925292529252925
      0000292529252925292529252925292500002925292529252925292529252925
      0000292529252925292529252925292500000000292589528952895289528952
      8952895289528952895289528952292500006362907F6362EB66FF7FFF7FFE7F
      FF7FFF7FFF7FFF7FFF7F907FFF7FE34D000029252925FF7F2925292529252925
      29252925FF7F29252925292529252925000029252925FF7F2925292529252925
      29252925FF7F2925292529252925292500000000292589528952292529252925
      2925292529252925292589528952292500006362D17F0A776362636263626362
      6362636263626362636263626362E34D000029252925FF7F2925292529250000
      29252925FF7F29252925292529252925000029252925FF7F2925292529250000
      29252925FF7F2925292529252925292500000000292589522925000000000000
      0000000000000000000029258952292500006362F37FD17FD17FD17FD17FD17F
      FF7FFF7FFF7FFF7FFF7F6362E34D0000000029252925FF7F2925292529250000
      29252925FF7F29252925292529252925000029252925FF7F2925292529250000
      29252925FF7F2925292529252925292500000000292589522925000000000000
      0000000000000000000029258952292500006362FF7FF37FF37FF37FF37FFF7F
      6362636263626362636263620000000000000000292529252925292529252925
      2925292529252925292529252925000000000000292529252925292529252925
      2925292529252925292529252925000000000000292589522925000000000000
      00000000000000000000292589522925000000008466FF7FFF7FFF7FFF7F6362
      000000000000000000000000000000000000000000002925FF7F292529252925
      00002925FF7F292529252925000000000000000000002925FF7F292529252925
      00002925FF7F2925292529250000000000000000292589522925000000000000
      0000000000000000000029258952292500000000000084668466846684660000
      0000000000000000000000000000000000000000000029252925292529252925
      0000292529252925292529250000000000000000000029252925292529252925
      0000292529252925292529250000000000000000292589522925000000000000
      0000000000000000000029252925292500000000000000000000000000000000
      0000000000000000000000000000000000000000000000002925292529250000
      0000000029252925292500000000000000000000000000002925292529250000
      0000000029252925292500000000000000000000292589522925000000000000
      0000000000000000000029250000292500000000000000000000000000000000
      0000000000000000000000000000000000000000000000002925FF7F29250000
      000000002925FF7F292500000000000000000000000000002925FF7F29250000
      000000002925FF7F292500000000000000000000292529252925292529252925
      2925292529252925292529252925292500000000000000000000000000000000
      0000000000000000000000000000000000000000000000002925292529250000
      0000000029252925292500000000000000000000000000002925292529250000
      0000000029252925292500000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C00FFFFFFFFFFFFF8007FDFFFEFFC001
      0003FC7FFEFF80310003054106C180310003044104418031000107C107C18001
      000101010101800100010001000180010001020102018FF10003020102018FF1
      0007800380038FF181FFC107C1078FF1C3F1C107C1078FF1FFF9E38FE38F8FF5
      FF75E38FE38F8001FF8FE38FE38FFFFF00000000000000000000000000000000
      000000000000}
  end
  object FdiaOpen: TOpenDialog
    Filter = 'CM Saved Game (*.sav)|*.sav'
    Left = 136
    Top = 48
  end
  object FpopHeader: TVTHeaderPopupMenu
    OnAddHeaderPopupItem = FpopHeaderAddHeaderPopupItem
    Options = []
    Left = 200
    Top = 48
  end
  object FdiaSave: TSaveDialog
    DefaultExt = 'pls'
    Filter = 
      'Scout Lists (*.pls)|*.pls|CSV (Comma Delimited) (*.csv)|*.csv|Te' +
      'xt File (*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Player List'
    Left = 168
    Top = 48
  end
end
