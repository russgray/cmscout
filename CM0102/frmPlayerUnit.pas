unit frmPlayerUnit;

{ $Id: frmPlayerUnit.pas,v 1.1 2002/05/10 19:12:32 michael Exp $ }

interface

uses
  Forms, CMDataRepresentation, Classes, Controls, ExtCtrls,
  CMFunctions, SysUtils, StdCtrls, ComCtrls, ScoutRatingUnit;

type
  TFfrmPlayer = class(TForm)
    FpnlCaption: TPanel;
    FpnlBorn: TPanel;
    FpcData: TPageControl;
    FtsProfile: TTabSheet;
    FlblAccelerationLabel: TLabel;
    FlblAcceleration: TLabel;
    FlblAggressionLabel: TLabel;
    FlblAgilityLabel: TLabel;
    FlblAnticipationLabel: TLabel;
    FlblBalanceLabel: TLabel;
    FlblBraveryLabel: TLabel;
    FlblCreativityLabel: TLabel;
    FlblCrossingLabel: TLabel;
    FlblDecisionsLabel: TLabel;
    FlblDeterminationLabel: TLabel;
    FlblDribblingLabel: TLabel;
    FlblFinishingLabel: TLabel;
    FlblAggression: TLabel;
    FlblAgility: TLabel;
    FlblAnticipation: TLabel;
    FlblBalance: TLabel;
    FlblBravery: TLabel;
    FlblCreativity: TLabel;
    FlblCrossing: TLabel;
    FlblDecisions: TLabel;
    FlblDetermination: TLabel;
    FlblDribbling: TLabel;
    FlblFinishing: TLabel;
    FlblFlairLabel: TLabel;
    FlblHandlingLabel: TLabel;
    FlblHeadingLabel: TLabel;
    FlblInfluenceLabel: TLabel;
    FlblJumpingLabel: TLabel;
    FlblLongShotsLabel: TLabel;
    FlblMarkingLabel: TLabel;
    FlblOffTheBallLabel: TLabel;
    FlblPaceLabel: TLabel;
    FlblPassingLabel: TLabel;
    FlblPositioningLabel: TLabel;
    FlblReflexesLabel: TLabel;
    FlblFlair: TLabel;
    FlblHandling: TLabel;
    FlblHeading: TLabel;
    FlblInfluence: TLabel;
    FlblJumping: TLabel;
    FlblLongShots: TLabel;
    FlblMarking: TLabel;
    FlblOffTheBall: TLabel;
    FlblPace: TLabel;
    FlblPassing: TLabel;
    FlblPositioning: TLabel;
    FlblReflexes: TLabel;
    FlblSetPiecesLabel: TLabel;
    FlblSetPieces: TLabel;
    FlblStrengthLabel: TLabel;
    FlblTacklingLabel: TLabel;
    FlblTeamworkLabel: TLabel;
    FlblTechniqueLabel: TLabel;
    FlblWorkRateLabel: TLabel;
    FlblLeftFootLabel: TLabel;
    FlblRightFootLabel: TLabel;
    FlblMoraleLabel: TLabel;
    FlblStaminaLabel: TLabel;
    FlblStamina: TLabel;
    FlblStrength: TLabel;
    FlblTackling: TLabel;
    FlblTeamwork: TLabel;
    FlblTechnique: TLabel;
    FlblWorkRate: TLabel;
    FlblLeftFoot: TLabel;
    FlblRightFoot: TLabel;
    FlblMorale: TLabel;
    FtsHidden: TTabSheet;
    FlblAdaptabilityLabel: TLabel;
    FlblAmbitionLabel: TLabel;
    FlblConsistencyLabel: TLabel;
    FlblCornersLabel: TLabel;
    FlblDirtinessLabel: TLabel;
    FlblImportantMatchesLabel: TLabel;
    FlblInjuryPronenessLabel: TLabel;
    FlblLoyalityLabel: TLabel;
    FlblNaturalFitnessLabel: TLabel;
    FlblOneOnOnesLabel: TLabel;
    FlblPenaltiesLabel: TLabel;
    FlblPressureLabel: TLabel;
    FlblProfessionalismLabel: TLabel;
    FlblSportsmanshipLabel: TLabel;
    FlblTemperamentLabel: TLabel;
    FlblThrowInsLabel: TLabel;
    FlblVersatilityLabel: TLabel;
    FlblAbilityLabel: TLabel;
    FlblPotentialAbilityLabel: TLabel;
    FlblHomeReputationLabel: TLabel;
    FlblCurrentReputationLabel: TLabel;
    FlblWorldReputationLabel: TLabel;
    FlblScoutRatingsLabel: TLabel;
    FlblGoalkeeperScoutRatingLabel: TLabel;
    FlblDefenderScoutRatingLabel: TLabel;
    FlblDefensiveMidfielderScoutRatingLabel: TLabel;
    FlblMidfielderScoutRatingLabel: TLabel;
    FlblAttackingMidfielderScoutRatingLabel: TLabel;
    FlblWingScoutRatingLabel: TLabel;
    FlblAttackerScoutRatingLabel: TLabel;
    FlblAdaptability: TLabel;
    FlblAmbition: TLabel;
    FlblConsistency: TLabel;
    FlblInjuryProneness: TLabel;
    FlblImportantMatches: TLabel;
    FlblDirtiness: TLabel;
    FlblCorners: TLabel;
    FlblPressure: TLabel;
    FlblPenalties: TLabel;
    FlblOneOnOnes: TLabel;
    FlblNaturalFitness: TLabel;
    FlblLoyality: TLabel;
    FlblProfessionalism: TLabel;
    FlblSportsmanship: TLabel;
    FlblTemperament: TLabel;
    FlblThrowIns: TLabel;
    FlblVersatility: TLabel;
    FlblAbility: TLabel;
    FlblPotentialAbility: TLabel;
    FlblHomeReputation: TLabel;
    FlblScoutRatingGoalkeeper: TLabel;
    FlblCurrentReputation: TLabel;
    FlblWorldReputation: TLabel;
    FlblScoutRatingDefender: TLabel;
    FlblScoutRatingDefensiveMidfielder: TLabel;
    FlblScoutRatingAttackingMidfielder: TLabel;
    FlblScoutRatingMidfielder: TLabel;
    FlblScoutRatingAttacker: TLabel;
    FlblScoutRatingWing: TLabel;
    FpnlPosition: TPanel;
    FtsContract: TTabSheet;
    FlblContractLabels: TLabel;
    FlblContractInformation: TLabel;
    FtsTransfer: TTabSheet;
    FlblTransferInformation: TLabel;
    FlblTransferLabels: TLabel;
  private
    { Private declarations }
  public
    procedure ShowPlayer(Player: PStaff);
  end;

var
  FfrmPlayer: TFfrmPlayer;

implementation

uses
  frmMainUnit;

{$R *.dfm}

procedure TFfrmPlayer.ShowPlayer(Player: PStaff);
var
  dblTemp: Double;
begin
  Left:=FfrmMain.Left + ((FfrmMain.Width - Width) div 2);
  Top:=FfrmMain.Top + ((FfrmMain.Height - Height) div 2);

  Caption:=Player.FirstName.Name + ' ' + Player.SecondName.Name;

  if ((Player.CommonName <> nil) and (Player.CommonName.Name <> '')) then
    FpnlCaption.Caption:=Player.CommonName.Name
  else
    FpnlCaption.Caption:=Player.FirstName.Name + ' ' + Player.SecondName.Name;

  if (Player.ClubJob <> nil) then
  begin
    FpnlCaption.Caption:=FpnlCaption.Caption + ' (' + Player.ClubJob.ShortName + ')';
    Caption:=Caption + ' (' + Player.ClubJob.Name + ')';
  end;

  FpnlBorn.Caption:='Born ' + CMDateToString(Player.DateOfBirth) + ' (Age ' + IntToStr(CMAge(FfrmMain.FcdData.GameDate, Player.DateOfBirth)) + '). ' + Player.Nation.Nationality;

  if (Player.IntApps > 0) then
  begin
    FpnlBorn.Caption:=FpnlBorn.Caption + ' (' + IntToStr(Player.IntApps);
    if (Player.IntApps = 1) then
      FpnlBorn.Caption:=FpnlBorn.Caption + ' cap'
    else
      FpnlBorn.Caption:=FpnlBorn.Caption + ' caps';

    if (Player.IntGoals > 0) then
    begin
      FpnlBorn.Caption:=FpnlBorn.Caption + '/' + IntToStr(Player.IntGoals);
      if (Player.IntGoals = 1) then
        FpnlBorn.Caption:=FpnlBorn.Caption + ' goal'
      else
        FpnlBorn.Caption:=FpnlBorn.Caption + ' goals';
    end;

    FpnlBorn.Caption:=FpnlBorn.Caption + ')'
  end;
  
  FpnlBorn.Caption:=FpnlBorn.Caption + '.';
  
  FlblAcceleration.Caption:=IntToStr(Player.Player.Acceleration);
  FlblAggression.Caption:=IntToStr(Player.Player.Aggression);
  FlblAgility.Caption:=IntToStr(Player.Player.Agility);
  FlblAnticipation.Caption:=IntToStr(Player.Player.Anticipation);
  FlblBalance.Caption:=IntToStr(Player.Player.Balance);
  FlblBravery.Caption:=IntToStr(Player.Player.Bravery);
  FlblCreativity.Caption:=IntToStr(Player.Player.Vision);
  FlblCrossing.Caption:=IntToStr(Player.Player.Crossing);
  FlblDecisions.Caption:=IntToStr(Player.Player.Decisions);
  FlblDetermination.Caption:=IntToStr(Player.Determination);
  FlblDribbling.Caption:=IntToStr(Player.Player.Dribbling);
  FlblFinishing.Caption:=IntToStr(Player.Player.Finishing);
  FlblFlair.Caption:=IntToStr(Player.Player.Flair);
  FlblHandling.Caption:=IntToStr(Player.Player.Handling);
  FlblHeading.Caption:=IntToStr(Player.Player.Heading);
  FlblInfluence.Caption:=IntToStr(Player.Player.Leadership);
  FlblJumping.Caption:=IntToStr(Player.Player.Jumping);
  FlblLongShots.Caption:=IntToStr(Player.Player.LongShots);
  FlblMarking.Caption:=IntToStr(Player.Player.Marking);
  FlblOffTheBall.Caption:=IntToStr(Player.Player.Movement);
  FlblPace.Caption:=IntToStr(Player.Player.PlayerPace);
  FlblPassing.Caption:=IntToStr(Player.Player.Passing);
  FlblPositioning.Caption:=IntToStr(Player.Player.Positioning);
  FlblReflexes.Caption:=IntToStr(Player.Player.Reflexes);
  FlblSetPieces.Caption:=IntToStr(Player.Player.FreeKicks);
  FlblStamina.Caption:=IntToStr(Player.Player.Stamina);
  FlblStrength.Caption:=IntToStr(Player.Player.Strength);
  FlblTackling.Caption:=IntToStr(Player.Player.Tackling);
  FlblTeamwork.Caption:=IntToStr(Player.Player.Teamwork);
  FlblTechnique.Caption:=IntToStr(Player.Player.Technique);
  FlblWorkRate.Caption:=IntToStr(Player.Player.WorkRate);
  FlblLeftFoot.Caption:=IntToStr(Player.Player.LeftFoot);
  FlblRightFoot.Caption:=IntToStr(Player.Player.RightFoot);
  FlblMorale.Caption:=IntToStr(Player.Player.PlayerMorale);
  FlblAdaptability.Caption:=IntToStr(Player.Adaptability);
  FlblAmbition.Caption:=IntToStr(Player.Ambition);
  FlblConsistency.Caption:=IntToStr(Player.Player.Consistency);
  FlblCorners.Caption:=IntToStr(Player.Player.Corners);
  FlblDirtiness.Caption:=IntToStr(Player.Player.Dirtiness);
  FlblImportantMatches.Caption:=IntToStr(Player.Player.ImportantMatches);
  FlblInjuryProneness.Caption:=IntToStr(Player.Player.InjuryProneness);
  FlblLoyality.Caption:=IntToStr(Player.Loyality);
  FlblNaturalFitness.Caption:=IntToStr(Player.Player.NaturalFitness);
  FlblOneOnOnes.Caption:=IntToStr(Player.Player.OneOnOnes);
  FlblPenalties.Caption:=IntToStr(Player.Player.Penalties);
  FlblPressure.Caption:=IntToStr(Player.Pressure);
  FlblProfessionalism.Caption:=IntToStr(Player.Professionalism);
  FlblSportsmanship.Caption:=IntToStr(Player.Sportsmanship);
  FlblTemperament.Caption:=IntToStr(Player.Temperament);
  FlblThrowIns.Caption:=IntToStr(Player.Player.ThrowIns);
  FlblVersatility.Caption:=IntToStr(Player.Player.Versatility);
  FlblAbility.Caption:=IntToStr(Player.Player.CurrentAbility);
  FlblPotentialAbility.Caption:=IntToStr(Player.Player.PotentialAbility);
  FlblHomeReputation.Caption:=IntToStr(Player.Player.HomeReputation);
  FlblWorldReputation.Caption:=IntToStr(Player.Player.WorldReputation);
  FlblCurrentReputation.Caption:=IntToStr(Player.Player.CurrentReputation);



  if (not Player.Player.Scouted) then
    ScoutPlayer(Player);

  FlblScoutRatingGoalkeeper.Caption:=FloatToStrF(Player.Player.GKScout, ffFixed, 10, 2) + ' %';
  FlblScoutRatingDefender.Caption:=FloatToStrF(Player.Player.DScout, ffFixed, 10, 2) + ' %';
  FlblScoutRatingDefensiveMidfielder.Caption:=FloatToStrF(Player.Player.DMScout, ffFixed, 10, 2) + ' %';
  FlblScoutRatingMidfielder.Caption:=FloatToStrF(Player.Player.MScout, ffFixed, 10, 2) + ' %';
  FlblScoutRatingAttackingMidfielder.Caption:=FloatToStrF(Player.Player.AMScout, ffFixed, 10, 2) + ' %';
  FlblScoutRatingWing.Caption:=FloatToStrF(Player.Player.WScout, ffFixed, 10, 2) + ' %';
  FlblScoutRatingAttacker.Caption:=FloatToStrF(Player.Player.AScout, ffFixed, 10, 2) + ' %';

  FlblContractLabels.Caption:='';
  FlblContractInformation.Caption:='';

  FlblContractLabels.Caption:='Type' + #13#10 + 'Wages' + #13#10;

  if (Player.Contract <> nil) then
  begin
    FlblContractLabels.Caption:=FlblContractLabels.Caption + 'Started' + #13#10 + 'Protected' + #13#10 + 'Expires' + #13#10;
    dblTemp:=Player.Contract.Wage;
    FlblContractInformation.Caption:=ContractTypeToStr(Player.Contract.ContractType) + #13#10 + Format('£%.0n per week', [dblTemp]) + #13#10 + CMDateToString(Player.Contract.DateStarted) + #13#10;

    if ((Player.Contract.DateStarted.Year < 2001) or ((Player.Contract.DateStarted.Year = 2001) and (Player.Contract.DateStarted.Year < 244))) then
      FlblContractInformation.Caption:=FlblContractInformation.Caption + 'Yes' + #13#10
    else
    begin
      if (CMAge(Player.Contract.DateStarted, Player.DateOfBirth) >= 28) then
      begin
        if ((Player.Contract.DateStarted.Year + 2 > FfrmMain.FcdData.GameDate.Year) or ((Player.Contract.DateStarted.Year + 2 = FfrmMain.FcdData.GameDate.Year) and (Player.Contract.DateStarted.Day > FfrmMain.FcdData.GameDate.Day))) then
          FlblContractInformation.Caption:=FlblContractInformation.Caption + 'Yes' + #13#10
        else
          FlblContractInformation.Caption:=FlblContractInformation.Caption + 'No (At least 2 years since start of contract)' + #13#10;
      end
      else
      begin
        if ((Player.Contract.DateStarted.Year + 3 > FfrmMain.FcdData.GameDate.Year) or ((Player.Contract.DateStarted.Year + 3 = FfrmMain.FcdData.GameDate.Year) and (Player.Contract.DateStarted.Day > FfrmMain.FcdData.GameDate.Day))) then
          FlblContractInformation.Caption:=FlblContractInformation.Caption + 'Yes' + #13#10
        else
          FlblContractInformation.Caption:=FlblContractInformation.Caption + 'No (At least 3 years since start of contract)' + #13#10;
      end;
    end;

    FlblContractInformation.Caption:=FlblContractInformation.Caption + CMDateToString(Player.Contract.ContractExpires) + #13#10;

    if (Player.LoanContract <> nil) then
    begin
      FlblContractLabels.Caption:=FlblContractLabels.Caption + 'Loan Details' + #13#10;
      FlblContractInformation.Caption:=FlblContractInformation.Caption + 'On loan from ' + Player.Contract.Club.ShortName + ' until ' + CMDateToString(Player.LoanContract.ContractExpires) + #13#10;
    end;

    FlblContractLabels.Caption:=FlblContractLabels.Caption + 'Squad Status' + #13#10 + 'Bonuses';
    FlblContractInformation.Caption:=FlblContractInformation.Caption + SquadStatusToLongStr(Player.Contract.SquadStatus) + #13#10;

    if ((Player.Contract.GoalBonus = -1) and (Player.Contract.AssistBonus = -1) and (Player.Contract.CleanSheetBonus = -1)) then
    begin
      FlblContractInformation.Caption:=FlblContractInformation.Caption + 'None' + #13#10;
      FlblContractLabels.Caption:=FlblContractLabels.Caption + #13#10;
    end
    else
    begin
      if (Player.Contract.GoalBonus <> -1) then
      begin
        dblTemp:=Player.Contract.GoalBonus;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('£%.0n Goal Bonus', [dblTemp]) + #13#10;
        FlblContractLabels.Caption:=FlblContractLabels.Caption + #13#10;
      end;

      if (Player.Contract.AssistBonus <> -1) then
      begin
        dblTemp:=Player.Contract.AssistBonus;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('£%.0n Assist Bonus', [dblTemp]) + #13#10;
        FlblContractLabels.Caption:=FlblContractLabels.Caption + #13#10;
      end;

      if (Player.Contract.CleanSheetBonus <> -1) then
      begin
        dblTemp:=Player.Contract.CleanSheetBonus;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('£%.0n Clean Sheet Bonus', [dblTemp]) + #13#10;
        FlblContractLabels.Caption:=FlblContractLabels.Caption + #13#10;
      end;
    end;

    FlblContractLabels.Caption:=FlblContractLabels.Caption + 'Clauses';

    if ((Player.Contract.NonPromotionRC < 1) and (Player.Contract.RelegationRC < 1) and (Player.Contract.MinimumFeeRC < 1) and (Player.Contract.NonPlayingRC < 1) and (Player.Contract.ManagerJobRC < 1)) then
      FlblContractInformation.Caption:=FlblContractInformation.Caption + 'None'
    else
    begin
      if (Player.Contract.NonPromotionRC > 0) then
      begin
        dblTemp:=Player.Contract.ReleaseFee;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('Non Promotion Release Clause (£%.0n)', [dblTemp]) + #13#10;
      end;

      if (Player.Contract.RelegationRC > 0) then
      begin
        dblTemp:=Player.Contract.ReleaseFee;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('Relegation Release Clause (£%.0n)', [dblTemp]) + #13#10;
      end;

      if (Player.Contract.MinimumFeeRC > 0) then
      begin
        dblTemp:=Player.Contract.ReleaseFee;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('Minimum Fee Release Clause (£%.0n)', [dblTemp]) + #13#10;
      end;

      if (Player.Contract.NonPlayingRC > 0) then
      begin
        dblTemp:=Player.Contract.ReleaseFee;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('Non Playing Release Clause (£%.0n)', [dblTemp]) + #13#10;
      end;

      if (Player.Contract.ManagerJobRC > 0) then
      begin
        dblTemp:=Player.Contract.ReleaseFee;
        FlblContractInformation.Caption:=FlblContractInformation.Caption + Format('Manager Job Release Clause (£%.0n)', [dblTemp]) + #13#10;
      end;
    end;
  end
  else
  begin
    FlblContractLabels.Caption:=FlblContractLabels.Caption + 'Expires' + #13#10 + 'Bonuses' + #13#10 + 'Clauses';
    FlblContractInformation.Caption:=FlblContractInformation.Caption + 'N/A' + #13#10 + '-' + #13#10 + '-' + #13#10 + 'None' + #13#10 + 'None';
  end;

  FlblTransferLabels.Caption:='Availability' + #13#10 + 'Value' + #13#10;

  dblTemp:=Player.Value;
  if (Player.Contract <> nil) then
    FlblTransferInformation.Caption:=TransferStatusToStr(Player.Contract.TransferStatus) + #13#10 + Format('£%.0n', [dblTemp]) + #13#10
  else
    FlblTransferInformation.Caption:='Unknown' + #13#10 + '£0' + #13#10;

  if (Player.SecondNation <> nil) then
  begin
    FlblTransferLabels.Caption:=FlblTransferLabels.Caption + 'Second Nationality' + #13#10;
    FlblTransferInformation.Caption:=FlblTransferInformation.Caption + Player.SecondNation.Nationality + #13#10;
  end;

  FlblTransferLabels.Caption:=FlblTransferLabels.Caption + 'Future';
  if (Player.Contract <> nil) then
  begin
    if (Player.Contract.LeavingOnBosman) then
      FlblTransferInformation.Caption:=FlblTransferInformation.Caption + 'Leaving the club under the Bosman ruling on ' + CMDateToString(Player.Contract.ContractExpires)
    else
      FlblTransferInformation.Caption:=FlblTransferInformation.Caption + '-';
  end
  else
    FlblTransferInformation.Caption:=FlblTransferInformation.Caption + '-';

  FpnlPosition.Caption:=FullPosition(Player.Player);
  
  FpcData.ActivePage:=FtsProfile;
  ShowModal;
end;

end.
