unit SearchUnit;

{ $Id: SearchUnit.pas,v 1.3 2002/04/30 18:25:05 michael Exp $ }

interface

uses
  CMDatabase, VirtualTrees, Classes, CMDataRepresentation,
  frmPSearchUnit, SysUtils, CMFunctions, ScoutRatingUnit;

type
  PStaffRecord = ^TStaffRecord;
  TStaffRecord = record
    Staff: Pointer;
  end;
  
  TListContents = class
  private
    FlstPlayers: TList;
    FlvList: TVirtualStringTree;
    FcdData: TCMDatabase;
    function Get(Index: Integer): PStaff;
    function GetColumnInteger(Column: Integer; Player: PStaff): Integer;
    procedure GetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure CompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure InitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure IncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: WideString; var Result: Integer);
  public
    constructor Create(List: TVirtualStringTree; Database: TCMDatabase);
    destructor Destroy; override;
    procedure Add(Staff: PStaff);
    procedure Delete(Index: Integer);
    function Count: Integer;
    procedure Clear;
    procedure Update;
    property Items[Index: Integer]: PStaff read Get; default;
    function GetColumnText(Column: Integer; Player: PStaff): String;
  end;

  TPlayerSearch = class
  private
    FcdData: TCMDatabase;
    FlcResult: TListContents;
    FOnStatus: TStatusEvent;
    FOnProgress: TProgressEvent;
    procedure ExecuteStatus(Status: String);
    procedure ExecuteProgress(Position: Integer);
    procedure CheckPlayers;
    procedure CheckNames(Name: String);
    procedure CheckAge(Min, Max: Integer);
    procedure CheckNation(Nation: PNation);
    procedure CheckEU;
    procedure CheckBased(Nation: PNation);
    procedure CheckDivision(Division: PDivision);
    procedure CheckGoalkeeper;
    procedure CheckDefender;
    procedure CheckMidfielder;
    procedure CheckAttacker;
    procedure CheckSweeper;
    procedure CheckDefensiveMidfielder;
    procedure CheckAttackingMidfielder;
    procedure CheckWingBack;
    procedure CheckFreeRole;
    procedure CheckLeftSide;
    procedure CheckCentral;
    procedure CheckRightSide;
    procedure CheckAbility(Min, Max: Integer);
    procedure CheckPotentialAbility(Min, Max: Integer);
    procedure CheckScoutRating(Min, Max: Integer);
    procedure CheckHomeReputation(Min, Max: Integer);
    procedure CheckCurrentReputation(Min, Max: Integer);
    procedure CheckWorldReputation(Min, Max: Integer);
    procedure CheckClubReputation(Min, Max: Integer);
    procedure CheckContract(Contract: Integer);
    procedure CheckLeavingOnBosman;
    procedure CheckNotTransferArranged;
    procedure CheckNonPromotion(Active: Boolean);
    procedure CheckRelegation(Active: Boolean);
    procedure CheckNonPlaying(Active: Boolean);
    procedure CheckMinimumFee;
    procedure CheckReleaseFee(Min, Max: Integer);
    procedure CheckTransferStatus(Status: Integer);
    procedure CheckSquadStatus(Status: Integer);
    procedure CheckContractType(CtrType: Integer);
    procedure CheckValue(Min, Max: Integer);
    procedure CheckWage(Min, Max: Integer);
    procedure CheckAcceleration(Min, Max: Integer);
    procedure CheckAdaptability(Min, Max: Integer);
    procedure CheckAggression(Min, Max: Integer);
    procedure CheckAgility(Min, Max: Integer);
    procedure CheckAmbition(Min, Max: Integer);
    procedure CheckAnticipation(Min, Max: Integer);
    procedure CheckBalance(Min, Max: Integer);
    procedure CheckBravery(Min, Max: Integer);
    procedure CheckConsistency(Min, Max: Integer);
    procedure CheckCorners(Min, Max: Integer);
    procedure CheckVision(Min, Max: Integer);
    procedure CheckCrossing(Min, Max: Integer);
    procedure CheckDecisions(Min, Max: Integer);
    procedure CheckDetermination(Min, Max: Integer);
    procedure CheckDirtiness(Min, Max: Integer);
    procedure CheckDribbling(Min, Max: Integer);
    procedure CheckFinishing(Min, Max: Integer);
    procedure CheckFlair(Min, Max: Integer);
    procedure CheckHandling(Min, Max: Integer);
    procedure CheckHeading(Min, Max: Integer);
    procedure CheckLeadership(Min, Max: Integer);
    procedure CheckImportantMatches(Min, Max: Integer);
    procedure CheckInjuryProneness(Min, Max: Integer);
    procedure CheckJumping(Min, Max: Integer);
    procedure CheckLongShots(Min, Max: Integer);
    procedure CheckLoyality(Min, Max: Integer);
    procedure CheckMarking(Min, Max: Integer);
    procedure CheckNaturalFitness(Min, Max: Integer);
    procedure CheckMovement(Min, Max: Integer);
    procedure CheckOneOnOnes(Min, Max: Integer);
    procedure CheckPlayerPace(Min, Max: Integer);
    procedure CheckPassing(Min, Max: Integer);
    procedure CheckPenalties(Min, Max: Integer);
    procedure CheckPositioning(Min, Max: Integer);
    procedure CheckPressure(Min, Max: Integer);
    procedure CheckProfessionalism(Min, Max: Integer);
    procedure CheckReflexes(Min, Max: Integer);
    procedure CheckFreeKicks(Min, Max: Integer);
    procedure CheckSportsmanship(Min, Max: Integer);
    procedure CheckStamina(Min, Max: Integer);
    procedure CheckStrength(Min, Max: Integer);
    procedure CheckTackling(Min, Max: Integer);
    procedure CheckTeamwork(Min, Max: Integer);
    procedure CheckTechnique(Min, Max: Integer);
    procedure CheckTemperament(Min, Max: Integer);
    procedure CheckThrowIns(Min, Max: Integer);
    procedure CheckVersatility(Min, Max: Integer);
    procedure CheckWorkRate(Min, Max: Integer);
  public
    constructor Create(Database: TCMDatabase; Contents: TListContents);
    procedure Search;         
  published
    property OnStatus: TStatusEvent read FOnStatus write FOnStatus;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
  end;

implementation

{ TListContents }

constructor TListContents.Create(List: TVirtualStringTree; Database: TCMDatabase);
begin
  FcdData:=Database;
  FlvList:=List;
  FlvList.NodeDataSize:=SizeOf(TStaffRecord);
  FlvList.OnGetText:=GetText;
  FlvList.OnCompareNodes:=CompareNodes;
  FlvList.OnInitNode:=InitNode;
  FlvList.OnIncrementalSearch:=IncrementalSearch;
  FlstPlayers:=TList.Create;
end;

destructor TListContents.Destroy;
begin
  FlstPlayers.Free;
end;

procedure TListContents.Add(Staff: PStaff);
begin
  FlstPlayers.Add(Staff);
end;

procedure TListContents.Delete(Index: Integer);
begin
  FlstPlayers.Delete(Index);
end;

function TListContents.Get(Index: Integer): PStaff;
begin
  Result:=FlstPlayers[Index];
end;

function TListContents.Count: Integer;
begin
  Result:=FlstPlayers.Count;
end;

procedure TListContents.Clear;
begin
  FlstPlayers.Clear;
  FlvList.Clear;
end;

procedure TListContents.Update;
begin
  FlvList.RootNodeCount:=Count;
end;

procedure TListContents.InitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PStaffRecord;
begin
  Data:=Sender.GetNodeData(Node);
  Data.Staff:=Items[Node.Index];
end;

procedure TListContents.GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PStaffRecord;
  stPlayer: PStaff;
begin
  Data:=Sender.GetNodeData(Node);
  stPlayer:=Data.Staff;
  CellText:=GetColumnText(Column, stPlayer);
end;

function TListContents.GetColumnText(Column: Integer; Player: PStaff): String;
begin
  case Column of
    11:                    
    begin
      if (Player.ClubJob <> nil) then
        Result:=Player.ClubJob.ShortName
      else
        Result:='';
    end;
    12:
    begin
      if (Player.ClubJob <> nil) then
        Result:=IntToStr(Player.ClubJob.Reputation)
      else
        Result:='0';
    end;
    43:
    begin
      if (Player.Nation <> nil) then
      begin
        Result:=Player.Nation.ShortName;
        if (Player.SecondNation <> nil) then
          Result:=Result + '/' + Player.SecondNation.ShortName;
      end
      else
        Result:='';
    end;
    0:
      Result:=IntToStr(Player.Player.CurrentAbility);
    53:
      Result:=IntToStr(Player.Player.PotentialAbility);
    29:
      Result:=IntToStr(Player.Player.HomeReputation);
    19:
      Result:=IntToStr(Player.Player.CurrentReputation);
    75:
      Result:=IntToStr(Player.Player.WorldReputation);
    51:
      Result:=ShortPosition(Player.Player);
    1:
      Result:=IntToStr(Player.Player.Acceleration);
    4:
      Result:=IntToStr(Player.Player.Aggression);
    5:
      Result:=IntToStr(Player.Player.Agility);
    7:
      Result:=IntToStr(Player.Player.Anticipation);
    8:
      Result:=IntToStr(Player.Player.Balance);
    9:
      Result:=IntToStr(Player.Player.Bravery);
    13:
      Result:=IntToStr(Player.Player.Consistency);
    16:
      Result:=IntToStr(Player.Player.Corners);
    18:
      Result:=IntToStr(Player.Player.Crossing);
    21:
      Result:=IntToStr(Player.Player.Decisions);
    23:
      Result:=IntToStr(Player.Player.Dirtiness);
    24:
      Result:=IntToStr(Player.Player.Dribbling);
    25:
      Result:=IntToStr(Player.Player.Finishing);
    26:
      Result:=IntToStr(Player.Player.Flair);
    60:
      Result:=IntToStr(Player.Player.FreeKicks);
    27:
      Result:=IntToStr(Player.Player.Handling);
    28:
      Result:=IntToStr(Player.Player.Heading);
    30:
      Result:=IntToStr(Player.Player.ImportantMatches);
    32:
      Result:=IntToStr(Player.Player.InjuryProneness);
    34:
      Result:=IntToStr(Player.Player.Jumping);
    31:
      Result:=IntToStr(Player.Player.Leadership);
    35:
      Result:=IntToStr(Player.Player.LeftFoot);
    36:
      Result:=IntToStr(Player.Player.LongShots);
    39:
      Result:=IntToStr(Player.Player.Marking);
    46:
      Result:=IntToStr(Player.Player.Movement);
    42:
      Result:=IntToStr(Player.Player.NaturalFitness);
    47:
      Result:=IntToStr(Player.Player.OneOnOnes);
    48:
      Result:=IntToStr(Player.Player.PlayerPace);
    49:
      Result:=IntToStr(Player.Player.Passing);
    50:
      Result:=IntToStr(Player.Player.Penalties);
    52:
      Result:=IntToStr(Player.Player.Positioning);
    56:
      Result:=IntToStr(Player.Player.Reflexes);
    58:
      Result:=IntToStr(Player.Player.RightFoot);
    63:
      Result:=IntToStr(Player.Player.Stamina);
    64:
      Result:=IntToStr(Player.Player.Strength);
    65:
      Result:=IntToStr(Player.Player.Tackling);
    66:
      Result:=IntToStr(Player.Player.Teamwork);
    67:
      Result:=IntToStr(Player.Player.Technique);
    69:
      Result:=IntToStr(Player.Player.ThrowIns);
    72:
      Result:=IntToStr(Player.Player.Versatility);
    17:
      Result:=IntToStr(Player.Player.Vision);
    74:
      Result:=IntToStr(Player.Player.WorkRate);
    73:
      Result:=IntToStr(Player.Wage);
    40:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.MinimumFeeRC > 0)) then
        Result:=IntToStr(Player.Contract.ReleaseFee)
      else
        Result:='0';
    end;
    44:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.NonPlayingRC > 0)) then
        Result:=IntToStr(Player.Contract.ReleaseFee)
      else
        Result:='0';
    end;
    45:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.NonPromotionRC > 0)) then
        Result:=IntToStr(Player.Contract.ReleaseFee)
      else
        Result:='0';
    end;
    57:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.RelegationRC > 0)) then
        Result:=IntToStr(Player.Contract.ReleaseFee)
      else
        Result:='0';
    end;
    38:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.ManagerJobRC > 0)) then
        Result:=IntToStr(Player.Contract.ReleaseFee)
      else
        Result:='0';
    end;
    14:
    begin
      if (Player.ClubJob <> nil) then
        Result:=CMDateToString(Player.DateExpiresClub)
      else
        Result:='';
    end;
    15:
    begin
      if (Player.Contract <> nil) then
        Result:=ContractTypeToStr(Player.Contract.ContractType)
      else
        Result:='';
    end;
    70:
    begin
      if (Player.Contract <> nil) then
        Result:=TransferStatusToStr(Player.Contract.TransferStatus)
      else
        Result:='';
    end;
    62:
    begin
      if (Player.Contract <> nil) then
        Result:=SquadStatusToStr(Player.Contract.SquadStatus)
      else
        Result:='';
    end;
    41:
    begin
      if ((Player.CommonName <> nil) and (Player.CommonName.Name <> '')) then
        Result:=Player.CommonName.Name
      else
        Result:=Player.SecondName.Name + ', ' + Player.FirstName.Name;
    end;
    3:
      Result:=IntToStr(CMAge(FcdData.GameDate, Player.DateOfBirth));
    10:
      Result:=IntToStr(Player.IntApps);
    33:
      Result:=IntToStr(Player.IntGoals);
    71:
      Result:=IntToStr(Player.Value);
    2:
      Result:=IntToStr(Player.Adaptability);
    6:
      Result:=IntToStr(Player.Ambition);
    22:
      Result:=IntToStr(Player.Determination);
    37:
      Result:=IntToStr(Player.Loyality);
    54:
      Result:=IntToStr(Player.Pressure);
    55:
      Result:=IntToStr(Player.Professionalism);
    61:
      Result:=IntToStr(Player.Sportsmanship);
    68:
      Result:=IntToStr(Player.Temperament);
    20:
      Result:=CMDateToString(Player.DateOfBirth);
    59:
      Result:=ScoutRating(Player);
  end;
end;

function TListContents.GetColumnInteger(Column: Integer; Player: PStaff): Integer;
begin
  case Column of
    12:
    begin
      if (Player.ClubJob <> nil) then
        Result:=(Player.ClubJob.Reputation)
      else
        Result:=0;
    end;
    0:
      Result:=(Player.Player.CurrentAbility);
    53:
      Result:=(Player.Player.PotentialAbility);
    29:
      Result:=(Player.Player.HomeReputation);
    19:
      Result:=(Player.Player.CurrentReputation);
    75:
      Result:=(Player.Player.WorldReputation);
    1:
      Result:=(Player.Player.Acceleration);
    4:
      Result:=(Player.Player.Aggression);
    5:
      Result:=(Player.Player.Agility);
    7:
      Result:=(Player.Player.Anticipation);
    8:
      Result:=(Player.Player.Balance);
    9:
      Result:=(Player.Player.Bravery);
    13:
      Result:=(Player.Player.Consistency);
    16:
      Result:=(Player.Player.Corners);
    18:
      Result:=(Player.Player.Crossing);
    21:
      Result:=(Player.Player.Decisions);
    23:
      Result:=(Player.Player.Dirtiness);
    24:
      Result:=(Player.Player.Dribbling);
    25:
      Result:=(Player.Player.Finishing);
    26:
      Result:=(Player.Player.Flair);
    60:
      Result:=(Player.Player.FreeKicks);
    27:
      Result:=(Player.Player.Handling);
    28:
      Result:=(Player.Player.Heading);
    30:
      Result:=(Player.Player.ImportantMatches);
    32:
      Result:=(Player.Player.InjuryProneness);
    34:
      Result:=(Player.Player.Jumping);
    31:
      Result:=(Player.Player.Leadership);
    35:
      Result:=(Player.Player.LeftFoot);
    36:
      Result:=(Player.Player.LongShots);
    39:
      Result:=(Player.Player.Marking);
    46:
      Result:=(Player.Player.Movement);
    42:
      Result:=(Player.Player.NaturalFitness);
    47:
      Result:=(Player.Player.OneOnOnes);
    48:
      Result:=(Player.Player.PlayerPace);
    49:
      Result:=(Player.Player.Passing);
    50:
      Result:=(Player.Player.Penalties);
    52:
      Result:=(Player.Player.Positioning);
    56:
      Result:=(Player.Player.Reflexes);
    58:
      Result:=(Player.Player.RightFoot);
    63:
      Result:=(Player.Player.Stamina);
    64:
      Result:=(Player.Player.Strength);
    65:
      Result:=(Player.Player.Tackling);
    66:
      Result:=(Player.Player.Teamwork);
    67:
      Result:=(Player.Player.Technique);
    69:
      Result:=(Player.Player.ThrowIns);
    72:
      Result:=(Player.Player.Versatility);
    17:
      Result:=(Player.Player.Vision);
    74:
      Result:=(Player.Player.WorkRate);
    73:
      Result:=(Player.Wage);
    40:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.MinimumFeeRC > 0)) then
        Result:=(Player.Contract.ReleaseFee)
      else
        Result:=0;
    end;
    44:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.NonPlayingRC > 0)) then
        Result:=(Player.Contract.ReleaseFee)
      else
        Result:=0;
    end;
    45:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.NonPromotionRC > 0)) then
        Result:=(Player.Contract.ReleaseFee)
      else
        Result:=0;
    end;
    57:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.RelegationRC > 0)) then
        Result:=(Player.Contract.ReleaseFee)
      else
        Result:=0;
    end;
    38:
    begin
      if ((Player.Contract <> nil) and (Player.Contract.ManagerJobRC > 0)) then
        Result:=(Player.Contract.ReleaseFee)
      else
        Result:=0;
    end;
    3:
      Result:=(CMAge(FcdData.GameDate, Player.DateOfBirth));
    10:
      Result:=(Player.IntApps);
    33:
      Result:=(Player.IntGoals);
    71:
      Result:=(Player.Value);
    2:
      Result:=(Player.Adaptability);
    6:
      Result:=(Player.Ambition);
    22:
      Result:=(Player.Determination);
    37:
      Result:=(Player.Loyality);
    54:
      Result:=(Player.Pressure);
    55:
      Result:=(Player.Professionalism);
    61:
      Result:=(Player.Sportsmanship);
    68:
      Result:=(Player.Temperament);
    else
      Result:=0;
  end;
end;

procedure TListContents.CompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data: PStaffRecord;
  stPlayer1,
  stPlayer2: PStaff;
  intPlayer1,
  intPlayer2: Integer;
  dblPlayer1,
  dblPlayer2: Double;
  cmdPlayer1,
  cmdPlayer2: TCMDate;
begin
  Data:=Sender.GetNodeData(Node1);
  stPlayer1:=Data.Staff;
  Data:=Sender.GetNodeData(Node2);
  stPlayer2:=Data.Staff;

  case FlvList.Header.Columns[Column].Tag of
    0:
    begin
      intPlayer1:=GetColumnInteger(Column, stPlayer1);
      intPlayer2:=GetColumnInteger(Column, stPlayer2);
      if (intPlayer1 < intPlayer2) then
        Result:=1
      else if (intPlayer1 = intPlayer2) then
        Result:=0
      else
        Result:=-1;
    end;
    1:
      Result:=CompareText(GetColumnText(Column, stPlayer1), GetColumnText(Column, stPlayer2));
    2:
    begin
      case Column of
        14:
        begin
          if (stPlayer1.ClubJob <> nil) then
            cmdPlayer1:=stPlayer1.DateExpiresClub
          else
          begin
            cmdPlayer1.Day:=0;
            cmdPlayer1.Year:=0;
          end;
          if (stPlayer2.ClubJob <> nil) then
            cmdPlayer2:=stPlayer2.DateExpiresClub
          else
          begin
            cmdPlayer2.Day:=0;
            cmdPlayer2.Year:=0;
          end;
        end;
        20:
        begin
          cmdPlayer1:=stPlayer1.DateOfBirth;
          cmdPlayer2:=stPlayer2.DateOfBirth;
        end
      end;
      if (cmdPlayer1.Year = cmdPlayer2.Year) then
      begin
        if (cmdPlayer1.Day = cmdPlayer2.Day) then
          Result:=0
        else if (cmdPlayer1.Day < cmdPlayer2.Day) then
          Result:=-1
        else
          Result:=1;
      end
      else if (cmdPlayer1.Year < cmdPlayer2.Year) then
        Result:=-1
      else
        Result:=1;
    end;
    3:
    begin
      dblPlayer1:=ScoutRatingDbl(stPlayer1);
      dblPlayer2:=ScoutRatingDbl(stPlayer2);
      if (dblPlayer1 = dblPlayer2) then
        Result:=0
      else if (dblPlayer1 > dblPlayer2) then
        Result:=-1
      else
        Result:=1;
    end;
  end;
end;

procedure TListContents.IncrementalSearch(Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: WideString; var Result: Integer);
var
  Data: PStaffRecord;
  stPlayer: PStaff;
  strTemp: String;
begin
  Data:=Sender.GetNodeData(Node);
  stPlayer:=Data.Staff;
  strTemp:=GetColumnText(FlvList.Header.MainColumn, stPlayer);
  Result:=CompareText(SearchText, Copy(strTemp, 1, Length(SearchText)));
end;

{ TPlayerSearch }

constructor TPlayerSearch.Create(Database: TCMDatabase; Contents: TListContents);
begin
  FcdData:=Database;
  FlcResult:=Contents;
end;

procedure TPlayerSearch.ExecuteStatus(Status: String);
begin
  if (Assigned(FOnStatus)) then
    FOnStatus(Self, Status);
end;

procedure TPlayerSearch.ExecuteProgress(Position: Integer);
begin
  if (Assigned(FOnProgress)) then
    FOnProgress(Self, Position);
end;

procedure TPlayerSearch.Search;
begin
  CheckPlayers;
  if (FfrmPSearch.FedName.Text <> '') then
    CheckNames(FfrmPSearch.FedName.Text);
  if ((FfrmPSearch.FspeMinAge.Value > 0) or (FfrmPSearch.FspeMaxAge.Value > 0)) then
    CheckAge(FfrmPSearch.FspeMinAge.Value, FfrmPSearch.FspeMaxAge.Value);
  if (FfrmPSearch.FcmbNation.ItemIndex > -1) then
    CheckNation(PNation(FfrmPSearch.FcmbNation.Items.Objects[FfrmPSearch.FcmbNation.ItemIndex]));
  if (FfrmPSearch.FcbEUNational.Checked) then
    CheckEU;
  if (FfrmPSearch.FcmbBased.ItemIndex > -1) then
    CheckBased(PNation(FfrmPSearch.FcmbBased.Items.Objects[FfrmPSearch.FcmbBased.ItemIndex]));
  if (FfrmPSearch.FcmbDivision.ItemIndex > -1) then
    CheckDivision(PDivision(FfrmPSearch.FcmbDivision.Items.Objects[FfrmPSearch.FcmbDivision.ItemIndex]));
  if (FfrmPSearch.FcbGoalkeeper.Checked) then
    CheckGoalkeeper;
  if (FfrmPSearch.FcbDefender.Checked) then
    CheckDefender;
  if (FfrmPSearch.FcbMidfielder.Checked) then
    CheckMidfielder;
  if (FfrmPSearch.FcbAttacker.Checked) then
    CheckAttacker;
  if (FfrmPSearch.FcbSweeper.Checked) then
    CheckSweeper;
  if (FfrmPSearch.FcbDefensiveMidfielder.Checked) then
    CheckDefensiveMidfielder;
  if (FfrmPSearch.FcbAttackingMidfielder.Checked) then
    CheckAttackingMidfielder;
  if (FfrmPSearch.FcbWingBack.Checked) then
    CheckWingBack;
  if (FfrmPSearch.FcbFreeRole.Checked) then
    CheckFreeRole;
  if (FfrmPSearch.FcbLeftSide.Checked) then
    CheckLeftSide;
  if (FfrmPSearch.FcbCentral.Checked) then
    CheckCentral;
  if (FfrmPSearch.FcbRightSide.Checked) then
    CheckRightSide;
  if ((FfrmPSearch.FspeAbilityMin.Value > 0) or (FfrmPSearch.FspeAbilityMax.Value < 200)) then
    CheckAbility(FfrmPSearch.FspeAbilityMin.Value, FfrmPSearch.FspeAbilityMax.Value);
  if ((FfrmPSearch.FspePotentialAbilityMin.Value > 0) or (FfrmPSearch.FspePotentialAbilityMax.Value < 200)) then
    CheckPotentialAbility(FfrmPSearch.FspepotentialAbilityMin.Value, FfrmPSearch.FspePotentialAbilityMax.Value);
  if ((FfrmPSearch.FspeScoutRatingMin.Value > 0) or (FfrmPSearch.FspeScoutRatingMax.Value < 100)) then
    CheckScoutRating(FfrmPSearch.FspeScoutRatingMin.Value, FfrmPSearch.FspeScoutRatingMax.Value);
  if ((FfrmPSearch.FspeHomeReputationMin.Value > 0) or (FfrmPSearch.FspeHomeReputationMax.Value < 10000)) then
    CheckHomeReputation(FfrmPSearch.FspeHomeReputationMin.Value, FfrmPSearch.FspeHomeReputationMax.Value);
  if ((FfrmPSearch.FspeCurrentReputationMin.Value > 0) or (FfrmPSearch.FspeCurrentReputationMax.Value < 10000)) then
    CheckCurrentReputation(FfrmPSearch.FspeCurrentReputationMin.Value, FfrmPSearch.FspeCurrentReputationMax.Value);
  if ((FfrmPSearch.FspeWorldReputationMin.Value > 0) or (FfrmPSearch.FspeWorldReputationMax.Value < 10000)) then
    CheckWorldReputation(FfrmPSearch.FspeWorldReputationMin.Value, FfrmPSearch.FspeWorldReputationMax.Value);
  if ((FfrmPSearch.FspeClubReputationMin.Value > 0) or (FfrmPSearch.FspeClubReputationMax.Value < 10000)) then
    CheckClubReputation(FfrmPSearch.FspeClubReputationMin.Value, FfrmPSearch.FspeClubReputationMax.Value);
  if (FfrmPSearch.FcmbContract.ItemIndex > -1) then
    CheckContract(FfrmPSearch.FcmbContract.ItemIndex);
  if (FfrmPSearch.FcbBosman.Checked) then
    CheckLeavingOnBosman;
  if (FfrmPSearch.FcbTransferArranged.Checked) then
    CheckNotTransferArranged;
  if (FfrmPSearch.FcbNonPromotion.Checked) then
    CheckNonPromotion(FfrmPSearch.FcbNonPromotionActive.Checked);
  if (FfrmPSearch.FcbRelegation.Checked) then
    CheckRelegation(FfrmPSearch.FcbRelegationActive.Checked);
  if (FfrmPSearch.FcbNonPlaying.Checked) then
    CheckNonPlaying(FfrmPSearch.FcbNonPlayingActive.Checked);
  if (FfrmPSearch.FcbMinimumFee.Checked) then
    CheckMinimumFee;
  if ((FfrmPSearch.FspeMinReleaseFee.Value > 0) or (FfrmPSearch.FspeMaxReleaseFee.Value > 0)) then
    CheckReleaseFee(FfrmPSearch.FspeMinReleaseFee.Value, FfrmPSearch.FspeMaxReleaseFee.Value);
  if (FfrmPSearch.FcmbTransferStatus.ItemIndex > -1) then
    CheckTransferStatus(FfrmPSearch.FcmbTransferStatus.ItemIndex);
  if (FfrmPSearch.FcmbSquadStatus.ItemIndex > -1) then
    CheckSquadStatus(FfrmPSearch.FcmbSquadStatus.ItemIndex);
  if (FfrmPSearch.FcmbContractType.ItemIndex > -1) then
    CheckContractType(FfrmPSearch.FcmbContractType.ItemIndex);
  if ((FfrmPSearch.FspeMinValue.Value > 0) or (FfrmPSearch.FspeMaxValue.Value > 0)) then
    CheckValue(FfrmPSearch.FspeMinValue.Value, FfrmPSearch.FspeMaxValue.Value);
  if ((FfrmPSearch.FspeMinWage.Value > 0) or (FfrmPSearch.FspeMaxWage.Value > 0)) then
    CheckWage(FfrmPSearch.FspeMinWage.Value, FfrmPSearch.FspeMaxWage.Value);
  if ((FfrmPSearch.FspeMinAcceleration.Value > 0) or (FfrmPSearch.FspeMaxAcceleration.Value < 20)) then
    CheckAcceleration(FfrmPSearch.FspeMinAcceleration.Value, FfrmPSearch.FspeMaxAcceleration.Value);
  if ((FfrmPSearch.FspeMinAdaptability.Value > 0) or (FfrmPSearch.FspeMaxAdaptability.Value < 20)) then
    CheckAdaptability(FfrmPSearch.FspeMinAdaptability.Value, FfrmPSearch.FspeMaxAdaptability.Value);
  if ((FfrmPSearch.FspeMinAggression.Value > 0) or (FfrmPSearch.FspeMaxAggression.Value < 20)) then
    CheckAggression(FfrmPSearch.FspeMinAggression.Value, FfrmPSearch.FspeMaxAggression.Value);
  if ((FfrmPSearch.FspeMinAgility.Value > 0) or (FfrmPSearch.FspeMaxAgility.Value < 20)) then
    CheckAgility(FfrmPSearch.FspeMinAgility.Value, FfrmPSearch.FspeMaxAgility.Value);
  if ((FfrmPSearch.FspeMinAmbition.Value > 0) or (FfrmPSearch.FspeMaxAmbition.Value < 20)) then
    CheckAmbition(FfrmPSearch.FspeMinAmbition.Value, FfrmPSearch.FspeMaxAmbition.Value);
  if ((FfrmPSearch.FspeMinAnticipation.Value > 0) or (FfrmPSearch.FspeMaxAnticipation.Value < 20)) then
    CheckAnticipation(FfrmPSearch.FspeMinAnticipation.Value, FfrmPSearch.FspeMaxAnticipation.Value);
  if ((FfrmPSearch.FspeMinBalance.Value > 0) or (FfrmPSearch.FspeMaxBalance.Value < 20)) then
    CheckBalance(FfrmPSearch.FspeMinBalance.Value, FfrmPSearch.FspeMaxBalance.Value);
  if ((FfrmPSearch.FspeMinBravery.Value > 0) or (FfrmPSearch.FspeMaxBravery.Value < 20)) then
    CheckBravery(FfrmPSearch.FspeMinBravery.Value, FfrmPSearch.FspeMaxBravery.Value);
  if ((FfrmPSearch.FspeMinConsistency.Value > 0) or (FfrmPSearch.FspeMaxConsistency.Value < 20)) then
    CheckConsistency(FfrmPSearch.FspeMinConsistency.Value, FfrmPSearch.FspeMaxConsistency.Value);
  if ((FfrmPSearch.FspeMinCorners.Value > 0) or (FfrmPSearch.FspeMaxCorners.Value < 20)) then
    CheckCorners(FfrmPSearch.FspeMinCorners.Value, FfrmPSearch.FspeMaxCorners.Value);
  if ((FfrmPSearch.FspeMinVision.Value > 0) or (FfrmPSearch.FspeMaxVision.Value < 20)) then
    CheckVision(FfrmPSearch.FspeMinVision.Value, FfrmPSearch.FspeMaxVision.Value);
  if ((FfrmPSearch.FspeMinCrossing.Value > 0) or (FfrmPSearch.FspeMaxCrossing.Value < 20)) then
    CheckCrossing(FfrmPSearch.FspeMinCrossing.Value, FfrmPSearch.FspeMaxCrossing.Value);
  if ((FfrmPSearch.FspeMinDecisions.Value > 0) or (FfrmPSearch.FspeMaxDecisions.Value < 20)) then
    CheckDecisions(FfrmPSearch.FspeMinDecisions.Value, FfrmPSearch.FspeMaxDecisions.Value);
  if ((FfrmPSearch.FspeMinDetermination.Value > 0) or (FfrmPSearch.FspeMaxDetermination.Value < 20)) then
    CheckDetermination(FfrmPSearch.FspeMinDetermination.Value, FfrmPSearch.FspeMaxDetermination.Value);
  if ((FfrmPSearch.FspeMinDirtiness.Value > 0) or (FfrmPSearch.FspeMaxDirtiness.Value < 20)) then
    CheckDirtiness(FfrmPSearch.FspeMinDirtiness.Value, FfrmPSearch.FspeMaxDirtiness.Value);
  if ((FfrmPSearch.FspeMinDribbling.Value > 0) or (FfrmPSearch.FspeMaxDribbling.Value < 20)) then
    CheckDribbling(FfrmPSearch.FspeMinDribbling.Value, FfrmPSearch.FspeMaxDribbling.Value);
  if ((FfrmPSearch.FspeMinFinishing.Value > 0) or (FfrmPSearch.FspeMaxFinishing.Value < 20)) then
    CheckFinishing(FfrmPSearch.FspeMinFinishing.Value, FfrmPSearch.FspeMaxFinishing.Value);
  if ((FfrmPSearch.FspeMinFlair.Value > 0) or (FfrmPSearch.FspeMaxFlair.Value < 20)) then
    CheckFlair(FfrmPSearch.FspeMinFlair.Value, FfrmPSearch.FspeMaxFlair.Value);
  if ((FfrmPSearch.FspeMinHandling.Value > 0) or (FfrmPSearch.FspeMaxHandling.Value < 20)) then
    CheckHandling(FfrmPSearch.FspeMinHandling.Value, FfrmPSearch.FspeMaxHandling.Value);
  if ((FfrmPSearch.FspeMinHeading.Value > 0) or (FfrmPSearch.FspeMaxHeading.Value < 20)) then
    CheckHeading(FfrmPSearch.FspeMinHeading.Value, FfrmPSearch.FspeMaxHeading.Value);
  if ((FfrmPSearch.FspeMinLeadership.Value > 0) or (FfrmPSearch.FspeMaxLeadership.Value < 20)) then
    CheckLeadership(FfrmPSearch.FspeMinLeadership.Value, FfrmPSearch.FspeMaxLeadership.Value);
  if ((FfrmPSearch.FspeMinImportantMatches.Value > 0) or (FfrmPSearch.FspeMaxImportantMatches.Value < 20)) then
    CheckImportantMatches(FfrmPSearch.FspeMinImportantMatches.Value, FfrmPSearch.FspeMaxImportantMatches.Value);
  if ((FfrmPSearch.FspeMinInjuryProneness.Value > 0) or (FfrmPSearch.FspeMaxInjuryProneness.Value < 20)) then
    CheckInjuryProneness(FfrmPSearch.FspeMinInjuryProneness.Value, FfrmPSearch.FspeMaxInjuryProneness.Value);
  if ((FfrmPSearch.FspeMinJumping.Value > 0) or (FfrmPSearch.FspeMaxJumping.Value < 20)) then
    CheckJumping(FfrmPSearch.FspeMinJumping.Value, FfrmPSearch.FspeMaxJumping.Value);
  if ((FfrmPSearch.FspeMinLongShots.Value > 0) or (FfrmPSearch.FspeMaxLongShots.Value < 20)) then
    CheckLongShots(FfrmPSearch.FspeMinLongShots.Value, FfrmPSearch.FspeMaxLongShots.Value);
  if ((FfrmPSearch.FspeMinLoyality.Value > 0) or (FfrmPSearch.FspeMaxLoyality.Value < 20)) then
    CheckLoyality(FfrmPSearch.FspeMinLoyality.Value, FfrmPSearch.FspeMaxLoyality.Value);
  if ((FfrmPSearch.FspeMinMarking.Value > 0) or (FfrmPSearch.FspeMaxMarking.Value < 20)) then
    CheckMarking(FfrmPSearch.FspeMinMarking.Value, FfrmPSearch.FspeMaxMarking.Value);
  if ((FfrmPSearch.FspeMinNaturalFitness.Value > 0) or (FfrmPSearch.FspeMaxNaturalFitness.Value < 20)) then
    CheckNaturalFitness(FfrmPSearch.FspeMinNaturalFitness.Value, FfrmPSearch.FspeMaxNaturalFitness.Value);
  if ((FfrmPSearch.FspeMinMovement.Value > 0) or (FfrmPSearch.FspeMaxMovement.Value < 20)) then
    CheckMovement(FfrmPSearch.FspeMinMovement.Value, FfrmPSearch.FspeMaxMovement.Value);
  if ((FfrmPSearch.FspeMinOneOnOnes.Value > 0) or (FfrmPSearch.FspeMaxOneOnOnes.Value < 20)) then
    CheckOneOnOnes(FfrmPSearch.FspeMinOneOnOnes.Value, FfrmPSearch.FspeMaxOneOnOnes.Value);
  if ((FfrmPSearch.FspeMinPlayerPace.Value > 0) or (FfrmPSearch.FspeMaxPlayerPace.Value < 20)) then
    CheckPlayerPace(FfrmPSearch.FspeMinPlayerPace.Value, FfrmPSearch.FspeMaxPlayerPace.Value);
  if ((FfrmPSearch.FspeMinPassing.Value > 0) or (FfrmPSearch.FspeMaxPassing.Value < 20)) then
    CheckPassing(FfrmPSearch.FspeMinPassing.Value, FfrmPSearch.FspeMaxPassing.Value);
  if ((FfrmPSearch.FspeMinPenalties.Value > 0) or (FfrmPSearch.FspeMaxPenalties.Value < 20)) then
    CheckPenalties(FfrmPSearch.FspeMinPenalties.Value, FfrmPSearch.FspeMaxPenalties.Value);
  if ((FfrmPSearch.FspeMinPositioning.Value > 0) or (FfrmPSearch.FspeMaxPositioning.Value < 20)) then
    CheckPositioning(FfrmPSearch.FspeMinPositioning.Value, FfrmPSearch.FspeMaxPositioning.Value);
  if ((FfrmPSearch.FspeMinPressure.Value > 0) or (FfrmPSearch.FspeMaxPressure.Value < 20)) then
    CheckPressure(FfrmPSearch.FspeMinPressure.Value, FfrmPSearch.FspeMaxPressure.Value);
  if ((FfrmPSearch.FspeMinProfessionalism.Value > 0) or (FfrmPSearch.FspeMaxProfessionalism.Value < 20)) then
    CheckProfessionalism(FfrmPSearch.FspeMinProfessionalism.Value, FfrmPSearch.FspeMaxProfessionalism.Value);
  if ((FfrmPSearch.FspeMinReflexes.Value > 0) or (FfrmPSearch.FspeMaxReflexes.Value < 20)) then
    CheckReflexes(FfrmPSearch.FspeMinReflexes.Value, FfrmPSearch.FspeMaxReflexes.Value);
  if ((FfrmPSearch.FspeMinFreeKicks.Value > 0) or (FfrmPSearch.FspeMaxFreeKicks.Value < 20)) then
    CheckFreeKicks(FfrmPSearch.FspeMinFreeKicks.Value, FfrmPSearch.FspeMaxFreeKicks.Value);
  if ((FfrmPSearch.FspeMinSportsmanship.Value > 0) or (FfrmPSearch.FspeMaxSportsmanship.Value < 20)) then
    CheckSportsmanship(FfrmPSearch.FspeMinSportsmanship.Value, FfrmPSearch.FspeMaxSportsmanship.Value);
  if ((FfrmPSearch.FspeMinStamina.Value > 0) or (FfrmPSearch.FspeMaxStamina.Value < 20)) then
    CheckStamina(FfrmPSearch.FspeMinStamina.Value, FfrmPSearch.FspeMaxStamina.Value);
  if ((FfrmPSearch.FspeMinStrength.Value > 0) or (FfrmPSearch.FspeMaxStrength.Value < 20)) then
    CheckStrength(FfrmPSearch.FspeMinStrength.Value, FfrmPSearch.FspeMaxStrength.Value);
  if ((FfrmPSearch.FspeMinTackling.Value > 0) or (FfrmPSearch.FspeMaxTackling.Value < 20)) then
    CheckTackling(FfrmPSearch.FspeMinTackling.Value, FfrmPSearch.FspeMaxTackling.Value);
  if ((FfrmPSearch.FspeMinTeamwork.Value > 0) or (FfrmPSearch.FspeMaxTeamwork.Value < 20)) then
    CheckTeamwork(FfrmPSearch.FspeMinTeamwork.Value, FfrmPSearch.FspeMaxTeamwork.Value);
  if ((FfrmPSearch.FspeMinTechnique.Value > 0) or (FfrmPSearch.FspeMaxTechnique.Value < 20)) then
    CheckTechnique(FfrmPSearch.FspeMinTechnique.Value, FfrmPSearch.FspeMaxTechnique.Value);
  if ((FfrmPSearch.FspeMinTemperament.Value > 0) or (FfrmPSearch.FspeMaxTemperament.Value < 20)) then
    CheckTemperament(FfrmPSearch.FspeMinTemperament.Value, FfrmPSearch.FspeMaxTemperament.Value);
  if ((FfrmPSearch.FspeMinThrowIns.Value > 0) or (FfrmPSearch.FspeMaxThrowIns.Value < 20)) then
    CheckThrowIns(FfrmPSearch.FspeMinThrowIns.Value, FfrmPSearch.FspeMaxThrowIns.Value);
  if ((FfrmPSearch.FspeMinVersatility.Value > 0) or (FfrmPSearch.FspeMaxVersatility.Value < 20)) then
    CheckVersatility(FfrmPSearch.FspeMinVersatility.Value, FfrmPSearch.FspeMaxVersatility.Value);
  if ((FfrmPSearch.FspeMinWorkRate.Value > 0) or (FfrmPSearch.FspeMaxWorkRate.Value < 20)) then
    CheckWorkRate(FfrmPSearch.FspeMinWorkRate.Value, FfrmPSearch.FspeMaxWorkRate.Value);
end;

procedure TPlayerSearch.CheckPlayers;
var
  j: Integer;
begin
  ExecuteStatus('Checking Players');
  for j:=0 to FcdData.Staff.Count - 1 do
  begin
    if (FcdData.Staff[j].Player <> nil) then
      FlcResult.Add(FcdData.Staff[j]);
    ExecuteProgress(Trunc((j + 1) / (FcdData.Staff.Count) * 100));
  end;
end;

procedure TPlayerSearch.CheckNames(Name: String);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Names');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (not (((FlcResult[j].CommonName <> nil) and (Pos(LowerCase(Name), LowerCase(FlcResult[j].CommonName.Name)) <> 0)) or (((FlcResult[j].FirstName <> nil) and (FlcResult[j].SecondName <> nil)) and (Pos(LowerCase(Name), LowerCase(FlcResult[j].FirstName.Name + ' ' + FlcResult[j].SecondName.Name)) <> 0)))) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAge(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Age');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (not ((CMAge(FcdData.GameDate, FlcResult[j].DateOfBirth) >= Min) and (CMAge(FcdData.GameDate, FlcResult[j].DateOfBirth) <= Max))) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckNation(Nation: PNation);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Nation');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Nation <> Nation) and (FlcResult[j].SecondNation <> Nation)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckEU;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking EU National');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (not ((FlcResult[j].Nation.GroupMembership = 2) or ((FlcResult[j].SecondNation <> nil) and (FlcResult[j].SecondNation.GroupMembership = 2)))) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckBased(Nation: PNation);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Based Nation');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].ClubJob = nil) then
    begin
      if ((FlcResult[j].Nation <> Nation) and (FlcResult[j].SecondNation <> Nation)) then
        FlcResult.Delete(j);
    end
    else
    begin
      if (FlcResult[j].ClubJob.Nation <> Nation) then
        FlcResult.Delete(j);
    end;
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckDivision(Division: PDivision);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Division');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (not ((FlcResult[j].ClubJob <> nil) and (FlcResult[j].ClubJob.Division = Division))) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckGoalkeeper;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Goalkeeper');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.Goalkeeper < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckDefender;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Defender');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.Defender < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckMidfielder;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Midfielder');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.Midfielder < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAttacker;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Attacker');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.Attacker < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckSweeper;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Sweeper');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.Sweeper < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckDefensiveMidfielder;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Defensive Midfielder');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.DefensiveMidfielder < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAttackingMidfielder;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Attacking Midfielder');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.AttackingMidfielder < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckWingBack;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Wing Back');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.WingBack < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckFreeRole;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Free Role');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.FreeRole < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckLeftSide;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Left Side');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.LeftSide < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckCentral;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Central');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.Central < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckRightSide;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Right Side');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Player.RightSide < 15) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAbility(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Ability');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.CurrentAbility < Min) or (FlcResult[j].Player.CurrentAbility > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckPotentialAbility(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Potential Ability');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.PotentialAbility < Min) or (FlcResult[j].Player.PotentialAbility > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckScoutRating(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Scout Rating');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((ScoutRatingDbl(FlcResult[j]) < Min) or (ScoutRatingDbl(FlcResult[j]) > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckHomeReputation(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Home Reputation');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.HomeReputation < Min) or (FlcResult[j].Player.HomeReputation > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckCurrentReputation(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Current Reputation');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.CurrentReputation < Min) or (FlcResult[j].Player.CurrentReputation > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckWorldReputation(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking World Reputation');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.WorldReputation < Min) or (FlcResult[j].Player.WorldReputation > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckClubReputation(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Club Reputation');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (not ((FlcResult[j].ClubJob <> nil) and ((FlcResult[j].ClubJob.Reputation >= Min) and (FlcResult[j].ClubJob.Reputation <= Max)))) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckContract(Contract: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Contract');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    case Contract of
      0: // Free Transfer
        if (FlcResult[j].ClubJob <> nil) then
          FlcResult.Delete(j);
      1: // Expired
        if (FlcResult[j].Contract = nil) then
          FlcResult.Delete(j)
        else if (FlcResult[j].Contract.ContractExpires.Year > FcdData.GameDate.Year) then
          FlcResult.Delete(j)
        else if ((FlcResult[j].Contract.ContractExpires.Year = FcdData.GameDate.Year) and (FlcResult[j].Contract.ContractExpires.Day > FcdData.GameDate.Day)) then
          FlcResult.Delete(j);
      2: // Expiring
        if (FlcResult[j].Contract = nil) then
          FlcResult.Delete(j)
        else if (FlcResult[j].Contract.ContractExpires.Year > FcdData.GameDate.Year + 1) then
          FlcResult.Delete(j)
        else if ((FlcResult[j].Contract.ContractExpires.Year = FcdData.GameDate.Year + 1) and (FlcResult[j].Contract.ContractExpires.Day > FcdData.GameDate.Day)) then
          FlcResult.Delete(j);
      3: // Unprotected
        if (FlcResult[j].Contract = nil) then
          FlcResult.Delete(j)
        else if (FlcResult[j].Contract.DateStarted.Year < 2001) then
          FlcResult.Delete(j)
        else if ((FlcResult[j].Contract.DateStarted.Year = 2001) and (FlcResult[j].Contract.DateStarted.Day < 244)) then
          FlcResult.Delete(j)
        else if (CMAge(FlcResult[j].Contract.DateStarted, FlcResult[j].DateOfBirth) >= 28) then
        begin
          if (FlcResult[j].Contract.DateStarted.Year + 2 > FcdData.GameDate.Year) then
            FlcResult.Delete(j)
          else if ((FlcResult[j].Contract.DateStarted.Year + 2 = FcdData.GameDate.Year) and (FlcResult[j].Contract.DateStarted.Day > FcdData.GameDate.Day)) then
            FlcResult.Delete(j);
        end
        else
        begin
          if (FlcResult[j].Contract.DateStarted.Year + 3 > FcdData.GameDate.Year) then
            FlcResult.Delete(j)
          else if ((FlcResult[j].Contract.DateStarted.Year + 3 = FcdData.GameDate.Year) and (FlcResult[j].Contract.DateStarted.Day > FcdData.GameDate.Day)) then
            FlcResult.Delete(j);
        end;
    end;
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckLeavingOnBosman;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Leaving On Bosman');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if (not FlcResult[j].Contract.LeavingOnBosman) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckNotTransferArranged;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Not Transfer Arranged');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if (FlcResult[j].Contract.TransferArrangedFor <> nil) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckNonPromotion(Active: Boolean);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Non Promotion Clause');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if (Active) then
    begin
      if (FlcResult[j].Contract.NonPromotionRC <> 2) then
        FlcResult.Delete(j);
    end
    else if (FlcResult[j].Contract.NonPromotionRC < 1) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckRelegation(Active: Boolean);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Relegation Clause');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if (Active) then
    begin
      if (FlcResult[j].Contract.RelegationRC <> 2) then
        FlcResult.Delete(j);
    end
    else if (FlcResult[j].Contract.RelegationRC < 1) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckNonPlaying(Active: Boolean);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Non Playing Clause');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if (Active) then
    begin
      if (FlcResult[j].Contract.NonPlayingRC <> 2) then
        FlcResult.Delete(j);
    end
    else if (FlcResult[j].Contract.NonPlayingRC < 1) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckMinimumFee;
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Minimum Fee Clause');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if (FlcResult[j].Contract.MinimumFeeRC < 1) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckReleaseFee(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Release Fee');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if ((FlcResult[j].Contract.ReleaseFee < Min) or (FlcResult[j].Contract.ReleaseFee > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckTransferStatus(Status: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Transfer Status');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else
    begin
      if ((FlcResult[j].Contract.TransferStatus and 1) = 1) then
      begin
        if (Status <> 0) then // Transfer Listed By Club
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.TransferStatus and 8) = 8) then
      begin
        if (Status <> 1) then // Transfer Listed By Request
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.TransferStatus and 2) = 2) then
      begin
        if (Status <> 2) then // Listed For Loan
          FlcResult.Delete(j);
      end
      else
        FlcResult.Delete(j);
    end;
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckSquadStatus(Status: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Squad Status');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else
    begin
      if ((FlcResult[j].Contract.SquadStatus and 240) = 0) then
      begin
        if (Status <> 0) then // Uncertain
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 224) = 0) then
      begin
        if (Status <> 1) then // Indispensable To The Club
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 208) = 0) then
      begin
        if (Status <> 2) then // Important First Team Player
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 192) = 0) then
      begin
        if (Status <> 3) then // Used In A Squad Rotation System
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 176) = 0) then
      begin
        if (Status <> 4) then // Backup For The First Team
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 160) = 0) then
      begin
        if (Status <> 5) then // Hot Prospect For The Future
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 144) = 0) then
      begin
        if (Status <> 6) then // Decent Young Player
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 128) = 0) then
      begin
        if (Status <> 7) then // Not Needed By The Club
          FlcResult.Delete(j);
      end
      else if ((FlcResult[j].Contract.SquadStatus and 112) = 0) then
      begin
        if (Status <> 8) then // On Trial
          FlcResult.Delete(j);
      end
      else
        FlcResult.Delete(j);
    end;
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckContractType(CtrType: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Contract Type');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else
    begin
      case CtrType of
        0: // Part Time Monthly Contract
          if ((FlcResult[j].Contract.ContractType <> $81) and (FlcResult[j].Contract.ContractType <> $C1)) then
            FlcResult.Delete(j);
        1: // Part Time Contract
          if ((FlcResult[j].Contract.ContractType <> $82) and (FlcResult[j].Contract.ContractType <> $C2)) then
            FlcResult.Delete(j);
        2: // Part Time Trial Contract
          if ((FlcResult[j].Contract.ContractType <> $85) and (FlcResult[j].Contract.ContractType <> $C5)) then
            FlcResult.Delete(j);
        3: // Part Time Loan Contract
          if ((FlcResult[j].Contract.ContractType <> $86) and (FlcResult[j].Contract.ContractType <> $87) and (FlcResult[j].Contract.ContractType <> $C6) and (FlcResult[j].Contract.ContractType <> $C7)) then
            FlcResult.Delete(j);
        4: // Full Time Monthly Contract
          if ((FlcResult[j].Contract.ContractType <> $1) and (FlcResult[j].Contract.ContractType <> $41)) then
            FlcResult.Delete(j);
        5: // Full Time Contract
          if ((FlcResult[j].Contract.ContractType <> $2) and (FlcResult[j].Contract.ContractType <> $42)) then
            FlcResult.Delete(j);
        6: // Full Time Trial Contract
          if ((FlcResult[j].Contract.ContractType <> $5) and (FlcResult[j].Contract.ContractType <> $45)) then
            FlcResult.Delete(j);
        7: // Full Time Loan Contract
          if ((FlcResult[j].Contract.ContractType <> $6) and (FlcResult[j].Contract.ContractType <> $7) and (FlcResult[j].Contract.ContractType <> $46) and (FlcResult[j].Contract.ContractType <> $47)) then
            FlcResult.Delete(j);
      end;
    end;
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckValue(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Value');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Value < Min) or (FlcResult[j].Value > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckWage(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Wage');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if (FlcResult[j].Contract = nil) then
      FlcResult.Delete(j)
    else if ((FlcResult[j].Contract.Wage < Min) or (FlcResult[j].Contract.Wage > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAcceleration(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Acceleration');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Acceleration < Min) or (FlcResult[j].Player.Acceleration > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAdaptability(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Adaptability');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Adaptability < Min) or (FlcResult[j].Adaptability > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAggression(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Aggression');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Aggression < Min) or (FlcResult[j].Player.Aggression > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAgility(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Agility');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Agility < Min) or (FlcResult[j].Player.Agility > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAmbition(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Ambition');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Ambition < Min) or (FlcResult[j].Ambition > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckAnticipation(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Anticipation');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Anticipation < Min) or (FlcResult[j].Player.Anticipation > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckBalance(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Balance');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Balance < Min) or (FlcResult[j].Player.Balance > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckBravery(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Bravery');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Bravery < Min) or (FlcResult[j].Player.Bravery > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckConsistency(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Consistency');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Consistency < Min) or (FlcResult[j].Player.Consistency > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckCorners(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Corners');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Corners < Min) or (FlcResult[j].Player.Corners > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckVision(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Vision');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Vision < Min) or (FlcResult[j].Player.Vision > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckCrossing(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Crossing');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Crossing < Min) or (FlcResult[j].Player.Crossing > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckDecisions(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Decisions');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Decisions < Min) or (FlcResult[j].Player.Decisions > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckDetermination(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Determination');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Determination < Min) or (FlcResult[j].Determination > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckDirtiness(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Dirtiness');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Dirtiness < Min) or (FlcResult[j].Player.Dirtiness > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckDribbling(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Dribbling');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Dribbling < Min) or (FlcResult[j].Player.Dribbling > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckFinishing(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Finishing');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Finishing < Min) or (FlcResult[j].Player.Finishing > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckFlair(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Flair');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Flair < Min) or (FlcResult[j].Player.Flair > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckHandling(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Handling');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Handling < Min) or (FlcResult[j].Player.Handling > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckHeading(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Heading');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Heading < Min) or (FlcResult[j].Player.Heading > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckLeadership(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Leadership');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Leadership < Min) or (FlcResult[j].Player.Leadership > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckImportantMatches(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking ImportantMatches');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.ImportantMatches < Min) or (FlcResult[j].Player.ImportantMatches > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckInjuryProneness(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking InjuryProneness');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.InjuryProneness < Min) or (FlcResult[j].Player.InjuryProneness > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckJumping(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Jumping');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Jumping < Min) or (FlcResult[j].Player.Jumping > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckLongShots(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking LongShots');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.LongShots < Min) or (FlcResult[j].Player.LongShots > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckLoyality(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Loyality');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Loyality < Min) or (FlcResult[j].Loyality > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckNaturalFitness(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking NaturalFitness');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.NaturalFitness < Min) or (FlcResult[j].Player.NaturalFitness > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckMarking(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Marking');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Marking < Min) or (FlcResult[j].Player.Marking > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckMovement(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Movement');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Movement < Min) or (FlcResult[j].Player.Movement > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckOneOnOnes(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking OneOnOnes');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.OneOnOnes < Min) or (FlcResult[j].Player.OneOnOnes > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckPlayerPace(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking PlayerPace');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.PlayerPace < Min) or (FlcResult[j].Player.PlayerPace > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckPassing(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Passing');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Passing < Min) or (FlcResult[j].Player.Passing > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckPenalties(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Penalties');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Penalties < Min) or (FlcResult[j].Player.Penalties > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckPositioning(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Positioning');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Positioning < Min) or (FlcResult[j].Player.Positioning > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckPressure(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Pressure');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Pressure < Min) or (FlcResult[j].Pressure > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckProfessionalism(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Professionalism');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Professionalism < Min) or (FlcResult[j].Professionalism > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckReflexes(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Reflexes');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Reflexes < Min) or (FlcResult[j].Player.Reflexes > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckFreeKicks(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking FreeKicks');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.FreeKicks < Min) or (FlcResult[j].Player.FreeKicks > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckSportsmanship(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Sportsmanship');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Sportsmanship < Min) or (FlcResult[j].Sportsmanship > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckStamina(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Stamina');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Stamina < Min) or (FlcResult[j].Player.Stamina > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckStrength(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Strength');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Strength < Min) or (FlcResult[j].Player.Strength > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckTackling(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Tackling');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Tackling < Min) or (FlcResult[j].Player.Tackling > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckTeamwork(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Teamwork');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Teamwork < Min) or (FlcResult[j].Player.Teamwork > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckTechnique(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Technique');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Technique < Min) or (FlcResult[j].Player.Technique > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckTemperament(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Temperament');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Temperament < Min) or (FlcResult[j].Temperament > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckThrowIns(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking ThrowIns');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.ThrowIns < Min) or (FlcResult[j].Player.ThrowIns > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckVersatility(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking Versatility');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.Versatility < Min) or (FlcResult[j].Player.Versatility > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

procedure TPlayerSearch.CheckWorkRate(Min, Max: Integer);
var
  intCount,
  j: Integer;
begin
  ExecuteStatus('Checking WorkRate');
  intCount:=FlcResult.Count - 1;
  for j:=intCount downto 0 do
  begin
    if ((FlcResult[j].Player.WorkRate < Min) or (FlcResult[j].Player.WorkRate > Max)) then
      FlcResult.Delete(j);
    ExecuteProgress(Trunc((intCount - j + 1) / (intCount + 1) * 100));
  end;
end;

end.
