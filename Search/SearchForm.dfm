object frmSearch: TfrmSearch
  Left = 192
  Top = 114
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Player Search'
  ClientHeight = 423
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pcSearchOptions: TPageControl
    Left = 4
    Top = 4
    Width = 418
    Height = 386
    ActivePage = tsGeneral
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = '&General'
      object gbGeneral: TGroupBox
        Left = 4
        Top = 0
        Width = 209
        Height = 207
        Caption = 'G&eneral:'
        TabOrder = 0
        object lblName: TLabel
          Left = 8
          Top = 20
          Width = 31
          Height = 13
          Caption = 'Name:'
          FocusControl = edName
        end
        object lblAge: TLabel
          Left = 8
          Top = 44
          Width = 22
          Height = 13
          Caption = 'Age:'
          FocusControl = speMinAge
        end
        object lblNation: TLabel
          Left = 8
          Top = 69
          Width = 34
          Height = 13
          Caption = 'Nation:'
          FocusControl = cmbNation
        end
        object lblDivision: TLabel
          Left = 8
          Top = 183
          Width = 40
          Height = 13
          Caption = 'Division:'
          FocusControl = cmbDivision
        end
        object lblBased: TLabel
          Left = 8
          Top = 159
          Width = 33
          Height = 13
          Caption = 'Based:'
          FocusControl = cmbBased
        end
        object lblAgeLine: TLabel
          Left = 123
          Top = 44
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblCaps: TLabel
          Left = 8
          Top = 109
          Width = 27
          Height = 13
          Caption = 'Caps:'
          FocusControl = speMinCaps
        end
        object lblCapsLine: TLabel
          Left = 123
          Top = 109
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblIntGoals: TLabel
          Left = 8
          Top = 134
          Width = 48
          Height = 13
          Caption = 'Int. Goals:'
          FocusControl = speMinIntGoals
        end
        object lblIntGoalsLine: TLabel
          Left = 123
          Top = 134
          Width = 3
          Height = 13
          Caption = '-'
        end
        object edName: TEdit
          Left = 80
          Top = 16
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object cbEUNational: TCheckBox
          Left = 6
          Top = 87
          Width = 87
          Height = 17
          Alignment = taLeftJustify
          Caption = 'EU National:'
          TabOrder = 4
        end
        object speMinAge: TSpinEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnKeyDown = speKeyDown
        end
        object cmbNation: TComboBox
          Left = 80
          Top = 65
          Width = 121
          Height = 21
          ItemHeight = 13
          Sorted = True
          TabOrder = 3
        end
        object cmbBased: TComboBox
          Left = 80
          Top = 155
          Width = 121
          Height = 21
          ItemHeight = 13
          Sorted = True
          TabOrder = 9
        end
        object cmbDivision: TComboBox
          Left = 80
          Top = 179
          Width = 121
          Height = 21
          ItemHeight = 13
          Sorted = True
          TabOrder = 10
        end
        object speMaxAge: TSpinEdit
          Left = 129
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMinCaps: TSpinEdit
          Left = 80
          Top = 105
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMaxCaps: TSpinEdit
          Left = 129
          Top = 105
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMinIntGoals: TSpinEdit
          Left = 80
          Top = 130
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMaxIntGoals: TSpinEdit
          Left = 129
          Top = 130
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnKeyDown = speKeyDown
        end
      end
      object gbPositions: TGroupBox
        Left = 4
        Top = 210
        Width = 209
        Height = 145
        Caption = '&Positions'
        TabOrder = 1
        object cbGoalkeeper: TCheckBox
          Left = 16
          Top = 18
          Width = 90
          Height = 17
          Caption = 'Goalkeeper'
          TabOrder = 0
        end
        object cbDefender: TCheckBox
          Left = 16
          Top = 34
          Width = 90
          Height = 17
          Caption = 'Defender'
          TabOrder = 1
        end
        object cbDefensiveMidfielder: TCheckBox
          Left = 16
          Top = 106
          Width = 90
          Height = 17
          Caption = 'Def. Midfielder'
          TabOrder = 5
        end
        object cbMidfielder: TCheckBox
          Left = 16
          Top = 50
          Width = 90
          Height = 17
          Caption = 'Midfielder'
          TabOrder = 2
        end
        object cbAttackingMidfielder: TCheckBox
          Left = 16
          Top = 122
          Width = 90
          Height = 17
          Caption = 'Att. Midfielder'
          TabOrder = 6
        end
        object cbAttacker: TCheckBox
          Left = 16
          Top = 66
          Width = 90
          Height = 17
          Caption = 'Attacker'
          TabOrder = 3
        end
        object cbSweeper: TCheckBox
          Left = 16
          Top = 90
          Width = 90
          Height = 17
          Caption = 'Sweeper'
          TabOrder = 4
        end
        object cbLeftSide: TCheckBox
          Left = 117
          Top = 26
          Width = 65
          Height = 17
          Caption = 'Left Side'
          TabOrder = 7
        end
        object cbFreeRole: TCheckBox
          Left = 117
          Top = 114
          Width = 76
          Height = 17
          Caption = 'Free Role'
          TabOrder = 11
        end
        object cbCentral: TCheckBox
          Left = 117
          Top = 42
          Width = 56
          Height = 17
          Caption = 'Central'
          TabOrder = 8
        end
        object cbRightSide: TCheckBox
          Left = 117
          Top = 58
          Width = 73
          Height = 17
          Caption = 'Right Side'
          TabOrder = 9
        end
        object cbWingBack: TCheckBox
          Left = 117
          Top = 98
          Width = 76
          Height = 17
          Caption = 'Wing Back'
          TabOrder = 10
        end
      end
      object gbAbility: TGroupBox
        Left = 220
        Top = 23
        Width = 185
        Height = 93
        Caption = '&Ability:'
        TabOrder = 2
        object lblAbility: TLabel
          Left = 8
          Top = 20
          Width = 30
          Height = 13
          Caption = 'Ability:'
          FocusControl = speAbilityMin
        end
        object lblPotentialAbility: TLabel
          Left = 8
          Top = 44
          Width = 74
          Height = 13
          Caption = 'Potential Ability:'
          FocusControl = spePotentialAbilityMin
        end
        object lblScoutRating: TLabel
          Left = 8
          Top = 68
          Width = 65
          Height = 13
          Caption = 'Scout Rating:'
          FocusControl = speScoutRatingMin
        end
        object lblAbilityLine: TLabel
          Left = 131
          Top = 20
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblPotentialAbilityLine: TLabel
          Left = 131
          Top = 44
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblScoutRatingLine: TLabel
          Left = 131
          Top = 68
          Width = 3
          Height = 13
          Caption = '-'
        end
        object speAbilityMin: TSpinEdit
          Left = 88
          Top = 16
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnKeyDown = speKeyDown
        end
        object spePotentialAbilityMin: TSpinEdit
          Left = 88
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speScoutRatingMin: TSpinEdit
          Left = 88
          Top = 64
          Width = 41
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speAbilityMax: TSpinEdit
          Left = 137
          Top = 16
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 1
          Value = 200
          OnKeyDown = speKeyDown
        end
        object spePotentialAbilityMax: TSpinEdit
          Left = 137
          Top = 40
          Width = 41
          Height = 22
          MaxValue = 200
          MinValue = 0
          TabOrder = 3
          Value = 200
          OnKeyDown = speKeyDown
        end
        object speScoutRatingMax: TSpinEdit
          Left = 137
          Top = 64
          Width = 41
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnKeyDown = speKeyDown
        end
      end
      object gbReputation: TGroupBox
        Left = 220
        Top = 119
        Width = 185
        Height = 208
        Caption = '&Reputation:'
        TabOrder = 3
        object lblHomeReputation: TLabel
          Left = 8
          Top = 18
          Width = 86
          Height = 13
          Caption = 'Home Reputation:'
          FocusControl = speHomeReputationMin
        end
        object lblHomeReputationLine: TLabel
          Left = 91
          Top = 38
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblCurrentReputation: TLabel
          Left = 8
          Top = 66
          Width = 92
          Height = 13
          Caption = 'Current Reputation:'
          FocusControl = speCurrentReputationMin
        end
        object lblCurrentReputationLine: TLabel
          Left = 91
          Top = 86
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblWorldReputation: TLabel
          Left = 8
          Top = 114
          Width = 86
          Height = 13
          Caption = 'World Reputation:'
          FocusControl = speWorldReputationMin
        end
        object lblWorldReputationLine: TLabel
          Left = 91
          Top = 134
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblSquadReputation: TLabel
          Left = 8
          Top = 162
          Width = 89
          Height = 13
          Caption = 'Squad Reputation:'
          FocusControl = speSquadReputationMin
        end
        object lblSquadReputationLine: TLabel
          Left = 91
          Top = 182
          Width = 3
          Height = 13
          Caption = '-'
        end
        object speHomeReputationMin: TSpinEdit
          Left = 8
          Top = 34
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speHomeReputationMax: TSpinEdit
          Left = 97
          Top = 34
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 1
          Value = 10000
          OnKeyDown = speKeyDown
        end
        object speCurrentReputationMin: TSpinEdit
          Left = 8
          Top = 82
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speCurrentReputationMax: TSpinEdit
          Left = 96
          Top = 82
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 3
          Value = 10000
          OnKeyDown = speKeyDown
        end
        object speWorldReputationMin: TSpinEdit
          Left = 8
          Top = 130
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speWorldReputationMax: TSpinEdit
          Left = 96
          Top = 130
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 5
          Value = 10000
          OnKeyDown = speKeyDown
        end
        object speSquadReputationMin: TSpinEdit
          Left = 8
          Top = 178
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speSquadReputationMax: TSpinEdit
          Left = 96
          Top = 178
          Width = 82
          Height = 22
          MaxValue = 10000
          MinValue = 0
          TabOrder = 7
          Value = 10000
          OnKeyDown = speKeyDown
        end
      end
    end
    object FtsContract: TTabSheet
      Caption = '&Contract'
      ImageIndex = 2
      object gbContract: TGroupBox
        Left = 4
        Top = 53
        Width = 197
        Height = 75
        Caption = 'C&ontract:'
        TabOrder = 0
        object lblContract: TLabel
          Left = 8
          Top = 20
          Width = 43
          Height = 13
          Caption = 'Contract:'
          FocusControl = cmbContract
        end
        object cmbContract: TComboBox
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
        object cbLeavingOnBosman: TCheckBox
          Left = 8
          Top = 46
          Width = 164
          Height = 17
          Caption = 'Leaving On Bosman Ruling'
          TabOrder = 1
        end
      end
      object gbStatus: TGroupBox
        Left = 208
        Top = 26
        Width = 197
        Height = 118
        Caption = '&Status:'
        TabOrder = 2
        object lblTransferStatus: TLabel
          Left = 8
          Top = 20
          Width = 75
          Height = 13
          Caption = 'Transfer Status:'
          FocusControl = cmbTransferStatus
        end
        object lblSquadStatus: TLabel
          Left = 8
          Top = 68
          Width = 67
          Height = 13
          Caption = 'Squad Status:'
          FocusControl = cmbSquadStatus
        end
        object cmbTransferStatus: TComboBox
          Left = 8
          Top = 38
          Width = 181
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Transfer Listed'
            'Listed For Loan')
        end
        object cmbSquadStatus: TComboBox
          Left = 8
          Top = 88
          Width = 177
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            'Not Yet Set'
            'Indispensable To The Club'
            'Important First Team Player'
            'Used In A Squad Rotation System'
            'Backup For The First Team'
            'Hot Prospect For The Future'
            'Decent Young Player'
            'Not Needed By The Club')
        end
      end
      object gbReleaseClauses: TGroupBox
        Left = 4
        Top = 137
        Width = 197
        Height = 153
        Caption = '&Release Clauses:'
        TabOrder = 1
        object lblReleaseFee: TLabel
          Left = 8
          Top = 106
          Width = 60
          Height = 13
          Caption = 'Release Fee'
          FocusControl = speMinReleaseFee
        end
        object lblReleaseFeeLine: TLabel
          Left = 97
          Top = 126
          Width = 3
          Height = 13
          Caption = '-'
        end
        object cbNonPromotion: TCheckBox
          Left = 8
          Top = 16
          Width = 161
          Height = 17
          Caption = 'Non Promotion Release'
          TabOrder = 0
        end
        object cbNonPromotionActive: TCheckBox
          Left = 24
          Top = 32
          Width = 97
          Height = 17
          Caption = 'Active'
          TabOrder = 1
        end
        object cbRelegation: TCheckBox
          Left = 8
          Top = 48
          Width = 137
          Height = 17
          Caption = 'Relegation Release'
          TabOrder = 2
        end
        object cbRelegationActive: TCheckBox
          Left = 24
          Top = 64
          Width = 97
          Height = 17
          Caption = 'Active'
          TabOrder = 3
        end
        object cbMinimumFee: TCheckBox
          Left = 8
          Top = 82
          Width = 137
          Height = 17
          Caption = 'Minimum Fee Release'
          TabOrder = 4
        end
        object speMinReleaseFee: TSpinEdit
          Left = 8
          Top = 122
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMaxReleaseFee: TSpinEdit
          Left = 102
          Top = 122
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnKeyDown = speKeyDown
        end
      end
      object gbContractDetails: TGroupBox
        Left = 208
        Top = 146
        Width = 197
        Height = 177
        Caption = 'Contract &Details'
        TabOrder = 3
        object lblContractType: TLabel
          Left = 8
          Top = 20
          Width = 70
          Height = 13
          Caption = 'Contract Type:'
          FocusControl = cmbContractType
        end
        object lblValue: TLabel
          Left = 8
          Top = 40
          Width = 30
          Height = 13
          Caption = 'Value:'
          FocusControl = speMinValue
        end
        object lblWage: TLabel
          Left = 8
          Top = 124
          Width = 32
          Height = 13
          Caption = 'Wage:'
          FocusControl = speMinWage
        end
        object lblValueLine: TLabel
          Left = 97
          Top = 60
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblWageLine: TLabel
          Left = 97
          Top = 144
          Width = 3
          Height = 13
          Caption = '-'
        end
        object lblSaleValue: TLabel
          Left = 8
          Top = 82
          Width = 54
          Height = 13
          Caption = 'Sale Value:'
          FocusControl = speMinSaleValue
        end
        object lblSaleValueLine: TLabel
          Left = 97
          Top = 102
          Width = 3
          Height = 13
          Caption = '-'
        end
        object cmbContractType: TComboBox
          Left = 84
          Top = 16
          Width = 106
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Part Time Contract'
            'Full Time Contract'
            'Trial Contract')
        end
        object speMinValue: TSpinEdit
          Left = 8
          Top = 56
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMaxValue: TSpinEdit
          Left = 102
          Top = 56
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMinWage: TSpinEdit
          Left = 8
          Top = 140
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMaxWage: TSpinEdit
          Left = 102
          Top = 140
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMinSaleValue: TSpinEdit
          Left = 8
          Top = 98
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnKeyDown = speKeyDown
        end
        object speMaxSaleValue: TSpinEdit
          Left = 101
          Top = 98
          Width = 88
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnKeyDown = speKeyDown
        end
      end
    end
    object FtsAttributes1: TTabSheet
      Caption = 'Attributes &1'
      ImageIndex = 1
      object lblAcceleration: TLabel
        Left = 8
        Top = 61
        Width = 62
        Height = 13
        Caption = 'Acceleration:'
      end
      object lblAccelerationLine: TLabel
        Left = 160
        Top = 61
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblAdaptability: TLabel
        Left = 8
        Top = 85
        Width = 57
        Height = 13
        Caption = 'Adaptability:'
      end
      object lblAdaptabilityLine: TLabel
        Left = 160
        Top = 85
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblAerialAbility: TLabel
        Left = 8
        Top = 109
        Width = 59
        Height = 13
        Caption = 'Aerial Ability:'
      end
      object lblAerialAbilityLine: TLabel
        Left = 160
        Top = 109
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblAggression: TLabel
        Left = 8
        Top = 133
        Width = 55
        Height = 13
        Caption = 'Aggression:'
      end
      object lblAggressionLine: TLabel
        Left = 160
        Top = 133
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblAgility: TLabel
        Left = 8
        Top = 157
        Width = 30
        Height = 13
        Caption = 'Agility:'
      end
      object lblAgilityLine: TLabel
        Left = 160
        Top = 157
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblAmbition: TLabel
        Left = 8
        Top = 181
        Width = 43
        Height = 13
        Caption = 'Ambition:'
      end
      object lblAmbitionLine: TLabel
        Left = 160
        Top = 181
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblAnticipation: TLabel
        Left = 8
        Top = 205
        Width = 58
        Height = 13
        Caption = 'Anticipation:'
      end
      object lblAnticipationLine: TLabel
        Left = 160
        Top = 205
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblBalance: TLabel
        Left = 8
        Top = 229
        Width = 42
        Height = 13
        Caption = 'Balance:'
      end
      object lblBalanceLine: TLabel
        Left = 160
        Top = 229
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblBravery: TLabel
        Left = 8
        Top = 253
        Width = 39
        Height = 13
        Caption = 'Bravery:'
      end
      object lblBraveryLine: TLabel
        Left = 160
        Top = 253
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblCommandOfArea: TLabel
        Left = 8
        Top = 277
        Width = 89
        Height = 13
        Caption = 'Command Of Area:'
      end
      object lblCommandOfAreaLine: TLabel
        Left = 160
        Top = 277
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblCommunication: TLabel
        Left = 212
        Top = 61
        Width = 75
        Height = 13
        Caption = 'Communication:'
      end
      object lblCommunicationLine: TLabel
        Left = 364
        Top = 61
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblConsistency: TLabel
        Left = 212
        Top = 85
        Width = 60
        Height = 13
        Caption = 'Consistency:'
      end
      object lblConsistencyLine: TLabel
        Left = 364
        Top = 85
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblControversy: TLabel
        Left = 212
        Top = 109
        Width = 59
        Height = 13
        Caption = 'Controversy:'
      end
      object lblControversyLine: TLabel
        Left = 364
        Top = 109
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblCorners: TLabel
        Left = 212
        Top = 133
        Width = 39
        Height = 13
        Caption = 'Corners:'
      end
      object lblCornersLine: TLabel
        Left = 364
        Top = 133
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblCreativity: TLabel
        Left = 212
        Top = 157
        Width = 46
        Height = 13
        Caption = 'Creativity:'
      end
      object lblCreativityLine: TLabel
        Left = 364
        Top = 157
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblCrossing: TLabel
        Left = 212
        Top = 181
        Width = 43
        Height = 13
        Caption = 'Crossing:'
      end
      object lblCrossingLine: TLabel
        Left = 364
        Top = 181
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblDecisions: TLabel
        Left = 212
        Top = 205
        Width = 49
        Height = 13
        Caption = 'Decisions:'
      end
      object lblDecisionsLine: TLabel
        Left = 364
        Top = 205
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblDetermination: TLabel
        Left = 212
        Top = 229
        Width = 68
        Height = 13
        Caption = 'Determination:'
      end
      object lblDeterminationLine: TLabel
        Left = 364
        Top = 229
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblDirtiness: TLabel
        Left = 212
        Top = 253
        Width = 43
        Height = 13
        Caption = 'Dirtiness:'
      end
      object lblDirtinessLine: TLabel
        Left = 364
        Top = 253
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblDribbling: TLabel
        Left = 212
        Top = 277
        Width = 44
        Height = 13
        Caption = 'Dribbling:'
      end
      object lblDribblingLine: TLabel
        Left = 364
        Top = 277
        Width = 3
        Height = 13
        Caption = '-'
      end
      object speMinAcceleration: TSpinEdit
        Left = 123
        Top = 57
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxAcceleration: TSpinEdit
        Left = 166
        Top = 57
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 1
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinAdaptability: TSpinEdit
        Left = 123
        Top = 81
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxAdaptability: TSpinEdit
        Left = 166
        Top = 81
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 3
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinAerialAbility: TSpinEdit
        Left = 123
        Top = 105
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxAerialAbility: TSpinEdit
        Left = 166
        Top = 105
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 5
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinAggression: TSpinEdit
        Left = 123
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxAggression: TSpinEdit
        Left = 166
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 7
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinAgility: TSpinEdit
        Left = 123
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxAgility: TSpinEdit
        Left = 166
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 9
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinAmbition: TSpinEdit
        Left = 123
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxAmbition: TSpinEdit
        Left = 166
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 11
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinAnticipation: TSpinEdit
        Left = 123
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 12
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxAnticipation: TSpinEdit
        Left = 166
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 13
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinBalance: TSpinEdit
        Left = 123
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 14
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxBalance: TSpinEdit
        Left = 166
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 15
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinBravery: TSpinEdit
        Left = 123
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 16
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxBravery: TSpinEdit
        Left = 166
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 17
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinCommandOfArea: TSpinEdit
        Left = 123
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 18
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxCommandOfArea: TSpinEdit
        Left = 166
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 19
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinCommunication: TSpinEdit
        Left = 327
        Top = 57
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 20
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxCommunication: TSpinEdit
        Left = 370
        Top = 57
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 21
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinConsistency: TSpinEdit
        Left = 327
        Top = 81
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 22
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxConsistency: TSpinEdit
        Left = 370
        Top = 81
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 23
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinControversy: TSpinEdit
        Left = 327
        Top = 105
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 24
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxControversy: TSpinEdit
        Left = 370
        Top = 105
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 25
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinCorners: TSpinEdit
        Left = 327
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 26
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxCorners: TSpinEdit
        Left = 370
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 27
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinCreativity: TSpinEdit
        Left = 327
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 28
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxCreativity: TSpinEdit
        Left = 370
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 29
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinCrossing: TSpinEdit
        Left = 327
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 30
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxCrossing: TSpinEdit
        Left = 370
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 31
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinDecisions: TSpinEdit
        Left = 327
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 32
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxDecisions: TSpinEdit
        Left = 370
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 33
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinDetermination: TSpinEdit
        Left = 327
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 34
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxDetermination: TSpinEdit
        Left = 370
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 35
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinDirtiness: TSpinEdit
        Left = 327
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 36
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxDirtiness: TSpinEdit
        Left = 370
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 37
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinDribbling: TSpinEdit
        Left = 327
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 38
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxDribbling: TSpinEdit
        Left = 370
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 39
        Value = 20
        OnKeyDown = speKeyDown
      end
    end
    object FtsAttributes2: TTabSheet
      Caption = 'Attributes &2'
      ImageIndex = 3
      object lblImportantMatches: TLabel
        Left = 8
        Top = 205
        Width = 91
        Height = 13
        Caption = 'Important Matches:'
      end
      object lblImportantMatchesLine: TLabel
        Left = 160
        Top = 205
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblInfluence: TLabel
        Left = 8
        Top = 229
        Width = 47
        Height = 13
        Caption = 'Influence:'
      end
      object lblInfluenceLine: TLabel
        Left = 160
        Top = 229
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblInjuryProneness: TLabel
        Left = 8
        Top = 253
        Width = 81
        Height = 13
        Caption = 'Injury Proneness:'
      end
      object lblInjuryPronenessLine: TLabel
        Left = 160
        Top = 253
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblJumping: TLabel
        Left = 8
        Top = 277
        Width = 42
        Height = 13
        Caption = 'Jumping:'
      end
      object lblJumpingLine: TLabel
        Left = 160
        Top = 277
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblKicking: TLabel
        Left = 212
        Top = 60
        Width = 38
        Height = 13
        Caption = 'Kicking:'
      end
      object lblKickingLine: TLabel
        Left = 364
        Top = 60
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblLeftFoot: TLabel
        Left = 212
        Top = 84
        Width = 45
        Height = 13
        Caption = 'Left Foot:'
      end
      object lblLeftFootLine: TLabel
        Left = 364
        Top = 84
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblLongShots: TLabel
        Left = 212
        Top = 108
        Width = 57
        Height = 13
        Caption = 'Long Shots:'
      end
      object lblLongShotsLine: TLabel
        Left = 364
        Top = 108
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblLongThrows: TLabel
        Left = 212
        Top = 132
        Width = 65
        Height = 13
        Caption = 'Long Throws:'
      end
      object lblLongThrowsLine: TLabel
        Left = 364
        Top = 132
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblLoyality: TLabel
        Left = 212
        Top = 156
        Width = 38
        Height = 13
        Caption = 'Loyality:'
      end
      object lblLoyalityLine: TLabel
        Left = 364
        Top = 156
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblMarking: TLabel
        Left = 212
        Top = 180
        Width = 41
        Height = 13
        Caption = 'Marking:'
      end
      object lblMarkingLine: TLabel
        Left = 364
        Top = 180
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblNaturalFitness: TLabel
        Left = 212
        Top = 204
        Width = 73
        Height = 13
        Caption = 'Natural Fitness:'
      end
      object lblNaturalFitnessLine: TLabel
        Left = 364
        Top = 204
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblOffTheBall: TLabel
        Left = 212
        Top = 229
        Width = 59
        Height = 13
        Caption = 'Off The Ball:'
      end
      object lblOffTheBallLine: TLabel
        Left = 364
        Top = 229
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblOneOnOnes: TLabel
        Left = 212
        Top = 253
        Width = 68
        Height = 13
        Caption = 'One On Ones:'
      end
      object lblOneOnOnesLine: TLabel
        Left = 364
        Top = 253
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblPace: TLabel
        Left = 212
        Top = 277
        Width = 28
        Height = 13
        Caption = 'Pace:'
      end
      object lblPaceLine: TLabel
        Left = 364
        Top = 277
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblFlair: TLabel
        Left = 8
        Top = 133
        Width = 22
        Height = 13
        Caption = 'Flair:'
      end
      object lblFlairLine: TLabel
        Left = 160
        Top = 133
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblHandling: TLabel
        Left = 8
        Top = 157
        Width = 45
        Height = 13
        Caption = 'Handling:'
      end
      object lblHandlingLine: TLabel
        Left = 160
        Top = 157
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblHeading: TLabel
        Left = 8
        Top = 181
        Width = 43
        Height = 13
        Caption = 'Heading:'
      end
      object lblHeadingLine: TLabel
        Left = 160
        Top = 181
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblEccentricity: TLabel
        Left = 8
        Top = 60
        Width = 58
        Height = 13
        Caption = 'Eccentricity:'
      end
      object lblEccentricityLine: TLabel
        Left = 160
        Top = 60
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblFinishing: TLabel
        Left = 8
        Top = 84
        Width = 44
        Height = 13
        Caption = 'Finishing:'
      end
      object lblFinishingLine: TLabel
        Left = 160
        Top = 84
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblFirstTouch: TLabel
        Left = 8
        Top = 108
        Width = 56
        Height = 13
        Caption = 'First Touch:'
      end
      object lblFirstTouchLine: TLabel
        Left = 160
        Top = 113
        Width = 3
        Height = 13
        Caption = '-'
      end
      object speMinImportantMatches: TSpinEdit
        Left = 123
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 12
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxImportantMatches: TSpinEdit
        Left = 166
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 13
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinInfluence: TSpinEdit
        Left = 123
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 14
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxInfluence: TSpinEdit
        Left = 166
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 15
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinInjuryProneness: TSpinEdit
        Left = 123
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 16
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxInjuryProneness: TSpinEdit
        Left = 166
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 17
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinJumping: TSpinEdit
        Left = 123
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 18
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxJumping: TSpinEdit
        Left = 166
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 19
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinKicking: TSpinEdit
        Left = 327
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 20
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxKicking: TSpinEdit
        Left = 370
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 21
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinLeftFoot: TSpinEdit
        Left = 327
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 22
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxLeftFoot: TSpinEdit
        Left = 370
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 23
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinLongShots: TSpinEdit
        Left = 327
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 24
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxLongShots: TSpinEdit
        Left = 370
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 25
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinLongThrows: TSpinEdit
        Left = 327
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 26
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxLongThrows: TSpinEdit
        Left = 370
        Top = 128
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 27
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinLoyality: TSpinEdit
        Left = 327
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 28
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxLoyality: TSpinEdit
        Left = 370
        Top = 152
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 29
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinMarking: TSpinEdit
        Left = 327
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 30
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxMarking: TSpinEdit
        Left = 370
        Top = 176
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 31
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinNaturalFitness: TSpinEdit
        Left = 327
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 32
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxNaturalFitness: TSpinEdit
        Left = 370
        Top = 200
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 33
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinOffTheBall: TSpinEdit
        Left = 327
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 34
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxOffTheBall: TSpinEdit
        Left = 370
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 35
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinOneOnOnes: TSpinEdit
        Left = 327
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 36
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxOneOnOnes: TSpinEdit
        Left = 370
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 37
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinPace: TSpinEdit
        Left = 327
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 38
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxPace: TSpinEdit
        Left = 370
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 39
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinFlair: TSpinEdit
        Left = 123
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxFlair: TSpinEdit
        Left = 166
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 7
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinHandling: TSpinEdit
        Left = 123
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxHandling: TSpinEdit
        Left = 166
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 9
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinHeading: TSpinEdit
        Left = 123
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxHeading: TSpinEdit
        Left = 166
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 11
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinEccentricity: TSpinEdit
        Left = 123
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxEccentricity: TSpinEdit
        Left = 166
        Top = 56
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 1
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinFinishing: TSpinEdit
        Left = 123
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxFinishing: TSpinEdit
        Left = 166
        Top = 80
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 3
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinFirstTouch: TSpinEdit
        Left = 123
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxFirstTouch: TSpinEdit
        Left = 166
        Top = 104
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 5
        Value = 20
        OnKeyDown = speKeyDown
      end
    end
    object FtsAttributes3: TTabSheet
      Caption = 'Attributes &3'
      ImageIndex = 4
      object lblTackling: TLabel
        Left = 212
        Top = 98
        Width = 44
        Height = 13
        Caption = 'Tackling:'
      end
      object lblTacklingLine: TLabel
        Left = 364
        Top = 98
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblTeamwork: TLabel
        Left = 212
        Top = 122
        Width = 53
        Height = 13
        Caption = 'Teamwork:'
      end
      object lblTeamworkLine: TLabel
        Left = 364
        Top = 122
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblTechnique: TLabel
        Left = 212
        Top = 146
        Width = 54
        Height = 13
        Caption = 'Technique:'
      end
      object lblTechniqueLine: TLabel
        Left = 364
        Top = 146
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblTemperament: TLabel
        Left = 212
        Top = 170
        Width = 68
        Height = 13
        Caption = 'Temperament:'
      end
      object lblTemperamentLine: TLabel
        Left = 364
        Top = 170
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblTendencyToPunch: TLabel
        Left = 212
        Top = 194
        Width = 101
        Height = 13
        Caption = 'Tendency To Punch:'
      end
      object lblTendencyToPunchLine: TLabel
        Left = 364
        Top = 194
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblThrowing: TLabel
        Left = 212
        Top = 218
        Width = 47
        Height = 13
        Caption = 'Throwing:'
      end
      object lblThrowingLine: TLabel
        Left = 364
        Top = 218
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblThrowIns: TLabel
        Left = 212
        Top = 242
        Width = 47
        Height = 13
        Caption = 'ThrowIns:'
      end
      object lblThrowInsLine: TLabel
        Left = 364
        Top = 242
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblVersatility: TLabel
        Left = 212
        Top = 266
        Width = 47
        Height = 13
        Caption = 'Versatility:'
      end
      object lblVersatilityLine: TLabel
        Left = 364
        Top = 266
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblWorkRate: TLabel
        Left = 212
        Top = 290
        Width = 52
        Height = 13
        Caption = 'WorkRate:'
      end
      object lblWorkRateLine: TLabel
        Left = 364
        Top = 290
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblStamina: TLabel
        Left = 212
        Top = 50
        Width = 41
        Height = 13
        Caption = 'Stamina:'
      end
      object lblStaminaLine: TLabel
        Left = 364
        Top = 50
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblStrength: TLabel
        Left = 212
        Top = 74
        Width = 43
        Height = 13
        Caption = 'Strength:'
      end
      object lblStrengthLine: TLabel
        Left = 364
        Top = 74
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblPassing: TLabel
        Left = 8
        Top = 61
        Width = 40
        Height = 13
        Caption = 'Passing:'
      end
      object lblPassingLine: TLabel
        Left = 160
        Top = 61
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblPenalties: TLabel
        Left = 8
        Top = 85
        Width = 46
        Height = 13
        Caption = 'Penalties:'
      end
      object lblPenaltiesLine: TLabel
        Left = 160
        Top = 85
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblPositioning: TLabel
        Left = 8
        Top = 109
        Width = 54
        Height = 13
        Caption = 'Positioning:'
      end
      object lblPositioningLine: TLabel
        Left = 160
        Top = 109
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblPressure: TLabel
        Left = 8
        Top = 133
        Width = 44
        Height = 13
        Caption = 'Pressure:'
      end
      object lblPressureLine: TLabel
        Left = 160
        Top = 133
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblProfessionalism: TLabel
        Left = 8
        Top = 157
        Width = 75
        Height = 13
        Caption = 'Professionalism:'
      end
      object lblProfessionalismLine: TLabel
        Left = 160
        Top = 157
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblReflexes: TLabel
        Left = 8
        Top = 181
        Width = 44
        Height = 13
        Caption = 'Reflexes:'
      end
      object lblReflexesLine: TLabel
        Left = 160
        Top = 181
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblRightFoot: TLabel
        Left = 8
        Top = 205
        Width = 52
        Height = 13
        Caption = 'Right Foot:'
      end
      object lblRightFootLine: TLabel
        Left = 160
        Top = 205
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblRushingOut: TLabel
        Left = 8
        Top = 229
        Width = 62
        Height = 13
        Caption = 'Rushing Out:'
      end
      object lblRushingOutLine: TLabel
        Left = 160
        Top = 229
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblSetPieces: TLabel
        Left = 8
        Top = 253
        Width = 54
        Height = 13
        Caption = 'Set Pieces:'
      end
      object lblSetPiecesLine: TLabel
        Left = 160
        Top = 253
        Width = 3
        Height = 13
        Caption = '-'
      end
      object lblSportsmanship: TLabel
        Left = 8
        Top = 277
        Width = 72
        Height = 13
        Caption = 'Sportsmanship:'
      end
      object lblSportsmanshipLine: TLabel
        Left = 160
        Top = 277
        Width = 3
        Height = 13
        Caption = '-'
      end
      object speMinTackling: TSpinEdit
        Left = 327
        Top = 94
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 24
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxTackling: TSpinEdit
        Left = 370
        Top = 94
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 25
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinTeamwork: TSpinEdit
        Left = 327
        Top = 118
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 26
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxTeamwork: TSpinEdit
        Left = 370
        Top = 118
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 27
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinTechnique: TSpinEdit
        Left = 327
        Top = 142
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 28
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxTechnique: TSpinEdit
        Left = 370
        Top = 142
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 29
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinTemperament: TSpinEdit
        Left = 327
        Top = 166
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 30
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxTemperament: TSpinEdit
        Left = 370
        Top = 166
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 31
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinTendencyToPunch: TSpinEdit
        Left = 327
        Top = 190
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 32
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxTendencyToPunch: TSpinEdit
        Left = 370
        Top = 190
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 33
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinThrowing: TSpinEdit
        Left = 327
        Top = 214
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 34
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxThrowing: TSpinEdit
        Left = 370
        Top = 214
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 35
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinThrowIns: TSpinEdit
        Left = 327
        Top = 238
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 36
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxThrowIns: TSpinEdit
        Left = 370
        Top = 238
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 37
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinVersatility: TSpinEdit
        Left = 327
        Top = 262
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 38
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxVersatility: TSpinEdit
        Left = 370
        Top = 262
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 39
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinWorkRate: TSpinEdit
        Left = 327
        Top = 286
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 40
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxWorkRate: TSpinEdit
        Left = 370
        Top = 286
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 41
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinStamina: TSpinEdit
        Left = 327
        Top = 46
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 20
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxStamina: TSpinEdit
        Left = 370
        Top = 46
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 21
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinStrength: TSpinEdit
        Left = 327
        Top = 70
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 22
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxStrength: TSpinEdit
        Left = 370
        Top = 70
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 23
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinPassing: TSpinEdit
        Left = 123
        Top = 57
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxPassing: TSpinEdit
        Left = 166
        Top = 57
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 1
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinPenalties: TSpinEdit
        Left = 123
        Top = 81
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxPenalties: TSpinEdit
        Left = 166
        Top = 81
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 3
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinPositioning: TSpinEdit
        Left = 123
        Top = 105
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 4
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxPositioning: TSpinEdit
        Left = 166
        Top = 105
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 5
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinPressure: TSpinEdit
        Left = 123
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 6
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxPressure: TSpinEdit
        Left = 166
        Top = 129
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 7
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinProfessionalism: TSpinEdit
        Left = 123
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxProfessionalism: TSpinEdit
        Left = 166
        Top = 153
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 9
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinReflexes: TSpinEdit
        Left = 123
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 10
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxReflexes: TSpinEdit
        Left = 166
        Top = 177
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 11
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinRightFoot: TSpinEdit
        Left = 123
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 12
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxRightFoot: TSpinEdit
        Left = 166
        Top = 201
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 13
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinRushingOut: TSpinEdit
        Left = 123
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 14
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxRushingOut: TSpinEdit
        Left = 166
        Top = 225
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 15
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinSetPieces: TSpinEdit
        Left = 123
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 16
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxSetPieces: TSpinEdit
        Left = 166
        Top = 249
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 17
        Value = 20
        OnKeyDown = speKeyDown
      end
      object speMinSportsmanship: TSpinEdit
        Left = 123
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 18
        Value = 0
        OnKeyDown = speKeyDown
      end
      object speMaxSportsmanship: TSpinEdit
        Left = 166
        Top = 273
        Width = 35
        Height = 22
        MaxValue = 20
        MinValue = 0
        TabOrder = 19
        Value = 20
        OnKeyDown = speKeyDown
      end
    end
  end
  object btnOK: TButton
    Left = 189
    Top = 394
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 268
    Top = 394
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnReset: TButton
    Left = 347
    Top = 394
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 3
    OnClick = btnResetClick
  end
end
