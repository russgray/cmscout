unit CMFilter;

interface

uses
  CM4SaveGameData, SearchForm, CM4SaveGameDatabase, Classes,
  CM4SupportClasses, Controls, StrUtils;
  
type
  TCMIncludeFilterMethod = function: Boolean of object;
  TCMFilterPlayer = function(Player: TCM4Player): Boolean of object;

  PCMFilterItem = ^TCMFilterItem;
  TCMFilterItem = record
    IncludeFilter: TCMIncludeFilterMethod;
    FilterPlayer: TCMFilterPlayer;
    FilterStatus: string;
  end;
  
  TCMFilter = class
  private
    FSearchForm: TfrmSearch;
    FCMData: TCM4SaveGameDatabase;
    FPlayers: TList;

    FFilterList: TList;

    FOnStatus: TStatusEvent;
    FOnProgress: TProgressEvent;
    
    procedure SetCMData(const Value: TCM4SaveGameDatabase);
    procedure TriggerStatus(Status: string);
    procedure TriggerProgress(Progress, Count: Integer);
    procedure PopulateFilterList;
    function IncludeNameFilter: Boolean;
    function FilterName(Player: TCM4Player): Boolean;
    function IncludeAgeFilter: Boolean;
    function FilterAbility(Player: TCM4Player): Boolean;
    function FilterAge(Player: TCM4Player): Boolean;
    function FilterAttacker(Player: TCM4Player): Boolean;
    function FilterAttackingMidfielder(Player: TCM4Player): Boolean;
    function FilterBased(Player: TCM4Player): Boolean;
    function FilterCentral(Player: TCM4Player): Boolean;
    function FilterDefender(Player: TCM4Player): Boolean;
    function FilterDefensiveMidfielder(Player: TCM4Player): Boolean;
    function FilterDivision(Player: TCM4Player): Boolean;
    function FilterEUNational(Player: TCM4Player): Boolean;
    function FilterFreeRole(Player: TCM4Player): Boolean;
    function FilterGoalkeeper(Player: TCM4Player): Boolean;
    function FilterLeftSide(Player: TCM4Player): Boolean;
    function FilterMidfielder(Player: TCM4Player): Boolean;
    function FilterNation(Player: TCM4Player): Boolean;
    function FilterPotentialAbility(Player: TCM4Player): Boolean;
    function FilterRightSide(Player: TCM4Player): Boolean;
    function FilterScoutRating(Player: TCM4Player): Boolean;
    function FilterSweeper(Player: TCM4Player): Boolean;
    function FilterWingBack(Player: TCM4Player): Boolean;
    function IncludeAbilityFilter: Boolean;
    function IncludeAttackerFilter: Boolean;
    function IncludeAttackingMidfielderFilter: Boolean;
    function IncludeBasedFilter: Boolean;
    function IncludeCentralFilter: Boolean;
    function IncludeDefenderFilter: Boolean;
    function IncludeDefensiveMidfielderFilter: Boolean;
    function IncludeDivisionFilter: Boolean;
    function IncludeEUNationalFilter: Boolean;
    function IncludeFreeRoleFilter: Boolean;
    function IncludeGoalkeeperFilter: Boolean;
    function IncludeLeftSideFilter: Boolean;
    function IncludeMidfielderFilter: Boolean;
    function IncludeNationFilter: Boolean;
    function IncludePotentialAbilityFilter: Boolean;
    function IncludeRightSideFilter: Boolean;
    function IncludeScoutRatingFilter: Boolean;
    function IncludeSweeperFilter: Boolean;
    function IncludeWingBackFilter: Boolean;
    function FilterCurrentReputation(Player: TCM4Player): Boolean;
    function FilterHomeReputation(Player: TCM4Player): Boolean;
    function FilterSquadReputation(Player: TCM4Player): Boolean;
    function FilterWorldReputation(Player: TCM4Player): Boolean;
    function IncludeCurrentReputationFilter: Boolean;
    function IncludeHomeReputationFilter: Boolean;
    function IncludeSquadReputationFilter: Boolean;
    function IncludeWorldReputationFilter: Boolean;
    function FilterContract(Player: TCM4Player): Boolean;
    function FilterLeavingOnBosman(Player: TCM4Player): Boolean;
    function IncludeContractFilter: Boolean;
    function IncludeLeavingOnBosmanFilter: Boolean;
    function FilterMinimumReleaseFee(Player: TCM4Player): Boolean;
    function FilterNonPromotionReleaseFee(Player: TCM4Player): Boolean;
    function FilterRelegationReleaseFee(Player: TCM4Player): Boolean;
    function IncludeMinimumReleaseFeeFilter: Boolean;
    function IncludeNonPromotionReleaseFeeFilter: Boolean;
    function IncludeRelegationReleaseFeeFilter: Boolean;
    function FilterSquadStatus(Player: TCM4Player): Boolean;
    function FilterTransferStatus(Player: TCM4Player): Boolean;
    function IncludeSquadStatusFilter: Boolean;
    function IncludeTransferStatusFilter: Boolean;
    function FilterContractType(Player: TCM4Player): Boolean;
    function IncludeContractTypeFilter: Boolean;
    function FilterSaleValue(Player: TCM4Player): Boolean;
    function FilterValue(Player: TCM4Player): Boolean;
    function FilterWage(Player: TCM4Player): Boolean;
    function IncludeSaleValueFilter: Boolean;
    function IncludeValueFilter: Boolean;
    function IncludeWageFilter: Boolean;
    function FilterAcceleration(Player: TCM4Player): Boolean;
    function FilterAdaptability(Player: TCM4Player): Boolean;
    function FilterAerialAbility(Player: TCM4Player): Boolean;
    function FilterAggression(Player: TCM4Player): Boolean;
    function FilterAgility(Player: TCM4Player): Boolean;
    function FilterAmbition(Player: TCM4Player): Boolean;
    function FilterAnticipation(Player: TCM4Player): Boolean;
    function FilterBalance(Player: TCM4Player): Boolean;
    function FilterBravery(Player: TCM4Player): Boolean;
    function FilterCommandOfArea(Player: TCM4Player): Boolean;
    function FilterCommunication(Player: TCM4Player): Boolean;
    function FilterConsistency(Player: TCM4Player): Boolean;
    function FilterControversy(Player: TCM4Player): Boolean;
    function FilterCorners(Player: TCM4Player): Boolean;
    function FilterCreativity(Player: TCM4Player): Boolean;
    function FilterCrossing(Player: TCM4Player): Boolean;
    function FilterDecisions(Player: TCM4Player): Boolean;
    function FilterDetermination(Player: TCM4Player): Boolean;
    function FilterDirtiness(Player: TCM4Player): Boolean;
    function FilterDribbling(Player: TCM4Player): Boolean;
    function FilterEccentricity(Player: TCM4Player): Boolean;
    function FilterFinishing(Player: TCM4Player): Boolean;
    function FilterFirstTouch(Player: TCM4Player): Boolean;
    function FilterFlair(Player: TCM4Player): Boolean;
    function FilterHandling(Player: TCM4Player): Boolean;
    function FilterHeading(Player: TCM4Player): Boolean;
    function FilterImportantMatches(Player: TCM4Player): Boolean;
    function FilterInfluence(Player: TCM4Player): Boolean;
    function FilterInjuryProneness(Player: TCM4Player): Boolean;
    function FilterJumping(Player: TCM4Player): Boolean;
    function FilterKicking(Player: TCM4Player): Boolean;
    function FilterLeftFoot(Player: TCM4Player): Boolean;
    function FilterLongShots(Player: TCM4Player): Boolean;
    function FilterLongThrows(Player: TCM4Player): Boolean;
    function FilterLoyality(Player: TCM4Player): Boolean;
    function FilterMarking(Player: TCM4Player): Boolean;
    function FilterNaturalFitness(Player: TCM4Player): Boolean;
    function FilterOffTheBall(Player: TCM4Player): Boolean;
    function FilterOneOnOnes(Player: TCM4Player): Boolean;
    function FilterPace(Player: TCM4Player): Boolean;
    function FilterPassing(Player: TCM4Player): Boolean;
    function FilterPenalties(Player: TCM4Player): Boolean;
    function FilterPositioning(Player: TCM4Player): Boolean;
    function FilterPressure(Player: TCM4Player): Boolean;
    function FilterProfessionalism(Player: TCM4Player): Boolean;
    function FilterReflexes(Player: TCM4Player): Boolean;
    function FilterRightFoot(Player: TCM4Player): Boolean;
    function FilterRushingOut(Player: TCM4Player): Boolean;
    function FilterSetPieces(Player: TCM4Player): Boolean;
    function FilterSportsmanship(Player: TCM4Player): Boolean;
    function FilterStamina(Player: TCM4Player): Boolean;
    function FilterStrength(Player: TCM4Player): Boolean;
    function FilterTackling(Player: TCM4Player): Boolean;
    function FilterTeamwork(Player: TCM4Player): Boolean;
    function FilterTechnique(Player: TCM4Player): Boolean;
    function FilterTemperament(Player: TCM4Player): Boolean;
    function FilterTendencyToPunch(Player: TCM4Player): Boolean;
    function FilterThrowing(Player: TCM4Player): Boolean;
    function FilterThrowIns(Player: TCM4Player): Boolean;
    function FilterVersatility(Player: TCM4Player): Boolean;
    function FilterWorkRate(Player: TCM4Player): Boolean;
    function IncludeAccelerationFilter: Boolean;
    function IncludeAdaptabilityFilter: Boolean;
    function IncludeAerialAbilityFilter: Boolean;
    function IncludeAggressionFilter: Boolean;
    function IncludeAgilityFilter: Boolean;
    function IncludeAmbitionFilter: Boolean;
    function IncludeAnticipationFilter: Boolean;
    function IncludeBalanceFilter: Boolean;
    function IncludeBraveryFilter: Boolean;
    function IncludeCommandOfAreaFilter: Boolean;
    function IncludeCommunicationFilter: Boolean;
    function IncludeConsistencyFilter: Boolean;
    function IncludeControversyFilter: Boolean;
    function IncludeCornersFilter: Boolean;
    function IncludeCreativityFilter: Boolean;
    function IncludeCrossingFilter: Boolean;
    function IncludeDecisionsFilter: Boolean;
    function IncludeDeterminationFilter: Boolean;
    function IncludeDirtinessFilter: Boolean;
    function IncludeDribblingFilter: Boolean;
    function IncludeEccentricityFilter: Boolean;
    function IncludeFinishingFilter: Boolean;
    function IncludeFirstTouchFilter: Boolean;
    function IncludeFlairFilter: Boolean;
    function IncludeHandlingFilter: Boolean;
    function IncludeHeadingFilter: Boolean;
    function IncludeImportantMatchesFilter: Boolean;
    function IncludeInfluenceFilter: Boolean;
    function IncludeInjuryPronenessFilter: Boolean;
    function IncludeJumpingFilter: Boolean;
    function IncludeKickingFilter: Boolean;
    function IncludeLeftFootFilter: Boolean;
    function IncludeLongShotsFilter: Boolean;
    function IncludeLongThrowsFilter: Boolean;
    function IncludeLoyalityFilter: Boolean;
    function IncludeMarkingFilter: Boolean;
    function IncludeNaturalFitnessFilter: Boolean;
    function IncludeOffTheBallFilter: Boolean;
    function IncludeOneOnOnesFilter: Boolean;
    function IncludePaceFilter: Boolean;
    function IncludePassingFilter: Boolean;
    function IncludePenaltiesFilter: Boolean;
    function IncludePositioningFilter: Boolean;
    function IncludePressureFilter: Boolean;
    function IncludeProfessionalismFilter: Boolean;
    function IncludeReflexesFilter: Boolean;
    function IncludeRightFootFilter: Boolean;
    function IncludeRushingOutFilter: Boolean;
    function IncludeSetPiecesFilter: Boolean;
    function IncludeSportsmanshipFilter: Boolean;
    function IncludeStaminaFilter: Boolean;
    function IncludeStrengthFilter: Boolean;
    function IncludeTacklingFilter: Boolean;
    function IncludeTeamworkFilter: Boolean;
    function IncludeTechniqueFilter: Boolean;
    function IncludeTemperamentFilter: Boolean;
    function IncludeTendencyToPunchFilter: Boolean;
    function IncludeThrowingFilter: Boolean;
    function IncludeThrowInsFilter: Boolean;
    function IncludeVersatilityFilter: Boolean;
    function IncludeWorkRateFilter: Boolean;
    function FilterInternationalApps(Player: TCM4Player): Boolean;
    function FilterInternationalGoals(Player: TCM4Player): Boolean;
    function IncludeInternationalAppsFilter: Boolean;
    function IncludeInternationalGoalsFilter: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Search(Players: TList): Boolean;

    property CMData: TCM4SaveGameDatabase read FCMData write SetCMData;

    property OnStatus: TStatusEvent read FOnStatus write FOnStatus;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
  end;

implementation

{ TCMFilter }

constructor TCMFilter.Create;
begin
  FSearchForm:=TfrmSearch.Create(nil);
  FFilterList:=TList.Create;
  PopulateFilterList;
end;

procedure TCMFilter.PopulateFilterList;
var
  FilterItem: PCMFilterItem;
begin
  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeNameFilter;
  FilterItem.FilterPlayer:=FilterName;
  FilterItem.FilterStatus:='Checking Name';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAgeFilter;
  FilterItem.FilterPlayer:=FilterAge;
  FilterItem.FilterStatus:='Checking Age';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeNationFilter;
  FilterItem.FilterPlayer:=FilterNation;
  FilterItem.FilterStatus:='Checking Nation';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeEUNationalFilter;
  FilterItem.FilterPlayer:=FilterEUNational;
  FilterItem.FilterStatus:='Checking EU National';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeBasedFilter;
  FilterItem.FilterPlayer:=FilterBased;
  FilterItem.FilterStatus:='Checking Based';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeDivisionFilter;
  FilterItem.FilterPlayer:=FilterDivision;
  FilterItem.FilterStatus:='Checking Division';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAbilityFilter;
  FilterItem.FilterPlayer:=FilterAbility;
  FilterItem.FilterStatus:='Checking Ability';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludePotentialAbilityFilter;
  FilterItem.FilterPlayer:=FilterPotentialAbility;
  FilterItem.FilterStatus:='Checking Potential Ability';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeScoutRatingFilter;
  FilterItem.FilterPlayer:=FilterScoutRating;
  FilterItem.FilterStatus:='Checking Scout Rating';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeGoalkeeperFilter;
  FilterItem.FilterPlayer:=FilterGoalkeeper;
  FilterItem.FilterStatus:='Checking Goalkeeper';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeSweeperFilter;
  FilterItem.FilterPlayer:=FilterSweeper;
  FilterItem.FilterStatus:='Checking Sweeper';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeDefenderFilter;
  FilterItem.FilterPlayer:=FilterDefender;
  FilterItem.FilterStatus:='Checking Defender';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeDefensiveMidfielderFilter;
  FilterItem.FilterPlayer:=FilterDefensiveMidfielder;
  FilterItem.FilterStatus:='Checking Defensive Midfielder';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeMidfielderFilter;
  FilterItem.FilterPlayer:=FilterMidfielder;
  FilterItem.FilterStatus:='Checking Midfielder';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAttackingMidfielderFilter;
  FilterItem.FilterPlayer:=FilterAttackingMidfielder;
  FilterItem.FilterStatus:='Checking Attacking Midfielder';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAttackerFilter;
  FilterItem.FilterPlayer:=FilterAttacker;
  FilterItem.FilterStatus:='Checking Attacker';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeWingBackFilter;
  FilterItem.FilterPlayer:=FilterWingBack;
  FilterItem.FilterStatus:='Checking Wing Back';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeFreeRoleFilter;
  FilterItem.FilterPlayer:=FilterFreeRole;
  FilterItem.FilterStatus:='Checking Free Role';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeLeftSideFilter;
  FilterItem.FilterPlayer:=FilterLeftSide;
  FilterItem.FilterStatus:='Checking Left Side';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeRightSideFilter;
  FilterItem.FilterPlayer:=FilterRightSide;
  FilterItem.FilterStatus:='Checking Right Side';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeCentralFilter;
  FilterItem.FilterPlayer:=FilterCentral;
  FilterItem.FilterStatus:='Checking Central';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeHomeReputationFilter;
  FilterItem.FilterPlayer:=FilterHomeReputation;
  FilterItem.FilterStatus:='Checking Home Reputation';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeCurrentReputationFilter;
  FilterItem.FilterPlayer:=FilterCurrentReputation;
  FilterItem.FilterStatus:='Checking Current Reputation';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeWorldReputationFilter;
  FilterItem.FilterPlayer:=FilterWorldReputation;
  FilterItem.FilterStatus:='Checking World Reputation';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeSquadReputationFilter;
  FilterItem.FilterPlayer:=FilterSquadReputation;
  FilterItem.FilterStatus:='Checking Squad Reputation';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeContractFilter;
  FilterItem.FilterPlayer:=FilterContract;
  FilterItem.FilterStatus:='Checking Contract';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeLeavingOnBosmanFilter;
  FilterItem.FilterPlayer:=FilterLeavingOnBosman;
  FilterItem.FilterStatus:='Checking Leaving On Bosman';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeNonPromotionReleaseFeeFilter;
  FilterItem.FilterPlayer:=FilterNonPromotionReleaseFee;
  FilterItem.FilterStatus:='Checking Non Promotion Release Fee';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeRelegationReleaseFeeFilter;
  FilterItem.FilterPlayer:=FilterRelegationReleaseFee;
  FilterItem.FilterStatus:='Checking Relegation Release Fee';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeMinimumReleaseFeeFilter;
  FilterItem.FilterPlayer:=FilterMinimumReleaseFee;
  FilterItem.FilterStatus:='Checking Minimum Release Fee';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeTransferStatusFilter;
  FilterItem.FilterPlayer:=FilterTransferStatus;
  FilterItem.FilterStatus:='Checking Transfer Status';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeSquadStatusFilter;
  FilterItem.FilterPlayer:=FilterSquadStatus;
  FilterItem.FilterStatus:='Checking Squad Status';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeContractTypeFilter;
  FilterItem.FilterPlayer:=FilterContractType;
  FilterItem.FilterStatus:='Checking Contract Type';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeValueFilter;
  FilterItem.FilterPlayer:=FilterValue;
  FilterItem.FilterStatus:='Checking Value';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeSaleValueFilter;
  FilterItem.FilterPlayer:=FilterSaleValue;
  FilterItem.FilterStatus:='Checking Sale Value';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeWageFilter;
  FilterItem.FilterPlayer:=FilterWage;
  FilterItem.FilterStatus:='Checking Wage';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAccelerationFilter;
  FilterItem.FilterPlayer:=FilterAcceleration;
  FilterItem.FilterStatus:='Checking Acceleration';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAdaptabilityFilter;
  FilterItem.FilterPlayer:=FilterAdaptability;
  FilterItem.FilterStatus:='Checking Adaptability';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAerialAbilityFilter;
  FilterItem.FilterPlayer:=FilterAerialAbility;
  FilterItem.FilterStatus:='Checking Aerial Ability';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAggressionFilter;
  FilterItem.FilterPlayer:=FilterAggression;
  FilterItem.FilterStatus:='Checking Aggression';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAgilityFilter;
  FilterItem.FilterPlayer:=FilterAgility;
  FilterItem.FilterStatus:='Checking Agility';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAmbitionFilter;
  FilterItem.FilterPlayer:=FilterAmbition;
  FilterItem.FilterStatus:='Checking Ambition';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeAnticipationFilter;
  FilterItem.FilterPlayer:=FilterAnticipation;
  FilterItem.FilterStatus:='Checking Anticipation';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeBalanceFilter;
  FilterItem.FilterPlayer:=FilterBalance;
  FilterItem.FilterStatus:='Checking Balance';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeBraveryFilter;
  FilterItem.FilterPlayer:=FilterBravery;
  FilterItem.FilterStatus:='Checking Bravery';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeCommandOfAreaFilter;
  FilterItem.FilterPlayer:=FilterCommandOfArea;
  FilterItem.FilterStatus:='Checking Command Of Area';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeCommunicationFilter;
  FilterItem.FilterPlayer:=FilterCommunication;
  FilterItem.FilterStatus:='Checking Communication';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeConsistencyFilter;
  FilterItem.FilterPlayer:=FilterConsistency;
  FilterItem.FilterStatus:='Checking Consistency';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeControversyFilter;
  FilterItem.FilterPlayer:=FilterControversy;
  FilterItem.FilterStatus:='Checking Controversy';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeCornersFilter;
  FilterItem.FilterPlayer:=FilterCorners;
  FilterItem.FilterStatus:='Checking Corners';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeCreativityFilter;
  FilterItem.FilterPlayer:=FilterCreativity;
  FilterItem.FilterStatus:='Checking Creativity';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeCrossingFilter;
  FilterItem.FilterPlayer:=FilterCrossing;
  FilterItem.FilterStatus:='Checking Crossing';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeDecisionsFilter;
  FilterItem.FilterPlayer:=FilterDecisions;
  FilterItem.FilterStatus:='Checking Decisions';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeDeterminationFilter;
  FilterItem.FilterPlayer:=FilterDetermination;
  FilterItem.FilterStatus:='Checking Determination';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeDirtinessFilter;
  FilterItem.FilterPlayer:=FilterDirtiness;
  FilterItem.FilterStatus:='Checking Dirtiness';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeDribblingFilter;
  FilterItem.FilterPlayer:=FilterDribbling;
  FilterItem.FilterStatus:='Checking Dribbling';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeEccentricityFilter;
  FilterItem.FilterPlayer:=FilterEccentricity;
  FilterItem.FilterStatus:='Checking Eccentricity';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeFinishingFilter;
  FilterItem.FilterPlayer:=FilterFinishing;
  FilterItem.FilterStatus:='Checking Finishing';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeFirstTouchFilter;
  FilterItem.FilterPlayer:=FilterFirstTouch;
  FilterItem.FilterStatus:='Checking First Touch';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeFlairFilter;
  FilterItem.FilterPlayer:=FilterFlair;
  FilterItem.FilterStatus:='Checking Flair';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeHandlingFilter;
  FilterItem.FilterPlayer:=FilterHandling;
  FilterItem.FilterStatus:='Checking Handling';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeHeadingFilter;
  FilterItem.FilterPlayer:=FilterHeading;
  FilterItem.FilterStatus:='Checking Heading';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeImportantMatchesFilter;
  FilterItem.FilterPlayer:=FilterImportantMatches;
  FilterItem.FilterStatus:='Checking Important Matches';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeInfluenceFilter;
  FilterItem.FilterPlayer:=FilterInfluence;
  FilterItem.FilterStatus:='Checking Influence';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeInjuryPronenessFilter;
  FilterItem.FilterPlayer:=FilterInjuryProneness;
  FilterItem.FilterStatus:='Checking Injury Proneness';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeJumpingFilter;
  FilterItem.FilterPlayer:=FilterJumping;
  FilterItem.FilterStatus:='Checking Jumping';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeKickingFilter;
  FilterItem.FilterPlayer:=FilterKicking;
  FilterItem.FilterStatus:='Checking Kicking';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeLeftFootFilter;
  FilterItem.FilterPlayer:=FilterLeftFoot;
  FilterItem.FilterStatus:='Checking Left Foot';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeLongShotsFilter;
  FilterItem.FilterPlayer:=FilterLongShots;
  FilterItem.FilterStatus:='Checking Long Shots';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeLongThrowsFilter;
  FilterItem.FilterPlayer:=FilterLongThrows;
  FilterItem.FilterStatus:='Checking Long Throws';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeLoyalityFilter;
  FilterItem.FilterPlayer:=FilterLoyality;
  FilterItem.FilterStatus:='Checking Loyality';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeMarkingFilter;
  FilterItem.FilterPlayer:=FilterMarking;
  FilterItem.FilterStatus:='Checking Marking';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeNaturalFitnessFilter;
  FilterItem.FilterPlayer:=FilterNaturalFitness;
  FilterItem.FilterStatus:='Checking Natural Fitness';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeOffTheBallFilter;
  FilterItem.FilterPlayer:=FilterOffTheBall;
  FilterItem.FilterStatus:='Checking Off The Ball';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeOneOnOnesFilter;
  FilterItem.FilterPlayer:=FilterOneOnOnes;
  FilterItem.FilterStatus:='Checking One On Ones';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludePaceFilter;
  FilterItem.FilterPlayer:=FilterPace;
  FilterItem.FilterStatus:='Checking Pace';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludePassingFilter;
  FilterItem.FilterPlayer:=FilterPassing;
  FilterItem.FilterStatus:='Checking Passing';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludePenaltiesFilter;
  FilterItem.FilterPlayer:=FilterPenalties;
  FilterItem.FilterStatus:='Checking Penalties';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludePositioningFilter;
  FilterItem.FilterPlayer:=FilterPositioning;
  FilterItem.FilterStatus:='Checking Positioning';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludePressureFilter;
  FilterItem.FilterPlayer:=FilterPressure;
  FilterItem.FilterStatus:='Checking Pressure';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeProfessionalismFilter;
  FilterItem.FilterPlayer:=FilterProfessionalism;
  FilterItem.FilterStatus:='Checking Professionalism';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeReflexesFilter;
  FilterItem.FilterPlayer:=FilterReflexes;
  FilterItem.FilterStatus:='Checking Reflexes';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeRightFootFilter;
  FilterItem.FilterPlayer:=FilterRightFoot;
  FilterItem.FilterStatus:='Checking Right Foot';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeRushingOutFilter;
  FilterItem.FilterPlayer:=FilterRushingOut;
  FilterItem.FilterStatus:='Checking Rushing Out';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeSetPiecesFilter;
  FilterItem.FilterPlayer:=FilterSetPieces;
  FilterItem.FilterStatus:='Checking Set Pieces';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeSportsmanshipFilter;
  FilterItem.FilterPlayer:=FilterSportsmanship;
  FilterItem.FilterStatus:='Checking Sportsmanship';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeStaminaFilter;
  FilterItem.FilterPlayer:=FilterStamina;
  FilterItem.FilterStatus:='Checking Stamina';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeStrengthFilter;
  FilterItem.FilterPlayer:=FilterStrength;
  FilterItem.FilterStatus:='Checking Strength';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeTacklingFilter;
  FilterItem.FilterPlayer:=FilterTackling;
  FilterItem.FilterStatus:='Checking Tackling';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeTeamworkFilter;
  FilterItem.FilterPlayer:=FilterTeamwork;
  FilterItem.FilterStatus:='Checking Teamwork';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeTechniqueFilter;
  FilterItem.FilterPlayer:=FilterTechnique;
  FilterItem.FilterStatus:='Checking Technique';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeTemperamentFilter;
  FilterItem.FilterPlayer:=FilterTemperament;
  FilterItem.FilterStatus:='Checking Temperament';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeTendencyToPunchFilter;
  FilterItem.FilterPlayer:=FilterTendencyToPunch;
  FilterItem.FilterStatus:='Checking Tendency To Punch';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeThrowingFilter;
  FilterItem.FilterPlayer:=FilterThrowing;
  FilterItem.FilterStatus:='Checking Throwing';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeThrowInsFilter;
  FilterItem.FilterPlayer:=FilterThrowIns;
  FilterItem.FilterStatus:='Checking Throw Ins';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeVersatilityFilter;
  FilterItem.FilterPlayer:=FilterVersatility;
  FilterItem.FilterStatus:='Checking Versatility';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeWorkRateFilter;
  FilterItem.FilterPlayer:=FilterWorkRate;
  FilterItem.FilterStatus:='Checking WorkRate';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeInternationalAppsFilter;
  FilterItem.FilterPlayer:=FilterInternationalApps;
  FilterItem.FilterStatus:='Checking Caps';

  New(FilterItem);
  FFilterList.Add(FilterItem);
  FilterItem.IncludeFilter:=IncludeInternationalGoalsFilter;
  FilterItem.FilterPlayer:=FilterInternationalGoals;
  FilterItem.FilterStatus:='Checking International Goals';
end;

destructor TCMFilter.Destroy;
var
  j: Integer;
begin
  for j:=0 to FFilterList.Count - 1 do
    Dispose(FFilterList[j]);
  FFilterList.Free;
  FSearchForm.Free;
  inherited;
end;

procedure TCMFilter.TriggerStatus(Status: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Status);
end;

procedure TCMFilter.TriggerProgress(Progress, Count: Integer);
begin
  if Assigned(FOnProgress) then
  begin
    if Count > 0 then
      FOnProgress(Trunc((Progress + 1) / Count * 100))
    else
      FOnProgress(100);
  end;
end;

function TCMFilter.Search(Players: TList): Boolean;
var
  j, s, Count: Integer;
  Filter: PCMFilterItem;
begin
  if FSearchForm.ShowModal = mrOK then
  begin
    Result:=True;
    FPlayers:=Players;

    Players.Clear;

    TriggerStatus('Finding Players');
    for j:=0 to CMData.People.Players.Count - 1 do
    begin
      Players.Add(CMData.People.Players[j]);
      TriggerProgress(j, CMData.People.Players.Count);
    end;

    for j:=0 to FFilterList.Count - 1 do
    begin
      Filter:=FFilterList[j];
      if Filter.IncludeFilter then
      begin
        TriggerStatus(Filter.FilterStatus);

        Count:=FPlayers.Count;

        for s:=FPlayers.Count - 1 downto 0 do
        begin
          if Filter.FilterPlayer(FPlayers[s]) then
            FPlayers.Delete(s);
            
          TriggerProgress(Count - s, Count);
        end;
      end;
    end;
  end
  else
    Result:=False;
end;

procedure TCMFilter.SetCMData(const Value: TCM4SaveGameDatabase);
var
  j: Integer;
begin
  FCMData:=Value;

  FSearchForm.cmbNation.Clear;
  FSearchForm.cmbBased.Clear;
  for j:=0 to CMData.Nations.Count - 1 do
  begin
    FSearchForm.cmbNation.AddItem(CMData.Nations[j].ShortName, CMData.Nations[j]);
    FSearchForm.cmbBased.AddItem(CMData.Nations[j].ShortName, CMData.Nations[j]);
  end;

  FSearchForm.cmbDivision.Clear;
  for j:=0 to CMData.Competitions.Count - 1 do
    if CMData.Competitions[j].Name <> '' then
      FSearchForm.cmbDivision.AddItem(CMData.Competitions[j].Name, CMData.Competitions[j]);
end;

function TCMFilter.IncludeNameFilter: Boolean;
begin
  Result:=FSearchForm.edName.Text <> '';
end;

function TCMFilter.FilterName(Player: TCM4Player): Boolean;
begin
  Result:=not AnsiContainsText(Player.FullName, FSearchForm.edName.Text);
  if (Result) and (Player.CommonName <> nil) then
    Result:=not AnsiContainsText(Player.CommonName.Name, FSearchForm.edName.Text);
end;

function TCMFilter.IncludeAgeFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAge.Value <> 0) or (FSearchForm.speMaxAge.Value <> 0);
end;

function TCMFilter.FilterAge(Player: TCM4Player): Boolean;
begin
  Result:=(Player.DateOfBirth.Age(CMData.GameDate) < FSearchForm.speMinAge.Value) or (Player.DateOfBirth.Age(CMData.GameDate) > FSearchForm.speMaxAge.Value);
end;

function TCMFilter.IncludeNationFilter: Boolean;
begin
  Result:=FSearchForm.cmbNation.ItemIndex <> -1;
end;

function TCMFilter.FilterNation(Player: TCM4Player): Boolean;
begin
  Result:=not Player.FromNation(TCM4Nation(FSearchForm.cmbNation.Items.Objects[FSearchForm.cmbNation.ItemIndex]));
end;

function TCMFilter.IncludeEUNationalFilter: Boolean;
begin
  Result:=FSearchForm.cbEUNational.Checked;
end;

function TCMFilter.FilterEUNational(Player: TCM4Player): Boolean;
begin
  Result:=not Player.EUMember;
end;

function TCMFilter.IncludeBasedFilter: Boolean;
begin
  Result:=FSearchForm.cmbBased.ItemIndex <> -1;
end;

function TCMFilter.FilterBased(Player: TCM4Player): Boolean;
begin
  Result:=Player.Based <> FSearchForm.cmbBased.Items.Objects[FSearchForm.cmbBased.ItemIndex];
end;

function TCMFilter.IncludeDivisionFilter: Boolean;
begin
  Result:=FSearchForm.cmbDivision.ItemIndex <> -1;
end;

function TCMFilter.FilterDivision(Player: TCM4Player): Boolean;
begin
  Result:=Player.Division <> FSearchForm.cmbDivision.Items.Objects[FSearchForm.cmbDivision.ItemIndex];
end;

function TCMFilter.IncludeAbilityFilter: Boolean;
begin
  Result:=(FSearchForm.speAbilityMin.Value <> 0) or (FSearchForm.speAbilityMax.Value <> 200);
end;

function TCMFilter.FilterAbility(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.CurrentAbility < FSearchForm.speAbilityMin.Value) or ((Player as ICM4Player).PlayerData.CurrentAbility > FSearchForm.speAbilityMax.Value);
end;

function TCMFilter.IncludePotentialAbilityFilter: Boolean;
begin
  Result:=(FSearchForm.spePotentialAbilityMin.Value <> 0) or (FSearchForm.spePotentialAbilityMax.Value <> 200);
end;

function TCMFilter.FilterPotentialAbility(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PotentialAbility < FSearchForm.spePotentialAbilityMin.Value) or ((Player as ICM4Player).PlayerData.PotentialAbility > FSearchForm.spePotentialAbilityMax.Value);
end;

function TCMFilter.IncludeScoutRatingFilter: Boolean;
begin
  Result:=(FSearchForm.speScoutRatingMin.Value <> 0) or (FSearchForm.speScoutRatingMax.Value <> 100);
end;

function TCMFilter.FilterScoutRating(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).ScoutRating.BestRating < FSearchForm.speScoutRatingMin.Value) or ((Player as ICM4Player).ScoutRating.BestRating > FSearchForm.speScoutRatingMax.Value);
end;

function TCMFilter.IncludeGoalkeeperFilter: Boolean;
begin
  Result:=FSearchForm.cbGoalkeeper.Checked;
end;

function TCMFilter.FilterGoalkeeper(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.Goalkeeper < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeSweeperFilter: Boolean;
begin
  Result:=FSearchForm.cbSweeper.Checked;
end;

function TCMFilter.FilterSweeper(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.Sweeper < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeDefenderFilter: Boolean;
begin
  Result:=FSearchForm.cbDefender.Checked;
end;

function TCMFilter.FilterDefender(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.Defender < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeDefensiveMidfielderFilter: Boolean;
begin
  Result:=FSearchForm.cbDefensiveMidfielder.Checked;
end;

function TCMFilter.FilterDefensiveMidfielder(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.DefensiveMidfielder < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeMidfielderFilter: Boolean;
begin
  Result:=FSearchForm.cbMidfielder.Checked;
end;

function TCMFilter.FilterMidfielder(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.Midfielder < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeAttackingMidfielderFilter: Boolean;
begin
  Result:=FSearchForm.cbAttackingMidfielder.Checked;
end;

function TCMFilter.FilterAttackingMidfielder(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.AttackingMidfielder < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeAttackerFilter: Boolean;
begin
  Result:=FSearchForm.cbAttacker.Checked;
end;

function TCMFilter.FilterAttacker(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.Attacker < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeWingBackFilter: Boolean;
begin
  Result:=FSearchForm.cbWingBack.Checked;
end;

function TCMFilter.FilterWingBack(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.WingBack < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeFreeRoleFilter: Boolean;
begin
  Result:=FSearchForm.cbFreeRole.Checked;
end;

function TCMFilter.FilterFreeRole(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.FreeRole < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeLeftSideFilter: Boolean;
begin
  Result:=FSearchForm.cbLeftSide.Checked;
end;

function TCMFilter.FilterLeftSide(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.LeftSide < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeRightSideFilter: Boolean;
begin
  Result:=FSearchForm.cbRightSide.Checked;
end;

function TCMFilter.FilterRightSide(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.RightSide < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeCentralFilter: Boolean;
begin
  Result:=FSearchForm.cbCentral.Checked;
end;

function TCMFilter.FilterCentral(Player: TCM4Player): Boolean;
begin
  Result:=(Player as ICM4Player).PlayerData.PlayingData.Central < POSITION_THRESHOLD;
end;

function TCMFilter.IncludeHomeReputationFilter: Boolean;
begin
  Result:=(FSearchForm.speHomeReputationMin.Value <> 0) or (FSearchForm.speHomeReputationMax.Value <> 10000);
end;

function TCMFilter.FilterHomeReputation(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.HomeReputation < FSearchForm.speHomeReputationMin.Value) or ((Player as ICM4Player).PlayerData.HomeReputation > FSearchForm.speHomeReputationMax.Value);
end;

function TCMFilter.IncludeCurrentReputationFilter: Boolean;
begin
  Result:=(FSearchForm.speCurrentReputationMin.Value <> 0) or (FSearchForm.speCurrentReputationMax.Value <> 10000);
end;

function TCMFilter.FilterCurrentReputation(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.CurrentReputation < FSearchForm.speCurrentReputationMin.Value) or ((Player as ICM4Player).PlayerData.CurrentReputation > FSearchForm.speCurrentReputationMax.Value);
end;

function TCMFilter.IncludeWorldReputationFilter: Boolean;
begin
  Result:=(FSearchForm.speWorldReputationMin.Value <> 0) or (FSearchForm.speWorldReputationMax.Value <> 10000);
end;

function TCMFilter.FilterWorldReputation(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.WorldReputation < FSearchForm.speWorldReputationMin.Value) or ((Player as ICM4Player).PlayerData.WorldReputation > FSearchForm.speWorldReputationMax.Value);
end;

function TCMFilter.IncludeSquadReputationFilter: Boolean;
begin
  Result:=(FSearchForm.speSquadReputationMin.Value <> 0) or (FSearchForm.speSquadReputationMax.Value <> 10000);
end;

function TCMFilter.FilterSquadReputation(Player: TCM4Player): Boolean;
begin
  Result:=(Player.SquadReputation < FSearchForm.speSquadReputationMin.Value) or (Player.SquadReputation > FSearchForm.speSquadReputationMax.Value);
end;

function TCMFilter.IncludeContractFilter: Boolean;
begin
  Result:=FSearchForm.cmbContract.ItemIndex <> -1;
end;

function TCMFilter.FilterContract(Player: TCM4Player): Boolean;
begin
  Result:=True;
  case FSearchForm.cmbContract.ItemIndex of
    0:
      Result:=Player.ClubTeam <> nil;
    1:
      if Player.Contracts.FullContract <> nil then
        Result:=Player.Contracts.FullContract.EndDate.Date > CMData.GameDate.Date
      else
        Result:=True;
    2:
      if Player.Contracts.FullContract <> nil then
        Result:=Player.Contracts.FullContract.EndDate.Date > CMData.GameDate.OneYearDate
      else
        Result:=True;
    3:
      if Player.Contracts.FullContract <> nil then
        Result:=(Player.DateOfBirth.Age(CMData.GameDate) > 16) and (not Player.Contracts.FullContract.EndDate.MonthToMonth)
      else
        Result:=True;
  end;
end;

function TCMFilter.IncludeLeavingOnBosmanFilter: Boolean;
begin
  Result:=FSearchForm.cbLeavingOnBosman.Checked;
end;

function TCMFilter.FilterLeavingOnBosman(Player: TCM4Player): Boolean;
begin
  Result:=not Player.LeavingOnBosman;
  if not Result then
    Result:=Player.Contracts.FullContract.EndDate.Date > CMData.GameDate.OneYearDate;
end;

function TCMFilter.IncludeNonPromotionReleaseFeeFilter: Boolean;
begin
  Result:=FSearchForm.cbNonPromotion.Checked;
end;

function TCMFilter.FilterNonPromotionReleaseFee(Player: TCM4Player): Boolean;
begin
  Result:=Player.NonPromotionClause = nil;
  if not Result then
  begin
    if FSearchForm.cbNonPromotionActive.Checked then
      Result:=Player.NonPromotionClause.ClauseType <> 10;
    if not Result then
    begin
      if (FSearchForm.speMinReleaseFee.Value <> 0) or (FSearchForm.speMaxReleaseFee.Value <> 0) then
      begin
        Result:=(Player.NonPromotionFee < FSearchForm.speMinReleaseFee.Value) or (Player.NonPromotionFee > FSearchForm.speMaxReleaseFee.Value);
      end;
    end;
  end;
end;

function TCMFilter.IncludeRelegationReleaseFeeFilter: Boolean;
begin
  Result:=FSearchForm.cbRelegation.Checked;
end;

function TCMFilter.FilterRelegationReleaseFee(Player: TCM4Player): Boolean;
begin
  Result:=Player.RelegationClause = nil;
  if not Result then
  begin
    if FSearchForm.cbRelegationActive.Checked then
      Result:=Player.RelegationClause.ClauseType <> 9;
    if not Result then
    begin
      if (FSearchForm.speMinReleaseFee.Value <> 0) or (FSearchForm.speMaxReleaseFee.Value <> 0) then
      begin
        Result:=(Player.RelegationFee < FSearchForm.speMinReleaseFee.Value) or (Player.RelegationFee > FSearchForm.speMaxReleaseFee.Value);
      end;
    end;
  end;
end;

function TCMFilter.IncludeMinimumReleaseFeeFilter: Boolean;
begin
  Result:=FSearchForm.cbMinimumFee.Checked;
end;

function TCMFilter.FilterMinimumReleaseFee(Player: TCM4Player): Boolean;
begin
  Result:=Player.MinimumFeeClause = nil;
  if not Result then
  begin
    if (FSearchForm.speMinReleaseFee.Value <> 0) or (FSearchForm.speMaxReleaseFee.Value <> 0) then
    begin
      Result:=(Player.MinimumFee < FSearchForm.speMinReleaseFee.Value) or (Player.MinimumFee > FSearchForm.speMaxReleaseFee.Value);
    end;
  end;
end;

function TCMFilter.IncludeTransferStatusFilter: Boolean;
begin
  Result:=FSearchForm.cmbTransferStatus.ItemIndex <> -1;
end;

function TCMFilter.FilterTransferStatus(Player: TCM4Player): Boolean;
begin
  if Player.Contracts.FullContract <> nil then
    case FSearchForm.cmbTransferStatus.ItemIndex of
      0:
        Result:=(Player.Contracts.FullContract.TransferStatus and 1 <> 1) and (Player.Contracts.FullContract.TransferStatus and 8 <> 8);
      1:
        Result:=Player.Contracts.FullContract.TransferStatus and 2 <> 2;
      else
        Result:=True;
    end
  else
    Result:=True;
end;

function TCMFilter.IncludeSquadStatusFilter: Boolean;
begin
  Result:=FSearchForm.cmbSquadStatus.ItemIndex <> -1;
end;

function TCMFilter.FilterSquadStatus(Player: TCM4Player): Boolean;
begin
  if Player.Contracts.FullContract <> nil then
    Result:=FSearchForm.cmbSquadStatus.ItemIndex <> Player.Contracts.FullContract.SquadStatus
  else
    Result:=True;
end;

function TCMFilter.IncludeContractTypeFilter: Boolean;
begin
  Result:=FSearchForm.cmbContractType.ItemIndex <> -1;
end;

function TCMFilter.FilterContractType(Player: TCM4Player): Boolean;
begin
  case FSearchForm.cmbContractType.ItemIndex of
    0:
      if Player.Contracts.FullContract <> nil then
        Result:=Player.Contracts.FullContract.FullTime
      else
        Result:=True;
    1:
      if Player.Contracts.FullContract <> nil then
        Result:=not Player.Contracts.FullContract.FullTime
      else
        Result:=True;
    2:
      if Player.Contracts.FullContract = nil then
      begin
        if Player.Contracts.ClubContract <> nil then
          Result:=not (Player.Contracts.ClubContract is TCM4TrialContract)
        else
          Result:=True;
      end
      else
        Result:=True;
    else
      Result:=True;
  end;
end;

function TCMFilter.IncludeValueFilter: Boolean;
begin
  Result:=(FSearchForm.speMinValue.Value <> 0) or (FSearchForm.speMaxValue.Value <> 0);
end;

function TCMFilter.FilterValue(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.DisplayValue < FSearchForm.speMinValue.Value) or ((Player as ICM4Player).PlayerData.DisplayValue > FSearchForm.speMaxValue.Value);
end;

function TCMFilter.IncludeSaleValueFilter: Boolean;
begin
  Result:=(FSearchForm.speMinSaleValue.Value <> 0) or (FSearchForm.speMaxSaleValue.Value <> 0);
end;

function TCMFilter.FilterSaleValue(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.SaleValue < FSearchForm.speMinSaleValue.Value) or ((Player as ICM4Player).PlayerData.SaleValue > FSearchForm.speMaxSaleValue.Value);
end;

function TCMFilter.IncludeWageFilter: Boolean;
begin
  Result:=(FSearchForm.speMinWage.Value <> 0) or (FSearchForm.speMaxWage.Value <> 0);
end;

function TCMFilter.FilterWage(Player: TCM4Player): Boolean;
begin
  if Player.Contracts.FullContract <> nil then
    Result:=(Player.Contracts.FullContract.Wage < FSearchForm.speMinWage.Value) or (Player.Contracts.FullContract.Wage > FSearchForm.speMaxWage.Value)
  else
    Result:=True;
end;

function TCMFilter.IncludeAccelerationFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAcceleration.Value <> 0) or (FSearchForm.speMaxAcceleration.Value <> 20);
end;

function TCMFilter.FilterAcceleration(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Acceleration < FSearchForm.speMinAcceleration.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Acceleration > FSearchForm.speMaxAcceleration.Value);
end;

function TCMFilter.IncludeAdaptabilityFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAdaptability.Value <> 0) or (FSearchForm.speMaxAdaptability.Value <> 20);
end;

function TCMFilter.FilterAdaptability(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Adaptability < FSearchForm.speMinAdaptability.Value) or (Player.PersonData.Adaptability > FSearchForm.speMaxAdaptability.Value);
end;

function TCMFilter.IncludeAerialAbilityFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAerialAbility.Value <> 0) or (FSearchForm.speMaxAerialAbility.Value <> 20);
end;

function TCMFilter.FilterAerialAbility(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.AerialAbility < FSearchForm.speMinAerialAbility.Value) or ((Player as ICM4Player).PlayerData.PlayingData.AerialAbility > FSearchForm.speMaxAerialAbility.Value);
end;

function TCMFilter.IncludeAggressionFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAggression.Value <> 0) or (FSearchForm.speMaxAggression.Value <> 20);
end;

function TCMFilter.FilterAggression(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Aggression < FSearchForm.speMinAggression.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Aggression > FSearchForm.speMaxAggression.Value);
end;

function TCMFilter.IncludeAgilityFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAgility.Value <> 0) or (FSearchForm.speMaxAgility.Value <> 20);
end;

function TCMFilter.FilterAgility(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Agility < FSearchForm.speMinAgility.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Agility > FSearchForm.speMaxAgility.Value);
end;

function TCMFilter.IncludeAmbitionFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAmbition.Value <> 0) or (FSearchForm.speMaxAmbition.Value <> 20);
end;

function TCMFilter.FilterAmbition(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Ambition < FSearchForm.speMinAmbition.Value) or (Player.PersonData.Ambition > FSearchForm.speMaxAmbition.Value);
end;

function TCMFilter.IncludeAnticipationFilter: Boolean;
begin
  Result:=(FSearchForm.speMinAnticipation.Value <> 0) or (FSearchForm.speMaxAnticipation.Value <> 20);
end;

function TCMFilter.FilterAnticipation(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Anticipation < FSearchForm.speMinAnticipation.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Anticipation > FSearchForm.speMaxAnticipation.Value);
end;

function TCMFilter.IncludeBalanceFilter: Boolean;
begin
  Result:=(FSearchForm.speMinBalance.Value <> 0) or (FSearchForm.speMaxBalance.Value <> 20);
end;

function TCMFilter.FilterBalance(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Balance < FSearchForm.speMinBalance.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Balance > FSearchForm.speMaxBalance.Value);
end;

function TCMFilter.IncludeBraveryFilter: Boolean;
begin
  Result:=(FSearchForm.speMinBravery.Value <> 0) or (FSearchForm.speMaxBravery.Value <> 20);
end;

function TCMFilter.FilterBravery(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Bravery < FSearchForm.speMinBravery.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Bravery > FSearchForm.speMaxBravery.Value);
end;

function TCMFilter.IncludeCommandOfAreaFilter: Boolean;
begin
  Result:=(FSearchForm.speMinCommandOfArea.Value <> 0) or (FSearchForm.speMaxCommandOfArea.Value <> 20);
end;

function TCMFilter.FilterCommandOfArea(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.CommandOfArea < FSearchForm.speMinCommandOfArea.Value) or ((Player as ICM4Player).PlayerData.PlayingData.CommandOfArea > FSearchForm.speMaxCommandOfArea.Value);
end;

function TCMFilter.IncludeCommunicationFilter: Boolean;
begin
  Result:=(FSearchForm.speMinCommunication.Value <> 0) or (FSearchForm.speMaxCommunication.Value <> 20);
end;

function TCMFilter.FilterCommunication(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Communication < FSearchForm.speMinCommunication.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Communication > FSearchForm.speMaxCommunication.Value);
end;

function TCMFilter.IncludeConsistencyFilter: Boolean;
begin
  Result:=(FSearchForm.speMinConsistency.Value <> 0) or (FSearchForm.speMaxConsistency.Value <> 20);
end;

function TCMFilter.FilterConsistency(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Consistency < FSearchForm.speMinConsistency.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Consistency > FSearchForm.speMaxConsistency.Value);
end;

function TCMFilter.IncludeControversyFilter: Boolean;
begin
  Result:=(FSearchForm.speMinControversy.Value <> 0) or (FSearchForm.speMaxControversy.Value <> 20);
end;

function TCMFilter.FilterControversy(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Controversy < FSearchForm.speMinControversy.Value) or (Player.PersonData.Controversy > FSearchForm.speMaxControversy.Value);
end;

function TCMFilter.IncludeCornersFilter: Boolean;
begin
  Result:=(FSearchForm.speMinCorners.Value <> 0) or (FSearchForm.speMaxCorners.Value <> 20);
end;

function TCMFilter.FilterCorners(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Corners < FSearchForm.speMinCorners.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Corners > FSearchForm.speMaxCorners.Value);
end;

function TCMFilter.IncludeCreativityFilter: Boolean;
begin
  Result:=(FSearchForm.speMinCreativity.Value <> 0) or (FSearchForm.speMaxCreativity.Value <> 20);
end;

function TCMFilter.FilterCreativity(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Creativity < FSearchForm.speMinCreativity.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Creativity > FSearchForm.speMaxCreativity.Value);
end;

function TCMFilter.IncludeCrossingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinCrossing.Value <> 0) or (FSearchForm.speMaxCrossing.Value <> 20);
end;

function TCMFilter.FilterCrossing(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Crossing < FSearchForm.speMinCrossing.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Crossing > FSearchForm.speMaxCrossing.Value);
end;

function TCMFilter.IncludeDecisionsFilter: Boolean;
begin
  Result:=(FSearchForm.speMinDecisions.Value <> 0) or (FSearchForm.speMaxDecisions.Value <> 20);
end;

function TCMFilter.FilterDecisions(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Decisions < FSearchForm.speMinDecisions.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Decisions > FSearchForm.speMaxDecisions.Value);
end;

function TCMFilter.IncludeDeterminationFilter: Boolean;
begin
  Result:=(FSearchForm.speMinDetermination.Value <> 0) or (FSearchForm.speMaxDetermination.Value <> 20);
end;

function TCMFilter.FilterDetermination(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Determination < FSearchForm.speMinDetermination.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Determination > FSearchForm.speMaxDetermination.Value);
end;

function TCMFilter.IncludeDirtinessFilter: Boolean;
begin
  Result:=(FSearchForm.speMinDirtiness.Value <> 0) or (FSearchForm.speMaxDirtiness.Value <> 20);
end;

function TCMFilter.FilterDirtiness(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Dirtiness < FSearchForm.speMinDirtiness.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Dirtiness > FSearchForm.speMaxDirtiness.Value);
end;

function TCMFilter.IncludeDribblingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinDribbling.Value <> 0) or (FSearchForm.speMaxDribbling.Value <> 20);
end;

function TCMFilter.FilterDribbling(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Dribbling < FSearchForm.speMinDribbling.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Dribbling > FSearchForm.speMaxDribbling.Value);
end;

function TCMFilter.IncludeEccentricityFilter: Boolean;
begin
  Result:=(FSearchForm.speMinEccentricity.Value <> 0) or (FSearchForm.speMaxEccentricity.Value <> 20);
end;

function TCMFilter.FilterEccentricity(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Eccentricity < FSearchForm.speMinEccentricity.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Eccentricity > FSearchForm.speMaxEccentricity.Value);
end;

function TCMFilter.IncludeFinishingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinFinishing.Value <> 0) or (FSearchForm.speMaxFinishing.Value <> 20);
end;

function TCMFilter.FilterFinishing(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Finishing < FSearchForm.speMinFinishing.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Finishing > FSearchForm.speMaxFinishing.Value);
end;

function TCMFilter.IncludeFirstTouchFilter: Boolean;
begin
  Result:=(FSearchForm.speMinFirstTouch.Value <> 0) or (FSearchForm.speMaxFirstTouch.Value <> 20);
end;

function TCMFilter.FilterFirstTouch(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.FirstTouch < FSearchForm.speMinFirstTouch.Value) or ((Player as ICM4Player).PlayerData.PlayingData.FirstTouch > FSearchForm.speMaxFirstTouch.Value);
end;

function TCMFilter.IncludeFlairFilter: Boolean;
begin
  Result:=(FSearchForm.speMinFlair.Value <> 0) or (FSearchForm.speMaxFlair.Value <> 20);
end;

function TCMFilter.FilterFlair(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Flair < FSearchForm.speMinFlair.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Flair > FSearchForm.speMaxFlair.Value);
end;

function TCMFilter.IncludeHandlingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinHandling.Value <> 0) or (FSearchForm.speMaxHandling.Value <> 20);
end;

function TCMFilter.FilterHandling(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Handling < FSearchForm.speMinHandling.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Handling > FSearchForm.speMaxHandling.Value);
end;

function TCMFilter.IncludeHeadingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinHeading.Value <> 0) or (FSearchForm.speMaxHeading.Value <> 20);
end;

function TCMFilter.FilterHeading(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Heading < FSearchForm.speMinHeading.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Heading > FSearchForm.speMaxHeading.Value);
end;

function TCMFilter.IncludeImportantMatchesFilter: Boolean;
begin
  Result:=(FSearchForm.speMinImportantMatches.Value <> 0) or (FSearchForm.speMaxImportantMatches.Value <> 20);
end;

function TCMFilter.FilterImportantMatches(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.ImportantMatches < FSearchForm.speMinImportantMatches.Value) or ((Player as ICM4Player).PlayerData.PlayingData.ImportantMatches > FSearchForm.speMaxImportantMatches.Value);
end;

function TCMFilter.IncludeInfluenceFilter: Boolean;
begin
  Result:=(FSearchForm.speMinInfluence.Value <> 0) or (FSearchForm.speMaxInfluence.Value <> 20);
end;

function TCMFilter.FilterInfluence(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Influence < FSearchForm.speMinInfluence.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Influence > FSearchForm.speMaxInfluence.Value);
end;

function TCMFilter.IncludeInjuryPronenessFilter: Boolean;
begin
  Result:=(FSearchForm.speMinInjuryProneness.Value <> 0) or (FSearchForm.speMaxInjuryProneness.Value <> 20);
end;

function TCMFilter.FilterInjuryProneness(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.InjuryProneness < FSearchForm.speMinInjuryProneness.Value) or ((Player as ICM4Player).PlayerData.PlayingData.InjuryProneness > FSearchForm.speMaxInjuryProneness.Value);
end;

function TCMFilter.IncludeJumpingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinJumping.Value <> 0) or (FSearchForm.speMaxJumping.Value <> 20);
end;

function TCMFilter.FilterJumping(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Jumping < FSearchForm.speMinJumping.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Jumping > FSearchForm.speMaxJumping.Value);
end;

function TCMFilter.IncludeKickingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinKicking.Value <> 0) or (FSearchForm.speMaxKicking.Value <> 20);
end;

function TCMFilter.FilterKicking(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Kicking < FSearchForm.speMinKicking.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Kicking > FSearchForm.speMaxKicking.Value);
end;

function TCMFilter.IncludeLeftFootFilter: Boolean;
begin
  Result:=(FSearchForm.speMinLeftFoot.Value <> 0) or (FSearchForm.speMaxLeftFoot.Value <> 20);
end;

function TCMFilter.FilterLeftFoot(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.LeftFoot < FSearchForm.speMinLeftFoot.Value) or ((Player as ICM4Player).PlayerData.PlayingData.LeftFoot > FSearchForm.speMaxLeftFoot.Value);
end;

function TCMFilter.IncludeLongShotsFilter: Boolean;
begin
  Result:=(FSearchForm.speMinLongShots.Value <> 0) or (FSearchForm.speMaxLongShots.Value <> 20);
end;

function TCMFilter.FilterLongShots(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.LongShots < FSearchForm.speMinLongShots.Value) or ((Player as ICM4Player).PlayerData.PlayingData.LongShots > FSearchForm.speMaxLongShots.Value);
end;

function TCMFilter.IncludeLongThrowsFilter: Boolean;
begin
  Result:=(FSearchForm.speMinLongThrows.Value <> 0) or (FSearchForm.speMaxLongThrows.Value <> 20);
end;

function TCMFilter.FilterLongThrows(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.LongThrows < FSearchForm.speMinLongThrows.Value) or ((Player as ICM4Player).PlayerData.PlayingData.LongThrows > FSearchForm.speMaxLongThrows.Value);
end;

function TCMFilter.IncludeLoyalityFilter: Boolean;
begin
  Result:=(FSearchForm.speMinLoyality.Value <> 0) or (FSearchForm.speMaxLoyality.Value <> 20);
end;

function TCMFilter.FilterLoyality(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Loyality < FSearchForm.speMinLoyality.Value) or (Player.PersonData.Loyality > FSearchForm.speMaxLoyality.Value);
end;

function TCMFilter.IncludeMarkingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinMarking.Value <> 0) or (FSearchForm.speMaxMarking.Value <> 20);
end;

function TCMFilter.FilterMarking(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Marking < FSearchForm.speMinMarking.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Marking > FSearchForm.speMaxMarking.Value);
end;

function TCMFilter.IncludeNaturalFitnessFilter: Boolean;
begin
  Result:=(FSearchForm.speMinNaturalFitness.Value <> 0) or (FSearchForm.speMaxNaturalFitness.Value <> 20);
end;

function TCMFilter.FilterNaturalFitness(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.NaturalFitness < FSearchForm.speMinNaturalFitness.Value) or ((Player as ICM4Player).PlayerData.PlayingData.NaturalFitness > FSearchForm.speMaxNaturalFitness.Value);
end;

function TCMFilter.IncludeOffTheBallFilter: Boolean;
begin
  Result:=(FSearchForm.speMinOffTheBall.Value <> 0) or (FSearchForm.speMaxOffTheBall.Value <> 20);
end;

function TCMFilter.FilterOffTheBall(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.OffTheBall < FSearchForm.speMinOffTheBall.Value) or ((Player as ICM4Player).PlayerData.PlayingData.OffTheBall > FSearchForm.speMaxOffTheBall.Value);
end;

function TCMFilter.IncludeOneOnOnesFilter: Boolean;
begin
  Result:=(FSearchForm.speMinOneOnOnes.Value <> 0) or (FSearchForm.speMaxOneOnOnes.Value <> 20);
end;

function TCMFilter.FilterOneOnOnes(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.OneOnOnes < FSearchForm.speMinOneOnOnes.Value) or ((Player as ICM4Player).PlayerData.PlayingData.OneOnOnes > FSearchForm.speMaxOneOnOnes.Value);
end;

function TCMFilter.IncludePaceFilter: Boolean;
begin
  Result:=(FSearchForm.speMinPace.Value <> 0) or (FSearchForm.speMaxPace.Value <> 20);
end;

function TCMFilter.FilterPace(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Pace < FSearchForm.speMinPace.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Pace > FSearchForm.speMaxPace.Value);
end;

function TCMFilter.IncludePassingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinPassing.Value <> 0) or (FSearchForm.speMaxPassing.Value <> 20);
end;

function TCMFilter.FilterPassing(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Passing < FSearchForm.speMinPassing.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Passing > FSearchForm.speMaxPassing.Value);
end;

function TCMFilter.IncludePenaltiesFilter: Boolean;
begin
  Result:=(FSearchForm.speMinPenalties.Value <> 0) or (FSearchForm.speMaxPenalties.Value <> 20);
end;

function TCMFilter.FilterPenalties(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Penalties < FSearchForm.speMinPenalties.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Penalties > FSearchForm.speMaxPenalties.Value);
end;

function TCMFilter.IncludePositioningFilter: Boolean;
begin
  Result:=(FSearchForm.speMinPositioning.Value <> 0) or (FSearchForm.speMaxPositioning.Value <> 20);
end;

function TCMFilter.FilterPositioning(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Positioning < FSearchForm.speMinPositioning.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Positioning > FSearchForm.speMaxPositioning.Value);
end;

function TCMFilter.IncludePressureFilter: Boolean;
begin
  Result:=(FSearchForm.speMinPressure.Value <> 0) or (FSearchForm.speMaxPressure.Value <> 20);
end;

function TCMFilter.FilterPressure(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Pressure < FSearchForm.speMinPressure.Value) or (Player.PersonData.Pressure > FSearchForm.speMaxPressure.Value);
end;

function TCMFilter.IncludeProfessionalismFilter: Boolean;
begin
  Result:=(FSearchForm.speMinProfessionalism.Value <> 0) or (FSearchForm.speMaxProfessionalism.Value <> 20);
end;

function TCMFilter.FilterProfessionalism(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Professionalism < FSearchForm.speMinProfessionalism.Value) or (Player.PersonData.Professionalism > FSearchForm.speMaxProfessionalism.Value);
end;

function TCMFilter.IncludeReflexesFilter: Boolean;
begin
  Result:=(FSearchForm.speMinReflexes.Value <> 0) or (FSearchForm.speMaxReflexes.Value <> 20);
end;

function TCMFilter.FilterReflexes(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Reflexes < FSearchForm.speMinReflexes.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Reflexes > FSearchForm.speMaxReflexes.Value);
end;

function TCMFilter.IncludeRightFootFilter: Boolean;
begin
  Result:=(FSearchForm.speMinRightFoot.Value <> 0) or (FSearchForm.speMaxRightFoot.Value <> 20);
end;

function TCMFilter.FilterRightFoot(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.RightFoot < FSearchForm.speMinRightFoot.Value) or ((Player as ICM4Player).PlayerData.PlayingData.RightFoot > FSearchForm.speMaxRightFoot.Value);
end;

function TCMFilter.IncludeRushingOutFilter: Boolean;
begin
  Result:=(FSearchForm.speMinRushingOut.Value <> 0) or (FSearchForm.speMaxRushingOut.Value <> 20);
end;

function TCMFilter.FilterRushingOut(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.RushingOut < FSearchForm.speMinRushingOut.Value) or ((Player as ICM4Player).PlayerData.PlayingData.RushingOut > FSearchForm.speMaxRushingOut.Value);
end;

function TCMFilter.IncludeSetPiecesFilter: Boolean;
begin
  Result:=(FSearchForm.speMinSetPieces.Value <> 0) or (FSearchForm.speMaxSetPieces.Value <> 20);
end;

function TCMFilter.FilterSetPieces(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.SetPieces < FSearchForm.speMinSetPieces.Value) or ((Player as ICM4Player).PlayerData.PlayingData.SetPieces > FSearchForm.speMaxSetPieces.Value);
end;

function TCMFilter.IncludeSportsmanshipFilter: Boolean;
begin
  Result:=(FSearchForm.speMinSportsmanship.Value <> 0) or (FSearchForm.speMaxSportsmanship.Value <> 20);
end;

function TCMFilter.FilterSportsmanship(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Sportsmanship < FSearchForm.speMinSportsmanship.Value) or (Player.PersonData.Sportsmanship > FSearchForm.speMaxSportsmanship.Value);
end;

function TCMFilter.IncludeStaminaFilter: Boolean;
begin
  Result:=(FSearchForm.speMinStamina.Value <> 0) or (FSearchForm.speMaxStamina.Value <> 20);
end;

function TCMFilter.FilterStamina(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Stamina < FSearchForm.speMinStamina.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Stamina > FSearchForm.speMaxStamina.Value);
end;

function TCMFilter.IncludeStrengthFilter: Boolean;
begin
  Result:=(FSearchForm.speMinStrength.Value <> 0) or (FSearchForm.speMaxStrength.Value <> 20);
end;

function TCMFilter.FilterStrength(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Strength < FSearchForm.speMinStrength.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Strength > FSearchForm.speMaxStrength.Value);
end;

function TCMFilter.IncludeTacklingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinTackling.Value <> 0) or (FSearchForm.speMaxTackling.Value <> 20);
end;

function TCMFilter.FilterTackling(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Tackling < FSearchForm.speMinTackling.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Tackling > FSearchForm.speMaxTackling.Value);
end;

function TCMFilter.IncludeTeamworkFilter: Boolean;
begin
  Result:=(FSearchForm.speMinTeamwork.Value <> 0) or (FSearchForm.speMaxTeamwork.Value <> 20);
end;

function TCMFilter.FilterTeamwork(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Teamwork < FSearchForm.speMinTeamwork.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Teamwork > FSearchForm.speMaxTeamwork.Value);
end;

function TCMFilter.IncludeTechniqueFilter: Boolean;
begin
  Result:=(FSearchForm.speMinTechnique.Value <> 0) or (FSearchForm.speMaxTechnique.Value <> 20);
end;

function TCMFilter.FilterTechnique(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Technique < FSearchForm.speMinTechnique.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Technique > FSearchForm.speMaxTechnique.Value);
end;

function TCMFilter.IncludeTemperamentFilter: Boolean;
begin
  Result:=(FSearchForm.speMinTemperament.Value <> 0) or (FSearchForm.speMaxTemperament.Value <> 20);
end;

function TCMFilter.FilterTemperament(Player: TCM4Player): Boolean;
begin
  Result:=(Player.PersonData.Temperament < FSearchForm.speMinTemperament.Value) or (Player.PersonData.Temperament > FSearchForm.speMaxTemperament.Value);
end;

function TCMFilter.IncludeTendencyToPunchFilter: Boolean;
begin
  Result:=(FSearchForm.speMinTendencyToPunch.Value <> 0) or (FSearchForm.speMaxTendencyToPunch.Value <> 20);
end;

function TCMFilter.FilterTendencyToPunch(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.TendencyToPunch < FSearchForm.speMinTendencyToPunch.Value) or ((Player as ICM4Player).PlayerData.PlayingData.TendencyToPunch > FSearchForm.speMaxTendencyToPunch.Value);
end;

function TCMFilter.IncludeThrowingFilter: Boolean;
begin
  Result:=(FSearchForm.speMinThrowing.Value <> 0) or (FSearchForm.speMaxThrowing.Value <> 20);
end;

function TCMFilter.FilterThrowing(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Throwing < FSearchForm.speMinThrowing.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Throwing > FSearchForm.speMaxThrowing.Value);
end;

function TCMFilter.IncludeThrowInsFilter: Boolean;
begin
  Result:=(FSearchForm.speMinThrowIns.Value <> 0) or (FSearchForm.speMaxThrowIns.Value <> 20);
end;

function TCMFilter.FilterThrowIns(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.ThrowIns < FSearchForm.speMinThrowIns.Value) or ((Player as ICM4Player).PlayerData.PlayingData.ThrowIns > FSearchForm.speMaxThrowIns.Value);
end;

function TCMFilter.IncludeVersatilityFilter: Boolean;
begin
  Result:=(FSearchForm.speMinVersatility.Value <> 0) or (FSearchForm.speMaxVersatility.Value <> 20);
end;

function TCMFilter.FilterVersatility(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.Versatility < FSearchForm.speMinVersatility.Value) or ((Player as ICM4Player).PlayerData.PlayingData.Versatility > FSearchForm.speMaxVersatility.Value);
end;

function TCMFilter.IncludeWorkRateFilter: Boolean;
begin
  Result:=(FSearchForm.speMinWorkRate.Value <> 0) or (FSearchForm.speMaxWorkRate.Value <> 20);
end;

function TCMFilter.FilterWorkRate(Player: TCM4Player): Boolean;
begin
  Result:=((Player as ICM4Player).PlayerData.PlayingData.WorkRate < FSearchForm.speMinWorkRate.Value) or ((Player as ICM4Player).PlayerData.PlayingData.WorkRate > FSearchForm.speMaxWorkRate.Value);
end;

function TCMFilter.IncludeInternationalAppsFilter: Boolean;
begin
  Result:=(FSearchForm.speMinCaps.Value <> 0) or (FSearchForm.speMaxCaps.Value <> 0);
end;

function TCMFilter.FilterInternationalApps(Player: TCM4Player): Boolean;
begin
  Result:=(Player.InternationalApps < FSearchForm.speMinCaps.Value) or (Player.InternationalApps > FSearchForm.speMaxCaps.Value);
end;

function TCMFilter.IncludeInternationalGoalsFilter: Boolean;
begin
  Result:=(FSearchForm.speMinIntGoals.Value <> 0) or (FSearchForm.speMaxIntGoals.Value <> 0);
end;

function TCMFilter.FilterInternationalGoals(Player: TCM4Player): Boolean;
begin
  Result:=(Player.InternationalGoals < FSearchForm.speMinIntGoals.Value) or (Player.InternationalGoals > FSearchForm.speMaxIntGoals.Value);
end;

end.
