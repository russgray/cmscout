object frmMain: TfrmMain
  Left = 192
  Top = 114
  Width = 795
  Height = 424
  Caption = 'CM Scout 3.10'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmnuMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvPlayers: TVirtualStringTree
    Left = 0
    Top = 25
    Width = 787
    Height = 326
    Align = alClient
    DefaultNodeHeight = 14
    DragOperations = []
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDrag, hoVisible]
    Header.PopupMenu = pmnuHeaders
    Header.SortColumn = 0
    IncrementalSearch = isAll
    Indent = 0
    NodeDataSize = 4
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnDblClick = lvPlayersDblClick
    OnHeaderClick = lvPlayersHeaderClick
    Columns = <
      item
        Position = 0
        Width = 125
        WideText = 'Name'
      end
      item
        Position = 1
        Width = 100
        WideText = 'Nation'
      end
      item
        Position = 2
        Width = 100
        WideText = 'Club'
      end
      item
        Position = 3
        Width = 55
        WideText = 'Position'
      end
      item
        Alignment = taRightJustify
        Position = 4
        Width = 45
        WideText = 'Ability'
      end
      item
        Alignment = taRightJustify
        Position = 5
        Width = 65
        WideText = 'Pot Ability'
      end
      item
        Alignment = taRightJustify
        Position = 6
        Width = 40
        WideText = 'Age'
      end
      item
        Alignment = taRightJustify
        Position = 7
        Width = 75
        WideText = 'Value'
      end
      item
        Alignment = taRightJustify
        Position = 8
        Width = 75
        WideText = 'Sale Value'
      end
      item
        Alignment = taRightJustify
        Position = 9
        Width = 80
        WideText = 'Scout Rating'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 10
        Width = 80
        WideText = 'Date Of Birth'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 11
        Width = 75
        WideText = 'EU Member'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 12
        Width = 45
        WideText = 'Caps'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 13
        Width = 60
        WideText = 'Int Goals'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 14
        Width = 75
        WideText = 'Based'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 15
        Width = 100
        WideText = 'Division'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 16
        Width = 100
        WideText = 'Squad'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 17
        Width = 75
        WideText = 'Squad Rep'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 18
        Width = 100
        WideText = 'Contract Type'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 19
        Width = 60
        WideText = 'Wage'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 20
        Width = 75
        WideText = 'Joined Club'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 21
        Width = 80
        WideText = 'Contract End'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 22
        Width = 115
        WideText = 'Leaving On Bosman'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 23
        Width = 80
        WideText = 'Minimum Fee'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 24
        Width = 90
        WideText = 'Relegation Fee'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 25
        Width = 110
        WideText = 'Non Promotion Fee'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 26
        Width = 100
        WideText = 'Squad Status'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 27
        Width = 135
        WideText = 'Perceived Squad Status'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 28
        Width = 100
        WideText = 'Transfer Status'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 29
        Width = 100
        WideText = 'Happiness Level'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 30
        Width = 70
        WideText = 'Home Rep'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 31
        Width = 75
        WideText = 'Current Rep'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 32
        Width = 70
        WideText = 'World Rep'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 33
        Width = 75
        WideText = 'Goalkeeper'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 34
        Width = 60
        WideText = 'Sweeper'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 35
        Width = 65
        WideText = 'Defender'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 36
        Width = 115
        WideText = 'Defensive Midfielder'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 37
        Width = 65
        WideText = 'Midfielder'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 38
        Width = 115
        WideText = 'Attacking Midfielder'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 39
        Width = 60
        WideText = 'Attacker'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 40
        Width = 75
        WideText = 'Wing Back'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 41
        Width = 65
        WideText = 'Free Role'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 42
        Width = 70
        WideText = 'Right Side'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 43
        Width = 60
        WideText = 'Left Side'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 44
        WideText = 'Central'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 45
        Width = 80
        WideText = 'Acceleration'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 46
        Width = 75
        WideText = 'Adaptability'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 47
        Width = 75
        WideText = 'Aerial Ability'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 48
        Width = 70
        WideText = 'Aggression'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 49
        WideText = 'Agility'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 50
        Width = 60
        WideText = 'Ambition'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 51
        Width = 75
        WideText = 'Anticipation'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 52
        Width = 60
        WideText = 'Balance'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 53
        Width = 55
        WideText = 'Bravery'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 54
        Width = 105
        WideText = 'Command Of Area'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 55
        Width = 90
        WideText = 'Communication'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 56
        Width = 75
        WideText = 'Consistency'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 57
        Width = 75
        WideText = 'Controversy'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 58
        Width = 55
        WideText = 'Corners'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 59
        Width = 60
        WideText = 'Creativity'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 60
        Width = 60
        WideText = 'Crossing'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 61
        Width = 65
        WideText = 'Decisions'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 62
        Width = 85
        WideText = 'Determination'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 63
        Width = 60
        WideText = 'Dirtiness'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 64
        Width = 60
        WideText = 'Dribbling'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 65
        Width = 75
        WideText = 'Eccentricity'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 66
        Width = 60
        WideText = 'Finishing'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 67
        Width = 70
        WideText = 'First Touch'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 68
        Width = 40
        WideText = 'Flair'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 69
        Width = 65
        WideText = 'Handling'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 70
        Width = 60
        WideText = 'Heading'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 71
        Width = 105
        WideText = 'Important Matches'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 72
        Width = 65
        WideText = 'Influence'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 73
        Width = 95
        WideText = 'Injury Proneness'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 74
        Width = 60
        WideText = 'Jumping'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 75
        Width = 55
        WideText = 'Kicking'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 76
        Width = 75
        WideText = 'Long Shots'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 77
        Width = 80
        WideText = 'Long Throws'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 78
        Width = 55
        WideText = 'Loyality'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 79
        Width = 55
        WideText = 'Marking'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 80
        Width = 90
        WideText = 'Natural Fitness'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 81
        Width = 75
        WideText = 'Off The Ball'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 82
        Width = 85
        WideText = 'One On Ones'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 83
        Width = 45
        WideText = 'Pace'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 84
        Width = 55
        WideText = 'Passing'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 85
        Width = 60
        WideText = 'Penalties'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 86
        Width = 70
        WideText = 'Positioning'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 87
        Width = 60
        WideText = 'Pressure'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 88
        Width = 90
        WideText = 'Professionalism'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 89
        Width = 60
        WideText = 'Reflexes'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 90
        Width = 80
        WideText = 'Rushing Out'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 91
        Width = 70
        WideText = 'Set Pieces'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 92
        Width = 90
        WideText = 'Sportsmanship'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 93
        Width = 55
        WideText = 'Stamina'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 94
        Width = 60
        WideText = 'Strength'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 95
        Width = 60
        WideText = 'Tackling'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 96
        Width = 70
        WideText = 'Teamwork'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 97
        Width = 70
        WideText = 'Technique'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 98
        Width = 85
        WideText = 'Temperament'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 99
        Width = 115
        WideText = 'Tendency To Punch'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 100
        Width = 65
        WideText = 'Throw Ins'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 101
        Width = 60
        WideText = 'Throwing'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 102
        Width = 60
        WideText = 'Versatility'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 103
        Width = 70
        WideText = 'Work Rate'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 104
        Width = 60
        WideText = 'Left Foot'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 105
        Width = 65
        WideText = 'Right Foot'
      end>
    WideDefaultText = 'No Name'
  end
  object tbToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 787
    Height = 25
    DisabledImages = ilDisabledMenu
    Flat = True
    Images = ilMenu
    Indent = 3
    TabOrder = 1
    object tbtnLoadGame: TToolButton
      Left = 3
      Top = 0
      Action = acLoadGame
    end
    object tbtnSave: TToolButton
      Left = 26
      Top = 0
      Action = acSave
    end
    object tbtnSeparator1: TToolButton
      Left = 49
      Top = 0
      Width = 8
      Caption = 'tbtnSeparator1'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object tbtnPlayerSearch: TToolButton
      Left = 57
      Top = 0
      Action = acPlayerSearch
    end
    object tbtnTeamSearch: TToolButton
      Left = 80
      Top = 0
      Action = acTeamSearch
    end
  end
  object sbStatusBar: TCMScoutStatusBar
    Left = 0
    Top = 351
    Width = 787
    Height = 19
    Position = 0
    PBVisible = False
  end
  object mmnuMenu: TMainMenu
    Images = ilMenu
    Left = 8
    Top = 56
    object mnuFile: TMenuItem
      Caption = '&File'
      object mnuLoadGame: TMenuItem
        Action = acLoadGame
      end
      object mnuLoadShortlist: TMenuItem
        Action = acLoadShortlist
      end
      object mnuSave: TMenuItem
        Action = acSave
      end
      object mnuLine1: TMenuItem
        Caption = '-'
      end
      object mnuOptions: TMenuItem
        Action = acOptions
      end
      object mnuLine2: TMenuItem
        Caption = '-'
      end
      object mnuExit: TMenuItem
        Action = acExit
      end
    end
    object mnuSearch: TMenuItem
      Caption = '&Search'
      object mnuPlayerSearch: TMenuItem
        Action = acPlayerSearch
      end
      object mnuTeamSearch: TMenuItem
        Action = acTeamSearch
      end
    end
    object mnuHelp: TMenuItem
      Caption = '&Help'
      object mnuAbout: TMenuItem
        Caption = '&About'
        OnClick = mnuAboutClick
      end
    end
  end
  object aclActions: TActionList
    Images = ilMenu
    Left = 40
    Top = 56
    object acLoadGame: TAction
      Category = 'File'
      Caption = '&Load Game'
      ImageIndex = 0
      ShortCut = 16460
      OnExecute = acLoadGameExecute
    end
    object acLoadShortlist: TAction
      Category = 'File'
      Caption = 'Load S&hortlist'
      Enabled = False
      Hint = 'Load Shortlist File'
      OnExecute = acLoadShortlistExecute
    end
    object acSave: TAction
      Category = 'File'
      Caption = '&Save'
      Enabled = False
      Hint = 'Save Search Result'
      ImageIndex = 3
      ShortCut = 16467
      OnExecute = acSaveExecute
    end
    object acOptions: TAction
      Category = 'File'
      Caption = '&Options'
      OnExecute = acOptionsExecute
    end
    object acExit: TAction
      Category = 'File'
      Caption = '&Exit'
      ShortCut = 32883
      OnExecute = acExitExecute
    end
    object acPlayerSearch: TAction
      Category = 'Search'
      Caption = '&Player Search'
      Enabled = False
      Hint = 'Search For A Player'
      ImageIndex = 1
      ShortCut = 16464
      OnExecute = acPlayerSearchExecute
    end
    object acTeamSearch: TAction
      Category = 'Search'
      Caption = '&Team Search'
      Enabled = False
      Hint = 'Search For A Team'
      ImageIndex = 2
      ShortCut = 16468
      OnExecute = acTeamSearchExecute
    end
  end
  object diaLoadGame: TOpenDialog
    Filter = 'CM4 Saved Games (*.cm4)|*.cm4'
    Title = 'Load Saved Game'
    Left = 72
    Top = 56
  end
  object ilMenu: TImageList
    Left = 104
    Top = 56
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
      0000000000000000000000000000000000000000205E205E205E205E205E205E
      205E205E205E205E205E205E205E000000000000893D574A0000000000000000
      0000000000000000000000000000000000000000893D574A0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000205E846A0E73507F2C7F2C7F2C7F
      2C7F2C7F2C7F2C7F2C7FA76E205E000000006D622376E951594A000000000000
      0000000000000000000000000000000000006D622376E951594A000000000000
      00000000000000000000000000000000000000000000121D121D764E764E764E
      764E764E764E764ED218121D000000000000205EE972A76A947F4D7F4D7F4D7F
      4D7F4D7F4D7F4D7F4D7FC76E5077205E0000C97ECA7E2476E951584A00000000
      000000000000000000000000000000000000C97ECA7E2476E951584A00000000
      0000000000000000000000000000000000000000121DBA3598317C6FB214B214
      9C739C737B733967910C1521121D00000000205E4E7F205EB57F6F7F6F7F6F7F
      6F7F6F7F6F7F6F7F6F7FC86ED57F205E00000000CA7ECA7E0372E951594A0000
      0000000000000000000000000000000000000000CA7ECA7E0372E951594A0000
      0000000000000000000000000000000000000000121D9A31782D9D73B214B214
      9C739C779B73396791101521121D00000000205E6F7F6362737B927F907F907F
      907F907F907F907F907FE96ED67F205E000000000000CA7EC97E2372E951574A
      00000000000000000000000000000000000000000000CA7EC97E2372E951574A
      0000000000000000000000000000000000000000121D9A31782D9D73B214B214
      7B6F9C779C735A6B710C1521121D00000000205E907FC86E0C73D57FB17FB17F
      B17FB17FB17FB17F010EE96ED67F2D73205E000000000000EA7EC97E046EAB39
      0000163E784A784A77460000000000000000000000000000EA7EC97E046EAB39
      0000163E784A784A774600000000000000000000121D9A31782D9D739D737C6F
      7C6F9B739C735A6BB2143625121D00000000205EB17F6E7B6462FF7FD97FD97F
      D97FD97FD97F010EE72E010EFB7FDA7F205E0000000000000000EA7E5677774A
      77467C63FF73FF73FF6F1B5B3642000000000000000000000000EA7E5677774A
      77467C63FF73FF73FF6F1B5B3642000000000000121D993199319931D939D939
      B8359831B9359931782D9931121D00000000205ED27FD27F4262205E205E205E
      205E205E010E6A3FAC4B0833010E205E205E000000000000000000000000994A
      BF5FFF6FFF6FFF6FFF73FF7F7D6F153E0000000000000000000000000000994A
      BF5FFF6FFF6FFF6FFF73FF7F7D6F153E00000000121D5629F83D7A4E9A529B52
      9B529A4E9A4EBA52BB569931121D00000000205ED37FD37FD37FD37FD37FD37F
      D37F010E28378B478B47AC4B0833010E0000000000000000000000000000984A
      7F57DF6BFF6FFF73FF7FFF7FFF7FB84E0000000000000000000000000000984A
      7F57DF6BFF6FFF73FF7FFF7FFF7FB84E00000000121D9931FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F9931121D00000000205EFF7FF47FF47FF47FF47FF47F
      010E010E010E010E8A432837010E010E010E00000000000000000000984A9F57
      1E4BDF67FF6FFF73FF7BFF7BFF779D67574600000000000000000000984A9F57
      1E4BDF67FF6FFF73FF7BFF7BFF779D6757460000121D9931FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F9931121D000000000000205EFF7FF47FF47FF47F205A
      C86EC86EC86E010E693FE62A010E0000000000000000000000000000984A9F57
      DD427E57FF6FFF6FFF73FF73FF73BE6B574600000000000000000000984A9F57
      DD427E57FF6FFF6FFF73FF73FF73BE6B57460000121D9931FF7F396739673967
      3967396739673967FF7F9931121D0000000000000000205E205E205E205E0000
      000000000000010E4833010E0000000000000000000000000000000057469F5B
      1E4B3E4B9F5FFF6FFF6FFF6FFF735C5F36420000000000000000000057469F5B
      1E4B3E4B9F5FFF6FFF6FFF6FFF735C5F36420000121D9931FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F9931121D000000000000000000000000000000000000
      00000000010EC522E526010E0000000000000000000000000000000000001B57
      FF737E5F3E4B5E53BF5FDF67FF6B564600000000000000000000000000001B57
      FF737E5F3E4B5E53BF5FDF67FF6B564600000000121D9931FF7F396739673967
      3967396739673967FF7F9931121D000000000000000000000000000000000000
      00000000010EC41E010E00000000000000000000000000000000000000003642
      7D6FFF7B7F531E475F4FBF5FDA4E574200000000000000000000000000003642
      7D6FFF7B7F531E475F4FBF5FDA4E574200000000121D9931FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F9931121D000000000000000000000000000000000000
      010E010E010E010E000000000000000000000000000000000000000000000000
      153EB94E9D5B7D5B3C5757425742000000000000000000000000000000000000
      153EB94E9D5B7D5B3C57574257420000000000000000121DFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F121D00000000000000000000000000000000010E010E
      010E010E00000000000000000000000000000000000000000000000000000000
      0000000057467746564600000000000000000000000000000000000000000000
      0000000057467746564600000000000000000000000000000000000000000000
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
      0000000000000000000000000000000080039FFF9FFFFFFF00030FFF0FFFC007
      000107FF07FF8003000183FF83FF80030001C1FFC1FF80030000E10FE10F8003
      0000F003F00380030000FC01FC01800300017C01DC01800300007800D8008003
      80037800D8008003C3C70800D8008003FF877401DC018003FF8F7401DC018003
      FE1F7603DE03C007F87F0F8F078FFFFF00000000000000000000000000000000
      000000000000}
  end
  object pmnuHeaders: TVTHeaderPopupMenu
    Options = []
    Left = 168
    Top = 56
  end
  object ilDisabledMenu: TImageList
    Left = 136
    Top = 56
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
      0000000000000000000000000000000000000000524A524A524A524A524A524A
      524A524A524A524A524A524A524A000000000000CE39F75E0000000000000000
      0000000000000000000000000000000000000000CE39F75E0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000524A734E18635A6B186318631863
      18631863186318631863B556524A00000000B556524A31461863000000000000
      000000000000000000000000000000000000B556524A31461863000000000000
      0000000000000000000000000000000000000000000031463146F75EF75EF75E
      F75EF75EF75EF75E10423146000000000000524AD65A94527B6F396739673967
      39673967396739673967B5563967524A0000F75EF75E734E3146186300000000
      000000000000000000000000000000000000F75EF75E734E3146186300000000
      00000000000000000000000000000000000000003146F75EB556BD7710421042
      DE7BBD77BD777B6FEF3D734E314600000000524A396731469C735A6B5A6B5A6B
      5A6B5A6B5A6B39673967B5569C73524A00000000F75EF75E524A314618630000
      0000000000000000000000000000000000000000F75EF75E524A314618630000
      00000000000000000000000000000000000000003146D65AB556DE7B10421042
      BD77DE7BBD777B6FEF3D734E314600000000524A5A6B524A7B6F7B6F5A6B5A6B
      5A6B5A6B5A6B5A6B5A6BB5569C73524A000000000000F75EF75E524A3146F75E
      00000000000000000000000000000000000000000000F75EF75E524A3146F75E
      00000000000000000000000000000000000000003146D65AB556DE7B10421042
      BD77BD77BD779C73EF3D734E314600000000524A5A6BB556F75E9C737B6F7B6F
      7B6F7B6F7B6F7B6F3146D65A9C731863524A000000000000F75EF75E524AEF3D
      0000524AB556B55694520000000000000000000000000000F75EF75E524AEF3D
      0000524AB556B5569452000000000000000000003146D65AB556DE7BDE7BBD77
      BD77BD77BD779C731042734E314600000000524A5A6B3967734EFF7FDE7BDE7B
      DE7BDE7BDE7B3146D65A3146FF7FDE7B524A0000000000000000F75E5A6BB556
      94525A6BDE7BDE7BBD771863734E000000000000000000000000F75E5A6BB556
      94525A6BDE7BDE7BBD771863734E0000000000003146D65AB556D65AF75ED65A
      D65AB556D65AD65AB556D65A314600000000524A7B6F7B6F524A314631463146
      31463146314618635A6BD65A31463146524A000000000000000000000000D65A
      7B6FBD77BD77BD77DE7BFF7F9C73524A0000000000000000000000000000D65A
      7B6FBD77BD77BD77DE7BFF7F9C73524A0000000031469452D65A39675A6B5A6B
      5A6B396739675A6B5A6BD65A314600000000524A7B6F7B6F7B6F7B6F7B6F7B6F
      7B6F3146F75E396739675A6BD65A31460000B55600000000000000000000B556
      5A6B9C73BD77DE7BFF7FFF7FFF7FD65A000000000000B556000000000000B556
      5A6B9C73BD77DE7BFF7FFF7FFF7FD65A000000003146D65AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FD65A314600000000524AFF7F9C739C739C739C739C73
      31463146314631463967F75E314631463146B5560000000000000000B5565A6B
      18639C73BD77DE7BFF7FFF7FDE7B7B6F945200000000B55600000000B5565A6B
      18639C73BD77DE7BFF7FFF7FDE7B7B6F945200003146D65AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FD65A3146000000000000524AFF7F9C739C739C73524A
      B556B556B55631461863B556314600000000B5560000000000000000B5565A6B
      D65A5A6BBD77BD77DE7BDE7BBD779C73945200000000B55600000000B5565A6B
      D65A5A6BBD77BD77DE7BDE7BBD779C73945200003146D65AFF7F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6FFF7FD65A31460000000000000000524A524A524A524A0000
      0000000000003146F75E3146000000000000B556B556B556B556000094527B6F
      186318637B6FBD77BD77BD77BD773967734E00000000B5560000000094527B6F
      186318637B6FBD77BD77BD77BD773967734E00003146D65AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FD65A3146000000000000000000000000000000000000
      000000003146B556B5563146000000000000B556000000000000B55600001863
      DE7B5A6B186339677B6F9C73BD77734E000000000000B5560000000000001863
      DE7B5A6B186339677B6F9C73BD77734E000000003146D65AFF7F7B6F7B6F7B6F
      7B6F7B6F7B6F7B6FFF7FD65A3146000000000000000000000000000000000000
      000000003146945231460000000000000000B556000000000000B5560000734E
      9C73FF7F3967186339677B6FD65A734E000000000000B556000000000000734E
      9C73FF7F3967186339677B6FD65A734E000000003146D65AFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FD65A3146000000000000000000000000000000000000
      314631463146314600000000000000000000B556000000000000B55600000000
      524AD65A5A6B5A6B3967734E734E0000000000000000B5560000000000000000
      524AD65A5A6B5A6B3967734E734E00000000000000003146FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F31460000000000000000000000000000000031463146
      314631460000000000000000000000000000B556B556B556B556000000000000
      0000000094529452734E0000000000000000B556B556B556B556B55600000000
      0000000094529452734E00000000000000000000000000000000000000000000
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
      0000000000000000000000000000000080039FFF9FFFFFFF00030FFF0FFFC007
      000107FF07FF8003000183FF83FF80030001C1FFC1FF80030000E10FE10F8003
      0000F003F00380030000FC01FC01800300017C01DC01800300007800D8008003
      80037800D8008003C3C70800D8008003FF877401DC018003FF8F7401DC018003
      FE1F7603DE03C007F87F0F8F078FFFFF00000000000000000000000000000000
      000000000000}
  end
  object diaSave: TSaveDialog
    DefaultExt = '.slf'
    Filter = 'CM4 Shortlist File (*.slf)|*.slf'
    Title = 'Save Search Result'
    Left = 200
    Top = 56
  end
end
