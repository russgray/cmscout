object frmPlayerInfo: TfrmPlayerInfo
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 288
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pcPlayerInfo: TPageControl
    Left = 8
    Top = 64
    Width = 521
    Height = 217
    ActivePage = tsProfile
    TabOrder = 0
    object tsProfile: TTabSheet
      Caption = '&Profile'
      object gbTechnical: TGroupBox
        Left = 8
        Top = 8
        Width = 160
        Height = 177
        Caption = 'Technical'
        TabOrder = 0
        object lblCrossing: TLabel
          Left = 8
          Top = 16
          Width = 40
          Height = 13
          Caption = 'Crossing'
          Color = clBtnFace
          ParentColor = False
        end
        object lblCrossingVal: TLabel
          Left = 133
          Top = 16
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblDribbling: TLabel
          Left = 8
          Top = 29
          Width = 41
          Height = 13
          Caption = 'Dribbling'
        end
        object lblDribblingVal: TLabel
          Left = 133
          Top = 29
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblFinishing: TLabel
          Left = 8
          Top = 42
          Width = 41
          Height = 13
          Caption = 'Finishing'
        end
        object lblFinishingVal: TLabel
          Left = 133
          Top = 42
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblHeading: TLabel
          Left = 8
          Top = 55
          Width = 40
          Height = 13
          Caption = 'Heading'
        end
        object lblHeadingVal: TLabel
          Left = 133
          Top = 55
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblLongShots: TLabel
          Left = 8
          Top = 68
          Width = 54
          Height = 13
          Caption = 'Long Shots'
        end
        object lblLongShotsVal: TLabel
          Left = 133
          Top = 68
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblLongThrows: TLabel
          Left = 8
          Top = 81
          Width = 62
          Height = 13
          Caption = 'Long Throws'
        end
        object lblLongThrowsVal: TLabel
          Left = 133
          Top = 81
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblMarking: TLabel
          Left = 8
          Top = 94
          Width = 38
          Height = 13
          Caption = 'Marking'
        end
        object lblMarkingVal: TLabel
          Left = 133
          Top = 94
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblPassing: TLabel
          Left = 8
          Top = 107
          Width = 37
          Height = 13
          Caption = 'Passing'
        end
        object lblPassingVal: TLabel
          Left = 133
          Top = 107
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblPenaltyTaking: TLabel
          Left = 8
          Top = 120
          Width = 71
          Height = 13
          Caption = 'Penalty Taking'
        end
        object lblPenaltyTakingVal: TLabel
          Left = 133
          Top = 120
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblSetPieces: TLabel
          Left = 8
          Top = 133
          Width = 51
          Height = 13
          Caption = 'Set Pieces'
        end
        object lblSetPiecesVal: TLabel
          Left = 133
          Top = 133
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblTackling: TLabel
          Left = 8
          Top = 146
          Width = 41
          Height = 13
          Caption = 'Tackling'
        end
        object lblTacklingVal: TLabel
          Left = 133
          Top = 146
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblTechnique: TLabel
          Left = 8
          Top = 159
          Width = 51
          Height = 13
          Caption = 'Technique'
        end
        object lblTechniqueVal: TLabel
          Left = 133
          Top = 159
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
      end
      object gbMental: TGroupBox
        Left = 176
        Top = 8
        Width = 161
        Height = 177
        Caption = 'Mental'
        TabOrder = 1
        object lblAggression: TLabel
          Left = 8
          Top = 16
          Width = 52
          Height = 13
          Caption = 'Aggression'
        end
        object lblAggressionVal: TLabel
          Left = 133
          Top = 16
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblAnticipation: TLabel
          Left = 8
          Top = 29
          Width = 55
          Height = 13
          Caption = 'Anticipation'
        end
        object lblAnticipationVal: TLabel
          Left = 133
          Top = 29
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblBravery: TLabel
          Left = 8
          Top = 42
          Width = 36
          Height = 13
          Caption = 'Bravery'
        end
        object lblBraveryVal: TLabel
          Left = 133
          Top = 42
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblCreativity: TLabel
          Left = 8
          Top = 55
          Width = 43
          Height = 13
          Caption = 'Creativity'
        end
        object lblCreativityVal: TLabel
          Left = 133
          Top = 55
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblDecisions: TLabel
          Left = 8
          Top = 68
          Width = 46
          Height = 13
          Caption = 'Decisions'
        end
        object lblDecisionsVal: TLabel
          Left = 133
          Top = 68
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblDetermination: TLabel
          Left = 8
          Top = 81
          Width = 65
          Height = 13
          Caption = 'Determination'
        end
        object lblDeterminationVal: TLabel
          Left = 133
          Top = 81
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblFlair: TLabel
          Left = 8
          Top = 94
          Width = 19
          Height = 13
          Caption = 'Flair'
        end
        object lblFlairVal: TLabel
          Left = 133
          Top = 94
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblInfluence: TLabel
          Left = 8
          Top = 107
          Width = 44
          Height = 13
          Caption = 'Influence'
        end
        object lblInfluenceVal: TLabel
          Left = 133
          Top = 107
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblOffTheBall: TLabel
          Left = 8
          Top = 120
          Width = 56
          Height = 13
          Caption = 'Off The Ball'
        end
        object lblOffTheBallVal: TLabel
          Left = 133
          Top = 120
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblPositioning: TLabel
          Left = 8
          Top = 133
          Width = 51
          Height = 13
          Caption = 'Positioning'
        end
        object lblPositioningVal: TLabel
          Left = 133
          Top = 133
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblTeamwork: TLabel
          Left = 8
          Top = 146
          Width = 50
          Height = 13
          Caption = 'Teamwork'
        end
        object lblTeamworkVal: TLabel
          Left = 133
          Top = 146
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblWorkRate: TLabel
          Left = 8
          Top = 159
          Width = 52
          Height = 13
          Caption = 'Work Rate'
        end
        object lblWorkRateVal: TLabel
          Left = 133
          Top = 159
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
      end
      object gbPhysical: TGroupBox
        Left = 345
        Top = 8
        Width = 160
        Height = 177
        Caption = 'Physical'
        TabOrder = 2
        object lblAcceleration: TLabel
          Left = 8
          Top = 16
          Width = 59
          Height = 13
          Caption = 'Acceleration'
        end
        object lblAccelerationVal: TLabel
          Left = 133
          Top = 16
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblAgility: TLabel
          Left = 8
          Top = 29
          Width = 27
          Height = 13
          Caption = 'Agility'
        end
        object lblAgilityVal: TLabel
          Left = 133
          Top = 29
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblBalance: TLabel
          Left = 8
          Top = 42
          Width = 39
          Height = 13
          Caption = 'Balance'
        end
        object lblBalanceVal: TLabel
          Left = 133
          Top = 42
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblJumping: TLabel
          Left = 8
          Top = 55
          Width = 39
          Height = 13
          Caption = 'Jumping'
        end
        object lblJumpingVal: TLabel
          Left = 133
          Top = 55
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblPace: TLabel
          Left = 8
          Top = 68
          Width = 25
          Height = 13
          Caption = 'Pace'
        end
        object lblPaceVal: TLabel
          Left = 133
          Top = 68
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblStamina: TLabel
          Left = 8
          Top = 81
          Width = 38
          Height = 13
          Caption = 'Stamina'
        end
        object lblStaminaVal: TLabel
          Left = 133
          Top = 81
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblStrength: TLabel
          Left = 8
          Top = 94
          Width = 40
          Height = 13
          Caption = 'Strength'
        end
        object lblStrengthVal: TLabel
          Left = 133
          Top = 94
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblUnprotected: TLabel
          Left = 8
          Top = 159
          Width = 144
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
        end
        object lblOnLoan: TLabel
          Left = 8
          Top = 146
          Width = 144
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
        end
        object lblPreferredFoot: TLabel
          Left = 8
          Top = 107
          Width = 67
          Height = 13
          Caption = 'Preferred Foot'
        end
        object lblPreferredFootVal: TLabel
          Left = 82
          Top = 107
          Width = 65
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
        end
      end
    end
    object tsHidden: TTabSheet
      Caption = '&Hidden'
      ImageIndex = 1
      object gbGoalkeeping: TGroupBox
        Left = 8
        Top = 8
        Width = 160
        Height = 177
        Caption = 'Goalkeeping'
        TabOrder = 0
        object lblAerialAbility: TLabel
          Left = 8
          Top = 16
          Width = 56
          Height = 13
          Caption = 'Aerial Ability'
        end
        object lblAerialAbilityVal: TLabel
          Left = 133
          Top = 16
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblCommandOfArea: TLabel
          Left = 8
          Top = 29
          Width = 86
          Height = 13
          Caption = 'Command Of Area'
        end
        object lblCommandOfAreaVal: TLabel
          Left = 133
          Top = 29
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblCommunication: TLabel
          Left = 8
          Top = 42
          Width = 72
          Height = 13
          Caption = 'Communication'
        end
        object lblCommunicationVal: TLabel
          Left = 133
          Top = 42
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblEccentricity: TLabel
          Left = 8
          Top = 55
          Width = 55
          Height = 13
          Caption = 'Eccentricity'
        end
        object lblEccentricityVal: TLabel
          Left = 133
          Top = 55
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblHandling: TLabel
          Left = 8
          Top = 68
          Width = 42
          Height = 13
          Caption = 'Handling'
        end
        object lblHandlingVal: TLabel
          Left = 133
          Top = 68
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblKicking: TLabel
          Left = 8
          Top = 81
          Width = 35
          Height = 13
          Caption = 'Kicking'
        end
        object lblKickingVal: TLabel
          Left = 133
          Top = 81
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblOneOnOnes: TLabel
          Left = 8
          Top = 94
          Width = 65
          Height = 13
          Caption = 'One On Ones'
        end
        object lblOneOnOnesVal: TLabel
          Left = 133
          Top = 94
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblReflexes: TLabel
          Left = 8
          Top = 107
          Width = 41
          Height = 13
          Caption = 'Reflexes'
        end
        object lblReflexesVal: TLabel
          Left = 133
          Top = 107
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblRushingOut: TLabel
          Left = 8
          Top = 120
          Width = 59
          Height = 13
          Caption = 'Rushing Out'
        end
        object lblRushingOutVal: TLabel
          Left = 133
          Top = 120
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblTendencyToPunch: TLabel
          Left = 8
          Top = 133
          Width = 98
          Height = 13
          Caption = 'Tendency To Punch'
        end
        object lblTendencyToPunchVal: TLabel
          Left = 133
          Top = 133
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblThrowing: TLabel
          Left = 8
          Top = 146
          Width = 44
          Height = 13
          Caption = 'Throwing'
        end
        object lblThrowingVal: TLabel
          Left = 133
          Top = 146
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
      end
      object cbHiddenAttributes: TGroupBox
        Left = 176
        Top = 8
        Width = 160
        Height = 177
        Caption = 'Hidden Attributes'
        TabOrder = 1
        object lblFirstTouch: TLabel
          Left = 8
          Top = 16
          Width = 53
          Height = 13
          Caption = 'First Touch'
        end
        object lblFirstTouchVal: TLabel
          Left = 133
          Top = 16
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblThrowIns: TLabel
          Left = 8
          Top = 29
          Width = 47
          Height = 13
          Caption = 'Throw Ins'
        end
        object lblThrowInsVal: TLabel
          Left = 133
          Top = 29
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblConsistency: TLabel
          Left = 8
          Top = 55
          Width = 57
          Height = 13
          Caption = 'Consistency'
        end
        object lblConsistencyVal: TLabel
          Left = 133
          Top = 55
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblCorners: TLabel
          Left = 8
          Top = 68
          Width = 36
          Height = 13
          Caption = 'Corners'
        end
        object lblCornersVal: TLabel
          Left = 133
          Top = 68
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblDirtiness: TLabel
          Left = 8
          Top = 81
          Width = 40
          Height = 13
          Caption = 'Dirtiness'
        end
        object lblDirtinessVal: TLabel
          Left = 133
          Top = 81
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblImportantMatches: TLabel
          Left = 8
          Top = 94
          Width = 88
          Height = 13
          Caption = 'Important Matches'
        end
        object lblImportantMatchesVal: TLabel
          Left = 133
          Top = 94
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblInjuryProneness: TLabel
          Left = 8
          Top = 107
          Width = 78
          Height = 13
          Caption = 'Injury Proneness'
        end
        object lblInjuryPronenessVal: TLabel
          Left = 133
          Top = 107
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblNaturalFitness: TLabel
          Left = 8
          Top = 120
          Width = 70
          Height = 13
          Caption = 'Natural Fitness'
        end
        object lblNaturalFitnessVal: TLabel
          Left = 133
          Top = 120
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblVersatility: TLabel
          Left = 8
          Top = 133
          Width = 44
          Height = 13
          Caption = 'Versatility'
        end
        object lblVersatilityVal: TLabel
          Left = 133
          Top = 133
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblLeftFoot: TLabel
          Left = 8
          Top = 146
          Width = 42
          Height = 13
          Caption = 'Left Foot'
        end
        object lblLeftFootVal: TLabel
          Left = 133
          Top = 146
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblRightFoot: TLabel
          Left = 8
          Top = 159
          Width = 49
          Height = 13
          Caption = 'Right Foot'
        end
        object lblRightFootVal: TLabel
          Left = 133
          Top = 159
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
      end
      object gbPositions: TGroupBox
        Left = 345
        Top = 8
        Width = 160
        Height = 177
        Caption = 'Positions'
        TabOrder = 2
        object lblGoalkeeper: TLabel
          Left = 8
          Top = 16
          Width = 55
          Height = 13
          Caption = 'Goalkeeper'
        end
        object lblGoalkeeperVal: TLabel
          Left = 133
          Top = 16
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblSweeper: TLabel
          Left = 8
          Top = 29
          Width = 42
          Height = 13
          Caption = 'Sweeper'
        end
        object lblSweeperVal: TLabel
          Left = 133
          Top = 29
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblDefender: TLabel
          Left = 8
          Top = 42
          Width = 44
          Height = 13
          Caption = 'Defender'
        end
        object lblDefenderVal: TLabel
          Left = 133
          Top = 42
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblDefensiveMidfielder: TLabel
          Left = 8
          Top = 55
          Width = 96
          Height = 13
          Caption = 'Defensive Midfielder'
        end
        object lblDefensiveMidfielderVal: TLabel
          Left = 133
          Top = 55
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblMidfielder: TLabel
          Left = 8
          Top = 68
          Width = 45
          Height = 13
          Caption = 'Midfielder'
        end
        object lblMidfielderVal: TLabel
          Left = 133
          Top = 68
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblAttackingMidfielder: TLabel
          Left = 8
          Top = 81
          Width = 93
          Height = 13
          Caption = 'Attacking Midfielder'
        end
        object lblAttackingMidfielderVal: TLabel
          Left = 133
          Top = 81
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblAttacker: TLabel
          Left = 8
          Top = 94
          Width = 40
          Height = 13
          Caption = 'Attacker'
        end
        object lblAttackerVal: TLabel
          Left = 133
          Top = 94
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblWingBack: TLabel
          Left = 8
          Top = 107
          Width = 53
          Height = 13
          Caption = 'Wing Back'
        end
        object lblWingBackVal: TLabel
          Left = 133
          Top = 107
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblFreeRole: TLabel
          Left = 8
          Top = 120
          Width = 46
          Height = 13
          Caption = 'Free Role'
        end
        object lblFreeRoleVal: TLabel
          Left = 133
          Top = 120
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblRightSide: TLabel
          Left = 8
          Top = 133
          Width = 49
          Height = 13
          Caption = 'Right Side'
        end
        object lblRightSideVal: TLabel
          Left = 133
          Top = 133
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblLeftSide: TLabel
          Left = 8
          Top = 146
          Width = 42
          Height = 13
          Caption = 'Left Side'
        end
        object lblLeftSideVal: TLabel
          Left = 133
          Top = 146
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblCentral: TLabel
          Left = 8
          Top = 159
          Width = 33
          Height = 13
          Caption = 'Central'
        end
        object lblCentralVal: TLabel
          Left = 133
          Top = 159
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
      end
    end
    object tsAbility: TTabSheet
      Caption = '&Ability'
      ImageIndex = 2
      object gbAbility: TGroupBox
        Left = 8
        Top = 35
        Width = 160
        Height = 49
        Caption = 'Ability'
        TabOrder = 0
        object lblCurrentAbility: TLabel
          Left = 8
          Top = 16
          Width = 64
          Height = 13
          Caption = 'Current Ability'
        end
        object lblCurrentAbilityVal: TLabel
          Left = 132
          Top = 16
          Width = 19
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '200'
        end
        object lblPotentialAbility: TLabel
          Left = 8
          Top = 29
          Width = 71
          Height = 13
          Caption = 'Potential Ability'
        end
        object lblPotentialAbilityVal: TLabel
          Left = 132
          Top = 29
          Width = 19
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '200'
        end
      end
      object gbReputation: TGroupBox
        Left = 8
        Top = 91
        Width = 160
        Height = 62
        Caption = 'Reputation'
        TabOrder = 1
        object lblHomeReputation: TLabel
          Left = 8
          Top = 16
          Width = 83
          Height = 13
          Caption = 'Home Reputation'
        end
        object lblHomeReputationVal: TLabel
          Left = 125
          Top = 16
          Width = 33
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '10000'
        end
        object lblCurrentReputation: TLabel
          Left = 8
          Top = 29
          Width = 89
          Height = 13
          Caption = 'Current Reputation'
        end
        object lblCurrentReputationVal: TLabel
          Left = 125
          Top = 29
          Width = 33
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '10000'
        end
        object lblWorldReputation: TLabel
          Left = 8
          Top = 42
          Width = 83
          Height = 13
          Caption = 'World Reputation'
        end
        object lblWorldReputationVal: TLabel
          Left = 125
          Top = 42
          Width = 33
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '10000'
        end
      end
      object gbScoutRating: TGroupBox
        Left = 176
        Top = 38
        Width = 160
        Height = 113
        Caption = 'Scout Rating'
        TabOrder = 2
        object lblGKRating: TLabel
          Left = 8
          Top = 16
          Width = 55
          Height = 13
          Caption = 'Goalkeeper'
        end
        object lblGKRatingVal: TLabel
          Left = 105
          Top = 16
          Width = 51
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '100,00 %'
        end
        object lblDRating: TLabel
          Left = 8
          Top = 29
          Width = 44
          Height = 13
          Caption = 'Defender'
        end
        object lblDRatingVal: TLabel
          Left = 105
          Top = 29
          Width = 51
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '100,00 %'
        end
        object lblDMRating: TLabel
          Left = 8
          Top = 42
          Width = 96
          Height = 13
          Caption = 'Defensive Midfielder'
        end
        object lblDMRatingVal: TLabel
          Left = 105
          Top = 42
          Width = 51
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '100,00 %'
        end
        object lblMRating: TLabel
          Left = 8
          Top = 55
          Width = 45
          Height = 13
          Caption = 'Midfielder'
        end
        object lblMRatingVal: TLabel
          Left = 105
          Top = 55
          Width = 51
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '100,00 %'
        end
        object lblAMRating: TLabel
          Left = 8
          Top = 68
          Width = 93
          Height = 13
          Caption = 'Attacking Midfielder'
        end
        object lblAMRatingVal: TLabel
          Left = 105
          Top = 68
          Width = 51
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '100,00 %'
        end
        object lblWRating: TLabel
          Left = 8
          Top = 81
          Width = 34
          Height = 13
          Caption = 'Winger'
        end
        object lblWRatingVal: TLabel
          Left = 105
          Top = 81
          Width = 51
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '100,00 %'
        end
        object lblARating: TLabel
          Left = 8
          Top = 94
          Width = 40
          Height = 13
          Caption = 'Attacker'
        end
        object lblARatingVal: TLabel
          Left = 105
          Top = 94
          Width = 51
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '100,00 %'
        end
      end
      object gbPersonData: TGroupBox
        Left = 345
        Top = 31
        Width = 160
        Height = 126
        Caption = 'Person Data'
        TabOrder = 3
        object lblAdaptability: TLabel
          Left = 8
          Top = 16
          Width = 54
          Height = 13
          Caption = 'Adaptability'
        end
        object lblAdaptabilityVal: TLabel
          Left = 133
          Top = 16
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblAmbition: TLabel
          Left = 8
          Top = 29
          Width = 40
          Height = 13
          Caption = 'Ambition'
        end
        object lblAmbitionVal: TLabel
          Left = 133
          Top = 29
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblControversy: TLabel
          Left = 8
          Top = 42
          Width = 56
          Height = 13
          Caption = 'Controversy'
        end
        object lblControversyVal: TLabel
          Left = 133
          Top = 42
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblLoyality: TLabel
          Left = 8
          Top = 55
          Width = 35
          Height = 13
          Caption = 'Loyality'
        end
        object lblLoyalityVal: TLabel
          Left = 133
          Top = 55
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblPressure: TLabel
          Left = 8
          Top = 68
          Width = 41
          Height = 13
          Caption = 'Pressure'
        end
        object lblPressureVal: TLabel
          Left = 133
          Top = 68
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblProfessionalism: TLabel
          Left = 8
          Top = 81
          Width = 72
          Height = 13
          Caption = 'Professionalism'
        end
        object lblProfessionalismVal: TLabel
          Left = 133
          Top = 81
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblSportsmanship: TLabel
          Left = 8
          Top = 94
          Width = 69
          Height = 13
          Caption = 'Sportsmanship'
        end
        object lblSportsmanshipVal: TLabel
          Left = 133
          Top = 94
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
        object lblTemperament: TLabel
          Left = 8
          Top = 107
          Width = 65
          Height = 13
          Caption = 'Temperament'
        end
        object lblTemperamentVal: TLabel
          Left = 133
          Top = 107
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '20'
        end
      end
    end
    object tsInformation: TTabSheet
      Caption = '&Information'
      ImageIndex = 3
      object gbOverview: TInfoGroupBox
        Left = 8
        Top = 8
        Width = 244
        Height = 24
        Caption = 'Overview'
        TabOrder = 0
        MaxHeight = 177
      end
      object gbContractDetails: TInfoGroupBox
        Left = 261
        Top = 8
        Width = 244
        Height = 24
        Caption = 'Contract Details'
        TabOrder = 1
        MaxHeight = 177
      end
    end
  end
  object pnlNameClub: TPanel
    Left = 8
    Top = 8
    Width = 521
    Height = 49
    TabOrder = 1
    object lblPositionAge: TLabel
      Left = 8
      Top = 30
      Width = 505
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNameClub: TLabel
      Left = 8
      Top = 3
      Width = 505
      Height = 24
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
