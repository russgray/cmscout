unit CMScoutSearch;

interface

uses
  Classes, CM4SaveGameDatabase, VirtualTrees, SysUtils,
  CMFilter, TeamSearch, CM4SupportClasses, CM4SaveGameData,
  Controls, CMShortlistFile;

type
  TCMScoutSearch = class
  private
    FResult: TList;
    FCMData: TCM4SaveGameDatabase;
    FListView: TVirtualStringTree;
    FDateFormat: TFormatSettings;
    FFilter: TCMFilter;

    FTeamSearch: TfrmTeamSearch;

    FOnStatus: TStatusEvent;
    FOnProgress: TProgressEvent;
    
    procedure SetCMData(const Value: TCM4SaveGameDatabase);
    procedure CompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure IncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure InitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    function GetCount: Integer;
    function ThousandSep(Value: Double): WideString;
    function GetStringValue(Player: TCM4Player;
      Column: Integer): WideString;
    function GetIntegerValue(Player: TCM4Player; Column: Integer): Integer;
    function BooleanToStr(Value: Boolean): WideString;
    function GetDateValue(Player: TCM4Player; Column: Integer): TDateTime;
    function CompareDates(Date1, Date2: TDateTime): Integer;
    function CompareIntegers(Value1, Value2: Integer): Integer;
    function CompareDoubles(Value1, Value2: Double): Integer;
    procedure SetOnProgress(const Value: TProgressEvent);
    procedure SetOnStatus(const Value: TStatusEvent);
    procedure TriggerStatus(Status: string);
  public
    constructor Create(ListView: TVirtualStringTree);
    destructor Destroy; override;
    procedure Clear;
    procedure Search;
    procedure TeamSearch;

    procedure SaveShortlist(FileName: string);
    procedure LoadShortList(FileName: string);

    property CMData: TCM4SaveGameDatabase read FCMData write SetCMData;
    property Count: Integer read GetCount;

    property OnStatus: TStatusEvent read FOnStatus write SetOnStatus;
    property OnProgress: TProgressEvent read FOnProgress write SetOnProgress;
  end;

implementation

{ TCMScoutSearch }

procedure TCMScoutSearch.Clear;
begin
  FListView.Clear;
  FResult.Clear;
end;

constructor TCMScoutSearch.Create(ListView: TVirtualStringTree);
begin
  FResult:=TList.Create;
  FListView:=ListView;
  FListView.OnCompareNodes:=CompareNodes;
  FListView.OnGetText:=GetText;
  FListView.OnIncrementalSearch:=IncrementalSearch;
  FListView.OnInitNode:=InitNode;

  FDateFormat.DateSeparator:='.';
  FDateFormat.ShortDateFormat:='dd.mm.yyyy';

  FFilter:=TCMFilter.Create;

  FTeamSearch:=TfrmTeamSearch.Create(nil);
end;

destructor TCMScoutSearch.Destroy;
begin
  FResult.Free;
  FFilter.Free;
  FTeamSearch.Free;
  inherited;
end;

procedure TCMScoutSearch.Search;
begin
  if FFilter.Search(FResult) then
  begin
    TriggerStatus('Clearing List');
    FListView.Clear;
    TriggerStatus('Sorting Result');
    FListView.RootNodeCount:=FResult.Count;
  end;
end;

procedure TCMScoutSearch.TeamSearch;
var
  Squad: TCM4Team;
  Club: TCM4Club;
  j, s: Integer;
begin
  if FTeamSearch.ShowModal = mrOK then
  begin
    if FTeamSearch.cmbSquad.ItemIndex <> -1 then
    begin
      TriggerStatus('Clearing List');
      Clear;

      if FTeamSearch.cmbSquad.ItemIndex <> -1 then
        Squad:=TCM4Team(FTeamSearch.cmbSquad.Items.Objects[FTeamSearch.cmbSquad.ItemIndex])
      else
        Squad:=nil;

      if Squad <> nil then
      begin
        for j:=0 to Squad.Players.Count - 1 do
          if Supports(Squad.Players[j], ICM4Player) then
            FResult.Add(Squad.Players[j])
      end
      else
      begin
        if FTeamSearch.cmbClub.ItemIndex <> -1 then
        begin
          Club:=TCM4Club(FTeamSearch.cmbClub.Items.Objects[FTeamSearch.cmbClub.ItemIndex]);

          for j:=0 to Club.Teams.Count - 1 do
            for s:=0 to Club.Teams[j].Players.Count - 1 do
              if Supports(Club.Teams[j].Players[s], ICM4Player) then
                FResult.Add(Club.Teams[j].Players[s]);
        end;
      end;

      TriggerStatus('Sorting Result');
      FListView.RootNodeCount:=FResult.Count;
    end;
  end;
end;

procedure TCMScoutSearch.SetCMData(const Value: TCM4SaveGameDatabase);
begin
  Clear;
  FCMData:=Value;
  FFilter.CMData:=CMData;
  FTeamSearch.CMData:=CMData;
end;

procedure TCMScoutSearch.CompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Player1, Player2: TCM4Player;
begin
  Player1:=TCM4Player(Sender.GetNodeData(Node1)^);
  Player2:=TCM4Player(Sender.GetNodeData(Node2)^);

  case Column of
    0..3, 11, 14..16, 18, 22, 26..28:
      Result:=AnsiCompareText(GetStringValue(Player1, Column), GetStringValue(Player2, Column));
    10, 20..21:
      Result:=CompareDates(GetDateValue(Player1, Column), GetDateValue(Player2, Column)); 
    4..8, 12..13, 17, 19, 23..25, 29..105:
      Result:=CompareIntegers(GetIntegerValue(Player1, Column), GetIntegerValue(Player2, Column));
    9:
      Result:=CompareDoubles((Player1 as ICM4Player).ScoutRating.BestRating, (Player2 as ICM4Player).ScoutRating.BestRating);
    else
      Result:=0;
  end;
end;

procedure TCMScoutSearch.GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Player: TCM4Player;
begin
  Player:=TCM4Player(Sender.GetNodeData(Node)^);

  case Column of
    0..3, 11, 14..16, 18, 22, 26..28:
      CellText:=GetStringValue(Player, Column);
    4..6, 12..13, 17, 29..105:
      CellText:=IntToStr(GetIntegerValue(Player, Column));
    7..8, 19, 23..25:
      CellText:=ThousandSep(GetIntegerValue(Player, Column));
    10, 20..21:
      CellText:=DateToStr(GetDateValue(Player, Column), FDateFormat);
    9:
      CellText:=(Player as ICM4Player).ScoutRating.BestRatingText;
    else
      CellText:='';
  end;
end;

procedure TCMScoutSearch.IncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: WideString; var Result: Integer);
var
  Player: TCM4Player;
begin
  Player:=TCM4Player(Sender.GetNodeData(Node)^);
  Result:=AnsiCompareText(SearchText, Copy(Player.ListName, 1, Length(SearchText)));
end;

procedure TCMScoutSearch.InitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Pointer(Sender.GetNodeData(Node)^):=FResult[Node.Index];
end;

function TCMScoutSearch.GetCount: Integer;
begin
  Result:=FResult.Count;
end;

function TCMScoutSearch.ThousandSep(Value: Double): WideString;
begin
  Result:=Format('%.0n', [Value]);
end;

function TCMScoutSearch.BooleanToStr(Value: Boolean): WideString;
begin
  if Value then
    Result:='Yes'
  else
    Result:='No';
end;

function TCMScoutSearch.GetStringValue(Player: TCM4Player; Column: Integer): WideString;
begin
  case Column of
    0:
      Result:=Player.ListName;
    1:
      Result:=Player.Nations;
    2:
      Result:=Player.ClubName;
    3:
      Result:=(Player as ICM4Player).Position;
    11:
      Result:=BooleanToStr(Player.EUMember);
    14:
      Result:=Player.BasedName;
    15:
      Result:=Player.DivisionName;
    16:
      Result:=Player.SquadName;
    18:
      Result:=Player.ContractType;
    22:
      Result:=BooleanToStr(Player.LeavingOnBosman);
    26:
      Result:=Player.SquadStatus;
    27:
      Result:=Player.PerceivedSquadStatus;
    28:
      Result:=Player.TransferStatus;
    else
      Result:='';
  end;
end;

function TCMScoutSearch.GetIntegerValue(Player: TCM4Player; Column: Integer): Integer;
begin
  case Column of
    4:
      Result:=(Player as ICM4Player).PlayerData.CurrentAbility;
    5:
      Result:=(Player as ICM4Player).PlayerData.PotentialAbility;
    6:
      Result:=Player.DateOfBirth.Age(CMData.GameDate);
    7:
      Result:=(Player as ICM4Player).PlayerData.DisplayValue;
    8:
      Result:=(Player as ICM4Player).PlayerData.SaleValue;
    12:
      Result:=Player.InternationalApps;
    13:
      Result:=Player.InternationalGoals;
    17:
      Result:=Player.SquadReputation;
    19:
      Result:=Player.Wage;
    23:
      Result:=Player.MinimumFee;
    24:
      Result:=Player.RelegationFee;
    25:
      Result:=Player.NonPromotionFee;
    29:
      Result:=Player.HappinessLevel;
    30:
      Result:=(Player as ICM4Player).PlayerData.HomeReputation;
    31:
      Result:=(Player as ICM4Player).PlayerData.CurrentReputation;
    32:
      Result:=(Player as ICM4Player).PlayerData.WorldReputation;
    33:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Goalkeeper;
    34:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Sweeper;
    35:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Defender;
    36:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.DefensiveMidfielder;
    37:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Midfielder;
    38:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.AttackingMidfielder;
    39:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Attacker;
    40:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.WingBack;
    41:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.FreeRole;
    42:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.RightSide;
    43:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.LeftSide;
    44:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Central;
    45:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Acceleration;
    46:
      Result:=Player.PersonData.Adaptability;
    47:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.AerialAbility;
    48:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Aggression;
    49:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Agility;
    50:
      Result:=Player.PersonData.Ambition;
    51:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Anticipation;
    52:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Balance;
    53:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Bravery;
    54:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.CommandOfArea;
    55:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Communication;
    56:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Consistency;
    57:
      Result:=Player.PersonData.Controversy;
    58:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Corners;
    59:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Creativity;
    60:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Crossing;
    61:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Decisions;
    62:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Determination;
    63:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Dirtiness;
    64:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Dribbling;
    65:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Eccentricity;
    66:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Finishing;
    67:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.FirstTouch;
    68:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Flair;
    69:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Handling;
    70:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Heading;
    71:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.ImportantMatches;
    72:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Influence;
    73:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.InjuryProneness;
    74:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Jumping;
    75:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Kicking;
    76:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.LongShots;
    77:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.LongThrows;
    78:
      Result:=Player.PersonData.Loyality;
    79:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Marking;
    80:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.NaturalFitness;
    81:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.OffTheBall;
    82:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.OneOnOnes;
    83:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Pace;
    84:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Passing;
    85:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Penalties;
    86:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Positioning;
    87:
      Result:=Player.PersonData.Pressure;
    88:
      Result:=Player.PersonData.Professionalism;
    89:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Reflexes;
    90:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.RushingOut;
    91:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.SetPieces;
    92:
      Result:=Player.PersonData.Sportsmanship;
    93:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Stamina;
    94:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Strength;
    95:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Tackling;
    96:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Teamwork;
    97:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Technique;
    98:
      Result:=Player.PersonData.Temperament;
    99:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.TendencyToPunch;
    100:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.ThrowIns;
    101:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Throwing;
    102:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.Versatility;
    103:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.WorkRate;
    104:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.LeftFoot;
    105:
      Result:=(Player as ICM4Player).PlayerData.PlayingData.RightFoot;
    else
      Result:=0;
  end;
end;

function TCMScoutSearch.GetDateValue(Player: TCM4Player; Column: Integer): TDateTime;
begin
  case Column of
    10:
      Result:=Player.DateOfBirth.Date;
    20:
      Result:=Player.JoinedClub;
    21:
      Result:=Player.ContractEnds;
    else
      Result:=Date;
  end;
end;

function TCMScoutSearch.CompareDates(Date1: TDateTime; Date2: TDateTime): Integer;
begin
  if Date1 < Date2 then
    Result:=-1
  else if Date1 > Date2 then
    Result:=1
  else
    Result:=0;
end;

function TCMScoutSearch.CompareIntegers(Value1, Value2: Integer): Integer;
begin
  if Value1 > Value2 then
    Result:=-1
  else if Value1 < Value2 then
    Result:=1
  else
    Result:=0;
end;

function TCMScoutSearch.CompareDoubles(Value1, Value2: Double): Integer;
begin
  if Value1 > Value2 then
    Result:=-1
  else if Value1 < Value2 then
    Result:=1
  else
    Result:=0;
end;

procedure TCMScoutSearch.SetOnProgress(const Value: TProgressEvent);
begin
  FOnProgress:=Value;
  FFilter.OnProgress:=OnProgress;
end;

procedure TCMScoutSearch.SetOnStatus(const Value: TStatusEvent);
begin
  FOnStatus:=Value;
  FFilter.OnStatus:=OnStatus;
end;

procedure TCMScoutSearch.TriggerStatus(Status: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Status);
end;

procedure TCMScoutSearch.LoadShortList(FileName: string);
var
  Shortlist: TCMShortListFile;
  j: Integer;
begin
  Shortlist:=TCMShortListFile.Create;

  try
    Shortlist.LoadFile(FileName);

    Clear;

    for j:=0 to Shortlist.Count - 1 do
      if CMData.People.UniqueEntity[Shortlist[j]] <> nil then
        if Supports(CMData.People.UniqueEntity[Shortlist[j]], ICM4Player) then
          FResult.Add(CMData.People.UniqueEntity[Shortlist[j]]);

    FListView.RootNodeCount:=FResult.Count;
  finally
    Shortlist.Free;
  end;
end;

procedure TCMScoutSearch.SaveShortlist(FileName: string);
var
  Shortlist: TCMShortListFile;
  j: Integer;
begin
  Shortlist:=TCMShortListFile.Create;

  try
    for j:=0 to FResult.Count - 1 do
      Shortlist.AddPlayer(TCM4Player(FResult[j]).UniqueID);
    Shortlist.SaveFile(FileName);
  finally
    Shortlist.Free;
  end;
end;

end.
