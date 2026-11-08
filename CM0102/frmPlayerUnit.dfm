object FfrmPlayer: TFfrmPlayer
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Player Name (Club)'
  ClientHeight = 330
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FpnlCaption: TPanel
    Left = 8
    Top = 8
    Width = 465
    Height = 35
    Caption = 'Player Name (Club)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object FpnlBorn: TPanel
    Left = 8
    Top = 48
    Width = 465
    Height = 22
    Caption = 'FpnlBorn'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object FpcData: TPageControl
    Left = 8
    Top = 73
    Width = 465
    Height = 229
    ActivePage = FtsTransfer
    TabIndex = 3
    TabOrder = 2
    object FtsProfile: TTabSheet
      Caption = '&Profile'
      object FlblAccelerationLabel: TLabel
        Left = 8
        Top = 8
        Width = 62
        Height = 13
        Caption = 'Acceleration:'
        Color = clBtnFace
        ParentColor = False
      end
      object FlblAcceleration: TLabel
        Left = 128
        Top = 8
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblAggressionLabel: TLabel
        Left = 8
        Top = 24
        Width = 55
        Height = 13
        Caption = 'Aggression:'
      end
      object FlblAgilityLabel: TLabel
        Left = 8
        Top = 40
        Width = 30
        Height = 13
        Caption = 'Agility:'
      end
      object FlblAnticipationLabel: TLabel
        Left = 8
        Top = 56
        Width = 58
        Height = 13
        Caption = 'Anticipation:'
      end
      object FlblBalanceLabel: TLabel
        Left = 8
        Top = 72
        Width = 42
        Height = 13
        Caption = 'Balance:'
      end
      object FlblBraveryLabel: TLabel
        Left = 8
        Top = 88
        Width = 39
        Height = 13
        Caption = 'Bravery:'
      end
      object FlblCreativityLabel: TLabel
        Left = 8
        Top = 104
        Width = 46
        Height = 13
        Caption = 'Creativity:'
      end
      object FlblCrossingLabel: TLabel
        Left = 8
        Top = 120
        Width = 43
        Height = 13
        Caption = 'Crossing:'
      end
      object FlblDecisionsLabel: TLabel
        Left = 8
        Top = 136
        Width = 49
        Height = 13
        Caption = 'Decisions:'
      end
      object FlblDeterminationLabel: TLabel
        Left = 8
        Top = 152
        Width = 68
        Height = 13
        Caption = 'Determination:'
      end
      object FlblDribblingLabel: TLabel
        Left = 8
        Top = 168
        Width = 44
        Height = 13
        Caption = 'Dribbling:'
      end
      object FlblFinishingLabel: TLabel
        Left = 8
        Top = 184
        Width = 44
        Height = 13
        Caption = 'Finishing:'
      end
      object FlblAggression: TLabel
        Left = 128
        Top = 24
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblAgility: TLabel
        Left = 128
        Top = 40
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblAnticipation: TLabel
        Left = 128
        Top = 56
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblBalance: TLabel
        Left = 128
        Top = 72
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblBravery: TLabel
        Left = 128
        Top = 88
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblCreativity: TLabel
        Left = 128
        Top = 104
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblCrossing: TLabel
        Left = 128
        Top = 120
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblDecisions: TLabel
        Left = 128
        Top = 136
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblDetermination: TLabel
        Left = 128
        Top = 152
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblDribbling: TLabel
        Left = 128
        Top = 168
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblFinishing: TLabel
        Left = 128
        Top = 184
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblFlairLabel: TLabel
        Left = 160
        Top = 8
        Width = 22
        Height = 13
        Caption = 'Flair:'
      end
      object FlblHandlingLabel: TLabel
        Left = 160
        Top = 24
        Width = 45
        Height = 13
        Caption = 'Handling:'
      end
      object FlblHeadingLabel: TLabel
        Left = 160
        Top = 40
        Width = 43
        Height = 13
        Caption = 'Heading:'
      end
      object FlblInfluenceLabel: TLabel
        Left = 160
        Top = 56
        Width = 47
        Height = 13
        Caption = 'Influence:'
      end
      object FlblJumpingLabel: TLabel
        Left = 160
        Top = 72
        Width = 42
        Height = 13
        Caption = 'Jumping:'
      end
      object FlblLongShotsLabel: TLabel
        Left = 160
        Top = 88
        Width = 57
        Height = 13
        Caption = 'Long Shots:'
      end
      object FlblMarkingLabel: TLabel
        Left = 160
        Top = 104
        Width = 41
        Height = 13
        Caption = 'Marking:'
      end
      object FlblOffTheBallLabel: TLabel
        Left = 160
        Top = 120
        Width = 59
        Height = 13
        Caption = 'Off The Ball:'
      end
      object FlblPaceLabel: TLabel
        Left = 160
        Top = 136
        Width = 28
        Height = 13
        Caption = 'Pace:'
      end
      object FlblPassingLabel: TLabel
        Left = 160
        Top = 152
        Width = 40
        Height = 13
        Caption = 'Passing:'
      end
      object FlblPositioningLabel: TLabel
        Left = 160
        Top = 168
        Width = 54
        Height = 13
        Caption = 'Positioning:'
      end
      object FlblReflexesLabel: TLabel
        Left = 160
        Top = 184
        Width = 44
        Height = 13
        Caption = 'Reflexes:'
      end
      object FlblFlair: TLabel
        Left = 280
        Top = 8
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblHandling: TLabel
        Left = 280
        Top = 24
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblHeading: TLabel
        Left = 280
        Top = 40
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblInfluence: TLabel
        Left = 280
        Top = 56
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblJumping: TLabel
        Left = 280
        Top = 72
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblLongShots: TLabel
        Left = 280
        Top = 88
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblMarking: TLabel
        Left = 280
        Top = 104
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblOffTheBall: TLabel
        Left = 280
        Top = 120
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblPace: TLabel
        Left = 280
        Top = 136
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblPassing: TLabel
        Left = 280
        Top = 152
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblPositioning: TLabel
        Left = 280
        Top = 168
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblReflexes: TLabel
        Left = 280
        Top = 184
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblSetPiecesLabel: TLabel
        Left = 312
        Top = 8
        Width = 54
        Height = 13
        Caption = 'Set Pieces:'
      end
      object FlblSetPieces: TLabel
        Left = 432
        Top = 8
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblStrengthLabel: TLabel
        Left = 312
        Top = 40
        Width = 43
        Height = 13
        Caption = 'Strength:'
      end
      object FlblTacklingLabel: TLabel
        Left = 312
        Top = 56
        Width = 44
        Height = 13
        Caption = 'Tackling:'
      end
      object FlblTeamworkLabel: TLabel
        Left = 312
        Top = 72
        Width = 53
        Height = 13
        Caption = 'Teamwork:'
      end
      object FlblTechniqueLabel: TLabel
        Left = 312
        Top = 88
        Width = 54
        Height = 13
        Caption = 'Technique:'
      end
      object FlblWorkRateLabel: TLabel
        Left = 312
        Top = 104
        Width = 55
        Height = 13
        Caption = 'Work Rate:'
      end
      object FlblLeftFootLabel: TLabel
        Left = 312
        Top = 136
        Width = 45
        Height = 13
        Caption = 'Left Foot:'
      end
      object FlblRightFootLabel: TLabel
        Left = 312
        Top = 152
        Width = 52
        Height = 13
        Caption = 'Right Foot:'
      end
      object FlblMoraleLabel: TLabel
        Left = 312
        Top = 184
        Width = 35
        Height = 13
        Caption = 'Morale:'
      end
      object FlblStaminaLabel: TLabel
        Left = 312
        Top = 24
        Width = 41
        Height = 13
        Caption = 'Stamina:'
      end
      object FlblStamina: TLabel
        Left = 432
        Top = 24
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblStrength: TLabel
        Left = 432
        Top = 40
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblTackling: TLabel
        Left = 432
        Top = 56
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblTeamwork: TLabel
        Left = 432
        Top = 72
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblTechnique: TLabel
        Left = 432
        Top = 88
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblWorkRate: TLabel
        Left = 432
        Top = 104
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblLeftFoot: TLabel
        Left = 432
        Top = 136
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblRightFoot: TLabel
        Left = 432
        Top = 152
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblMorale: TLabel
        Left = 432
        Top = 184
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
    end
    object FtsHidden: TTabSheet
      Caption = '&Hidden'
      ImageIndex = 1
      object FlblAdaptabilityLabel: TLabel
        Left = 8
        Top = 8
        Width = 57
        Height = 13
        Caption = 'Adaptability:'
      end
      object FlblAmbitionLabel: TLabel
        Left = 8
        Top = 24
        Width = 43
        Height = 13
        Caption = 'Ambition:'
      end
      object FlblConsistencyLabel: TLabel
        Left = 8
        Top = 40
        Width = 60
        Height = 13
        Caption = 'Consistency:'
      end
      object FlblCornersLabel: TLabel
        Left = 8
        Top = 56
        Width = 39
        Height = 13
        Caption = 'Corners:'
      end
      object FlblDirtinessLabel: TLabel
        Left = 8
        Top = 72
        Width = 43
        Height = 13
        Caption = 'Dirtiness:'
      end
      object FlblImportantMatchesLabel: TLabel
        Left = 8
        Top = 88
        Width = 91
        Height = 13
        Caption = 'Important Matches:'
      end
      object FlblInjuryPronenessLabel: TLabel
        Left = 8
        Top = 104
        Width = 81
        Height = 13
        Caption = 'Injury Proneness:'
      end
      object FlblLoyalityLabel: TLabel
        Left = 8
        Top = 120
        Width = 38
        Height = 13
        Caption = 'Loyality:'
      end
      object FlblNaturalFitnessLabel: TLabel
        Left = 8
        Top = 136
        Width = 73
        Height = 13
        Caption = 'Natural Fitness:'
      end
      object FlblOneOnOnesLabel: TLabel
        Left = 8
        Top = 152
        Width = 68
        Height = 13
        Caption = 'One On Ones:'
      end
      object FlblPenaltiesLabel: TLabel
        Left = 8
        Top = 168
        Width = 46
        Height = 13
        Caption = 'Penalties:'
      end
      object FlblPressureLabel: TLabel
        Left = 8
        Top = 184
        Width = 44
        Height = 13
        Caption = 'Pressure:'
      end
      object FlblProfessionalismLabel: TLabel
        Left = 160
        Top = 8
        Width = 75
        Height = 13
        Caption = 'Professionalism:'
      end
      object FlblSportsmanshipLabel: TLabel
        Left = 160
        Top = 24
        Width = 72
        Height = 13
        Caption = 'Sportsmanship:'
      end
      object FlblTemperamentLabel: TLabel
        Left = 160
        Top = 40
        Width = 68
        Height = 13
        Caption = 'Temperament:'
      end
      object FlblThrowInsLabel: TLabel
        Left = 160
        Top = 56
        Width = 50
        Height = 13
        Caption = 'Throw Ins:'
      end
      object FlblVersatilityLabel: TLabel
        Left = 160
        Top = 72
        Width = 47
        Height = 13
        Caption = 'Versatility:'
      end
      object FlblAbilityLabel: TLabel
        Left = 160
        Top = 104
        Width = 30
        Height = 13
        Caption = 'Ability:'
      end
      object FlblPotentialAbilityLabel: TLabel
        Left = 160
        Top = 120
        Width = 74
        Height = 13
        Caption = 'Potential Ability:'
      end
      object FlblHomeReputationLabel: TLabel
        Left = 160
        Top = 152
        Width = 86
        Height = 13
        Caption = 'Home Reputation:'
      end
      object FlblCurrentReputationLabel: TLabel
        Left = 160
        Top = 168
        Width = 92
        Height = 13
        Caption = 'Current Reputation:'
      end
      object FlblWorldReputationLabel: TLabel
        Left = 160
        Top = 184
        Width = 86
        Height = 13
        Caption = 'World Reputation:'
      end
      object FlblScoutRatingsLabel: TLabel
        Left = 312
        Top = 8
        Width = 85
        Height = 13
        Caption = 'Scout Ratings:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object FlblGoalkeeperScoutRatingLabel: TLabel
        Left = 312
        Top = 24
        Width = 58
        Height = 13
        Caption = 'Goalkeeper:'
      end
      object FlblDefenderScoutRatingLabel: TLabel
        Left = 312
        Top = 40
        Width = 47
        Height = 13
        Caption = 'Defender:'
      end
      object FlblDefensiveMidfielderScoutRatingLabel: TLabel
        Left = 312
        Top = 56
        Width = 99
        Height = 13
        Caption = 'Defensive Midfielder:'
      end
      object FlblMidfielderScoutRatingLabel: TLabel
        Left = 312
        Top = 72
        Width = 48
        Height = 13
        Caption = 'Midfielder:'
      end
      object FlblAttackingMidfielderScoutRatingLabel: TLabel
        Left = 312
        Top = 88
        Width = 96
        Height = 13
        Caption = 'Attacking Midfielder:'
      end
      object FlblWingScoutRatingLabel: TLabel
        Left = 312
        Top = 104
        Width = 28
        Height = 13
        Caption = 'Wing:'
      end
      object FlblAttackerScoutRatingLabel: TLabel
        Left = 312
        Top = 120
        Width = 43
        Height = 13
        Caption = 'Attacker:'
      end
      object FlblAdaptability: TLabel
        Left = 128
        Top = 8
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblAmbition: TLabel
        Left = 128
        Top = 24
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblConsistency: TLabel
        Left = 128
        Top = 40
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblInjuryProneness: TLabel
        Left = 128
        Top = 104
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblImportantMatches: TLabel
        Left = 128
        Top = 88
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblDirtiness: TLabel
        Left = 128
        Top = 72
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblCorners: TLabel
        Left = 128
        Top = 56
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblPressure: TLabel
        Left = 128
        Top = 184
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblPenalties: TLabel
        Left = 128
        Top = 168
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblOneOnOnes: TLabel
        Left = 128
        Top = 152
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblNaturalFitness: TLabel
        Left = 128
        Top = 136
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblLoyality: TLabel
        Left = 128
        Top = 120
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblProfessionalism: TLabel
        Left = 280
        Top = 8
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblSportsmanship: TLabel
        Left = 280
        Top = 24
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblTemperament: TLabel
        Left = 280
        Top = 40
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblThrowIns: TLabel
        Left = 280
        Top = 56
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblVersatility: TLabel
        Left = 280
        Top = 72
        Width = 15
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '20'
      end
      object FlblAbility: TLabel
        Left = 277
        Top = 104
        Width = 21
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '200'
      end
      object FlblPotentialAbility: TLabel
        Left = 277
        Top = 120
        Width = 21
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '200'
      end
      object FlblHomeReputation: TLabel
        Left = 270
        Top = 152
        Width = 35
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '10000'
      end
      object FlblScoutRatingGoalkeeper: TLabel
        Left = 407
        Top = 24
        Width = 48
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '100,00 %'
        Transparent = True
      end
      object FlblCurrentReputation: TLabel
        Left = 270
        Top = 168
        Width = 35
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '10000'
      end
      object FlblWorldReputation: TLabel
        Left = 270
        Top = 184
        Width = 35
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '10000'
      end
      object FlblScoutRatingDefender: TLabel
        Left = 407
        Top = 40
        Width = 48
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '100,00 %'
        Transparent = True
      end
      object FlblScoutRatingDefensiveMidfielder: TLabel
        Left = 407
        Top = 56
        Width = 48
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '100,00 %'
        Transparent = True
      end
      object FlblScoutRatingAttackingMidfielder: TLabel
        Left = 407
        Top = 88
        Width = 48
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '100,00 %'
        Transparent = True
      end
      object FlblScoutRatingMidfielder: TLabel
        Left = 407
        Top = 72
        Width = 48
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '100,00 %'
        Transparent = True
      end
      object FlblScoutRatingAttacker: TLabel
        Left = 407
        Top = 120
        Width = 48
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '100,00 %'
        Transparent = True
      end
      object FlblScoutRatingWing: TLabel
        Left = 407
        Top = 104
        Width = 48
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '100,00 %'
        Transparent = True
      end
    end
    object FtsContract: TTabSheet
      Caption = '&Contract'
      ImageIndex = 2
      object FlblContractLabels: TLabel
        Left = 8
        Top = 8
        Width = 66
        Height = 185
        AutoSize = False
        Caption = 'Squad Status'
      end
      object FlblContractInformation: TLabel
        Left = 88
        Top = 8
        Width = 361
        Height = 185
        AutoSize = False
        Caption = 'This Player is indispensable to the club'
      end
    end
    object FtsTransfer: TTabSheet
      Caption = '&Transfer'
      ImageIndex = 3
      object FlblTransferInformation: TLabel
        Left = 104
        Top = 8
        Width = 345
        Height = 185
        AutoSize = False
        Caption = 'Australian'
      end
      object FlblTransferLabels: TLabel
        Left = 8
        Top = 8
        Width = 92
        Height = 185
        AutoSize = False
        Caption = 'Second Nationality'
      end
    end
  end
  object FpnlPosition: TPanel
    Left = 8
    Top = 306
    Width = 465
    Height = 22
    Caption = 'Position'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
end
