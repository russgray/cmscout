object FfrmPSearch: TFfrmPSearch
  Left = 192
  Top = 107
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Player Search'
  ClientHeight = 374
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FpcSearchOptions: TPageControl
    Left = 4
    Top = 4
    Width = 418
    Height = 337
    ActivePage = FtsGeneral
    TabIndex = 0
    TabOrder = 0
    object FtsGeneral: TTabSheet
      Caption = '&General'
      object FgbGeneral: TGroupBox
        Left = 4
        Top = 0
        Width = 209
        Height = 157
        Caption = 'G&eneral:'
        TabOrder = 0
        object FlblName: TLabel
          Left = 8
          Top = 20
          Width = 31
          Height = 13
          Caption = 'Name:'
          FocusControl = FedName
        end
        object FlblAge: TLabel
          Left = 8
          Top = 44
          Width = 22
          Height = 13
          Caption = 'Age:'
          FocusControl = FspeMinAge
        end
        object FlblNation: TLabel
          Left = 8
          Top = 69
          Width = 34
          Height = 13
          Caption = 'Nation:'
          FocusControl = FcmbNation
        end
        object FlblDivision: TLabel
          Left = 8
          Top = 133
          Width = 40
          Height = 13
          Caption = 'Division:'
          FocusControl = FcmbDivision
        end
        object FlblBased: TLabel
          Left = 8
          Top = 109
          Width = 33
          Height = 13
          Caption = 'Based:'
          FocusControl = FcmbBased
        end
        object FlblAgeLine: TLabel
          Left = 123
          Top = 44
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FedName: TEdit
          Left = 80
          Top = 16
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object FcbEUNational: TCheckBox
          Left = 6
          Top = 87
          Width = 87
          Height = 17
          Alignment = taLeftJustify
          Caption = 'EU National:'
          TabOrder = 4
        end
        object FspeMinAge: TSpinEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FcmbNation: TComboBox
          Left = 80
          Top = 65
          Width = 121
          Height = 21
          ItemHeight = 13
          Sorted = True
          TabOrder = 3
        end
        object FcmbBased: TComboBox
          Left = 80
          Top = 105
          Width = 121
          Height = 21
          ItemHeight = 13
          Sorted = True
          TabOrder = 5
        end
        object FcmbDivision: TComboBox
          Left = 80
          Top = 129
          Width = 121
          Height = 21
          ItemHeight = 13
          Sorted = True
          TabOrder = 6
        end
        object FspeMaxAge: TSpinEdit
          Left = 129
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = FspeKeyDown
        end
      end
      object FgbPositions: TGroupBox
        Left = 4
        Top = 160
        Width = 209
        Height = 145
        Caption = '&Positions'
        TabOrder = 1
        object FcbGoalkeeper: TCheckBox
          Left = 16
          Top = 18
          Width = 90
          Height = 17
          Caption = 'Goalkeeper'
          TabOrder = 0
        end
        object FcbDefender: TCheckBox
          Left = 16
          Top = 34
          Width = 90
          Height = 17
          Caption = 'Defender'
          TabOrder = 1
        end
        object FcbDefensiveMidfielder: TCheckBox
          Left = 16
          Top = 106
          Width = 90
          Height = 17
          Caption = 'Def. Midfielder'
          TabOrder = 5
        end
        object FcbMidfielder: TCheckBox
          Left = 16
          Top = 50
          Width = 90
          Height = 17
          Caption = 'Midfielder'
          TabOrder = 2
        end
        object FcbAttackingMidfielder: TCheckBox
          Left = 16
          Top = 122
          Width = 90
          Height = 17
          Caption = 'Att. Midfielder'
          TabOrder = 6
        end
        object FcbAttacker: TCheckBox
          Left = 16
          Top = 66
          Width = 90
          Height = 17
          Caption = 'Attacker'
          TabOrder = 3
        end
        object FcbSweeper: TCheckBox
          Left = 16
          Top = 90
          Width = 90
          Height = 17
          Caption = 'Sweeper'
          TabOrder = 4
        end
        object FcbLeftSide: TCheckBox
          Left = 117
          Top = 26
          Width = 65
          Height = 17
          Caption = 'Left Side'
          TabOrder = 7
        end
        object FcbFreeRole: TCheckBox
          Left = 117
          Top = 114
          Width = 76
          Height = 17
          Caption = 'Free Role'
          TabOrder = 11
        end
        object FcbCentral: TCheckBox
          Left = 117
          Top = 42
          Width = 56
          Height = 17
          Caption = 'Central'
          TabOrder = 8
        end
        object FcbRightSide: TCheckBox
          Left = 117
          Top = 58
          Width = 73
          Height = 17
          Caption = 'Right Side'
          TabOrder = 9
        end
        object FcbWingBack: TCheckBox
          Left = 117
          Top = 98
          Width = 76
          Height = 17
          Caption = 'Wing Back'
          TabOrder = 10
        end
      end
      object FgbAbility: TGroupBox
        Left = 220
        Top = 0
        Width = 185
        Height = 94
        Caption = '&Ability:'
        TabOrder = 2
        object FlblAbility: TLabel
          Left = 8
          Top = 20
          Width = 30
          Height = 13
          Caption = 'Ability:'
          FocusControl = FspeAbilityMin
        end
        object FlblPotentialAbility: TLabel
          Left = 8
          Top = 44
          Width = 74
          Height = 13
          Caption = 'Potential Ability:'
          FocusControl = FspePotentialAbilityMin
        end
        object FlblScoutRating: TLabel
          Left = 8
          Top = 68
          Width = 65
          Height = 13
          Caption = 'Scout Rating:'
          FocusControl = FspeScoutRatingMin
        end
        object FlblAbilityLine: TLabel
          Left = 131
          Top = 20
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FlblPotentialAbilityLine: TLabel
          Left = 131
          Top = 44
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FlblScoutRatingLine: TLabel
          Left = 131
          Top = 68
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FspeAbilityMin: TSpinEdit
          Left = 88
          Top = 16
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspePotentialAbilityMin: TSpinEdit
          Left = 88
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeScoutRatingMin: TSpinEdit
          Left = 88
          Top = 64
          Width = 41
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeAbilityMax: TSpinEdit
          Left = 137
          Top = 16
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 1
          Value = 200
          OnKeyDown = FspeKeyDown
        end
        object FspePotentialAbilityMax: TSpinEdit
          Left = 137
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 3
          Value = 200
          OnKeyDown = FspeKeyDown
        end
        object FspeScoutRatingMax: TSpinEdit
          Left = 137
          Top = 64
          Width = 41
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnKeyDown = FspeKeyDown
        end
      end
      object FgbReputation: TGroupBox
        Left = 220
        Top = 96
        Width = 185
        Height = 209
        Caption = '&Reputation:'
        TabOrder = 3
        object FlblHomeReputation: TLabel
          Left = 8
          Top = 18
          Width = 86
          Height = 13
          Caption = 'Home Reputation:'
          FocusControl = FspeHomeReputationMin
        end
        object FlblHomeReputationLine: TLabel
          Left = 91
          Top = 38
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FlblCurrentReputation: TLabel
          Left = 8
          Top = 66
          Width = 92
          Height = 13
          Caption = 'Current Reputation:'
          FocusControl = FspeCurrentReputationMin
        end
        object FlblCurrentReputationLine: TLabel
          Left = 91
          Top = 86
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FlblWorldReputation: TLabel
          Left = 8
          Top = 114
          Width = 86
          Height = 13
          Caption = 'World Reputation:'
          FocusControl = FspeWorldReputationMin
        end
        object FlblWorldReputationLine: TLabel
          Left = 91
          Top = 134
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FlblClubReputation: TLabel
          Left = 8
          Top = 162
          Width = 79
          Height = 13
          Caption = 'Club Reputation:'
          FocusControl = FspeClubReputationMin
        end
        object FlblClubReputationLine: TLabel
          Left = 91
          Top = 182
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FspeHomeReputationMin: TSpinEdit
          Left = 8
          Top = 34
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeHomeReputationMax: TSpinEdit
          Left = 97
          Top = 34
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 1
          Value = 10000
          OnKeyDown = FspeKeyDown
        end
        object FspeCurrentReputationMin: TSpinEdit
          Left = 8
          Top = 82
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeCurrentReputationMax: TSpinEdit
          Left = 96
          Top = 82
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 3
          Value = 10000
          OnKeyDown = FspeKeyDown
        end
        object FspeWorldReputationMin: TSpinEdit
          Left = 8
          Top = 130
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeWorldReputationMax: TSpinEdit
          Left = 96
          Top = 130
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 5
          Value = 10000
          OnKeyDown = FspeKeyDown
        end
        object FspeClubReputationMin: TSpinEdit
          Left = 8
          Top = 178
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeClubReputationMax: TSpinEdit
          Left = 96
          Top = 178
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 7
          Value = 10000
          OnKeyDown = FspeKeyDown
        end
      end
    end
    object FtsContract: TTabSheet
      Caption = '&Contract'
      ImageIndex = 2
      object FgbContract: TGroupBox
        Left = 4
        Top = 20
        Width = 197
        Height = 75
        Caption = 'C&ontract:'
        TabOrder = 0
        object FlblContract: TLabel
          Left = 8
          Top = 20
          Width = 43
          Height = 13
          Caption = 'Contract:'
          FocusControl = FcmbContract
        end
        object FcmbContract: TComboBox
          Left = 72
          Top = 16
          Width = 118
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Free Transfer'
            'Expired'
            'Expiring'
            'Unprotected')
        end
        object FcbBosman: TCheckBox
          Left = 8
          Top = 38
          Width = 164
          Height = 17
          Caption = 'Leaving On Bosman Ruling'
          TabOrder = 1
        end
        object FcbTransferArranged: TCheckBox
          Left = 8
          Top = 54
          Width = 145
          Height = 17
          Caption = 'Not Transfer Arranged'
          TabOrder = 2
        end
      end
      object FgbStatus: TGroupBox
        Left = 208
        Top = 24
        Width = 197
        Height = 118
        Caption = '&Status:'
        TabOrder = 2
        object FlblTransferStatus: TLabel
          Left = 8
          Top = 20
          Width = 75
          Height = 13
          Caption = 'Transfer Status:'
          FocusControl = FcmbTransferStatus
        end
        object FlblSquadStatus: TLabel
          Left = 8
          Top = 68
          Width = 67
          Height = 13
          Caption = 'Squad Status:'
          FocusControl = FcmbSquadStatus
        end
        object FcmbTransferStatus: TComboBox
          Left = 8
          Top = 38
          Width = 181
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Transfer Listed By Club'
            'Transfer Listed By Request'
            'Listed For Loan')
        end
        object FcmbSquadStatus: TComboBox
          Left = 8
          Top = 88
          Width = 177
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            'Uncertain'
            'Indispensable To The Club'
            'Important First Team Player'
            'Used In A Squad Rotation System'
            'Backup For The First Team'
            'Hot Prospect For The Future'
            'Decent Young Player'
            'Not Needed By The Club'
            'On Trial')
        end
      end
      object FgbReleaseClauses: TGroupBox
        Left = 4
        Top = 104
        Width = 197
        Height = 182
        Caption = '&Release Clauses:'
        TabOrder = 1
        object FlblReleaseFee: TLabel
          Left = 8
          Top = 136
          Width = 60
          Height = 13
          Caption = 'Release Fee'
          FocusControl = FspeMinReleaseFee
        end
        object FlblReleaseFeeLine: TLabel
          Left = 97
          Top = 156
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FcbNonPromotion: TCheckBox
          Left = 8
          Top = 16
          Width = 161
          Height = 17
          Caption = 'Non Promotion Release'
          TabOrder = 0
        end
        object FcbNonPromotionActive: TCheckBox
          Left = 24
          Top = 32
          Width = 97
          Height = 17
          Caption = 'Active'
          TabOrder = 1
        end
        object FcbRelegation: TCheckBox
          Left = 8
          Top = 48
          Width = 137
          Height = 17
          Caption = 'Relegation Release'
          TabOrder = 2
        end
        object FcbRelegationActive: TCheckBox
          Left = 24
          Top = 64
          Width = 97
          Height = 17
          Caption = 'Active'
          TabOrder = 3
        end
        object FcbNonPlaying: TCheckBox
          Left = 8
          Top = 80
          Width = 161
          Height = 17
          Caption = 'Non Playing Release'
          TabOrder = 4
        end
        object FcbNonPlayingActive: TCheckBox
          Left = 24
          Top = 96
          Width = 97
          Height = 17
          Caption = 'Active'
          TabOrder = 5
        end
        object FcbMinimumFee: TCheckBox
          Left = 8
          Top = 112
          Width = 137
          Height = 17
          Caption = 'Minimum Fee Release'
          TabOrder = 6
        end
        object FspeMinReleaseFee: TSpinEdit
          Left = 8
          Top = 152
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeMaxReleaseFee: TSpinEdit
          Left = 102
          Top = 152
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnKeyDown = FspeKeyDown
        end
      end
      object FgbContractDetails: TGroupBox
        Left = 208
        Top = 153
        Width = 197
        Height = 129
        Caption = 'Contract &Details'
        TabOrder = 3
        object FlblContractType: TLabel
          Left = 8
          Top = 20
          Width = 70
          Height = 13
          Caption = 'Contract Type:'
          FocusControl = FcmbContractType
        end
        object FlblValue: TLabel
          Left = 8
          Top = 40
          Width = 27
          Height = 13
          Caption = 'Value'
          FocusControl = FspeMinValue
        end
        object FlblWage: TLabel
          Left = 8
          Top = 84
          Width = 29
          Height = 13
          Caption = 'Wage'
          FocusControl = FspeMinWage
        end
        object FlblValueLine: TLabel
          Left = 97
          Top = 60
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FlblWageLine: TLabel
          Left = 97
          Top = 104
          Width = 3
          Height = 13
          Caption = '-'
        end
        object FcmbContractType: TComboBox
          Left = 84
          Top = 16
          Width = 106
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Part Time Monthly Contract'
            'Part Time Contract'
            'Part Time Trial Contract'
            'Part Time Loan Contract'
            'Full Time Monthly Contract'
            'Full Time Contract'
            'Full Time Trial Contract'
            'Full Time Loan Contract')
        end
        object FspeMinValue: TSpinEdit
          Left = 8
          Top = 56
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeMaxValue: TSpinEdit
          Left = 102
          Top = 56
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeMinWage: TSpinEdit
          Left = 8
          Top = 100
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnKeyDown = FspeKeyDown
        end
        object FspeMaxWage: TSpinEdit
          Left = 102
          Top = 100
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnKeyDown = FspeKeyDown
        end
      end
    end
    object FtsAttributes1: TTabSheet
      Caption = 'Attributes &1'
      ImageIndex = 1
      object FlblAcceleration: TLabel
        Left = 8
        Top = 12
        Width = 62
        Height = 13
        Caption = 'Acceleration:'
      end
      object FlblAccelerationLine: TLabel
        Left = 160
        Top = 12
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblDecisions: TLabel
        Left = 209
        Top = 12
        Width = 49
        Height = 13
        Caption = 'Decisions:'
      end
      object FlblDecisionsLine: TLabel
        Left = 361
        Top = 12
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblAdaptability: TLabel
        Left = 8
        Top = 36
        Width = 57
        Height = 13
        Caption = 'Adaptability:'
      end
      object FlblAdaptabilityLine: TLabel
        Left = 160
        Top = 36
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblDetermination: TLabel
        Left = 209
        Top = 36
        Width = 68
        Height = 13
        Caption = 'Determination:'
      end
      object FlblDeterminationLine: TLabel
        Left = 361
        Top = 36
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblAggression: TLabel
        Left = 8
        Top = 60
        Width = 55
        Height = 13
        Caption = 'Aggression:'
      end
      object FlblAggressionLine: TLabel
        Left = 160
        Top = 60
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblDirtiness: TLabel
        Left = 209
        Top = 60
        Width = 43
        Height = 13
        Caption = 'Dirtiness:'
      end
      object FlblDirtinessLine: TLabel
        Left = 361
        Top = 60
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblAgility: TLabel
        Left = 8
        Top = 84
        Width = 30
        Height = 13
        Caption = 'Agility:'
      end
      object FlblAgilityLine: TLabel
        Left = 160
        Top = 84
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblDribbling: TLabel
        Left = 209
        Top = 84
        Width = 44
        Height = 13
        Caption = 'Dribbling:'
      end
      object FlblDribblingLine: TLabel
        Left = 361
        Top = 84
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblAmbition: TLabel
        Left = 8
        Top = 108
        Width = 43
        Height = 13
        Caption = 'Ambition:'
      end
      object FlblAmbitionLine: TLabel
        Left = 160
        Top = 108
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblFinishing: TLabel
        Left = 209
        Top = 108
        Width = 44
        Height = 13
        Caption = 'Finishing:'
      end
      object FlblFinishingLine: TLabel
        Left = 361
        Top = 108
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblAnticipation: TLabel
        Left = 8
        Top = 132
        Width = 58
        Height = 13
        Caption = 'Anticipation:'
      end
      object FlblAnticipationLine: TLabel
        Left = 160
        Top = 132
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblFlair: TLabel
        Left = 209
        Top = 132
        Width = 22
        Height = 13
        Caption = 'Flair:'
      end
      object FlblFlairLine: TLabel
        Left = 361
        Top = 132
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblBalance: TLabel
        Left = 8
        Top = 156
        Width = 42
        Height = 13
        Caption = 'Balance:'
      end
      object FlblBalanceLine: TLabel
        Left = 160
        Top = 156
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblHandling: TLabel
        Left = 209
        Top = 156
        Width = 45
        Height = 13
        Caption = 'Handling:'
      end
      object FlblHandlingLine: TLabel
        Left = 361
        Top = 156
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblBravery: TLabel
        Left = 8
        Top = 180
        Width = 39
        Height = 13
        Caption = 'Bravery:'
      end
      object FlblBraveryLine: TLabel
        Left = 160
        Top = 180
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblConsistency: TLabel
        Left = 8
        Top = 204
        Width = 60
        Height = 13
        Caption = 'Consistency:'
      end
      object FlblConsistencyLine: TLabel
        Left = 160
        Top = 204
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblCorners: TLabel
        Left = 8
        Top = 228
        Width = 39
        Height = 13
        Caption = 'Corners:'
      end
      object FlblCornersLine: TLabel
        Left = 160
        Top = 228
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblVision: TLabel
        Left = 8
        Top = 252
        Width = 46
        Height = 13
        Caption = 'Creativity:'
      end
      object FlblVisionLine: TLabel
        Left = 160
        Top = 252
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblCrossing: TLabel
        Left = 8
        Top = 276
        Width = 43
        Height = 13
        Caption = 'Crossing:'
      end
      object FlblCrossingLine: TLabel
        Left = 160
        Top = 276
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblHeading: TLabel
        Left = 209
        Top = 180
        Width = 43
        Height = 13
        Caption = 'Heading:'
      end
      object FlblHeadingLine: TLabel
        Left = 361
        Top = 180
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblLeadership: TLabel
        Left = 209
        Top = 204
        Width = 47
        Height = 13
        Caption = 'Influence:'
      end
      object FlblLeadershipLine: TLabel
        Left = 361
        Top = 204
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblImportantMatches: TLabel
        Left = 209
        Top = 228
        Width = 91
        Height = 13
        Caption = 'Important Matches:'
      end
      object FlblImportantMatchesLine: TLabel
        Left = 361
        Top = 228
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblInjuryProneness: TLabel
        Left = 209
        Top = 252
        Width = 81
        Height = 13
        Caption = 'Injury Proneness:'
      end
      object FlblInjuryPronenessLine: TLabel
        Left = 361
        Top = 252
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblJumping: TLabel
        Left = 209
        Top = 276
        Width = 42
        Height = 13
        Caption = 'Jumping:'
      end
      object FlblJumpingLine: TLabel
        Left = 361
        Top = 276
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FspeMinAcceleration: TSpinEdit
        Left = 123
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxAcceleration: TSpinEdit
        Left = 166
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 1
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinDecisions: TSpinEdit
        Left = 324
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 24
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxDecisions: TSpinEdit
        Left = 367
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 25
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinAdaptability: TSpinEdit
        Left = 123
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxAdaptability: TSpinEdit
        Left = 166
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 3
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinDetermination: TSpinEdit
        Left = 324
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 26
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxDetermination: TSpinEdit
        Left = 367
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 27
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinAggression: TSpinEdit
        Left = 123
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxAggression: TSpinEdit
        Left = 166
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 5
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinDirtiness: TSpinEdit
        Left = 324
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 28
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxDirtiness: TSpinEdit
        Left = 367
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 29
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinAgility: TSpinEdit
        Left = 123
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxAgility: TSpinEdit
        Left = 166
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 7
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinDribbling: TSpinEdit
        Left = 324
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 30
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxDribbling: TSpinEdit
        Left = 367
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 31
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinAmbition: TSpinEdit
        Left = 123
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxAmbition: TSpinEdit
        Left = 166
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 9
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinFinishing: TSpinEdit
        Left = 324
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 32
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxFinishing: TSpinEdit
        Left = 367
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 33
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinAnticipation: TSpinEdit
        Left = 123
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxAnticipation: TSpinEdit
        Left = 166
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 11
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinFlair: TSpinEdit
        Left = 324
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 34
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxFlair: TSpinEdit
        Left = 367
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 35
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinBalance: TSpinEdit
        Left = 123
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 12
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxBalance: TSpinEdit
        Left = 166
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 13
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinHandling: TSpinEdit
        Left = 324
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 36
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxHandling: TSpinEdit
        Left = 367
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 37
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinBravery: TSpinEdit
        Left = 123
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 14
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxBravery: TSpinEdit
        Left = 166
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 15
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinConsistency: TSpinEdit
        Left = 123
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 16
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxConsistency: TSpinEdit
        Left = 166
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 17
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinCorners: TSpinEdit
        Left = 123
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 18
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxCorners: TSpinEdit
        Left = 166
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 19
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinVision: TSpinEdit
        Left = 123
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 20
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxVision: TSpinEdit
        Left = 166
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 21
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinCrossing: TSpinEdit
        Left = 123
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 22
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxCrossing: TSpinEdit
        Left = 166
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 23
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinHeading: TSpinEdit
        Left = 324
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 38
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxHeading: TSpinEdit
        Left = 367
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 39
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinLeadership: TSpinEdit
        Left = 324
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 40
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxLeadership: TSpinEdit
        Left = 367
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 41
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinImportantMatches: TSpinEdit
        Left = 324
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 42
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxImportantMatches: TSpinEdit
        Left = 367
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 43
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinInjuryProneness: TSpinEdit
        Left = 324
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 44
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxInjuryProneness: TSpinEdit
        Left = 367
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 45
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxJumping: TSpinEdit
        Left = 367
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 46
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinJumping: TSpinEdit
        Left = 324
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 47
        Value = 0
        OnKeyDown = FspeKeyDown
      end
    end
    object FtsAttributes2: TTabSheet
      Caption = 'Attributes &2'
      ImageIndex = 3
      object FlblLongShots: TLabel
        Left = 8
        Top = 12
        Width = 57
        Height = 13
        Caption = 'Long Shots:'
      end
      object FlblLongShotsLine: TLabel
        Left = 160
        Top = 12
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblLoyality: TLabel
        Left = 8
        Top = 36
        Width = 38
        Height = 13
        Caption = 'Loyality:'
      end
      object FlblLoyalityLine: TLabel
        Left = 160
        Top = 36
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblMarking: TLabel
        Left = 8
        Top = 60
        Width = 41
        Height = 13
        Caption = 'Marking:'
      end
      object FlblMarkingLine: TLabel
        Left = 160
        Top = 60
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblNaturalFitness: TLabel
        Left = 8
        Top = 84
        Width = 73
        Height = 13
        Caption = 'Natural Fitness:'
      end
      object FlblNaturalFitnessLine: TLabel
        Left = 160
        Top = 84
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblMovement: TLabel
        Left = 8
        Top = 108
        Width = 59
        Height = 13
        Caption = 'Off The Ball:'
      end
      object FlblMovementLine: TLabel
        Left = 160
        Top = 108
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblOneOnOnes: TLabel
        Left = 8
        Top = 132
        Width = 68
        Height = 13
        Caption = 'One On Ones:'
      end
      object FlblOneOnOnesLine: TLabel
        Left = 160
        Top = 132
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblPlayerPace: TLabel
        Left = 8
        Top = 156
        Width = 28
        Height = 13
        Caption = 'Pace:'
      end
      object FlblPlayerPaceLine: TLabel
        Left = 160
        Top = 156
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblPassing: TLabel
        Left = 8
        Top = 180
        Width = 40
        Height = 13
        Caption = 'Passing:'
      end
      object FlblPassingLine: TLabel
        Left = 160
        Top = 180
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblPenalties: TLabel
        Left = 8
        Top = 204
        Width = 46
        Height = 13
        Caption = 'Penalties:'
      end
      object FlblPenaltiesLine: TLabel
        Left = 160
        Top = 204
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblPositioning: TLabel
        Left = 8
        Top = 228
        Width = 54
        Height = 13
        Caption = 'Positioning:'
      end
      object FlblPositioningLine: TLabel
        Left = 160
        Top = 228
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblPressure: TLabel
        Left = 8
        Top = 252
        Width = 44
        Height = 13
        Caption = 'Pressure:'
      end
      object FlblPressureLine: TLabel
        Left = 160
        Top = 252
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblProfessionalism: TLabel
        Left = 8
        Top = 276
        Width = 75
        Height = 13
        Caption = 'Professionalism:'
      end
      object FlblProfessionalismLine: TLabel
        Left = 160
        Top = 276
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblReflexes: TLabel
        Left = 209
        Top = 12
        Width = 44
        Height = 13
        Caption = 'Reflexes:'
      end
      object FlblReflexesLine: TLabel
        Left = 361
        Top = 12
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblFreeKicks: TLabel
        Left = 209
        Top = 36
        Width = 54
        Height = 13
        Caption = 'Set Pieces:'
      end
      object FlblFreeKicksLine: TLabel
        Left = 361
        Top = 36
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblSportsmanship: TLabel
        Left = 209
        Top = 60
        Width = 72
        Height = 13
        Caption = 'Sportsmanship:'
      end
      object FlblSportsmanshipLine: TLabel
        Left = 361
        Top = 60
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblStamina: TLabel
        Left = 209
        Top = 84
        Width = 41
        Height = 13
        Caption = 'Stamina:'
      end
      object FlblStaminaLine: TLabel
        Left = 361
        Top = 84
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblStrength: TLabel
        Left = 209
        Top = 108
        Width = 43
        Height = 13
        Caption = 'Strength:'
      end
      object FlblStrengthLine: TLabel
        Left = 361
        Top = 108
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblTackling: TLabel
        Left = 209
        Top = 132
        Width = 44
        Height = 13
        Caption = 'Tackling:'
      end
      object FlblTacklingLine: TLabel
        Left = 361
        Top = 132
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblTeamwork: TLabel
        Left = 209
        Top = 156
        Width = 53
        Height = 13
        Caption = 'Teamwork:'
      end
      object FlblTeamworkLine: TLabel
        Left = 361
        Top = 156
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblTechnique: TLabel
        Left = 209
        Top = 180
        Width = 54
        Height = 13
        Caption = 'Technique:'
      end
      object FlblTechniqueLine: TLabel
        Left = 361
        Top = 180
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblTemperament: TLabel
        Left = 209
        Top = 204
        Width = 68
        Height = 13
        Caption = 'Temperament:'
      end
      object FlblTemperamentLine: TLabel
        Left = 361
        Top = 204
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblThrowIns: TLabel
        Left = 209
        Top = 228
        Width = 50
        Height = 13
        Caption = 'Throw Ins:'
      end
      object FlblThrowInsLine: TLabel
        Left = 361
        Top = 228
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblVersatility: TLabel
        Left = 209
        Top = 252
        Width = 47
        Height = 13
        Caption = 'Versatility:'
      end
      object FlblVersatilityLine: TLabel
        Left = 361
        Top = 252
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FlblWorkRate: TLabel
        Left = 209
        Top = 276
        Width = 55
        Height = 13
        Caption = 'Work Rate:'
      end
      object FlblWorkRateLine: TLabel
        Left = 361
        Top = 276
        Width = 3
        Height = 13
        Caption = '-'
      end
      object FspeMinLongShots: TSpinEdit
        Left = 123
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxLongShots: TSpinEdit
        Left = 166
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 1
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinLoyality: TSpinEdit
        Left = 123
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxLoyality: TSpinEdit
        Left = 166
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 3
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinMarking: TSpinEdit
        Left = 123
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxMarking: TSpinEdit
        Left = 166
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 5
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinNaturalFitness: TSpinEdit
        Left = 123
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxNaturalFitness: TSpinEdit
        Left = 166
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 7
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinMovement: TSpinEdit
        Left = 123
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxMovement: TSpinEdit
        Left = 166
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 9
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinOneOnOnes: TSpinEdit
        Left = 123
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxOneOnOnes: TSpinEdit
        Left = 166
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 11
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinPlayerPace: TSpinEdit
        Left = 123
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 12
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxPlayerPace: TSpinEdit
        Left = 166
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 13
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinPassing: TSpinEdit
        Left = 123
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 14
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxPassing: TSpinEdit
        Left = 166
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 15
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinPenalties: TSpinEdit
        Left = 123
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 16
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxPenalties: TSpinEdit
        Left = 166
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 17
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinPositioning: TSpinEdit
        Left = 123
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 18
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxPositioning: TSpinEdit
        Left = 166
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 19
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinPressure: TSpinEdit
        Left = 123
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 20
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxPressure: TSpinEdit
        Left = 166
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 21
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinProfessionalism: TSpinEdit
        Left = 123
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 22
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxProfessionalism: TSpinEdit
        Left = 166
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 23
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinReflexes: TSpinEdit
        Left = 324
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 24
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxReflexes: TSpinEdit
        Left = 367
        Top = 8
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 25
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinFreeKicks: TSpinEdit
        Left = 324
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 26
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxFreeKicks: TSpinEdit
        Left = 367
        Top = 32
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 27
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinSportsmanship: TSpinEdit
        Left = 324
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 28
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxSportsmanship: TSpinEdit
        Left = 367
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 29
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinStamina: TSpinEdit
        Left = 324
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 30
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxStamina: TSpinEdit
        Left = 367
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 31
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinStrength: TSpinEdit
        Left = 324
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 32
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxStrength: TSpinEdit
        Left = 367
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 33
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinTackling: TSpinEdit
        Left = 324
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 34
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxTackling: TSpinEdit
        Left = 367
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 35
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinTeamwork: TSpinEdit
        Left = 324
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 36
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxTeamwork: TSpinEdit
        Left = 367
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 37
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinTechnique: TSpinEdit
        Left = 324
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 38
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxTechnique: TSpinEdit
        Left = 367
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 39
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinTemperament: TSpinEdit
        Left = 324
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 40
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxTemperament: TSpinEdit
        Left = 367
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 41
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinThrowIns: TSpinEdit
        Left = 324
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 42
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxThrowIns: TSpinEdit
        Left = 367
        Top = 224
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 43
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinVersatility: TSpinEdit
        Left = 324
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 44
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxVersatility: TSpinEdit
        Left = 367
        Top = 248
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 45
        Value = 20
        OnKeyDown = FspeKeyDown
      end
      object FspeMinWorkRate: TSpinEdit
        Left = 324
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 46
        Value = 0
        OnKeyDown = FspeKeyDown
      end
      object FspeMaxWorkRate: TSpinEdit
        Left = 367
        Top = 272
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 47
        Value = 20
        OnKeyDown = FspeKeyDown
      end
    end
  end
  object FbtnOK: TButton
    Left = 189
    Top = 345
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object FbtnCancel: TButton
    Left = 268
    Top = 345
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object FbtnReset: TButton
    Left = 347
    Top = 345
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 3
    OnClick = FbtnResetClick
  end
end
