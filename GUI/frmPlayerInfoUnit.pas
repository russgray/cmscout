unit frmPlayerInfoUnit;

interface

uses
  Forms, ExtCtrls, CMScoutControls, Controls, StdCtrls,
  ComCtrls, Classes, CM4SaveGameData, CM4SaveGameDatabase,
  SysUtils, CM4SupportClasses;

type
  TfrmPlayerInfo = class(TForm)
    pcPlayerInfo: TPageControl;
    tsProfile: TTabSheet;
    gbTechnical: TGroupBox;
    gbMental: TGroupBox;
    gbPhysical: TGroupBox;
    lblCrossing: TLabel;
    lblCrossingVal: TLabel;
    lblDribbling: TLabel;
    lblDribblingVal: TLabel;
    lblFinishing: TLabel;
    lblFinishingVal: TLabel;
    lblHeading: TLabel;
    lblHeadingVal: TLabel;
    lblLongShots: TLabel;
    lblLongShotsVal: TLabel;
    lblLongThrows: TLabel;
    lblLongThrowsVal: TLabel;
    lblMarking: TLabel;
    lblMarkingVal: TLabel;
    lblPassing: TLabel;
    lblPassingVal: TLabel;
    lblPenaltyTaking: TLabel;
    lblPenaltyTakingVal: TLabel;
    lblSetPieces: TLabel;
    lblSetPiecesVal: TLabel;
    lblTackling: TLabel;
    lblTacklingVal: TLabel;
    lblTechnique: TLabel;
    lblTechniqueVal: TLabel;
    lblAggression: TLabel;
    lblAggressionVal: TLabel;
    lblAnticipation: TLabel;
    lblAnticipationVal: TLabel;
    lblBravery: TLabel;
    lblBraveryVal: TLabel;
    lblCreativity: TLabel;
    lblCreativityVal: TLabel;
    lblDecisions: TLabel;
    lblDecisionsVal: TLabel;
    lblDetermination: TLabel;
    lblDeterminationVal: TLabel;
    lblFlair: TLabel;
    lblFlairVal: TLabel;
    lblInfluence: TLabel;
    lblInfluenceVal: TLabel;
    lblOffTheBall: TLabel;
    lblOffTheBallVal: TLabel;
    lblPositioning: TLabel;
    lblPositioningVal: TLabel;
    lblTeamwork: TLabel;
    lblTeamworkVal: TLabel;
    lblWorkRate: TLabel;
    lblWorkRateVal: TLabel;
    lblAcceleration: TLabel;
    lblAccelerationVal: TLabel;
    lblAgility: TLabel;
    lblAgilityVal: TLabel;
    lblBalance: TLabel;
    lblBalanceVal: TLabel;
    lblJumping: TLabel;
    lblJumpingVal: TLabel;
    lblPace: TLabel;
    lblPaceVal: TLabel;
    lblStamina: TLabel;
    lblStaminaVal: TLabel;
    lblStrength: TLabel;
    lblStrengthVal: TLabel;
    pnlNameClub: TPanel;
    lblPositionAge: TLabel;
    lblNameClub: TLabel;
    tsHidden: TTabSheet;
    gbGoalkeeping: TGroupBox;
    lblAerialAbility: TLabel;
    lblAerialAbilityVal: TLabel;
    lblCommandOfArea: TLabel;
    lblCommandOfAreaVal: TLabel;
    lblCommunication: TLabel;
    lblCommunicationVal: TLabel;
    lblEccentricity: TLabel;
    lblEccentricityVal: TLabel;
    lblHandling: TLabel;
    lblHandlingVal: TLabel;
    lblKicking: TLabel;
    lblKickingVal: TLabel;
    lblOneOnOnes: TLabel;
    lblOneOnOnesVal: TLabel;
    lblReflexes: TLabel;
    lblReflexesVal: TLabel;
    lblRushingOut: TLabel;
    lblRushingOutVal: TLabel;
    lblTendencyToPunch: TLabel;
    lblTendencyToPunchVal: TLabel;
    lblThrowing: TLabel;
    lblThrowingVal: TLabel;
    lblUnprotected: TLabel;
    lblOnLoan: TLabel;
    lblPreferredFoot: TLabel;
    lblPreferredFootVal: TLabel;
    cbHiddenAttributes: TGroupBox;
    lblFirstTouch: TLabel;
    lblFirstTouchVal: TLabel;
    lblThrowIns: TLabel;
    lblThrowInsVal: TLabel;
    lblConsistency: TLabel;
    lblConsistencyVal: TLabel;
    lblCorners: TLabel;
    lblCornersVal: TLabel;
    lblDirtiness: TLabel;
    lblDirtinessVal: TLabel;
    lblImportantMatches: TLabel;
    lblImportantMatchesVal: TLabel;
    lblInjuryProneness: TLabel;
    lblInjuryPronenessVal: TLabel;
    lblNaturalFitness: TLabel;
    lblNaturalFitnessVal: TLabel;
    lblVersatility: TLabel;
    lblVersatilityVal: TLabel;
    lblLeftFoot: TLabel;
    lblLeftFootVal: TLabel;
    lblRightFoot: TLabel;
    lblRightFootVal: TLabel;
    gbPositions: TGroupBox;
    lblGoalkeeper: TLabel;
    lblGoalkeeperVal: TLabel;
    lblSweeper: TLabel;
    lblSweeperVal: TLabel;
    lblDefender: TLabel;
    lblDefenderVal: TLabel;
    lblDefensiveMidfielder: TLabel;
    lblDefensiveMidfielderVal: TLabel;
    lblMidfielder: TLabel;
    lblMidfielderVal: TLabel;
    lblAttackingMidfielder: TLabel;
    lblAttackingMidfielderVal: TLabel;
    lblAttacker: TLabel;
    lblAttackerVal: TLabel;
    lblWingBack: TLabel;
    lblWingBackVal: TLabel;
    lblFreeRole: TLabel;
    lblFreeRoleVal: TLabel;
    lblRightSide: TLabel;
    lblRightSideVal: TLabel;
    lblLeftSide: TLabel;
    lblLeftSideVal: TLabel;
    lblCentral: TLabel;
    lblCentralVal: TLabel;
    tsAbility: TTabSheet;
    gbAbility: TGroupBox;
    gbReputation: TGroupBox;
    gbScoutRating: TGroupBox;
    lblCurrentAbility: TLabel;
    lblCurrentAbilityVal: TLabel;
    lblPotentialAbility: TLabel;
    lblPotentialAbilityVal: TLabel;
    lblHomeReputation: TLabel;
    lblHomeReputationVal: TLabel;
    lblCurrentReputation: TLabel;
    lblCurrentReputationVal: TLabel;
    lblWorldReputation: TLabel;
    lblWorldReputationVal: TLabel;
    lblGKRating: TLabel;
    lblGKRatingVal: TLabel;
    lblDRating: TLabel;
    lblDRatingVal: TLabel;
    lblDMRating: TLabel;
    lblDMRatingVal: TLabel;
    lblMRating: TLabel;
    lblMRatingVal: TLabel;
    lblAMRating: TLabel;
    lblAMRatingVal: TLabel;
    lblWRating: TLabel;
    lblWRatingVal: TLabel;
    lblARating: TLabel;
    lblARatingVal: TLabel;
    gbPersonData: TGroupBox;
    lblAdaptability: TLabel;
    lblAdaptabilityVal: TLabel;
    lblAmbition: TLabel;
    lblAmbitionVal: TLabel;
    lblControversy: TLabel;
    lblControversyVal: TLabel;
    lblLoyality: TLabel;
    lblLoyalityVal: TLabel;
    lblPressure: TLabel;
    lblPressureVal: TLabel;
    lblProfessionalism: TLabel;
    lblProfessionalismVal: TLabel;
    lblSportsmanship: TLabel;
    lblSportsmanshipVal: TLabel;
    lblTemperament: TLabel;
    lblTemperamentVal: TLabel;
    tsInformation: TTabSheet;
    gbOverview: TInfoGroupBox;
    gbContractDetails: TInfoGroupBox;
    procedure FormCreate(Sender: TObject);
  private
    FPlayer: TCM4Player;
    FCMData: TCM4SaveGameDatabase;
    FDateFormat: TFormatSettings;
    procedure SetPlayer(const Value: TCM4Player);
  public
    property Player: TCM4Player read FPlayer write SetPlayer;
    property CMData: TCM4SaveGameDatabase read FCMData write FCMData;
  end;

var
  frmPlayerInfo: TfrmPlayerInfo;

implementation

{$R *.dfm}

{ TfrmPlayerInfo }

procedure TfrmPlayerInfo.SetPlayer(const Value: TCM4Player);
var
  TempDbl: Double;
  j: Integer;
  ContractBox: TInfoGroupBox;
  ContractType: string;
  Tokenizer: TCM4Tokenizer;
begin
  FPlayer:=Value;

  Tokenizer:=TCM4Tokenizer.Create;

  // Caption
  if Player.FirstName <> nil then
    Tokenizer.Add(Player.FirstName.Name);
  if Player.CommonName <> nil then
    Tokenizer.Add('''' + Player.CommonName.Name + '''');
  if Player.SecondName <> nil then
    Tokenizer.Add(Player.SecondName.Name);
  if Player.ClubTeam <> nil then
    Tokenizer.Add('(' + Player.ClubTeam.SquadName + ')');
  Caption:=Tokenizer.Serialize(' ');

  // Number, Name, Club
  Tokenizer.Clear;
  if (Player.ClubContract <> nil) and (Player.ClubContract.SquadNumber > 0) then
    Tokenizer.Add(IntToStr(Player.ClubContract.SquadNumber) + '.');
  Tokenizer.Add(Player.Name);
  if Player.ClubTeam <> nil then
    Tokenizer.Add('(' + Player.SquadName + ')');
  lblNameClub.Caption:=Tokenizer.Serialize(' ');

  // Position, Nationality, Age
  Tokenizer.Clear;
  Tokenizer.Add((Player as ICM4Player).LongPosition);
  if Player.Nation <> nil then
    if Player.Nation.Nationality <> '' then
      Tokenizer.Add(', ' + Player.Nation.Nationality)
    else
      Tokenizer.Add(', ' + Player.Nation.ShortName);
  if Player.InternationalApps > 0 then
  begin
    Tokenizer.Add(' (' + IntToStr(Player.InternationalApps));
    Tokenizer.Add(' cap');
    if Player.InternationalApps > 1 then
      Tokenizer.Add('s');

    if Player.InternationalGoals > 0 then
    begin
      Tokenizer.Add('/' + IntToStr(Player.InternationalGoals));
      Tokenizer.Add(' goal');
      if Player.InternationalGoals > 1 then
        Tokenizer.Add('s');
    end;

    Tokenizer.Add(')');
  end;

  Tokenizer.Add(', Age ' + IntToStr(Player.DateOfBirth.Age(CMData.GameDate)));
  lblPositionAge.Caption:=Tokenizer.Serialize('');

  // Is technical or goalkeeping hidden??
  if (Player as ICM4Player).PlayerData.PlayingData.Goalkeeper >= POSITION_THRESHOLD then
  begin
    gbGoalkeeping.Parent:=tsProfile;
    gbTechnical.Parent:=tsHidden;
  end
  else
  begin
    gbGoalkeeping.Parent:=tsHidden;
    gbTechnical.Parent:=tsProfile;
  end;

  // Techincal
  lblCrossingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Crossing);
  lblDribblingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Dribbling);
  lblFinishingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Finishing);
  lblHeadingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Heading);
  lblLongShotsVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.LongShots);
  lblLongThrowsVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.LongThrows);
  lblMarkingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Marking);
  lblPassingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Passing);
  lblPenaltyTakingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Penalties);
  lblSetPiecesVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.SetPieces);
  lblTacklingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Tackling);
  lblTechniqueVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Technique);

  // Mental
  lblAggressionVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Aggression);
  lblAnticipationVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Anticipation);
  lblBraveryVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Bravery);
  lblCreativityVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Creativity);
  lblDecisionsVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Decisions);
  lblDeterminationVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Determination);
  lblFlairVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Flair);
  lblInfluenceVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Influence);
  lblOffTheBallVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.OffTheBall);
  lblPositioningVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Positioning);
  lblTeamworkVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Teamwork);
  lblWorkRateVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.WorkRate);

  // Physical
  lblAccelerationVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Acceleration);
  lblAgilityVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Agility);
  lblBalanceVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Balance);
  lblJumpingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Jumping);
  lblPaceVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Pace);
  lblStaminaVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Stamina);
  lblStrengthVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Strength);

  // Goalkeeping
  lblAerialAbilityVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.AerialAbility);
  lblCommandOfAreaVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.CommandOfArea);
  lblCommunicationVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Communication);
  lblEccentricityVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Eccentricity);
  lblHandlingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Handling);
  lblKickingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Kicking);
  lblOneOnOnesVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.OneOnOnes);
  lblReflexesVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Reflexes);
  lblRushingOutVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.RushingOut);
  lblTendencyToPunchVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.TendencyToPunch);
  lblThrowingVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Throwing);

  // On Loan
  lblOnLoan.Caption:='';
  if (Player.ClubContract <> nil) and (Player.ClubContract is TCM4LoanContract) and (Player.Contracts.FullContract <> nil) then
    lblOnLoan.Caption:='On loan from ' + Player.Contracts.FullContract.TeamContainer.ShortName;

  // Unprotected
  lblUnprotected.Caption:='';
  if (Player.Contracts.FullContract <> nil) and ((Player.DateOfBirth.Age(CMData.GameDate) < 17) or (Player.Contracts.FullContract.EndDate.MonthToMonth)) then
    lblUnprotected.Caption:='Contract is not protected';

  // Preferred Foot
  if ((Player as ICM4Player).PlayerData.PlayingData.LeftFoot > 13) and ((Player as ICM4Player).PlayerData.PlayingData.RightFoot > 13) then
    lblPreferredFootVal.Caption:='Either'
  else if (Player as ICM4Player).PlayerData.PlayingData.LeftFoot > 13 then
  begin
    if (Player as ICM4Player).PlayerData.PlayingData.RightFoot < 8 then
      lblPreferredFootVal.Caption:='Left Only'
    else
      lblPreferredFootVal.Caption:='Left';
  end
  else
  begin
    if (Player as ICM4Player).PlayerData.PlayingData.LeftFoot < 8 then
      lblPreferredFootVal.Caption:='Right Only'
    else
      lblPreferredFootVal.Caption:='Right';
  end;

  // Hidden Attributes
  lblFirstTouchVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.FirstTouch);
  lblThrowInsVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.ThrowIns);
  lblConsistencyVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Consistency);
  lblCornersVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Corners);
  lblDirtinessVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Dirtiness);
  lblImportantMatchesVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.ImportantMatches);
  lblInjuryPronenessVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.InjuryProneness);
  lblNaturalFitnessVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.NaturalFitness);
  lblVersatilityVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Versatility);
  lblLeftFootVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.LeftFoot);
  lblRightFootVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.RightFoot);

  // Postitions
  lblGoalkeeperVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Goalkeeper);
  lblSweeperVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Sweeper);
  lblDefenderVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Defender);
  lblDefensiveMidfielderVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.DefensiveMidfielder);
  lblMidfielderVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Midfielder);
  lblAttackingMidfielderVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.AttackingMidfielder);
  lblAttackerVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Attacker);
  lblWingBackVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.WingBack);
  lblFreeRoleVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.FreeRole);
  lblRightSideVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.RightSide);
  lblLeftSideVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.LeftSide);
  lblCentralVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PlayingData.Central);

  // Ability
  lblCurrentAbilityVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.CurrentAbility);
  lblPotentialAbilityVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.PotentialAbility);

  // Reputation
  lblHomeReputationVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.HomeReputation);
  lblCurrentReputationVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.CurrentReputation);
  lblWorldReputationVal.Caption:=IntToStr((Player as ICM4Player).PlayerData.WorldReputation);

  // Scout Ratings
  lblGKRatingVal.Caption:=Format('%.2f %%', [(Player as ICM4Player).ScoutRating.GKRating]);
  lblDRatingVal.Caption:=Format('%.2f %%', [(Player as ICM4Player).ScoutRating.DRating]);
  lblDMRatingVal.Caption:=Format('%.2f %%', [(Player as ICM4Player).ScoutRating.DMRating]);
  lblMRatingVal.Caption:=Format('%.2f %%', [(Player as ICM4Player).ScoutRating.MRating]);
  lblAMRatingVal.Caption:=Format('%.2f %%', [(Player as ICM4Player).ScoutRating.AMRating]);
  lblWRatingVal.Caption:=Format('%.2f %%', [(Player as ICM4Player).ScoutRating.WRating]);
  lblARatingVal.Caption:=Format('%.2f %%', [(Player as ICM4Player).ScoutRating.ARating]);

  // Person Data
  lblAdaptabilityVal.Caption:=IntToStr(Player.PersonData.Adaptability);
  lblAmbitionVal.Caption:=IntToStr(Player.PersonData.Ambition);
  lblControversyVal.Caption:=IntToStr(Player.PersonData.Controversy);
  lblLoyalityVal.Caption:=IntToStr(Player.PersonData.Loyality);
  lblPressureVal.Caption:=IntToStr(Player.PersonData.Pressure);
  lblProfessionalismVal.Caption:=IntToStr(Player.PersonData.Professionalism);
  lblSportsmanshipVal.Caption:=IntToStr(Player.PersonData.Sportsmanship);
  lblTemperamentVal.Caption:=IntToStr(Player.PersonData.Temperament);

  // Overview
  gbOverview.Clear;
  if Player.CommonName <> nil then
    gbOverview.AddInfo('Full Name', Player.FullName);
  gbOverview.AddInfo('Date Of Birth', DateToStr(Player.DateOfBirth.Date, FDateFormat));
  TempDbl:=(Player as ICM4Player).PlayerData.DisplayValue;
  gbOverview.AddInfo('Value', Format('£%.0n', [TempDbl]));
  TempDbl:=(Player as ICM4Player).PlayerData.SaleValue;
  gbOverview.AddInfo('Sale Value', Format('£%.0n', [TempDbl]));

  if Player.Contracts.FullContract <> nil then
  begin
    if (Player.Contracts.FullContract.TransferStatus <> 0) and (Player.Contracts.FullContract.TransferStatus <> 4) and (Player.Contracts.FullContract.TransferStatus <> 32) then
    begin
      if Player.Contracts.FullContract.TransferStatus and 1 = 1 then
        gbOverview.AddInfo('Availability', 'Transfer Listed By Club');

      if Player.Contracts.FullContract.TransferStatus and 2 = 2 then
        gbOverview.AddInfo('Availability', 'Listed For Loan');

      if Player.Contracts.FullContract.TransferStatus and 8 = 8 then
        gbOverview.AddInfo('Availability', 'Transfer Listed By Request');

      if Player.Contracts.FullContract.TransferStatus and 16 = 16 then
        gbOverview.AddInfo('Availability', 'Unavailable For Transfer');

      if Player.Contracts.FullContract.TransferStatus and 64 = 64 then
        gbOverview.AddInfo('Availability', 'Unavailable For Loan');
    end
    else
      gbOverview.AddInfo('Availability', 'Unknown');
  end
  else
    gbOverview.AddInfo('Availabiliy', 'Unknown');

  for j:=0 to Player.AdditionalNations.Count - 1 do
    if Player.AdditionalNations[j].Nationality <> '' then
      gbOverview.AddInfo('Other Nationalities', Player.AdditionalNations[j].Nationality)
    else
      gbOverview.AddInfo('Other Nationalities', Player.AdditionalNations[j].ShortName);

  // Contract Details
  gbContractDetails.Clear;
  for j:=0 to Player.Contracts.Count - 1 do
  begin
    if Player.Contracts[j].TeamContainerType = TC_CLUB then
    begin
      ContractBox:=TInfoGroupBox.Create(gbContractDetails);
      ContractBox.Parent:=gbContractDetails;
      ContractBox.Caption:=Player.Contracts[j].TeamContainer.ShortName;

      if Player.Contracts[j] is TCM4FullContract then
      begin
        if Player.DateOfBirth.Age(CMData.GameDate) < 17 then
          ContractType:='Youth Contract'
        else
        begin
          if TCM4FullContract(Player.Contracts[j]).FullTime then
            ContractType:='Full Time'
          else
            ContractType:='Part Time';
          if Player.Contracts[j].EndDate.MonthToMonth then
            ContractType:=ContractType + ' Month To Month Contract'
          else
            ContractType:=ContractType + ' Contract'
        end;

        ContractBox.AddInfo('Type', ContractType);
      end
      else if Player.Contracts[j] is TCM4LoanContract then
        ContractBox.AddInfo('Type', 'Loan Contract')
      else if Player.Contracts[j] is TCM4TrialContract then
        ContractBox.AddInfo('Type', 'Trial Contract');

      TempDbl:=Player.Contracts[j].Wage;
      ContractBox.AddInfo('Wages', Format('£%.0n per week', [TempDbl]));

      if Player.Contracts[j].EndDate.MonthToMonth then
        ContractBox.AddInfo('Expires', 'N/A')
      else
        ContractBox.AddInfo('Expires', DateToStr(Player.Contracts[j].EndDate.Date, FDateFormat));

      ContractBox.AddInfo('Squad Status', Player.Contracts[j].LongSquadStatusText);

      if Player.Contracts[j] is TCM4FullContract then
      begin
        if Player.MinimumFeeClause <> nil then
        begin
          TempDbl:=Player.MinimumFee;
          ContractBox.AddInfo('Clauses', 'Minimum Fee ' + Format('£%.0n', [TempDbl]));
        end;

        if Player.RelegationClause <> nil then
        begin
          TempDbl:=Player.RelegationFee;
          ContractBox.AddInfo('Clauses', 'Relegation Fee ' + Format('£%.0n', [TempDbl]), Player.RelegationClause.ClauseType = 9);
        end;

        if Player.NonPromotionClause <> nil then
        begin
          TempDbl:=Player.NonPromotionFee;
          ContractBox.AddInfo('Clauses', 'Non Promotion Fee ' + Format('£%.0n', [TempDbl]), Player.NonPromotionClause.ClauseType = 9);
        end;
      end;

      gbContractDetails.AddBox(ContractBox);
    end;
  end;

  Tokenizer.Free;
end;

procedure TfrmPlayerInfo.FormCreate(Sender: TObject);
begin
  FDateFormat.DateSeparator:='.';
  FDateFormat.ShortDateFormat:='dd.mm.yyyy';
end;

end.
