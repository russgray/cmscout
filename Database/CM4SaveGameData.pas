unit CM4SaveGameData;

interface

uses
  CM4SupportClasses, Classes, Hashtable, SysUtils;

type
  TCM4DatabaseContainer = class;
  TCM4Person = class;
  TCM4PersonList = class;
  TCM4Competition = class;
  TCM4TeamCont = class;
  TCM4PersonData = class;
  TCM4NonPlayingData = class;
  TCM4PlayingData = class;
  TCM4PlayerScoutRating = class;
    
  TCM4Date = class
  private
    FDays: Word;
    FYear: Word;
  public
    procedure Load(DataFile: TCM4FileStream);
    function Date: TDateTime;
    function Age(Today: TCM4Date): Integer;
    function OneYearDate: TDateTime;
    function MonthToMonth: Boolean;
  end;

  TCM4DatabaseEntity = class
  private
    FID: Integer;
    FUniqueID: Integer;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); virtual;
    property ID: Integer read FID;
    property UniqueID: Integer read FUniqueID;
  end;

  TCM4DatabaseContainer = class
  private
    FContainer: TList;
    FIDList: THashtable;
    FUniqueID: THashtable;
    FOnStatus: TStatusEvent;
    FOnProgress: TProgressEvent;
    function GetEntity(Index: Integer): TCM4DatabaseEntity;
    function GetIDEntity(Index: Integer): TCM4DatabaseEntity;
    function GetUniqueEntity(Index: Integer): TCM4DatabaseEntity;
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; virtual; abstract;
    procedure TriggerStatus(Status: string);
    procedure TriggerProgress(Progress: Integer; Count: Integer);
  public
    function Count: Integer;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
    property Entity[Index: Integer]: TCM4DatabaseEntity read GetEntity;
    property IDEntity[Index: Integer]: TCM4DatabaseEntity read GetIDEntity;
    property UniqueEntity[Index: Integer]: TCM4DatabaseEntity read GetUniqueEntity;
    property OnStatus: TStatusEvent read FOnStatus write FOnStatus;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
  end;

  TCM4List = class
  private
    FData: TList;
    function GetItem(Index: Integer): Pointer;
    procedure LoadData(DataFile: TCM4FileStream; Size: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    procedure Add(Entity: Pointer);
    procedure Load(DataFile: TCM4FileStream);
    procedure LoadW(DataFile: TCM4FileStream);
    procedure ConvertIndexes(Container: TCM4DatabaseContainer);
    procedure Clear;
    property Item[Index: Integer]: Pointer read GetItem; default;
  end;

  TCM4TeamBase = class(TCM4DatabaseEntity)
  private
    FTeamType: ShortInt;
    FTeamContainerType: Byte;
    FTeamContainer: TCM4TeamCont;
    function GetSquadName: WideString;
    function GetShortName: WideString;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(Clubs, Nations: TCM4DatabaseContainer); overload; virtual;

    property TeamContainer: TCM4TeamCont read FTeamContainer;
    property SquadName: WideString read GetSquadName;
    property ShortName: WideString read GetShortName;
  end;

  TCM4Team = class(TCM4TeamBase)
  private
    FReputation: Word;
    FDivision: TCM4Competition;
    FManager: TCM4Person;
    FPhysios: TCM4PersonList;
    FPlayers: TCM4PersonList;
    FCoaches: TCM4PersonList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(Competitions, People, Clubs, Nations: TCM4DatabaseContainer); reintroduce; overload;

    property Players: TCM4PersonList read FPlayers;
    property Division: TCM4Competition read FDivision;
    property Reputation: Word read FReputation; 
  end;

  TCM4NationalTeam = class(TCM4Team)
  private
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4TeamContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
    function GetTeam(Index: Integer): TCM4Team;
  public
    procedure ConvertIndexes(Competitions, People, Clubs, Nations: TCM4DatabaseContainer);
    property Team[Index: Integer]: TCM4Team read GetTeam;
  end;

  TCM4TeamList = class(TCM4List)
  private
    function GetTeam(Index: Integer): TCM4Team;
  public
    property Team[Index: Integer]: TCM4Team read GetTeam; default;
  end;

  TCM4TeamCont = class(TCM4DatabaseEntity)
  private
    FType: Byte;
    FName: WideString;
    FShortName: WideString;
    FTeams: TCM4TeamList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(Teams: TCM4DatabaseContainer); overload; virtual;

    property TeamType: Byte read FType;
    property Name: WideString read FName write FName;
    property ShortName: WideString read FShortName write FShortName;
    property Teams: TCM4TeamList read FTeams;
  end;

  TCM4Nation = class(TCM4TeamCont)
  private
    FGroupMembership: Byte;
    FNationality: WideString;
    function GetEUMember: Boolean;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    property EUMember: Boolean read GetEUMember;
    property Nationality: WideString read FNationality write FNationality;
  end;

  TCM4NationList = class(TCM4List)
  private
    function GetNation(Index: Integer): TCM4Nation;
  public
    property Nation[Index: Integer]: TCM4Nation read GetNation; default;
  end;

  TCM4NationContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
    function GetNation(Index: Integer): TCM4Nation;
    function GetUniqueNation(Index: Integer): TCM4Nation;
  public
    procedure ConvertIndexes(Teams: TCM4DatabaseContainer);
    property Nation[Index: Integer]: TCM4Nation read GetNation; default;
    property UniqueNation[Index: Integer]: TCM4Nation read GetUniqueNation;
  end;

  TCM4Competition = class(TCM4DatabaseEntity)
  private
    FNation: TCM4Nation;
    FNameType: Byte;
    FShortName: WideString;
    FName: WideString;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexs(Nations: TCM4DatabaseContainer);
    property Name: WideString read FName write FName;
    property ShortName: WideString read FShortName write FShortName;
  end;

  TCM4CompetitionContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
    function GetCompetition(Index: Integer): TCM4Competition;
    function GetUniqueCompetition(Index: Integer): TCM4Competition;
  public
    procedure ConvertIndexes(Nations: TCM4DatabaseContainer);
    property Competition[Index: Integer]: TCM4Competition read GetCompetition; default;
    property UniqueCompetition[Index: Integer]: TCM4Competition read GetUniqueCompetition;
  end;

  TCM4Club = class(TCM4TeamCont)
  private
    FNation: TCM4Nation;
    FNickName1: WideString;
    FNickName2: WideString;
    FChairman: TCM4Person;
    FDirectors: TCM4PersonList;
    FScouts: TCM4PersonList;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(Nations, People, Competitions, Teams: TCM4DatabaseContainer); reintroduce; overload;

    property Nation: TCM4Nation read FNation;
    property NickName1: WideString read FNickName1 write FNickName1;
    property NickName2: WideString read FNickName2 write FNickName2;
    property Chairman: TCM4Person read FChairman;
    property Directors: TCM4PersonList read FDirectors;
    property Scouts: TCM4PersonList read FScouts;
  end;

  TCM4LeagueBodyClub = class(TCM4Club)
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4ClubContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
    function GetClub(Index: Integer): TCM4Club;
    function GetUniqueClub(Index: Integer): TCM4Club;
  public
    procedure ConvertIndexes(Nations, People, Competitions, Teams: TCM4DatabaseContainer);
    property Club[Index: Integer]: TCM4Club read GetClub; default;
    property UniqueClub[Index: Integer]: TCM4Club read GetUniqueClub;
  end;

  TCM4Name = class(TCM4DatabaseEntity)
  private
    FName: WideString;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    property Name: WideString read FName;
  end;

  TCM4NameContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
    function GetName(Index: Integer): TCM4Name;
  public
    property Name[Index: Integer]: TCM4Name read GetName; default;
  end;

  TCM4ContractClause = class
  private
    FType: ShortInt;
    FReleaseFee: Integer;
  public
    function Load(DataFile: TCM4FileStream): Boolean;
    property ClauseType: ShortInt read FType;
    property ReleaseFee: Integer read FReleaseFee; 
  end;
  
  TCM4ContractClauseList = class
  private
    FClauses: TList;
    function GetClause(Index: Integer): TCM4ContractClause;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Count: Integer;
    procedure Load(DataFile: TCM4FileStream; ClauseCount: Byte);
    property Clause[Index: Integer]: TCM4ContractClause read GetClause; default;
  end;

  TCM4Contract = class
  private
    FTeamContainerType: Byte;
    FTeamContainer: TCM4TeamCont;
    FWeeklyWage: Integer;
    FEndDate: TCM4Date;
    FCurrentSquadStatus: ShortInt;
    FTransferStatus: ShortInt;
    FHappiness: Int64;
    FHappinessLevel: ShortInt;
    FPerceivedSquadStatus: ShortInt;
    FSquadNumber: ShortInt;

    function GetContractType: WideString; virtual; abstract;
    function GetSquadStatusText: WideString;
    function ConvertSquadStatus(SquadStatus: ShortInt): WideString;
    function GetPerceivedSquadStatus: WideString;
    function GetTransferStatusText: WideString;
    function GetLongSquadStatusText: WideString;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream); virtual;
    procedure ConvertIndexes(Clubs, Nations, Teams: TCM4DatabaseContainer); virtual;
    property ContractType: WideString read GetContractType;
    property TeamContainerType: Byte read FTeamContainerType;
    property TeamContainer: TCM4TeamCont read FTeamContainer;
    property SquadStatus: ShortInt read FCurrentSquadStatus;
    property SquadStatusText: WideString read GetSquadStatusText;
    property LongSquadStatusText: WideString read GetLongSquadStatusText;
    property PerceivedSquadStatus: WideString read GetPerceivedSquadStatus;
    property TransferStatus: ShortInt read FTransferStatus;
    property TransferStatusText: WideString read GetTransferStatusText;
    property EndDate: TCM4Date read FEndDate;
    property Wage: Integer read FWeeklyWage;
    property HappinessLevel: ShortInt read FHappinessLevel;
    property SquadNumber: ShortInt read FSquadNumber; 
  end;

  TCM4FullContract = class(TCM4Contract)
  private
    FFullTime: Boolean;
    FLeavingOnBosmanRule: Boolean;
    FClauses: TCM4ContractClauseList;

    function GetContractType: WideString; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream); override;
    property LeavingOnBosman: Boolean read FLeavingOnBosmanRule;
    property Clauses: TCM4ContractClauseList read FClauses;
    property FullTime: Boolean read FFullTime;
  end;

  TCM4LoanContract = class(TCM4Contract)
  private
    function GetContractType: WideString; override;
  public
    procedure Load(DataFile: TCM4FileStream); override;
  end;

  TCM4TrialContract = class(TCM4Contract)
  private
    function GetContractType: WideString; override;
  end;

  TCM4LeagueContract = class(TCM4Contract)
  private
    FFullTime: Boolean;
    FTeam: TCM4Team;

    function GetContractType: WideString; override;
  public
    procedure Load(DataFile: TCM4FileStream); override;
    procedure ConvertIndexes(Clubs, Nations, Teams: TCM4DatabaseContainer); override;
  end;

  TCM4ContractList = class
  private
    FContracts: TList;
    function GetContract(Index: Integer): TCM4Contract;
    function GetClubContract: TCM4Contract;
    function GetFullContract: TCM4FullContract;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Count: Integer;
    procedure Load(DataFile: TCM4FileStream);
    procedure ConvertIndexes(Clubs, Nations, Teams: TCM4DatabaseContainer);
    property Contract[Index: Integer]: TCM4Contract read GetContract; default;
    property FullContract: TCM4FullContract read GetFullContract;
    property ClubContract: TCM4Contract read GetClubContract;
  end;

  TCM4Person = class(TCM4DatabaseEntity, IUnknown)
  private
    FFirstName: TCM4Name;
    FSecondName: TCM4Name;
    FCommonName: TCM4Name;
    FDateOfBirth: TCM4Date;

    FNation: TCM4Nation;
    FAdditionalNations: TCM4NationList;
    FInternationalApps: Byte;
    FInternationalGoals: Byte;

    FNationalTeam: TCM4NationalTeam;
    FNationalJob: Byte;
    FNationalJoinDate: TCM4Date;

    FClubTeam: TCM4Team;
    FClubJob: Byte;
    FClubJoinDate: TCM4Date;

    FPersonData: TCM4PersonData;

    FContracts: TCM4ContractList;

    function GetListName: WideString;
    function GetFullName: WideString;
    function GetNations: WideString;
    function GetClubName: WideString;
    function GetEUMember: Boolean;
    function GetBasedName: WideString;
    function GetDivision: TCM4Competition;
    function GetDivisionName: WideString;
    function GetSquadName: WideString;
    function GetContractType: WideString;
    function GetLeavingOnBosman: Boolean;
    function GetSquadStatus: WideString;
    function GetPerceivedSquadStatus: WideString;
    function GetTransferStatus: WideString;
    function GetContractEnds: TDateTime;
    function GetJoinedClub: TDateTime;
    function GetSquadReputation: Word;
    function GetWage: Integer;
    function GetMinimumFeeClause: TCM4ContractClause;
    function GetMinimumFee: Integer;
    function GetNonPromotionClause: TCM4ContractClause;
    function GetNonPromotionFee: Integer;
    function GetRelegationClause: TCM4ContractClause;
    function GetRelegationFee: Integer;
    function GetHappinessLevel: ShortInt;
    function GetBased: TCM4Nation;
    function GetName: WideString;
    function GetClubContract: TCM4Contract;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(FirstNames, SecondNames, CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData, PlayingData: TCM4DatabaseContainer); virtual;

    function FromNation(ANation: TCM4Nation): Boolean;

    property FirstName: TCM4Name read FFirstName;
    property SecondName: TCM4Name read FSecondName;
    property CommonName: TCM4Name read FCommonName;
    property DateOfBirth: TCM4Date read FDateOfBirth;

    property Nation: TCM4Nation read FNation;
    property InternationalApps: Byte read FInternationalApps;
    property InternationalGoals: Byte read FInternationalGoals;

    property ClubTeam: TCM4Team read FClubTeam;

    property PersonData: TCM4PersonData read FPersonData;

    property ListName: WideString read GetListName;
    property Name: WideString read GetName;
    property FullName: WideString read GetFullName;
    property Nations: WideString read GetNations;
    property EUMember: Boolean read GetEUMember;
    property ClubName: WideString read GetClubName;
    property BasedName: WideString read GetBasedName;
    property Based: TCM4Nation read GetBased;
    property Division: TCM4Competition read GetDivision;
    property DivisionName: WideString read GetDivisionName;
    property SquadName: WideString read GetSquadName;
    property ContractType: WideString read GetContractType;
    property LeavingOnBosman: Boolean read GetLeavingOnBosman;
    property SquadStatus: WideString read GetSquadStatus;
    property PerceivedSquadStatus: WideString read GetPerceivedSquadStatus;
    property TransferStatus: WideString read GetTransferStatus;
    property JoinedClub: TDateTime read GetJoinedClub;
    property ContractEnds: TDateTime read GetContractEnds;
    property SquadReputation: Word read GetSquadReputation;
    property Wage: Integer read GetWage;
    property MinimumFeeClause: TCM4ContractClause read GetMinimumFeeClause;
    property MinimumFee: Integer read GetMinimumFee;
    property RelegationClause: TCM4ContractClause read GetRelegationClause;
    property RelegationFee: Integer read GetRelegationFee;
    property NonPromotionClause: TCM4ContractClause read GetNonPromotionClause;
    property NonPromotionFee: Integer read GetNonPromotionFee;
    property HappinessLevel: ShortInt read GetHappinessLevel;
    property Contracts: TCM4ContractList read FContracts;
    property ClubContract: TCM4Contract read GetClubContract;
    property AdditionalNations: TCM4NationList read FAdditionalNations; 
  end;

  TCM4NonPlayerData = class
  private
    FHomeReputation: SmallInt;
    FCurrentReputation: SmallInt;
    FWorldReputation: SmallInt;
    FCurrentAbility: SmallInt;
    FPotentialAbility: SmallInt;
    FPreferredFormation: ShortInt;
    FNonPlayingData: TCM4NonPlayingData;
  public
    procedure Load(DataFile: TCM4FileStream);
    procedure ConvertIndexes(NonPlayingData: TCM4DatabaseContainer);

    property NonPlayingData: TCM4NonPlayingData read FNonPlayingData;
  end;

  ICM4NonPlayer = interface(IInterface)
    ['{5B0DD81A-1BAB-465E-BD3C-59E9FF513320}']
    function GetNonPlayerData: TCM4NonPlayerData;
    property NonPlayerData: TCM4NonPlayerData read GetNonPlayerData;
  end;

  TCM4NonPlayer = class(TCM4Person, ICM4NonPlayer)
  private
    FNonPlayerData: TCM4NonPlayerData;
    function GetNonPlayerData: TCM4NonPlayerData;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(FirstNames, SecondNames, CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData, PlayingData: TCM4DatabaseContainer); override;
  end;

  TCM4PlayerData = class
  private
    FHomeReputation: SmallInt;
    FCurrentReputation: SmallInt;
    FWorldReputation: SmallInt;
    FCurrentAbility: SmallInt;
    FPotentialAbility: SmallInt;
    FPlayingData: TCM4PlayingData;
    FDisplayValue: Integer;
    FSaleValue: Integer;
    procedure SkipBookingCount(DataFile: TCM4FileStream;
      BookingCountType: ShortInt);
    procedure SkipPlayerInjuries(DataFile: TCM4FileStream);

    function GetPosition: WideString;
    function GetLongPosition: WideString;
  public
    procedure Load(DataFile: TCM4FileStream);
    procedure ConvertIndexes(PlayingData: TCM4DatabaseContainer);

    property HomeReputation: SmallInt read FHomeReputation;
    property CurrentReputation: SmallInt read FCurrentReputation;
    property WorldReputation: SmallInt read FWorldReputation;
    property CurrentAbility: SmallInt read FCurrentAbility;
    property PotentialAbility: SmallInt read FPotentialAbility;
    property PlayingData: TCM4PlayingData read FPlayingData;
    property Position: WideString read GetPosition;
    property LongPosition: WideString read GetLongPosition;
    property DisplayValue: Integer read FDisplayValue;
    property SaleValue: Integer read FSaleValue;
  end;

  ICM4Player = interface
    ['{B4F0517B-9F8E-459A-8BD6-87E4CBBB87E7}']
    function GetPlayerData: TCM4PlayerData;
    function GetPosition: WideString;
    function GetLongPosition: WideString;
    function GetScoutRating: TCM4PlayerScoutRating;
    property PlayerData: TCM4PlayerData read GetPlayerData;
    property Position: WideString read GetPosition;
    property LongPosition: WideString read GetLongPosition;
    property ScoutRating: TCM4PlayerScoutRating read GetScoutRating;
  end;

  TCM4Player = class(TCM4Person, ICM4Player)
  private
    FPlayerData: TCM4PlayerData;
    FPlayerScoutRating: TCM4PlayerScoutRating;
    function GetPlayerData: TCM4PlayerData;
    function GetPosition: WideString;
    function GetLongPosition: WideString;
    function GetScoutRating: TCM4PlayerScoutRating;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(FirstNames, SecondNames, CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData, PlayingData: TCM4DatabaseContainer); override;
  end;

  TCM4PlayerNonPlayer = class(TCM4Person, ICM4Player, ICM4NonPlayer)
  private
    FPlayerData: TCM4PlayerData;
    FNonPlayerData: TCM4NonPlayerData;
    FPlayerScoutRating: TCM4PlayerScoutRating;
    function GetNonPlayerData: TCM4NonPlayerData;
    function GetPlayerData: TCM4PlayerData;
    function GetPosition: WideString;
    function GetLongPosition: WideString;
    function GetScoutRating: TCM4PlayerScoutRating;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertIndexes(FirstNames, SecondNames, CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData, PlayingData: TCM4DatabaseContainer); override;
  end;

  TCM4Official = class(TCM4Person)
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4RetiredPerson = class(TCM4DatabaseEntity)
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4VirtualNonPlayer = class(TCM4DatabaseEntity)
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4VirtualPlayer = class(TCM4DatabaseEntity)
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4YouthPlayer = class(TCM4Person)
  end;

  TCM4HumanNonPlayer = class(TCM4NonPlayer)
  private
    procedure SkipFilterList(DataFile: TCM4FileStream);
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4PersonContainer = class(TCM4DatabaseContainer)
  private
    FPlayers: TCM4PersonList;
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
    function GetPerson(Index: Integer): TCM4Person;
  public
    constructor Create; override;
    procedure Clear; override;
    procedure ConvertIndexes(FirstNames, SecondNames, CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData, PlayingData: TCM4DatabaseContainer);
    property Person[Index: Integer]: TCM4Person read GetPerson; default;
    property Players: TCM4PersonList read FPlayers;
  end;

  TCM4PersonList = class(TCM4List)
  private
    function GetPerson(Index: Integer): TCM4Person;
  public
    property Person[Index: Integer]: TCM4Person read GetPerson; default;
  end;

  TCM4PersonData = class(TCM4DatabaseEntity)
  private
    FAdaptability: ShortInt;
    FAmbition: ShortInt;
    FLoyality: ShortInt;
    FPressure: ShortInt;
    FProfessionalism: ShortInt;
    FSportsmanship: ShortInt;
    FTemperament: ShortInt;
    FControversy: ShortInt;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;

    property Adaptability: ShortInt read FAdaptability;
    property Ambition: ShortInt read FAmbition;
    property Loyality: ShortInt read FLoyality;
    property Pressure: ShortInt read FPressure;
    property Professionalism: ShortInt read FProfessionalism;
    property Sportsmanship: ShortInt read FSportsmanship;
    property Temperament: ShortInt read FTemperament;
    property Controversy: ShortInt read FControversy;
  end;

  TCM4PersonDataContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
  end;

  TCM4PlayingData = class(TCM4DatabaseEntity)
  private
    FGoalkeeper: ShortInt;
    FSweeper: ShortInt;
    FDefender: ShortInt;
    FDefensiveMidfielder: ShortInt;
    FMidfielder: ShortInt;
    FAttackingMidfielder: ShortInt;
    FAttacker: ShortInt;
    FWingBack: ShortInt;
    FFreeRole: ShortInt;
    FRightSide: ShortInt;
    FLeftSide: ShortInt;
    FCentral: ShortInt;
    FCrossing: ShortInt;
    FDribbling: ShortInt;
    FFinishing: ShortInt;
    FHeading: ShortInt;
    FLongShots: ShortInt;
    FMarking: ShortInt;
    FOffTheBall: ShortInt;
    FPassing: ShortInt;
    FPenalties: ShortInt;
    FTackling: ShortInt;
    FCreativity: ShortInt;
    FHandling: ShortInt;
    FAerialAbility: ShortInt;
    FCommandOfArea: ShortInt;
    FCommunication: ShortInt;
    FKicking: ShortInt;
    FThrowing: ShortInt;
    FAnticipation: ShortInt;
    FDecisions: ShortInt;
    FOneOnOnes: ShortInt;
    FPositioning: ShortInt;
    FReflexes: ShortInt;
    FThrowIns: ShortInt;
    FFirstTouch: ShortInt;
    FTechnique: ShortInt;
    FLeftFoot: ShortInt;
    FRightFoot: ShortInt;
    FFlair: ShortInt;
    FCorners: ShortInt;
    FTeamwork: ShortInt;
    FWorkRate: ShortInt;
    FLongThrows: ShortInt;
    FEccentricity: ShortInt;
    FRushingOut: ShortInt;
    FTendencyToPunch: ShortInt;
    FAcceleration: ShortInt;
    FSetPieces: ShortInt;
    FStrength: ShortInt;
    FStamina: ShortInt;
    FPace: ShortInt;
    FJumping: ShortInt;
    FInfluence: ShortInt;
    FDirtiness: ShortInt;
    FBalance: ShortInt;
    FBravery: ShortInt;
    FConsistency: ShortInt;
    FAggression: ShortInt;
    FAgility: ShortInt;
    FImportantMatches: ShortInt;
    FInjuryProneness: ShortInt;
    FVersatility: ShortInt;
    FNaturalFitness: ShortInt;
    FDetermination: ShortInt;

    FPosition: WideString;
    FLongPosition: WideString;

    function HighConvert(Ability: SmallInt; Value: ShortInt): ShortInt;
    function LowConvert(Ability: SmallInt; Value: ShortInt): ShortInt;

    function GetPosition: WideString;
    function GetLongPosition: WideString;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
    procedure ConvertRelativeAbilities(Ability: SmallInt);

    property Goalkeeper: ShortInt read FGoalkeeper;
    property Sweeper: ShortInt read FSweeper;
    property Defender: ShortInt read FDefender;
    property DefensiveMidfielder: ShortInt read FDefensiveMidfielder;
    property Midfielder: ShortInt read FMidfielder;
    property AttackingMidfielder: ShortInt read FAttackingMidfielder;
    property Attacker: ShortInt read FAttacker;
    property WingBack: ShortInt read FWingBack;
    property FreeRole: ShortInt read FFreeRole;
    property RightSide: ShortInt read FRightSide;
    property LeftSide: ShortInt read FLeftSide;
    property Central: ShortInt read FCentral;
    property Crossing: ShortInt read FCrossing;
    property Dribbling: ShortInt read FDribbling;
    property Finishing: ShortInt read FFinishing;
    property Heading: ShortInt read FHeading;
    property LongShots: ShortInt read FLongShots;
    property Marking: ShortInt read FMarking;
    property OffTheBall: ShortInt read FOffTheBall;
    property Passing: ShortInt read FPassing;
    property Penalties: ShortInt read FPenalties;
    property Tackling: ShortInt read FTackling;
    property Creativity: ShortInt read FCreativity;
    property Handling: ShortInt read FHandling;
    property AerialAbility: ShortInt read FAerialAbility;
    property CommandOfArea: ShortInt read FCommandOfArea;
    property Communication: ShortInt read FCommunication;
    property Kicking: ShortInt read FKicking;
    property Throwing: ShortInt read FThrowing;
    property Anticipation: ShortInt read FAnticipation;
    property Decisions: ShortInt read FDecisions;
    property OneOnOnes: ShortInt read FOneOnOnes;
    property Positioning: ShortInt read FPositioning;
    property Reflexes: ShortInt read FReflexes;
    property ThrowIns: ShortInt read FThrowIns;
    property FirstTouch: ShortInt read FFirstTouch;
    property Technique: ShortInt read FTechnique;
    property LeftFoot: ShortInt read FLeftFoot;
    property RightFoot: ShortInt read FRightFoot;
    property Flair: ShortInt read FFlair;
    property Corners: ShortInt read FCorners;
    property Teamwork: ShortInt read FTeamwork;
    property WorkRate: ShortInt read FWorkRate;
    property LongThrows: ShortInt read FLongThrows;
    property Eccentricity: ShortInt read FEccentricity;
    property RushingOut: ShortInt read FRushingOut;
    property TendencyToPunch: ShortInt read FTendencyToPunch;
    property Acceleration: ShortInt read FAcceleration;
    property SetPieces: ShortInt read FSetPieces;
    property Strength: ShortInt read FStrength;
    property Stamina: ShortInt read FStamina;
    property Pace: ShortInt read FPace;
    property Jumping: ShortInt read FJumping;
    property Influence: ShortInt read FInfluence;
    property Dirtiness: ShortInt read FDirtiness;
    property Balance: ShortInt read FBalance;
    property Bravery: ShortInt read FBravery;
    property Consistency: ShortInt read FConsistency;
    property Aggression: ShortInt read FAggression;
    property Agility: ShortInt read FAgility;
    property ImportantMatches: ShortInt read FImportantMatches;
    property InjuryProneness: ShortInt read FInjuryProneness;
    property Versatility: ShortInt read FVersatility;
    property NaturalFitness: ShortInt read FNaturalFitness;
    property Determination: ShortInt read FDetermination;

    property Position: WideString read GetPosition;
    property LongPosition: WideString read GetLongPosition;
  end;

  TCM4PlayingDataContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
    function GetPlayingData(Index: Integer): TCM4PlayingData;
  public
    property PlayingData[Index: Integer]: TCM4PlayingData read GetPlayingData; default;
  end;

  TCM4NonPlayingData = class(TCM4DatabaseEntity)
  private
    FAttacking: ShortInt;
    FBusiness: ShortInt;
    FCoachingTechnique: ShortInt;
    FDirectness: ShortInt;
    FLevelOfDiscipline: ShortInt;
    FFreeRoles: ShortInt;
    FInterference: ShortInt;
    FMarking: ShortInt;
    FOffside: ShortInt;
    FPatience: ShortInt;
    FPressing: ShortInt;
    FResources: ShortInt;
    FWorkingWithYoungsters: ShortInt;
    FDetermination: ShortInt;
    FBuyingPlayers: ShortInt;
    FMindGames: ShortInt;
    FSellingPlayers: ShortInt;
    FSittingBack: ShortInt;
    FUseOfPlayMaker: ShortInt;
    FUseOfSubs: ShortInt;
    FCoachingOutfieldPlayers: ShortInt;
    FCoachingGoalkeepers: ShortInt;
    FJudgingPlayerAbility: ShortInt;
    FJudgingPlayerPotential: ShortInt;
    FManManagement: ShortInt;
    FMotivating: ShortInt;
    FPhysiotherapy: ShortInt;
    FTacticalKnowledge: ShortInt;
  public
    procedure Load(DataFile: TCM4FileStream; DBVersion: SmallInt); override;
  end;

  TCM4NonPlayingDataContainer = class(TCM4DatabaseContainer)
  private
    function NewEntity(RecordType: Byte): TCM4DatabaseEntity; override;
  end;

  TCM4PlayerScoutRating = class
  private
    FPersonData: TCM4PersonData;
    FPlayerData: TCM4PlayerData;

    FGKRating: Double;
    FDRating: Double;
    FDMRating: Double;
    FMRating: Double;
    FAMRating: Double;
    FWRating: Double;
    FARating: Double;

    FBestRating: Double;
    FBestRatingText: WideString;

    FCurrentValue: PDouble;

    procedure CalculateGKRating;
    procedure CalculateDRating;
    procedure CalculateDMRating;
    procedure CalculateMRating;
    procedure CalculateAMRating;
    procedure CalculateWRating;
    procedure CalculateARating;
    procedure Increase(Addition: Double);
  public
    procedure Calculate(PersonData: TCM4PersonData; PlayerData: TCM4PlayerData);

    property BestRating: Double read FBestRating;
    property BestRatingText: WideString read FBestRatingText;

    property GKRating: Double read FGKRating;
    property DRating: Double read FDRating;
    property DMRating: Double read FDMRating;
    property MRating: Double read FMRating;
    property AMRating: Double read FAMRating;
    property WRating: Double read FWRating;
    property ARating: Double read FARating;
  end;

const
  RT_STANDARD = 0;
  RT_NON_PLAYER = 1;
  RT_PLAYER = 2;
  RT_PLAYER_NON_PLAYER = 3;
  RT_OFFICIAL = 4;
  RT_RETIRED_PERSON = 5;
  RT_VIRTUAL_NON_PLAYER = 6;
  RT_VIRTUAL_PLAYER = 7;
  RT_YOUTH_PLAYER = 8;
  RT_HUMAN_NON_PLAYER = 9;
  RT_TEAM = 10;
  RT_NATIONAL_TEAM = 11;
  RT_LEAGUE_BODY_CLUB = 12;

  FINANCE_BASE = 0;
  FINANCE_FULL = 1;

  TI_MAX_PLAYERS_ON_LOAN_IN_SEASON = 0;
  TI_NUMBER_OF_DISCOVERY_PLAYERS_IN_SEASON = 1;
  TI_MONTHLY_INSTALLMENT = 2;
  TI_CLUB_SQUAD_SELECTION_TOTAL_VALUES = 3;
  TI_PLAYER_FIRST_OPTION = 4;
  TI_NEXT_SALE_PERCENTAGE = 5;
  TI_APPEARANCE_MONEY = 6;
  TI_PLAYER_BUY_BACK = 7;

  TC_CLUB = 0;
  TC_NATION = 1;

  GM_UNDEFINED = 0;
  GM_NON_EU = 1;
  GM_EU = 2;

  CT_FULL_CONTRACT = 0;
  CT_LOAN_CONTRACT = 1;
  CT_TRIAL_CONTRACT = 2;
  CT_LEAGUE_CONTRACT = 5;

  BC_TYPE_INVALID = -1;
  BC_TYPE_BASE = 0;
  BC_TYPE_POINTS = 1;
  BC_TYPE_LAST_TEN_GAMES = 2;
  BC_TYPE_LAST_THREE_SEASONS = 3;
  BC_TYPE_LAST_FIVE_GAMES = 4;

  POSITION_THRESHOLD = 15;

  CNT_ORIGINAL_DATABASE_NAME = 0;
  CNT_FRIENDLY_NAME = 1;
  CNT_RESERVES_LEAGUE_NAME = 2;
  CNT_U19_LEAGUE_NAME = 3;
  CNT_NAME_ON_SERVER_ONLY = 4;
  CNT_U21_LEAGUE_NAME = 5;
  CNT_U18_LEAGUE_NAME = 6;
  CNT_U20_LEAGUE_NAME = 7;

  EU_MEMBER = 2;

implementation

function GetContractObject(ContractType: Byte): TCM4Contract;
begin
  if ContractType = CT_FULL_CONTRACT then
    Result:=TCM4FullContract.Create
  else if ContractType = CT_LOAN_CONTRACT then
    Result:=TCM4LoanContract.Create
  else if ContractType = CT_TRIAL_CONTRACT then
    Result:=TCM4TrialContract.Create
  else if ContractType = CT_LEAGUE_CONTRACT then
    Result:=TCM4LeagueContract.Create
  else
    raise EFileCorruptError.Create('Contract data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Contract Type: ' + IntToStr(ContractType));
end;

{ TCM4Date }

function TCM4Date.Age(Today: TCM4Date): Integer;
begin
  Result:=Today.FYear - FYear;
  if Today.FDays < FDays then
    Dec(Result);
end;

function TCM4Date.Date: TDateTime;
begin
  Result:=EncodeDate(FYear, 1, 1);
  Result:=Result + FDays;
end;

procedure TCM4Date.Load(DataFile: TCM4FileStream);
begin
  DataFile.Read(FDays, 2);
  DataFile.Read(FYear, 2);
end;

function TCM4Date.MonthToMonth: Boolean;
begin
  Result:=(FYear = 1900) and (FDays = 1);
end;

function TCM4Date.OneYearDate: TDateTime;
begin
  Inc(FYear);
  Result:=Date;
  Dec(FYear);
end;

{ TCM4DatabaseEntity }

procedure TCM4DatabaseEntity.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  DataFile.Read(FID, 4);
  DataFile.Read(FUniqueID, 4);
end;

{ TCM4DatabaseContainer }

procedure TCM4DatabaseContainer.Clear;
var
  j: Integer;
begin
  for j:=0 to Count - 1 do
    Entity[j].Free;
  FContainer.Clear;
  FIDList.Clear;
  FUniqueID.Clear;
end;

function TCM4DatabaseContainer.Count: Integer;
begin
  Result:=FContainer.Count;
end;

constructor TCM4DatabaseContainer.Create;
begin
  FContainer:=TList.Create;
  FIDList:=THashtable.Create(1);
  FUniqueID:=THashtable.Create(1);
end;

destructor TCM4DatabaseContainer.Destroy;
begin
  Clear;
  FContainer.Free;
  FIDList.Free;
  FUniqueID.Free;
  inherited;
end;

function TCM4DatabaseContainer.GetEntity(Index: Integer): TCM4DatabaseEntity;
begin
  if (Index >= 0) and (Index < Count) then
    Result:=FContainer[Index]
  else
    Result:=nil;
end;

function TCM4DatabaseContainer.GetIDEntity(Index: Integer): TCM4DatabaseEntity;
begin
  Result:=FIDList.Get(Index);
end;

function TCM4DatabaseContainer.GetUniqueEntity(
  Index: Integer): TCM4DatabaseEntity;
begin
  Result:=FUniqueID.Get(Index);
end;

procedure TCM4DatabaseContainer.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
var
  Temp, j: Integer;
  Entity: TCM4DatabaseEntity;
  RecordType: Byte;
begin
  DataFile.Read(Temp, 4);

  FContainer.Capacity:=Temp;
  FIDList.Capacity:=Temp;
  FUniqueID.Capacity:=Temp;

  for j:=0 to Temp - 1 do
  begin
    try
      DataFile.Read(RecordType, 1);
      Entity:=NewEntity(RecordType);
      Entity.Load(DataFile, DBVersion);
    except
      on E: EFileCorruptError do
        raise ECM4LoadError.Create('Error Loading Entity Number: ' + IntToStr(j) + #13#10 + 'File Position: ' + IntToStr(DataFile.Position) + #13#10 + 'Database Version: ' + IntToStr(DBVersion) + #13#10 + E.Message, DataFile.Position);
      on E: EOutOfMemory do
        raise ECM4LoadError.Create('Out of memory while loading Entity Number: ' + IntToStr(j) + ' from: ' + Self.ClassName, DataFile.Position);
    end;

    FContainer.Add(Entity);
    FIDList.Put(Entity.ID, Entity);
    FUniqueID.Put(Entity.UniqueID, Entity);

    TriggerProgress(j, Temp);
  end;
end;

procedure TCM4DatabaseContainer.TriggerProgress(Progress, Count: Integer);
begin
  if Assigned(FOnProgress) then
  begin
    if Count > 0 then
      FOnProgress(Trunc((Progress + 1) / Count * 100))
    else
      FOnProgress(100);
  end;
end;

procedure TCM4DatabaseContainer.TriggerStatus(Status: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Status);
end;

{ TCM4List }

function TCM4List.Count: Integer;
begin
  Result:=FData.Count;
end;

constructor TCM4List.Create;
begin
  FData:=TList.Create;
end;

destructor TCM4List.Destroy;
begin
  FData.Free;
  inherited;
end;

function TCM4List.GetItem(Index: Integer): Pointer;
begin
  if (Index >= 0) and (Index < Count) then
    Result:=FData[Index]
  else
    Result:=nil;
end;

procedure TCM4List.Load(DataFile: TCM4FileStream);
var
  temp: Byte;
begin
  DataFile.Read(temp, 1);
  LoadData(DataFile, temp);
end;

procedure TCM4List.LoadW(DataFile: TCM4FileStream);
var
  temp: Word;
begin
  DataFile.Read(temp, 2);
  LoadData(DataFile, temp);
end;

procedure TCM4List.LoadData(DataFile: TCM4FileStream; Size: Integer);
var
  j: Integer;
  entry: Pointer;
begin
  for j:=0 to Size - 1 do
  begin
    DataFile.Read(entry, 4);
    FData.Add(entry);
  end;
end;

procedure TCM4List.ConvertIndexes(Container: TCM4DatabaseContainer);
var
  j: Integer;
begin
  for j:=0 to Count - 1 do
    FData[j]:=Container.Entity[Integer(FData[j])];
end;

procedure TCM4List.Add(Entity: Pointer);
begin
  FData.Add(Entity);
end;

procedure TCM4List.Clear;
begin
  FData.Clear;
end;

{ TCM4TeamBase }

procedure TCM4TeamBase.ConvertIndexes(Clubs,
  Nations: TCM4DatabaseContainer);
begin
  case FTeamContainerType of
    TC_CLUB:
      FTeamContainer:=TCM4TeamCont(Clubs.Entity[Integer(FTeamContainer)]);
    TC_NATION:
      FTeamContainer:=TCM4TeamCont(Nations.Entity[Integer(FTeamContainer)]);
  end;
end;

function TCM4TeamBase.GetShortName: WideString;
begin
  case FTeamType of
    1:
      Result:='Reserves';
    3:
      Result:='B';
    9:
      Result:='U23';
    10:
      Result:='U21';
    11:
      Result:='U19';
    12:
      Result:='U18';
    13:
      Result:='C';
    14:
      Result:='(A)';
    15:
      Result:='II';
    16:
      Result:='2';
    17:
      Result:='3';
    18:
      Result:='U20';
  end;
end;

function TCM4TeamBase.GetSquadName: WideString;
begin
  if TeamContainer <> nil then
  begin
    Result:=TeamContainer.ShortName;

    if ShortName <> '' then
      Result:=Result + ' ' + ShortName;
  end;
end;

procedure TCM4TeamBase.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  DataFile.Read(FTeamType, 1);
  if (FTeamType < 0) or (FTeamType > 18) then
    raise EFileCorruptError.Create('Team data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Team Type: ' + IntToStr(FTeamType));

  DataFile.Read(FTeamContainerType, 1);
  if (FTeamContainerType <> TC_CLUB) and (FTeamContainerType <> TC_NATION) then
    raise EFileCorruptError.Create('Team data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Team Container Type: ' + IntToStr(FTeamContainerType));

  // Skip New Team
  DataFile.Skip(1);
  DataFile.Read(FTeamContainer, 4);

  inherited;
end;

{ TCM4Team }

procedure TCM4Team.ConvertIndexes(Competitions, People, Clubs,
  Nations: TCM4DatabaseContainer);
begin
  FDivision:=TCM4Competition(Competitions.Entity[Integer(FDivision)]);
  FManager:=TCM4Person(People.Entity[Integer(FManager)]);
  FPhysios.ConvertIndexes(People);
  FPlayers.ConvertIndexes(People);
  FCoaches.ConvertIndexes(People);
  ConvertIndexes(Clubs, Nations);
end;

constructor TCM4Team.Create;
begin
  FPhysios:=TCM4PersonList.Create;
  FPlayers:=TCM4PersonList.Create;
  FCoaches:=TCM4PersonList.Create;
end;

destructor TCM4Team.Destroy;
begin
  FPhysios.Free;
  FPlayers.Free;
  FCoaches.Free;
  inherited;
end;

procedure TCM4Team.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip Last Position
  DataFile.Skip(1);
  DataFile.Read(FReputation, 2);
  DataFile.Read(FDivision, 4);
  // Skip Last Division and Stadium
  DataFile.Skip(8);
  DataFile.Read(FManager, 4);
  // Skip Continental Cup and Seeding, Home Match Day,
  // Future Continental Cup and Info,
  // First and Last Fixture Year,
  // Last Match Date Day and Year
  DataFile.Skip(19);
  FPhysios.Load(DataFile);
  FPlayers.LoadW(DataFile);
  FCoaches.Load(DataFile);
  // Skip Team Selected
  DataFile.SkipByteArray(4);
  // Skip Number Of Unhappy Players
  DataFile.Skip(1);
  // Skip Team Fixture Blocks
  DataFile.SkipWordArray(11);
  // Skip Other Division
  DataFile.Skip(4);
  inherited;
end;

{ TCM4NationalTeam }

procedure TCM4NationalTeam.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip National Team Data
  DataFile.Skip(13);
  inherited;
end;

{ TCM4TeamContainer }

procedure TCM4TeamContainer.ConvertIndexes(Competitions, People, Clubs,
  Nations: TCM4DatabaseContainer);
var
  j: Integer;
begin
  TriggerStatus('Converting Team Indexes');
  for j:=0 to Count - 1 do
  begin
    Team[j].ConvertIndexes(Competitions, People, Clubs, Nations);
    TriggerProgress(j, Count);
  end;
end;

function TCM4TeamContainer.GetTeam(Index: Integer): TCM4Team;
begin
  Result:=TCM4Team(Entity[Index]);
end;

function TCM4TeamContainer.NewEntity(RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_TEAM then
    Result:=TCM4Team.Create
  else if RecordType = RT_NATIONAL_TEAM then
    Result:=TCM4NationalTeam.Create
  else
    raise EFileCorruptError.Create('Team data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4TeamList }

function TCM4TeamList.GetTeam(Index: Integer): TCM4Team;
begin
  Result:=Item[Index];
end;

{ TCM4TeamCont }

procedure TCM4TeamCont.ConvertIndexes(Teams: TCM4DatabaseContainer);
begin
  FTeams.ConvertIndexes(Teams);
end;

constructor TCM4TeamCont.Create;
begin
  FTeams:=TCM4TeamList.Create;
end;

destructor TCM4TeamCont.Destroy;
begin
  FTeams.Free;
  inherited;
end;

procedure TCM4TeamCont.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  DataFile.Read(FType, 1);
  if (FType <> TC_CLUB) and (FType <> TC_NATION) then
    raise EFileCorruptError.Create('Club data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Team Type: ' + IntToStr(FType));

  // Skip Name Gender and Short Name Gender
  DataFile.Skip(2);
  FName:=DataFile.ReadWideString;
  FShortName:=DataFile.ReadWideString;

  // Skip Colours
  DataFile.SkipByteArray(6);

  FTeams.Load(DataFile);

  // Skip Relationships
  DataFile.SkipByteArray(8);

  inherited;
end;

{ TCM4Nation }

function TCM4Nation.GetEUMember: Boolean;
begin
  Result:=FGroupMembership = EU_MEMBER;
end;

procedure TCM4Nation.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
var
  j, s: Integer;
begin
  // Skip Number of Clubs, Staff and Players, Reputation,
  // FIFA Ranking, FIFA Ranking Points, Stadium, Wage Budget,
  // Wage Factor, Current Game Index, Name Index and Counts
  DataFile.Skip(51);

  // Skip FIFA Ranking Points
  DataFile.SkipByteArray(2);

  // Skip FIFA Ranking Current Year Matches
  DataFile.SkipByteArray(4);

  // Skip UEFA Coefficients
  DataFile.SkipByteArray(4);

  // Skip Human Player Pool
  DataFile.SkipWordArray(4);

  // Skip Nation Shortlists
  for j:=0 to 1 do
    for s:=0 to 3 do
    begin
      DataFile.Skip(2);
      DataFile.SkipByteArray(4);
    end;

  // Skip Style of Football and State Of Development
  DataFile.Skip(2);
  DataFile.Read(FGroupMembership, 1);

  if (FGroupMembership <> GM_UNDEFINED) and (FGroupMembership <> GM_NON_EU) and (FGroupMembership <> GM_EU) then
    raise EFileCorruptError.Create('Nation data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Group Membership: ' + IntToStr(FGroupMembership));

  // Skip Game Importance, League Standard, League Selected,
  // Rule Group Loaded, FIFA Full Member, Continent, Region
  // and Capital City
  DataFile.Skip(17);

  // Skip Languages
  DataFile.SkipByteArray(4);

  // Skip Update Days
  DataFile.Skip(1);

  inherited;
end;

{ TCM4NationList }

function TCM4NationList.GetNation(Index: Integer): TCM4Nation;
begin
  Result:=Item[Index];
end;

{ TCM4NationContainer }

procedure TCM4NationContainer.ConvertIndexes(Teams: TCM4DatabaseContainer);
var
  j: Integer;
begin
  TriggerStatus('Converting Nation Indexes');
  for j:=0 to Count - 1 do
  begin
    Nation[j].ConvertIndexes(Teams);
    TriggerProgress(j, Count);
  end;
end;

function TCM4NationContainer.GetNation(Index: Integer): TCM4Nation;
begin
  Result:=TCM4Nation(Entity[Index]);
end;

function TCM4NationContainer.GetUniqueNation(Index: Integer): TCM4Nation;
begin
  Result:=TCM4Nation(UniqueEntity[Index]);
end;

function TCM4NationContainer.NewEntity(RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_STANDARD then
    Result:=TCM4Nation.Create
  else
    raise EFileCorruptError.Create('Nation data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4Competition }

procedure TCM4Competition.ConvertIndexs(Nations: TCM4DatabaseContainer);
begin
  FNation:=TCM4Nation(Nations.Entity[Integer(FNation)]);
end;

procedure TCM4Competition.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip Name Gender, Short Name Gender, Scope, Colour and
  // Reputation
  DataFile.Skip(11);
  DataFile.Read(FNameType, 1);
  // Skip Competition Level
  DataFile.Skip(1);

  if FNameType = CNT_NAME_ON_SERVER_ONLY then
  begin
    FShortName:=DataFile.ReadWideString;
    FName:=DataFile.ReadWideString;
  end;

  // Skip Continent
  DataFile.Skip(4);
  DataFile.Read(FNation, 4);
  // Skip League Body Club, Last History, History Index and
  // Uses Squad Numbers
  DataFile.Skip(13);
  inherited;
end;

{ TCM4CompetitionContainer }

procedure TCM4CompetitionContainer.ConvertIndexes(
  Nations: TCM4DatabaseContainer);
var
  j: Integer;
begin
  TriggerStatus('Converting Competition Indexes');
  for j:=0 to Count - 1 do
  begin
    Competition[j].ConvertIndexs(Nations);
    TriggerProgress(j, Count);
  end;
end;

function TCM4CompetitionContainer.GetCompetition(
  Index: Integer): TCM4Competition;
begin
  Result:=TCM4Competition(Entity[Index]);
end;

function TCM4CompetitionContainer.GetUniqueCompetition(
  Index: Integer): TCM4Competition;
begin
  Result:=TCM4Competition(UniqueEntity[Index]);
end;

function TCM4CompetitionContainer.NewEntity(
  RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_STANDARD then
    Result:=TCM4Competition.Create
  else
    raise EFileCorruptError.Create('Competition data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4Club }

procedure TCM4Club.ConvertIndexes(Nations, People,
  Competitions, Teams: TCM4DatabaseContainer);
begin
  FNation:=TCM4Nation(Nations.Entity[Integer(FNation)]);
  FChairman:=TCM4Person(People.Entity[Integer(FChairman)]);
  FDirectors.ConvertIndexes(People);
  FScouts.ConvertIndexes(People);
  ConvertIndexes(Teams);  
end;

constructor TCM4Club.Create;
begin
  inherited;
  FDirectors:=TCM4PersonList.Create;
  FScouts:=TCM4PersonList.Create;
end;

destructor TCM4Club.Destroy;
begin
  FDirectors.Free;
  FScouts.Free;
  inherited;
end;

procedure TCM4Club.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
var
  FinanceType: Byte;
  Sponsor: Integer;
  WordCount: Word;
  j: Integer;
  TransferInfoType: Byte;
  TotalValuesExist: Boolean;
begin
  DataFile.Read(FNation, 4);
  // Skip Nick Name 1 Gender
  DataFile.Skip(1);
  FNickName1:=DataFile.ReadWideString;
  // Skip Nick Name 2 Gender
  DataFile.Skip(1);
  FNickName2:=DataFile.ReadWideString;
  // Skip Youth Academy, Youth Setup, Professional Status,
  // Attendane, Training and PLC
  DataFile.Skip(17);
  DataFile.Read(FChairman, 4);
  // Skip Unused Short
  DataFile.Skip(2);
  FDirectors.Load(DataFile);
  FScouts.Load(DataFile);

  // Skip Finances
  DataFile.Read(FinanceType, 1);
  if FinanceType = FINANCE_BASE then
    DataFile.Skip(4)
  else if FinanceType = FINANCE_FULL then
  begin
    DataFile.Skip(421);
    if DBVersion > 110 then
      DataFile.Skip(16);
    if DBVersion >= 115 then
      DataFile.Skip(1);
  end;

  // Skip Sponsor
  DataFile.Read(Sponsor, 4);
  if Sponsor <> 0 then
    DataFile.Skip(13);

  // Skip Transfer Offers
  DataFile.SkipWordArray(4);

  // Skip Transfer Infos
  DataFile.Read(WordCount, 2);
  for j:=0 to WordCount - 1 do
  begin
    DataFile.Read(TransferInfoType, 1);
    if TransferInfoType = TI_NEXT_SALE_PERCENTAGE then
      DataFile.Skip(10)
    else if TransferInfoType = TI_APPEARANCE_MONEY then
      DataFile.Skip(15)
    else if TransferInfoType = TI_NUMBER_OF_DISCOVERY_PLAYERS_IN_SEASON then
      DataFile.Skip(1)
    else if TransferInfoType = TI_MONTHLY_INSTALLMENT then
      DataFile.Skip(5)
    else if TransferInfoType = TI_CLUB_SQUAD_SELECTION_TOTAL_VALUES then
    begin
      DataFile.Read(TotalValuesExist, 1);
      if TotalValuesExist then
        DataFile.SkipByteArray(4);
        
      DataFile.Skip(5);
    end
    else if TransferInfoType = TI_PLAYER_FIRST_OPTION then
      DataFile.Skip(16)
    else if TransferInfoType = TI_PLAYER_BUY_BACK then
      DataFile.Skip(12)
    else if TransferInfoType = TI_MAX_PLAYERS_ON_LOAN_IN_SEASON then
    begin
      DataFile.Skip(1);
      if DBVersion > 110 then
        DataFile.Skip(4);
    end
    else
      raise EFileCorruptError.Create('Club data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Transfer Info Type: ' + IntToStr(TransferInfoType));
  end;

  // Skip Club Links
  DataFile.SkipByteArray(6);

  // Skip Club Training Info
  DataFile.Skip(12);

  // Skip Shortlisted People
  DataFile.SkipWordArray(4);

  // Skip International Date Player Counts
  DataFile.SkipByteArray(5);

  // Skip Rough Financial State, Captain
  DataFile.Skip(5);

  inherited;
end;

{ TCM4LeagueBodyClub }

procedure TCM4LeagueBodyClub.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip League Body Club data
  DataFile.Skip(9);
  inherited;
end;

{ TCM4ClubContainer }

procedure TCM4ClubContainer.ConvertIndexes(Nations, People, Competitions,
  Teams: TCM4DatabaseContainer);
var
  j: Integer;
begin
  TriggerStatus('Converting Club Indexes');
  for j:=0 to Count - 1 do
  begin
    Club[j].ConvertIndexes(Nations, People, Competitions, Teams);
    TriggerProgress(j, Count);
  end;
end;

function TCM4ClubContainer.GetClub(Index: Integer): TCM4Club;
begin
  Result:=TCM4Club(Entity[Index]);
end;

function TCM4ClubContainer.GetUniqueClub(Index: Integer): TCM4Club;
begin
  Result:=TCM4Club(UniqueEntity[Index]);
end;

function TCM4ClubContainer.NewEntity(RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_STANDARD then
    Result:=TCM4Club.Create
  else if RecordType = RT_LEAGUE_BODY_CLUB then
    Result:=TCM4LeagueBodyClub.Create
  else
    raise EFileCorruptError.Create('Club data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4Name }

procedure TCM4Name.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  FName:=DataFile.ReadWideString;
  // Skip Count and Nation
  DataFile.Skip(6);
  inherited;
end;

{ TCM4NameContainer }

function TCM4NameContainer.GetName(Index: Integer): TCM4Name;
begin
  Result:=TCM4Name(Entity[Index]);
end;

function TCM4NameContainer.NewEntity(RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_STANDARD then
    Result:=TCM4Name.Create
  else
    raise EFileCorruptError.Create('Name data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4ContractClause }

function TCM4ContractClause.Load(DataFile: TCM4FileStream): Boolean;
begin
  Result:=True;

  DataFile.Read(FType, 1);
  if (FType < 0) or (FType > 14) then
//    raise EFileCorruptError.Create('Contract Clause data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Contract Clause Type: ' + IntToStr(FType));
    Result:=False;

  DataFile.Read(FReleaseFee, 4);
end;

{ TCM4ContractClauseList }

procedure TCM4ContractClauseList.Clear;
var
  j: Integer;
begin
  for j:=0 to Count - 1 do
    Clause[j].Free;
end;

function TCM4ContractClauseList.Count: Integer;
begin
  Result:=FClauses.Count;
end;

constructor TCM4ContractClauseList.Create;
begin
  FClauses:=TList.Create;
end;

destructor TCM4ContractClauseList.Destroy;
begin
  Clear;
  FClauses.Free;
  inherited;
end;

function TCM4ContractClauseList.GetClause(
  Index: Integer): TCM4ContractClause;
begin
  if (Index >= 0) and (Index < Count) then
    Result:=FClauses[Index]
  else
    Result:=nil;
end;

procedure TCM4ContractClauseList.Load(DataFile: TCM4FileStream;
  ClauseCount: Byte);
var
  j: Integer;
  NewClause: TCM4ContractClause;
begin
  for j:=0 to ClauseCount - 1 do
  begin
    NewClause:=TCM4ContractClause.Create;
    if NewClause.Load(DataFile) then
      FClauses.Add(NewClause)
    else
      NewClause.Free;
  end;
end;

{ TCM4Contract }

procedure TCM4Contract.ConvertIndexes(Clubs,
  Nations, Teams: TCM4DatabaseContainer);
begin
  case FTeamContainerType of
    TC_CLUB:
      FTeamContainer:=TCM4TeamCont(Clubs.Entity[Integer(FTeamContainer)]);
    TC_NATION:
      FTeamContainer:=TCM4TeamCont(Nations.Entity[Integer(FTeamContainer)]);
  end;
end;

constructor TCM4Contract.Create;
begin
  FEndDate:=TCM4Date.Create;
end;

destructor TCM4Contract.Destroy;
begin
  FEndDate.Free;
  inherited;
end;

function TCM4Contract.GetSquadStatusText: WideString;
begin
  Result:=ConvertSquadStatus(FCurrentSquadStatus);
end;

function TCM4Contract.ConvertSquadStatus(SquadStatus: ShortInt): WideString;
begin
  case SquadStatus of
    0:
      Result:='-';
    1:
      Result:='Key Player';
    2:
      Result:='First Team';
    3:
      Result:='Rotation';
    4:
      Result:='Backup';
    5:
      Result:='Hot Prospect';
    6:
      Result:='Youngster';
    7:
      Result:='Not Needed';
  end;
end;

procedure TCM4Contract.Load(DataFile: TCM4FileStream);
begin
  DataFile.Read(FTeamContainerType, 1);
  if (FTeamContainerType <> TC_CLUB) and (FTeamContainerType <> TC_NATION) then
    raise EFileCorruptError.Create('Contract data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Team Container Type: ' + IntToStr(FTeamContainerType));

  DataFile.Read(FTeamContainer, 4);
  DataFile.Read(FWeeklyWage, 4);
  FEndDate.Load(DataFile);

  DataFile.Read(FCurrentSquadStatus, 1);
  if (FCurrentSquadStatus < -1) or (FCurrentSquadStatus > 7) then
    raise EFileCorruptError.Create('Contract data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Current Squad Status: ' + IntToStr(FCurrentSquadStatus));

  DataFile.Read(FTransferStatus, 1);
  DataFile.Read(FHappiness, 8);

  DataFile.Read(FHappinessLevel, 1);
//  if (FHappinessLevel < -100) or (FHappinessLevel > 100) then
//    raise EFileCorruptError.Create('Contract data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Happiness Level: ' + IntToStr(FHappinessLevel));

  DataFile.Read(FPerceivedSquadStatus, 1);
  if (FPerceivedSquadStatus < -1) or (FPerceivedSquadStatus > 7) then
    raise EFileCorruptError.Create('Contract data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Percieved Squad Status: ' + IntToStr(FPerceivedSquadStatus));

  // Skip Club Choice Factor
  DataFile.Skip(1);

  DataFile.Read(FSquadNumber, 1);
  if (FSquadNumber < -1) or (FSquadNumber > 99) then
    raise EFileCorruptError.Create('Contract data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Squad Number: ' + IntToStr(FSquadNumber));

  // Skip Transfer Offer Options
  DataFile.Skip(1);
end;

function TCM4Contract.GetPerceivedSquadStatus: WideString;
begin
  Result:=ConvertSquadStatus(FPerceivedSquadStatus);
end;

function TCM4Contract.GetTransferStatusText: WideString;
begin
  if FTransferStatus and 1 = 1 then
    Result:='Transfer Listed By Club'
  else if FTransferStatus and 2 = 2 then
    Result:='Listed For Loan'
  else if FTransferStatus and 8 = 8 then
    Result:='Transfer Listed By Request'
  else if FTransferStatus and 16 = 16 then
    Result:='Unavailable';
end;

function TCM4Contract.GetLongSquadStatusText: WideString;
begin
  case SquadStatus of
    0:
      Result:='Unspecified';
    1:
      Result:='Indispensable to the club';
    2:
      Result:='Important first team player';
    3:
      Result:='Squad rotation system';
    4:
      Result:='Backup to the first team';
    5:
      Result:='Hot prospect for the future';
    6:
      Result:='Decent young player';
    7:
      Result:='Not needed by the club';
  end;
end;

{ TCM4FullContract }

constructor TCM4FullContract.Create;
begin
  inherited;
  FClauses:=TCM4ContractClauseList.Create;
end;

destructor TCM4FullContract.Destroy;
begin
  FClauses.Free;
  inherited;
end;

function TCM4FullContract.GetContractType: WideString;
begin
  if FFullTime then
    Result:='Full Time'
  else
    Result:='Part Time';
end;

procedure TCM4FullContract.Load(DataFile: TCM4FileStream);
var
  ClauseCount: Byte;
begin
  DataFile.Read(FFullTime, 1);
  DataFile.Read(FLeavingOnBosmanRule, 1);
  // Skip League Games Played Since Joined, Appearance Bonus,
  // Goal Bonus, Assist Bonus and Clean Sheet Bonus
  DataFile.Skip(18);
  DataFile.Read(ClauseCount, 1);
  // Skip Signing On Fee, Contract Length and Job
  DataFile.Skip(6);
  FClauses.Load(DataFile, ClauseCount);
  inherited;
end;

{ TCM4LoanContract }

function TCM4LoanContract.GetContractType: WideString;
begin
  Result:='Loan Contract';
end;

procedure TCM4LoanContract.Load(DataFile: TCM4FileStream);
begin
  // Skip Loan Contract Data
  DataFile.Skip(7);
  inherited;
end;

{ TCM4TrialContract }

function TCM4TrialContract.GetContractType: WideString;
begin
  Result:='Trial Contract';
end;

{ TCM4LeagueContract }

procedure TCM4LeagueContract.ConvertIndexes(Clubs, Nations,
  Teams: TCM4DatabaseContainer);
begin
  FTeam:=TCM4Team(Teams.Entity[Integer(FTeam)]);
  inherited;
end;

function TCM4LeagueContract.GetContractType: WideString;
begin
  Result:='League Contract';
end;

procedure TCM4LeagueContract.Load(DataFile: TCM4FileStream);
begin
  DataFile.Read(FFullTime, 1);
  DataFile.Read(FTeam, 4);
  // Skip Contract Length and Flags
  DataFile.Skip(2);
  inherited;
end;

{ TCM4ContractList }

procedure TCM4ContractList.Clear;
var
  j: Integer;
begin
  for j:=0 to Count - 1 do
    Contract[j].Free;
  FContracts.Clear;
end;

constructor TCM4ContractList.Create;
begin
  FContracts:=TList.Create;
end;

function TCM4ContractList.Count: Integer;
begin
  Result:=FContracts.Count;
end;

destructor TCM4ContractList.Destroy;
begin
  Clear;
  FContracts.Free;
  inherited;
end;

function TCM4ContractList.GetContract(Index: Integer): TCM4Contract;
begin
  if (Index >= 0) and (Index < Count) then
    Result:=FContracts[Index]
  else
    Result:=nil;
end;

procedure TCM4ContractList.Load(DataFile: TCM4FileStream);
var
  ContractCount: Byte;
  j: Integer;
  ContractType: Byte;
  NewContract: TCM4Contract; 
begin
  DataFile.Read(ContractCount, 1);
  for j:=0 to ContractCount - 1 do
  begin
    DataFile.Read(ContractType, 1);
    NewContract:=GetContractObject(ContractType);
    NewContract.Load(DataFile);
    FContracts.Add(NewContract);
  end;
end;

procedure TCM4ContractList.ConvertIndexes(Clubs, Nations,
  Teams: TCM4DatabaseContainer);
var
  j: Integer;
begin
  for j:=0 to Count - 1 do
    Contract[j].ConvertIndexes(Clubs, Nations, Teams);
end;

function TCM4ContractList.GetClubContract: TCM4Contract;
var
  j: Integer;
begin
  Result:=nil;
  for j:=0 to Count - 1 do
    if Contract[j].FTeamContainerType = TC_CLUB then
    begin
      Result:=Contract[j];
      Break;
    end;
end;

function TCM4ContractList.GetFullContract: TCM4FullContract;
var
  j: Integer;
begin
  Result:=nil;
  for j:=0 to Count - 1 do
    if (Contract[j] is TCM4FullContract) and (Contract[j].TeamContainerType = TC_CLUB) then
    begin
      Result:=TCM4FullContract(Contract[j]);
      Break;
    end;
end;

{ TCM4Person }

constructor TCM4Person.Create;
begin
  FDateOfBirth:=TCM4Date.Create;
  FNationalJoinDate:=TCM4Date.Create;
  FClubJoinDate:=TCM4Date.Create;
  FContracts:=TCM4ContractList.Create;
  FAdditionalNations:=TCM4NationList.Create;
end;

destructor TCM4Person.Destroy;
begin
  FDateOfBirth.Free;
  FNationalJoinDate.Free;
  FClubJoinDate.Free;
  FContracts.Free;
  FAdditionalNations.Free;
  inherited;
end;

procedure TCM4Person.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
var
  HasPreferences: Boolean;
  OfferCount, ContractType: Byte;
  j: Integer;
  Contract: TCM4Contract;
  RelCount: Byte;
  RecType: Byte;
  RelType: Byte;
  AdNation: Pointer; 
begin
  DataFile.Read(FFirstName, 4);
  DataFile.Read(FSecondName, 4);
  DataFile.Read(FCommonName, 4);
  FDateOfBirth.Load(DataFile);
  DataFile.Read(FNation, 4);
  DataFile.Read(FInternationalApps, 1);
  DataFile.Read(FInternationalGoals, 1);
  DataFile.Read(FNationalTeam, 4);
  DataFile.Read(FNationalJob, 1);
  FNationalJoinDate.Load(DataFile);
  DataFile.Read(FClubTeam, 4);
  DataFile.Read(FClubJob, 1);
  FClubJoinDate.Load(DataFile);
  // Skip Speaks Current Language
  DataFile.Skip(1);
  DataFile.Read(FPersonData, 4);
  // Skip City of Birth
  DataFile.Skip(4);
  // Skip Transfer Offers
  DataFile.SkipByteArray(4);
  // Skip Contract Offer Decision Date Unique ID,
  // Person History Index
  DataFile.Skip(8);
  FContracts.Load(DataFile);

  // Skip Contract Offers
  DataFile.Read(OfferCount, 1);
  for j:=0 to OfferCount - 1 do
  begin
    DataFile.Read(ContractType, 1);
    // Skip Decision, Work Permit State and
    // Transfer Offer Index
    DataFile.Skip(6);
    Contract:=GetContractObject(ContractType);
    Contract.Load(DataFile);
    Contract.Free;
  end;

  // Skip Preferences
  DataFile.Read(HasPreferences, 1);
  if HasPreferences then
  begin
    DataFile.Read(RelCount, 1);
    for j:=0 to RelCount - 1 do
    begin
      DataFile.Read(RecType, 1);
      if RecType = 2 then
      begin
        DataFile.Read(RelType, 1);
        if RelType = 9 then
        begin
          DataFile.Skip(2);
          DataFile.Read(AdNation, 4);
          FAdditionalNations.Add(AdNation);
        end
        else
          DataFile.Skip(6);
      end
      else
        DataFile.Skip(7);
    end;
  end;

  // Skip Interested Clubs
  DataFile.SkipWordArray(4);

  // Skip Person Flags
  DataFile.Skip(1);
  inherited;
end;

function TCM4Person._AddRef: Integer;
begin
  Result:=0;
end;

function TCM4Person._Release: Integer;
begin
  Result:=0;
end;

function TCM4Person.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

procedure TCM4Person.ConvertIndexes(FirstNames, SecondNames, CommonNames,
  Nations, Teams, PersonData, Clubs, NonPlayingData,
  PlayingData: TCM4DatabaseContainer);
begin
  FFirstName:=TCM4Name(FirstNames.Entity[Integer(FFirstName)]);
  FSecondName:=TCM4Name(SecondNames.Entity[Integer(FSecondName)]);
  FCommonName:=TCM4Name(CommonNames.Entity[Integer(FCommonName)]);
  FNation:=TCM4Nation(Nations.Entity[Integer(FNation)]);
  FNationalTeam:=TCM4NationalTeam(Teams.Entity[Integer(FNationalTeam)]);
  FClubTeam:=TCM4Team(Teams.Entity[Integer(FClubTeam)]);
  FPersonData:=TCM4PersonData(PersonData.Entity[Integer(FPersonData)]);
  FContracts.ConvertIndexes(Clubs, Nations, Teams);
  FAdditionalNations.ConvertIndexes(Nations);
end;

function TCM4Person.GetListName: WideString;
begin
  if FCommonName <> nil then
    Result:=FCommonName.Name
  else
  begin
    if FSecondName <> nil then
      Result:=FSecondName.Name;

    if FFirstName <> nil then
    begin
      if Result = '' then
        Result:=FFirstName.Name
      else
        Result:=Result + ', ' + FFirstName.Name;
    end;
  end;
end;

function TCM4Person.GetFullName: WideString;
begin
  if FFirstName <> nil then
    Result:=FFirstName.Name + ' ';
  if FSecondName <> nil then
    Result:=Result + FSecondName.Name;
end;

function TCM4Person.GetNations: WideString;
var
  j: Integer;
begin
  if FNation <> nil then
    Result:=FNation.ShortName
  else
    Result:='';

  for j:=0 to FAdditionalNations.Count - 1 do
  begin
    if Result <> '' then
      Result:=Result + ' / ' + FAdditionalNations[j].ShortName
    else
      Result:=FAdditionalNations[j].ShortName;
  end;
end;

function TCM4Person.GetClubName: WideString;
begin
  if FClubTeam <> nil then
    if FClubTeam.TeamContainer <> nil then
      Result:=FClubTeam.TeamContainer.ShortName;
end;

function TCM4Person.GetEUMember: Boolean;
var
  j: Integer;
begin
  Result:=False;

  if FNation <> nil then
    if FNation.EUMember then
      Result:=True;

  for j:=0 to FAdditionalNations.Count - 1 do
    if FAdditionalNations[j].EUMember then
      Result:=True;
end;

function TCM4Person.GetBased: TCM4Nation;
begin
  Result:=nil;
  
  if FClubTeam <> nil then
  begin
    if FClubTeam.TeamContainer.TeamType = TC_CLUB then
      if TCM4Club(FClubTeam.TeamContainer).Nation <> nil then
        Result:=TCM4Club(FClubTeam.TeamContainer).Nation;
  end
  else
    if FNation <> nil then
      Result:=FNation;
end;

function TCM4Person.GetBasedName: WideString;
begin
  if Based <> nil then
    Result:=Based.ShortName;
end;

function TCM4Person.GetDivision: TCM4Competition;
begin
  Result:=nil;
  if FClubTeam <> nil then
    if FClubTeam.Division <> nil then
      Result:=FClubTeam.Division;
end;

function TCM4Person.GetDivisionName: WideString;
begin
  if Division <> nil then
    Result:=Division.ShortName;
end;

function TCM4Person.GetSquadName: WideString;
begin
  if FClubTeam <> nil then
    Result:=FClubTeam.SquadName;
end;

function TCM4Person.GetContractType: WideString;
begin
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.ContractType
  else if FContracts.ClubContract <> nil then
    Result:=FContracts.ClubContract.ContractType;
end;

function TCM4Person.GetLeavingOnBosman: Boolean;
begin
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.LeavingOnBosman
  else
    Result:=False;
end;

function TCM4Person.GetSquadStatus: WideString;
begin
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.SquadStatusText
  else if FContracts.ClubContract <> nil then
    Result:=FContracts.ClubContract.SquadStatusText;
end;

function TCM4Person.GetPerceivedSquadStatus: WideString;
begin
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.PerceivedSquadStatus
  else if FContracts.ClubContract <> nil then
    Result:=FContracts.ClubContract.PerceivedSquadStatus;
end;

function TCM4Person.GetTransferStatus: WideString;
begin
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.TransferStatusText;
end;

function TCM4Person.GetContractEnds: TDateTime;
begin
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.EndDate.Date
  else
    Result:=EncodeDate(1900, 1, 1);
end;

function TCM4Person.GetJoinedClub: TDateTime;
begin
  Result:=FClubJoinDate.Date;
end;

function TCM4Person.GetSquadReputation: Word;
begin
  if FClubTeam <> nil then
    Result:=FClubTeam.Reputation
  else
    Result:=0;
end;

function TCM4Person.GetWage: Integer;
begin
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.Wage
  else
    Result:=0;
end;

function TCM4Person.GetMinimumFeeClause: TCM4ContractClause;
var
  j: Integer;
begin
  Result:=nil;

  if FContracts.FullContract <> nil then
    for j:=0 to FContracts.FullContract.Clauses.Count - 1 do
      if FContracts.FullContract.Clauses[j].ClauseType = 0 then
        Result:=FContracts.FullContract.Clauses[j];
end;

function TCM4Person.GetMinimumFee: Integer;
begin
  if MinimumFeeClause <> nil then
    Result:=MinimumFeeClause.ReleaseFee
  else
    Result:=0;
end;

function TCM4Person.GetNonPromotionClause: TCM4ContractClause;
var
  j: Integer;
begin
  Result:=nil;

  if FContracts.FullContract <> nil then
    for j:=0 to FContracts.FullContract.Clauses.Count - 1 do
      if (FContracts.FullContract.Clauses[j].ClauseType = 2) or (FContracts.FullContract.Clauses[j].ClauseType = 10) then
        Result:=FContracts.FullContract.Clauses[j];
end;

function TCM4Person.GetNonPromotionFee: Integer;
begin
  if NonPromotionClause <> nil then
    Result:=NonPromotionClause.ReleaseFee
  else
    Result:=0;
end;

function TCM4Person.GetRelegationClause: TCM4ContractClause;
var
  j: Integer;
begin
  Result:=nil;

  if FContracts.FullContract <> nil then
    for j:=0 to FContracts.FullContract.Clauses.Count - 1 do
      if (FContracts.FullContract.Clauses[j].ClauseType = 1) or (FContracts.FullContract.Clauses[j].ClauseType = 9) then
        Result:=FContracts.FullContract.Clauses[j];
end;

function TCM4Person.GetRelegationFee: Integer;
begin
  if RelegationClause <> nil then
    Result:=RelegationClause.ReleaseFee
  else
    Result:=0;
end;

function TCM4Person.GetHappinessLevel: ShortInt;
begin
  Result:=0;
  if FContracts.FullContract <> nil then
    Result:=FContracts.FullContract.HappinessLevel
  else if FContracts.ClubContract <> nil then
    Result:=FContracts.ClubContract.HappinessLevel;
end;

function TCM4Person.FromNation(ANation: TCM4Nation): Boolean;
var
  j: Integer;
begin
  Result:=Nation = ANation;

  if not Result then
  begin
    for j:=0 to FAdditionalNations.Count - 1 do
      if FAdditionalNations[j] = ANation then
        Result:=True;
  end;
end;

function TCM4Person.GetName: WideString;
begin
  if FCommonName <> nil then
    Result:=FCommonName.Name
  else
  begin
    if FFirstName <> nil then
      Result:=FFirstName.Name;

    if FSecondName <> nil then
    begin
      if Result = '' then
        Result:=FSecondName.Name
      else
        Result:=Result + ' ' + FSecondName.Name;
    end;
  end;
end;

function TCM4Person.GetClubContract: TCM4Contract;
var
  j: Integer;
begin
  Result:=nil;

  if FClubTeam <> nil then
  begin
    for j:=0 to FContracts.Count - 1 do
      if FContracts[j].TeamContainer = FClubTeam.TeamContainer then
        Result:=FContracts[j];
  end;
end;

{ TCM4NonPlayerData }

procedure TCM4NonPlayerData.ConvertIndexes(
  NonPlayingData: TCM4DatabaseContainer);
begin
  FNonPlayingData:=TCM4NonPlayingData(NonPlayingData.Entity[Integer(FNonPlayingData)]);
end;

procedure TCM4NonPlayerData.Load(DataFile: TCM4FileStream);
begin
  DataFile.Read(FHomeReputation, 2);
  DataFile.Read(FCurrentReputation, 2);
  DataFile.Read(FWorldReputation, 2);
  DataFile.Read(FCurrentAbility, 2);
  DataFile.Read(FPotentialAbility, 2);
  DataFile.Read(FPreferredFormation, 1);
  DataFile.Read(FNonPlayingData, 4);
end;

{ TCM4NonPlayer }

procedure TCM4NonPlayer.ConvertIndexes(FirstNames, SecondNames,
  CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData,
  PlayingData: TCM4DatabaseContainer);
begin
  FNonPlayerData.ConvertIndexes(NonPlayingData);
  inherited;
end;

constructor TCM4NonPlayer.Create;
begin
  inherited;
  FNonPlayerData:=TCM4NonPlayerData.Create;
end;

destructor TCM4NonPlayer.Destroy;
begin
  FNonPlayerData.Free;
  inherited;
end;

function TCM4NonPlayer.GetNonPlayerData: TCM4NonPlayerData;
begin
  Result:=FNonPlayerData;
end;

procedure TCM4NonPlayer.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  FNonPlayerData.Load(DataFile);
  inherited;
end;

{ TCM4PlayerData }

procedure TCM4PlayerData.Load(DataFile: TCM4FileStream);
var
  HasCareerStats: Boolean;
  HasExtraPlayingData: Boolean;
  HasInjuryStatus: Boolean;
  BanCount: Byte;
  j: Integer;
  HasFixture: Boolean;
  BookingCountCount: Byte;
  BookingCountType: ShortInt;
begin
  DataFile.Read(FHomeReputation, 2);
  DataFile.Read(FCurrentReputation, 2);
  DataFile.Read(FWorldReputation, 2);
  DataFile.Read(FCurrentAbility, 2);
  DataFile.Read(FPotentialAbility, 2);
  DataFile.Read(FPlayingData, 4);
  // Skip Playing History ID
  DataFile.Skip(4);
  DataFile.Read(FDisplayValue, 4);
  // Skip Morale, Nation Choice Factor, Fitness, Jadedness,
  // Condition, Number Clubs Shortlisted By,
  // Nation Games Mask, Last National Game Index,
  // National Games When Joined Club, Declared For Nation,
  // Weight, Height, Ability Offset
  DataFile.Skip(20);
  DataFile.Read(FSaleValue, 4);

  // Skip Career Stats
  DataFile.Read(HasCareerStats, 1);
  if HasCareerStats then
    DataFile.Skip(16);

  // Skip Starting Club ID
  DataFile.Skip(4);

  // Skip Extra Playing Data
  DataFile.Read(HasExtraPlayingData, 1);
  if HasExtraPlayingData then
  begin
    // Skip Player Injuries
    SkipPlayerInjuries(DataFile);

    // Skip Bans
    DataFile.Read(BanCount, 1);
    for j:=0 to BanCount - 1 do
    begin
      DataFile.Skip(18);
      DataFile.Read(HasFixture, 1);
      if HasFixture then
        DataFile.Skip(39);
    end;

    // Skip InjuryStatus
    DataFile.Read(HasInjuryStatus, 1);
    if HasInjuryStatus then
      DataFile.Skip(26);
  end;

  // Skip Booking Counts
  DataFile.Read(BookingCountCount, 1);
  for j:=0 to BookingCountCount - 1 do
  begin
    DataFile.Read(BookingCountType, 1);
    SkipBookingCount(DataFile, BookingCountType);
  end;

  // Skip Training Info and Awol
  DataFile.Skip(38);
end;

procedure TCM4PlayerData.SkipPlayerInjuries(DataFile: TCM4FileStream);
var
  InjuryCount: Byte;
  j: Integer;
  FixtType: ShortInt;
begin
  DataFile.Read(InjuryCount, 1);
  for j:=0 to InjuryCount - 1 do
  begin
    DataFile.Skip(4);

    DataFile.Skip(6);
    DataFile.Read(FixtType, 1);
    case FixtType of
      0:
        DataFile.Skip(1);
      1:
        DataFile.Skip(3);
      3, 5:
        DataFile.Skip(5);
      7:
        DataFile.Skip(7);
      else
        raise EFileCorruptError.Create('Player Injury data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Injury Fixture Type: ' + IntToStr(FixtType));
    end;
    DataFile.Skip(16);

    DataFile.Skip(9);
  end;
end;

procedure TCM4PlayerData.SkipBookingCount(DataFile: TCM4FileStream;
  BookingCountType: ShortInt);
begin
  case BookingCountType of
    BC_TYPE_BASE:
      DataFile.Skip(3);
    BC_TYPE_POINTS, BC_TYPE_LAST_TEN_GAMES:
      DataFile.Skip(5);
    BC_TYPE_LAST_THREE_SEASONS:
      DataFile.Skip(8);
    BC_TYPE_LAST_FIVE_GAMES:
      DataFile.Skip(4);
  else
    if BookingCountType <> BC_TYPE_LAST_TEN_GAMES then
      raise EFileCorruptError.Create('Booking Count data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Booking Count Type: ' + IntToStr(BookingCountType));
  end;
end;

procedure TCM4PlayerData.ConvertIndexes(PlayingData: TCM4DatabaseContainer);
begin
  FPlayingData:=TCM4PlayingData(PlayingData.Entity[Integer(FPlayingData)]);
  FPlayingData.ConvertRelativeAbilities(CurrentAbility);
end;

function TCM4PlayerData.GetPosition: WideString;
begin
  Result:=FPlayingData.Position;
end;

function TCM4PlayerData.GetLongPosition: WideString;
begin
  Result:=FPlayingData.LongPosition;
end;

{ TCM4Player }

procedure TCM4Player.ConvertIndexes(FirstNames, SecondNames, CommonNames,
  Nations, Teams, PersonData, Clubs, NonPlayingData,
  PlayingData: TCM4DatabaseContainer);
begin
  FPlayerData.ConvertIndexes(PlayingData);
  inherited;
end;

constructor TCM4Player.Create;
begin
  inherited;
  FPlayerData:=TCM4PlayerData.Create;
  FPlayerScoutRating:=TCM4PlayerScoutRating.Create;
end;

destructor TCM4Player.Destroy;
begin
  FPlayerScoutRating.Free;
  FPlayerData.Free;
  inherited;
end;

function TCM4Player.GetLongPosition: WideString;
begin
  Result:=GetPlayerData.LongPosition;
end;

function TCM4Player.GetPlayerData: TCM4PlayerData;
begin
  Result:=FPlayerData;
end;

function TCM4Player.GetPosition: WideString;
begin
  Result:=GetPlayerData.Position;
end;

function TCM4Player.GetScoutRating: TCM4PlayerScoutRating;
begin
  Result:=FPlayerScoutRating;
end;

procedure TCM4Player.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  FPlayerData.Load(DataFile);
  inherited;
end;

{ TCM4PlayerNonPlayer }

procedure TCM4PlayerNonPlayer.ConvertIndexes(FirstNames, SecondNames,
  CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData,
  PlayingData: TCM4DatabaseContainer);
begin
  FPlayerData.ConvertIndexes(PlayingData);
  FNonPlayerData.ConvertIndexes(NonPlayingData);
  inherited;
end;

constructor TCM4PlayerNonPlayer.Create;
begin
  inherited;
  FPlayerData:=TCM4PlayerData.Create;
  FNonPlayerData:=TCM4NonPlayerData.Create;
  FPlayerScoutRating:=TCM4PlayerScoutRating.Create;
end;

destructor TCM4PlayerNonPlayer.Destroy;
begin
  FPlayerScoutRating.Free;
  FPlayerData.Free;
  FNonPlayerData.Free;
  inherited;
end;

function TCM4PlayerNonPlayer.GetLongPosition: WideString;
begin
  Result:=GetPlayerData.LongPosition;
end;

function TCM4PlayerNonPlayer.GetNonPlayerData: TCM4NonPlayerData;
begin
  Result:=FNonPlayerData;
end;

function TCM4PlayerNonPlayer.GetPlayerData: TCM4PlayerData;
begin
  Result:=FPlayerData;
end;

function TCM4PlayerNonPlayer.GetPosition: WideString;
begin
  Result:=GetPlayerData.Position;
end;

function TCM4PlayerNonPlayer.GetScoutRating: TCM4PlayerScoutRating;
begin
  Result:=FPlayerScoutRating;
end;

procedure TCM4PlayerNonPlayer.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  FPlayerData.Load(DataFile);
  FNonPlayerData.Load(DataFile);
  inherited;
end;

{ TCM4Official }

procedure TCM4Official.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip Official Data
  DataFile.Skip(24);
  inherited;
end;

{ TCM4RetiredPerson }

procedure TCM4RetiredPerson.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip Retired Person Data
  DataFile.SkipWideString;
  DataFile.SkipWideString;
  DataFile.Skip(2); 
  inherited;
end;

{ TCM4VirtualNonPlayer }

procedure TCM4VirtualNonPlayer.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip Virtual Non Player Data
  DataFile.Skip(1);
  inherited;
end;

{ TCM4VirtualPlayer }

procedure TCM4VirtualPlayer.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  // Skip Virtual Player Data
  DataFile.Skip(6);
  inherited;
end;

{ TCM4HumanNonPlayer }

procedure TCM4HumanNonPlayer.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
var
  FilterListCount, j: Integer;
begin
  // Skip TCP/IP Handle, On Holiday, Holiday Flags,
  // Number Unread News, Fog Of War Index,
  // Current Person Search Index
  DataFile.Skip(12);
  // Skip Password
  DataFile.SkipWideString;
  // Skip Club Options, Nation Options, Match Highlight Type,
  // Match Playback Speed
  DataFile.Skip(67);
  // Skip Viewed Fixtures
  DataFile.SkipByteArray(8);
  // Skip Preferred Player Array
  DataFile.Skip(96);

  // Skip Filter Lists
  DataFile.Read(FilterListCount, 4);
  for j:=0 to FilterListCount - 1 do
    SkipFilterList(DataFile);
  if DBVersion >= 115 then
    DataFile.Skip(4);

  // Skip Initialised
  DataFile.Skip(1);
  
  inherited;
end;

procedure TCM4HumanNonPlayer.SkipFilterList(DataFile: TCM4FileStream);
var
  FilterListType: array[0..7] of Char;
  FilterType: array[0..7] of Char;
  FilterInfoType: array[0..3] of Char;
  FilterCount, FilterInfoCount: Integer;
  j, s: Integer;
begin
  DataFile.Read(FilterListType, 8);

  if (FilterListType = 'slfttslf') or (FilterListType = 'tslttslf') then
  begin
    DataFile.Read(FilterCount, 4);
    for j:=0 to FilterCount - 1 do
    begin
      DataFile.Read(FilterType, 8);
      if FilterType = 'daqstlif' then
      begin
        DataFile.SkipWideString;
        DataFile.Skip(5);
        DataFile.Read(FilterInfoCount, 4);
        for s:=0 to FilterInfoCount - 1 do
        begin
          DataFile.Read(FilterInfoType, 4);
          if FilterInfoType = 'rfqs' then
            DataFile.Skip(10)
          else if FilterInfoType = 'rfsp' then
            DataFile.Skip(2)
          else if FilterInfoType = 'rfpv' then
            DataFile.Skip(3)
          else
            raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Info Type: ' + FilterInfoType);
        end;
      end
      else
        raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Type: ' + FilterType);
    end;

    if FilterListType <> 'tslttslf' then
      DataFile.Skip(10);
  end
  else if FilterListType = 'tslntslf' then
  begin
    DataFile.Read(FilterCount, 4);
    for j:=0 to FilterCount - 1 do
    begin
      DataFile.Read(FilterType, 8);
      if FilterType = 'swentlif' then
      begin
        DataFile.SkipWideString;
        DataFile.Skip(5);
        DataFile.Read(FilterInfoCount, 4);
        for s:=0 to FilterInfoCount - 1 do
        begin
          DataFile.Read(FilterInfoType, 4);
          if FilterInfoType = 'rfsn' then
            DataFile.Skip(1)
          else if FilterInfoType = 'rfcn' then
            DataFile.Skip(2)
          else
            raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Info Type: ' + FilterInfoType);
        end;
      end
      else
        raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Type: ' + FilterType);
    end;

    DataFile.Skip(4);
  end
  else if FilterListType = 'ltontslf' then
  begin
    DataFile.Read(FilterCount, 4);
    for j:=0 to FilterCount - 1 do
    begin
      DataFile.Read(FilterType, 8);
      if FilterType = 'etontlif' then
      begin
        DataFile.SkipWideString;
        DataFile.Skip(5);
        DataFile.Read(FilterInfoCount, 4);
        for s:=0 to FilterInfoCount - 1 do
        begin
          DataFile.Read(FilterInfoType, 4);
          if FilterInfoType = 'rftn' then
            DataFile.Skip(9)
          else
            raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Info Type: ' + FilterInfoType);
        end;
      end
      else
        raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Type: ' + FilterType);
    end;
  end
  else if FilterListType = 'tslhtslf' then
  begin
    DataFile.Read(FilterCount, 4);
    for j:=0 to FilterCount - 1 do
    begin
      DataFile.Read(FilterType, 8);
      if FilterType = 'ntantlif' then
      begin
        DataFile.SkipWideString;
        DataFile.Skip(5);
        DataFile.Read(FilterInfoCount, 4);
        for s:=0 to FilterInfoCount - 1 do
        begin
          DataFile.Read(FilterInfoType, 4);
          if FilterInfoType = 'rftn' then
          begin
            DataFile.Skip(2);
            DataFile.SkipIntArray(8);
            DataFile.Skip(8);
          end
          else
            raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Info Type: ' + FilterInfoType);
        end;
      end
      else
        raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter Type: ' + FilterType);
    end;
  end
  else
    raise EFileCorruptError.Create('Human Non Player data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Filter List Type: ' + FilterListType);
end;


{ TCM4PersonContainer }

procedure TCM4PersonContainer.Clear;
begin
  inherited;
  FPlayers.Clear;
end;

procedure TCM4PersonContainer.ConvertIndexes(FirstNames, SecondNames,
  CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData,
  PlayingData: TCM4DatabaseContainer);
var
  j: Integer;
begin
  TriggerStatus('Converting People Indexes');
  for j:=0 to Count - 1 do
  begin
    if Entity[j] is TCM4Person then
      Person[j].ConvertIndexes(FirstNames, SecondNames, CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData, PlayingData);

    if Supports(Person[j], ICM4Player) then
    begin
      FPlayers.Add(Person[j]);
      (Person[j] as ICM4Player).ScoutRating.Calculate(Person[j].PersonData, (Person[j] as ICM4Player).PlayerData);
    end;
      
    TriggerProgress(j, Count);
  end;
end;

constructor TCM4PersonContainer.Create;
begin
  inherited;
  FPlayers:=TCM4PersonList.Create;
end;

function TCM4PersonContainer.GetPerson(Index: Integer): TCM4Person;
begin
  Result:=TCM4Person(Entity[Index]);
end;

function TCM4PersonContainer.NewEntity(
  RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_NON_PLAYER then
    Result:=TCM4NonPlayer.Create
  else if RecordType = RT_PLAYER then
    Result:=TCM4Player.Create
  else if RecordType = RT_PLAYER_NON_PLAYER then
    Result:=TCM4PlayerNonPlayer.Create
  else if RecordType = RT_OFFICIAL then
    Result:=TCM4Official.Create
  else if RecordType = RT_RETIRED_PERSON then
    Result:=TCM4RetiredPerson.Create
  else if RecordType = RT_VIRTUAL_NON_PLAYER then
    Result:=TCM4VirtualNonPlayer.Create
  else if RecordType = RT_VIRTUAL_PLAYER then
    Result:=TCM4VirtualPlayer.Create
  else if RecordType = RT_YOUTH_PLAYER then
    Result:=TCM4YouthPlayer.Create
  else if RecordType = RT_HUMAN_NON_PLAYER then
    Result:=TCM4HumanNonPlayer.Create
  else
    raise EFileCorruptError.Create('Person data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4PersonList }

function TCM4PersonList.GetPerson(Index: Integer): TCM4Person;
begin
  Result:=Item[Index];
end;

{ TCM4PersonData }

procedure TCM4PersonData.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  DataFile.Read(FAdaptability, 1);
  DataFile.Read(FAmbition, 1);
  DataFile.Read(FLoyality, 1);
  DataFile.Read(FPressure, 1);
  DataFile.Read(FProfessionalism, 1);
  DataFile.Read(FSportsmanship, 1);
  DataFile.Read(FTemperament, 1);
  DataFile.Read(FControversy, 1);

  inherited;
end;

{ TCM4PersonDataContainer }

function TCM4PersonDataContainer.NewEntity(
  RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_STANDARD then
    Result:=TCM4PersonData.Create
  else
    raise EFileCorruptError.Create('Person Data data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4PlayingData }

procedure TCM4PlayingData.ConvertRelativeAbilities(Ability: SmallInt);
begin
  if Goalkeeper < POSITION_THRESHOLD then
  begin
    FCrossing:=HighConvert(Ability, Crossing);
    FDribbling:=HighConvert(Ability, Dribbling);
    FFinishing:=HighConvert(Ability, Finishing);
    FHeading:=HighConvert(Ability, Heading);
    FLongShots:=HighConvert(Ability, LongShots);
    FMarking:=HighConvert(Ability, Marking);
    FOffTheBall:=HighConvert(Ability, OffTheBall);
    FPassing:=HighConvert(Ability, Passing);
    FPenalties:=HighConvert(Ability, Penalties);
    FTackling:=HighConvert(Ability, Tackling);
    FCreativity:=HighConvert(Ability, Creativity);

    FHandling:=LowConvert(Ability, Handling);
    FAerialAbility:=LowConvert(Ability, AerialAbility);
    FCommandOfArea:=LowConvert(Ability, CommandOfArea);
    FCommunication:=LowConvert(Ability, Communication);
    FKicking:=LowConvert(Ability, Kicking);
    FThrowing:=LowConvert(Ability, Throwing);
  end
  else
  begin
    FCrossing:=LowConvert(Ability, Crossing);
    FDribbling:=LowConvert(Ability, Dribbling);
    FFinishing:=LowConvert(Ability, Finishing);
    FHeading:=LowConvert(Ability, Heading);
    FLongShots:=LowConvert(Ability, LongShots);
    FMarking:=LowConvert(Ability, Marking);
    FOffTheBall:=LowConvert(Ability, OffTheBall);
    FPassing:=LowConvert(Ability, Passing);
    FPenalties:=LowConvert(Ability, Penalties);
    FTackling:=LowConvert(Ability, Tackling);
    FCreativity:=LowConvert(Ability, Creativity);

    FHandling:=HighConvert(Ability, Handling);
    FAerialAbility:=HighConvert(Ability, AerialAbility);
    FCommandOfArea:=HighConvert(Ability, CommandOfArea);
    FCommunication:=HighConvert(Ability, Communication);
    FKicking:=HighConvert(Ability, Kicking);
    FThrowing:=HighConvert(Ability, Throwing);
  end;

  FAnticipation:=HighConvert(Ability, Anticipation);
  FDecisions:=HighConvert(Ability, Decisions);
  FOneOnOnes:=HighConvert(Ability, OneOnOnes);
  FPositioning:=HighConvert(Ability, Positioning);
  FReflexes:=HighConvert(Ability, Reflexes);
  FThrowIns:=HighConvert(Ability, ThrowIns);
  FFirstTouch:=HighConvert(Ability, FirstTouch);
  FTechnique:=HighConvert(Ability, Technique);
end;

function TCM4PlayingData.GetLongPosition: WideString;
var
  Side: WideString;
  Pos: WideString;
begin
  if FLongPosition = '' then
  begin
    if RightSide >= POSITION_THRESHOLD then
      Side:='Right';
    if LeftSide >= POSITION_THRESHOLD then
      if Side <> '' then
        Side:=Side + '/Left'
      else
        Side:=Side + 'Left';
    if Central >= POSITION_THRESHOLD then
      if Side <> '' then
        Side:=Side + '/Centre'
      else
        Side:=Side + 'Centre';

    if Goalkeeper >= POSITION_THRESHOLD then
      Pos:='Goalkeeper'
    else
    begin
      if Sweeper >= POSITION_THRESHOLD then
        Pos:='Sweeper';
      if Defender >= POSITION_THRESHOLD then
        if Pos <> '' then
          Pos:=Pos + '/Defender'
        else
          Pos:='Defender';
      if DefensiveMidfielder >= POSITION_THRESHOLD then
        if Pos <> '' then
          Pos:=Pos + '/Defensive Midfielder'
        else
          Pos:='Defensive Midfielder';
      if (Midfielder >= POSITION_THRESHOLD) and (DefensiveMidfielder < POSITION_THRESHOLD) and (AttackingMidfielder < POSITION_THRESHOLD) then
        if Pos <> '' then
          Pos:=Pos + '/Midfielder'
        else
          Pos:='Midfielder';
      if (AttackingMidfielder >= POSITION_THRESHOLD) and (DefensiveMidfielder < POSITION_THRESHOLD) and ((Attacker < POSITION_THRESHOLD) or ((Attacker >= POSITION_THRESHOLD) and (Midfielder >= POSITION_THRESHOLD))) then
        if Pos <> '' then
          Pos:=Pos + '/Attacking Midfielder'
        else
          Pos:='Attacking Midfielder';
      if Attacker >= POSITION_THRESHOLD then
        if (LeftSide >= POSITION_THRESHOLD) or (RightSide >= POSITION_THRESHOLD) or (FreeRole >= POSITION_THRESHOLD) or (AttackingMidfielder >= POSITION_THRESHOLD) then
        begin
          if Pos <> '' then
            Pos:=Pos + '/Forward'
          else
            Pos:='Forward';
        end
        else
        begin
          if Pos <> '' then
            Pos:=Pos + '/Striker'
          else
            Pos:='Striker';
        end;
    end;

    FLongPosition:=Pos;
    if Side <> '' then
      FLongPosition:=FLongPosition + ' (' + Side + ')';
  end;

  Result:=FLongPosition;
end;

function TCM4PlayingData.GetPosition: WideString;
var
  Side: WideString;
  Pos: WideString;
begin
  if FPosition = '' then
  begin
    if RightSide >= POSITION_THRESHOLD then
      Side:='R';
    if LeftSide >= POSITION_THRESHOLD then
      Side:=Side + 'L';
    if Central >= POSITION_THRESHOLD then
      Side:=Side + 'C';

    if Goalkeeper >= POSITION_THRESHOLD then
      Pos:='GK'
    else
    begin
      if Sweeper >= POSITION_THRESHOLD then
        Pos:='SW';
      if Defender >= POSITION_THRESHOLD then
        if Pos <> '' then
          Pos:=Pos + '/D'
        else
          Pos:='D';
      if DefensiveMidfielder >= POSITION_THRESHOLD then
        if Pos <> '' then
          Pos:=Pos + '/DM'
        else
          Pos:='DM';
      if (Midfielder >= POSITION_THRESHOLD) and (DefensiveMidfielder < POSITION_THRESHOLD) and (AttackingMidfielder < POSITION_THRESHOLD) then
        if Pos <> '' then
          Pos:=Pos + '/M'
        else
          Pos:='M';
      if (AttackingMidfielder >= POSITION_THRESHOLD) and (DefensiveMidfielder < POSITION_THRESHOLD) and ((Attacker < POSITION_THRESHOLD) or ((Attacker >= POSITION_THRESHOLD) and (Midfielder >= POSITION_THRESHOLD))) then
        if Pos <> '' then
          Pos:=Pos + '/AM'
        else
          Pos:='AM';
      if Attacker >= POSITION_THRESHOLD then
        if (LeftSide >= POSITION_THRESHOLD) or (RightSide >= POSITION_THRESHOLD) or (FreeRole >= POSITION_THRESHOLD) or (AttackingMidfielder >= POSITION_THRESHOLD) then
        begin
          if Pos <> '' then
            Pos:=Pos + '/F'
          else
            Pos:='F';
        end
        else
        begin
          if Pos <> '' then
            Pos:=Pos + '/S'
          else
            Pos:='S';
        end;
    end;

    FPosition:=Pos + ' ' + Side;
  end;

  Result:=FPosition;
end;

function TCM4PlayingData.HighConvert(Ability: SmallInt;
  Value: ShortInt): ShortInt;
var
  Temp: Double;
begin
  Temp:=(((Value * 2) + Ability) * 0.05) + 10;
  Temp:=((((Temp * Temp) * 0.1) + Temp) * (1/3)) + 0.5;

  if Temp < 1 then
    Result:=1
  else if Temp > 20 then
    Result:=20
  else
    Result:=Trunc(Temp);
end;

procedure TCM4PlayingData.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  DataFile.Read(FGoalkeeper, 1);
  DataFile.Read(FSweeper, 1);
  DataFile.Read(FDefender, 1);
  DataFile.Read(FDefensiveMidfielder, 1);
  DataFile.Read(FMidfielder, 1);
  DataFile.Read(FAttackingMidfielder, 1);
  DataFile.Read(FAttacker, 1);
  DataFile.Read(FWingBack, 1);
  DataFile.Read(FFreeRole, 1);
  DataFile.Read(FRightSide, 1);
  DataFile.Read(FLeftSide, 1);
  DataFile.Read(FCentral, 1);
  DataFile.Read(FCrossing, 1);
  DataFile.Read(FDribbling, 1);
  DataFile.Read(FFinishing, 1);
  DataFile.Read(FHeading, 1);
  DataFile.Read(FLongShots, 1);
  DataFile.Read(FMarking, 1);
  DataFile.Read(FOffTheBall, 1);
  DataFile.Read(FPassing, 1);
  DataFile.Read(FPenalties, 1);
  DataFile.Read(FTackling, 1);
  DataFile.Read(FCreativity, 1);
  DataFile.Read(FHandling, 1);
  DataFile.Read(FAerialAbility, 1);
  DataFile.Read(FCommandOfArea, 1);
  DataFile.Read(FCommunication, 1);
  DataFile.Read(FKicking, 1);
  DataFile.Read(FThrowing, 1);
  DataFile.Read(FAnticipation, 1);
  DataFile.Read(FDecisions, 1);
  DataFile.Read(FOneOnOnes, 1);
  DataFile.Read(FPositioning, 1);
  DataFile.Read(FReflexes, 1);
  DataFile.Read(FThrowIns, 1);
  DataFile.Read(FFirstTouch, 1);
  DataFile.Read(FTechnique, 1);
  DataFile.Read(FLeftFoot, 1);
  DataFile.Read(FRightFoot, 1);
  DataFile.Read(FFlair, 1);
  DataFile.Read(FCorners, 1);
  DataFile.Read(FTeamwork, 1);
  DataFile.Read(FWorkRate, 1);
  DataFile.Read(FLongThrows, 1);
  DataFile.Read(FEccentricity, 1);
  DataFile.Read(FRushingOut, 1);
  DataFile.Read(FTendencyToPunch, 1);
  DataFile.Read(FAcceleration, 1);
  DataFile.Read(FSetPieces, 1);
  DataFile.Read(FStrength, 1);
  DataFile.Read(FStamina, 1);
  DataFile.Read(FPace, 1);
  DataFile.Read(FJumping, 1);
  DataFile.Read(FInfluence, 1);
  DataFile.Read(FDirtiness, 1);
  DataFile.Read(FBalance, 1);
  DataFile.Read(FBravery, 1);
  DataFile.Read(FConsistency, 1);
  DataFile.Read(FAggression, 1);
  DataFile.Read(FAgility, 1);
  DataFile.Read(FImportantMatches, 1);
  DataFile.Read(FInjuryProneness, 1);
  DataFile.Read(FVersatility, 1);
  DataFile.Read(FNaturalFitness, 1);
  DataFile.Read(FDetermination, 1);

  inherited;
end;

function TCM4PlayingData.LowConvert(Ability: SmallInt;
  Value: ShortInt): ShortInt;
var
  Temp: Double;
begin
  Temp:=(((Ability * 0.1) + (Value * 2)) * 0.05) + 10;
  Temp:=((((Temp * Temp) * 0.1) + Temp) * (1/3)) + 0.5;

  if Temp < 1 then
    Result:=1
  else if Temp > 20 then
    Result:=20
  else
    Result:=Trunc(Temp);
end;

{ TCM4PlayingDataContainer }

function TCM4PlayingDataContainer.GetPlayingData(
  Index: Integer): TCM4PlayingData;
begin
  Result:=TCM4PlayingData(Entity[Index]);
end;

function TCM4PlayingDataContainer.NewEntity(
  RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_STANDARD then
    Result:=TCM4PlayingData.Create
  else
    raise EFileCorruptError.Create('Playing Data data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4NonPlayingData }

procedure TCM4NonPlayingData.Load(DataFile: TCM4FileStream; DBVersion: SmallInt);
begin
  DataFile.Read(FAttacking, 1);
  DataFile.Read(FBusiness, 1);
  DataFile.Read(FCoachingTechnique, 1);
  DataFile.Read(FDirectness, 1);
  DataFile.Read(FLevelOfDiscipline, 1);
  DataFile.Read(FFreeRoles, 1);
  DataFile.Read(FInterference, 1);
  DataFile.Read(FMarking, 1);
  DataFile.Read(FOffside, 1);
  DataFile.Read(FPatience, 1);
  DataFile.Read(FPressing, 1);
  DataFile.Read(FResources, 1);
  DataFile.Read(FWorkingWithYoungsters, 1);
  DataFile.Read(FDetermination, 1);
  DataFile.Read(FBuyingPlayers, 1);
  DataFile.Read(FMindGames, 1);
  DataFile.Read(FSellingPlayers, 1);
  DataFile.Read(FSittingBack, 1);
  DataFile.Read(FUseOfPlayMaker, 1);
  DataFile.Read(FUseOfSubs, 1);
  DataFile.Read(FCoachingOutfieldPlayers, 1);
  DataFile.Read(FCoachingGoalkeepers, 1);
  DataFile.Read(FJudgingPlayerAbility, 1);
  DataFile.Read(FJudgingPlayerPotential, 1);
  DataFile.Read(FManManagement, 1);
  DataFile.Read(FMotivating, 1);
  DataFile.Read(FPhysiotherapy, 1);
  DataFile.Read(FTacticalKnowledge, 1);

  inherited;
end;

{ TCM4NonPlayingDataContainer }

function TCM4NonPlayingDataContainer.NewEntity(
  RecordType: Byte): TCM4DatabaseEntity;
begin
  if RecordType = RT_STANDARD then
    Result:=TCM4NonPlayingData.Create
  else
    raise EFileCorruptError.Create('Non Playing Data data seems to be corrupt, make sure the saved game can be loaded by CM4!' + #13#10 + 'Record Type: ' + IntToStr(RecordType));
end;

{ TCM4PlayerScoutRating }

procedure TCM4PlayerScoutRating.Calculate(PersonData: TCM4PersonData;
  PlayerData: TCM4PlayerData);
begin
  FPersonData:=PersonData;
  FPlayerData:=PlayerData;

  CalculateGKRating;
  CalculateDRating;
  CalculateDMRating;
  CalculateMRating;
  CalculateAMRating;
  CalculateWRating;
  CalculateARating;

  FBestRating:=0;
  FBestRatingText:=Format('%.2f %% (?)', [0.0]);

  with FPlayerData.PlayingData do
  begin
    if Goalkeeper >= POSITION_THRESHOLD then
      if FGKRating > FBestRating then
      begin
        FBestRating:=FGKRating;
        FBestRatingText:=Format('%.2f %% (GK)', [FBestRating]);
      end;

    if (Defender >= POSITION_THRESHOLD) or (Sweeper >= POSITION_THRESHOLD) then
      if FDRating > FBestRating then
      begin
        FBestRating:=FDRating;
        FBestRatingText:=Format('%.2f %% (D)', [FBestRating]);
      end;

    if DefensiveMidfielder >= POSITION_THRESHOLD then
      if FDMRating > FBestRating then
      begin
        FBestRating:=FDMRating;
        FBestRatingText:=Format('%.2f %% (DM)', [FBestRating]);
      end;

    if Midfielder >= POSITION_THRESHOLD then
      if FMRating > FBestRating then
      begin
        FBestRating:=FMRating;
        FBestRatingText:=Format('%.2f %% (M)', [FBestRating]);
      end;

    if AttackingMidfielder >= POSITION_THRESHOLD then
      if FAMRating > FBestRating then
      begin
        FBestRating:=FAMRating;
        FBestRatingText:=Format('%.2f %% (AM)', [FBestRating]);
      end;

    if ((Midfielder >= POSITION_THRESHOLD) or (AttackingMidfielder >= POSITION_THRESHOLD) or (WingBack >= POSITION_THRESHOLD)) and ((LeftSide >= POSITION_THRESHOLD) or (RightSide >= POSITION_THRESHOLD)) then
      if FWRating > FBestRating then
      begin
        FBestRating:=FWRating;
        FBestRatingText:=Format('%.2f %% (W)', [FBestRating]);
      end;

    if Attacker >= POSITION_THRESHOLD then
      if FARating > FBestRating then
      begin
        FBestRating:=FARating;
        FBestRatingText:=Format('%.2f %% (A)', [FBestRating]);
      end;
  end;
end;

procedure TCM4PlayerScoutRating.CalculateGKRating;
begin
  FCurrentValue:=@FGKRating;
  FGKRating:=0;

  with FPersonData do
  begin
    Increase(Adaptability / 20 * 3);
    Increase(Ambition / 20 * 5);
    Increase(Loyality / 20 * 4);
    Increase(Pressure / 20 * 6);
    Increase(Professionalism / 20 * 3);
    Increase(Sportsmanship / 20 * 2);
    Increase(Temperament / 20 * 1);
    Increase((21 - Controversy) / 20 * 1);
  end;
  // 3 + 5 + 4 + 6 + 3 + 2 + 1 + 1 = 25

  with FPlayerData.PlayingData do
  begin
    Increase(Goalkeeper / 20 * 20);
    Increase(Handling / 20 * 20);
    Increase(AerialAbility / 20 * 15);
    Increase(CommandOfArea / 20 * 12);
    Increase(Communication / 20 * 10);
    Increase(Kicking / 20 * 5);
    Increase(Throwing / 20 * 5);
    Increase(Anticipation / 20 * 2);
    Increase(Decisions / 20 * 8);
    Increase(OneOnOnes / 20 * 10);
    Increase(Positioning / 20 * 10);
    Increase(Reflexes / 20 * 15);
    Increase(FirstTouch / 20 * 2);
    Increase(Technique / 20 * 1);
    Increase((21 - Eccentricity) / 20 * 5);
    Increase(RushingOut / 20 * 6);
    Increase((21 - TendencyToPunch) / 20 * 5);
    Increase(Acceleration / 20 * 4);
    Increase(Strength / 20 * 8);
    Increase(Stamina / 20 * 1);
    Increase(Jumping / 20 * 10);
    Increase(Influence / 20 * 8);
    Increase((21 - Dirtiness) / 20 * 3);
    Increase(Balance / 20 * 8);
    Increase(Bravery / 20 * 7);
    Increase(Consistency / 20 * 6);
    Increase(Aggression / 20 * 8);
    Increase(Agility / 20 * 8);
    Increase(ImportantMatches / 20 * 5);
    Increase((21 - InjuryProneness) / 20 * 3);
    Increase(Versatility / 20 * 1);
    Increase(NaturalFitness / 20 * 3);
    Increase(Determination / 20 * 5);

    Increase(Dribbling / 20 * 5);
    Increase(Heading / 20 * 6);
    Increase(Marking / 20 * 2);
    Increase(Passing / 20 * 8);
    Increase(Penalties / 20 * 1);
    Increase(Tackling / 20 * 7);
    Increase(LeftFoot / 20 * 2);
    Increase(RightFoot / 20 * 2);
    Increase(Flair / 20 * 3);
    Increase(Teamwork / 20 * 4);
    Increase(WorkRate / 20 * 3);
  end;
  // 282

  Increase(FPlayerData.CurrentAbility / 200 * 25);
  // 25

  // 25 + 282 + 25 = 343
  FGKRating:=(FGKRating / 333) * 100;
end;

procedure TCM4PlayerScoutRating.CalculateDRating;
begin
  FCurrentValue:=@FDRating;
  FDRating:=0;

  with FPersonData do
  begin
    Increase(Adaptability / 20 * 3);
    Increase(Ambition / 20 * 5);
    Increase(Loyality / 20 * 4);
    Increase(Pressure / 20 * 6);
    Increase(Professionalism / 20 * 3);
    Increase(Sportsmanship / 20 * 2);
    Increase(Temperament / 20 * 1);
    Increase((21 - Controversy) / 20 * 1);
  end;
  // 3 + 5 + 4 + 6 + 3 + 2 + 1 + 1 = 25

  with FPlayerData.PlayingData do
  begin
    if Sweeper > Defender then
      Increase(Sweeper / 20 * 20)
    else
      Increase(Defender / 20 * 20);
      
    Increase(Crossing / 20 * 3);
    Increase(Dribbling / 20 * 2);
    Increase(Finishing / 20 * 1);
    Increase(Heading / 20 * 10);
    Increase(LongShots / 20 * 5);
    Increase(Marking / 20 * 20);
    Increase(OffTheBall / 20 * 4);
    Increase(Passing / 20 * 8);
    Increase(Penalties / 20 * 1);
    Increase(Tackling / 20 * 20);
    Increase(Creativity / 20 * 1);
    Increase(Anticipation / 20 * 4);
    Increase(Decisions / 20 * 7);
    Increase(OneOnOnes / 20 * 1);
    Increase(Positioning / 20 * 15);
    Increase(Reflexes / 20 * 1);
    Increase(ThrowIns / 20 * 1);
    Increase(FirstTouch / 20 * 4);
    Increase(Technique / 20 * 3);
    Increase(LeftFoot / 20 * 2);
    Increase(RightFoot / 20 * 2);
    Increase(Flair / 20 * 1);
    Increase(Corners / 20 * 5);
    Increase(Teamwork / 20 * 7);
    Increase(WorkRate / 20 * 6);
    Increase(LongThrows / 20 * 5);
    Increase(Acceleration / 20 * 7);
    Increase(SetPieces / 20 * 4);
    Increase(Strength / 20 * 8);
    Increase(Stamina / 20 * 10);
    Increase(Pace / 20 * 7);
    Increase(Jumping / 20 * 5);
    Increase(Influence / 20 * 7);
    Increase((21 - Dirtiness) / 20 * 8);
    Increase(Balance / 20 * 2);
    Increase(Bravery / 20 * 2);
    Increase(Consistency / 20 * 2);
    Increase(Aggression / 20 * 3);
    Increase(Agility / 20 * 1);
    Increase(ImportantMatches / 20 * 5);
    Increase((InjuryProneness - 21) / 20 * 5);
    Increase(Versatility / 20 * 1);
    Increase(NaturalFitness / 20 * 5);
    Increase(Determination / 20 * 5);
  end;
  // 246

  Increase(FPlayerData.CurrentAbility / 200 * 25);
  // 25

  // 25 + 246 + 25 = 296
  FDRating:=(FDRating / 296) * 100;
end;

procedure TCM4PlayerScoutRating.CalculateDMRating;
begin
  FCurrentValue:=@FDMRating;
  FDMRating:=0;

  with FPersonData do
  begin
    Increase(Adaptability / 20 * 3);
    Increase(Ambition / 20 * 5);
    Increase(Loyality / 20 * 4);
    Increase(Pressure / 20 * 6);
    Increase(Professionalism / 20 * 3);
    Increase(Sportsmanship / 20 * 2);
    Increase(Temperament / 20 * 1);
    Increase((21 - Controversy) / 20 * 1);
  end;
  // 3 + 5 + 4 + 6 + 3 + 2 + 1 + 1 = 25

  with FPlayerData.PlayingData do
  begin
    Increase(DefensiveMidfielder / 20 * 20);
    Increase(Crossing / 20 * 8);
    Increase(Dribbling / 20 * 5);
    Increase(Finishing / 20 * 6);
    Increase(Heading / 20 * 10);
    Increase(LongShots / 20 * 8);
    Increase(Marking / 20 * 15);
    Increase(OffTheBall / 20 * 6);
    Increase(Passing / 20 * 10);
    Increase(Penalties / 20 * 1);
    Increase(Tackling / 20 * 15);
    Increase(Creativity / 20 * 5);
    Increase(Anticipation / 20 * 5);
    Increase(Decisions / 20 * 6);
    Increase(OneOnOnes / 20 * 3);
    Increase(Positioning / 20 * 12);
    Increase(Reflexes / 20 * 1);
    Increase(ThrowIns / 20 * 1);
    Increase(FirstTouch / 20 * 7);
    Increase(Technique / 20 * 6);
    Increase(LeftFoot / 20 * 2);
    Increase(RightFoot / 20 * 2);
    Increase(Flair / 20 * 5);
    Increase(Corners / 20 * 5);
    Increase(Teamwork / 20 * 9);
    Increase(WorkRate / 20 * 10);
    Increase(LongThrows / 20 * 5);
    Increase(Acceleration / 20 * 7);
    Increase(SetPieces / 20 * 4);
    Increase(Strength / 20 * 10);
    Increase(Stamina / 20 * 12);
    Increase(Pace / 20 * 6);
    Increase(Jumping / 20 * 5);
    Increase(Influence / 20 * 8);
    Increase((21 - Dirtiness) / 20 * 5);
    Increase(Balance / 20 * 2);
    Increase(Bravery / 20 * 2);
    Increase(Consistency / 20 * 2);
    Increase(Aggression / 20 * 8);
    Increase(Agility / 20 * 1);
    Increase(ImportantMatches / 20 * 5);
    Increase((InjuryProneness - 21) / 20 * 5);
    Increase(Versatility / 20 * 1);
    Increase(NaturalFitness / 20 * 5);
    Increase(Determination / 20 * 5);
  end;
  // 281

  Increase(FPlayerData.CurrentAbility / 200 * 25);
  // 25

  // 25 + 281 + 25 = 331
  FDMRating:=(FDMRating / 331) * 100;
end;

procedure TCM4PlayerScoutRating.CalculateMRating;
begin
  FCurrentValue:=@FMRating;
  FMRating:=0;

  with FPersonData do
  begin
    Increase(Adaptability / 20 * 3);
    Increase(Ambition / 20 * 5);
    Increase(Loyality / 20 * 4);
    Increase(Pressure / 20 * 6);
    Increase(Professionalism / 20 * 3);
    Increase(Sportsmanship / 20 * 2);
    Increase(Temperament / 20 * 1);
    Increase((21 - Controversy) / 20 * 1);
  end;
  // 3 + 5 + 4 + 6 + 3 + 2 + 1 + 1 = 25

  with FPlayerData.PlayingData do
  begin
    Increase(Midfielder / 20 * 20);
    Increase(Crossing / 20 * 10);
    Increase(Dribbling / 20 * 10);
    Increase(Finishing / 20 * 8);
    Increase(Heading / 20 * 8);
    Increase(LongShots / 20 * 10);
    Increase(Marking / 20 * 8);
    Increase(OffTheBall / 20 * 9);
    Increase(Passing / 20 * 12);
    Increase(Penalties / 20 * 1);
    Increase(Tackling / 20 * 7);
    Increase(Creativity / 20 * 10);
    Increase(Anticipation / 20 * 8);
    Increase(Decisions / 20 * 6);
    Increase(OneOnOnes / 20 * 5);
    Increase(Positioning / 20 * 7);
    Increase(Reflexes / 20 * 1);
    Increase(ThrowIns / 20 * 1);
    Increase(FirstTouch / 20 * 11);
    Increase(Technique / 20 * 12);
    Increase(LeftFoot / 20 * 2);
    Increase(RightFoot / 20 * 2);
    Increase(Flair / 20 * 10);
    Increase(Corners / 20 * 5);
    Increase(Teamwork / 20 * 8);
    Increase(WorkRate / 20 * 12);
    Increase(LongThrows / 20 * 5);
    Increase(Acceleration / 20 * 9);
    Increase(SetPieces / 20 * 4);
    Increase(Strength / 20 * 7);
    Increase(Stamina / 20 * 13);
    Increase(Pace / 20 * 8);
    Increase(Jumping / 20 * 5);
    Increase(Influence / 20 * 7);
    Increase((21 - Dirtiness) / 20 * 3);
    Increase(Balance / 20 * 2);
    Increase(Bravery / 20 * 2);
    Increase(Consistency / 20 * 2);
    Increase(Aggression / 20 * 6);
    Increase(Agility / 20 * 1);
    Increase(ImportantMatches / 20 * 5);
    Increase((InjuryProneness - 21) / 20 * 5);
    Increase(Versatility / 20 * 1);
    Increase(NaturalFitness / 20 * 5);
    Increase(Determination / 20 * 5);
  end;
  // 298

  Increase(FPlayerData.CurrentAbility / 200 * 25);
  // 25

  // 25 + 298 + 25 = 348
  FMRating:=(FMRating / 348) * 100;
end;

procedure TCM4PlayerScoutRating.CalculateAMRating;
begin
  FCurrentValue:=@FAMRating;
  FAMRating:=0;

  with FPersonData do
  begin
    Increase(Adaptability / 20 * 3);
    Increase(Ambition / 20 * 5);
    Increase(Loyality / 20 * 4);
    Increase(Pressure / 20 * 6);
    Increase(Professionalism / 20 * 3);
    Increase(Sportsmanship / 20 * 2);
    Increase(Temperament / 20 * 1);
    Increase((21 - Controversy) / 20 * 1);
  end;
  // 3 + 5 + 4 + 6 + 3 + 2 + 1 + 1 = 25

  with FPlayerData.PlayingData do
  begin
    Increase(AttackingMidfielder / 20 * 20);
    Increase(Crossing / 20 * 15);
    Increase(Dribbling / 20 * 15);
    Increase(Finishing / 20 * 12);
    Increase(Heading / 20 * 6);
    Increase(LongShots / 20 * 12);
    Increase(Marking / 20 * 3);
    Increase(OffTheBall / 20 * 12);
    Increase(Passing / 20 * 14);
    Increase(Penalties / 20 * 1);
    Increase(Tackling / 20 * 2);
    Increase(Creativity / 20 * 15);
    Increase(Anticipation / 20 * 10);
    Increase(Decisions / 20 * 3);
    Increase(OneOnOnes / 20 * 8);
    Increase(Positioning / 20 * 4);
    Increase(Reflexes / 20 * 1);
    Increase(ThrowIns / 20 * 1);
    Increase(FirstTouch / 20 * 14);
    Increase(Technique / 20 * 13);
    Increase(LeftFoot / 20 * 2);
    Increase(RightFoot / 20 * 2);
    Increase(Flair / 20 * 12);
    Increase(Corners / 20 * 5);
    Increase(Teamwork / 20 * 4);
    Increase(WorkRate / 20 * 5);
    Increase(LongThrows / 20 * 5);
    Increase(Acceleration / 20 * 10);
    Increase(SetPieces / 20 * 4);
    Increase(Strength / 20 * 5);
    Increase(Stamina / 20 * 5);
    Increase(Pace / 20 * 10);
    Increase(Jumping / 20 * 5);
    Increase(Influence / 20 * 3);
    Increase((21 - Dirtiness) / 20 * 1);
    Increase(Balance / 20 * 2);
    Increase(Bravery / 20 * 2);
    Increase(Consistency / 20 * 2);
    Increase(Aggression / 20 * 2);
    Increase(Agility / 20 * 1);
    Increase(ImportantMatches / 20 * 5);
    Increase((InjuryProneness - 21) / 20 * 5);
    Increase(Versatility / 20 * 1);
    Increase(NaturalFitness / 20 * 3);
    Increase(Determination / 20 * 5);
  end;
  // 287

  Increase(FPlayerData.CurrentAbility / 200 * 25);
  // 25

  // 25 + 287 + 25 = 337
  FAMRating:=(FAMRating / 337) * 100;
end;

procedure TCM4PlayerScoutRating.CalculateWRating;
begin
  FCurrentValue:=@FWRating;
  FWRating:=0;

  with FPersonData do
  begin
    Increase(Adaptability / 20 * 3);
    Increase(Ambition / 20 * 5);
    Increase(Loyality / 20 * 4);
    Increase(Pressure / 20 * 6);
    Increase(Professionalism / 20 * 3);
    Increase(Sportsmanship / 20 * 2);
    Increase(Temperament / 20 * 1);
    Increase((21 - Controversy) / 20 * 1);
  end;
  // 3 + 5 + 4 + 6 + 3 + 2 + 1 + 1 = 25

  with FPlayerData.PlayingData do
  begin
    Increase(AttackingMidfielder / 20 * 20);
    Increase(Crossing / 20 * 18);
    Increase(Dribbling / 20 * 18);
    Increase(Finishing / 20 * 8);
    Increase(Heading / 20 * 4);
    Increase(LongShots / 20 * 8);
    Increase(Marking / 20 * 5);
    Increase(OffTheBall / 20 * 10);
    Increase(Passing / 20 * 12);
    Increase(Penalties / 20 * 1);
    Increase(Tackling / 20 * 5);
    Increase(Creativity / 20 * 15);
    Increase(Anticipation / 20 * 10);
    Increase(Decisions / 20 * 2);
    Increase(OneOnOnes / 20 * 6);
    Increase(Positioning / 20 * 5);
    Increase(Reflexes / 20 * 1);
    Increase(ThrowIns / 20 * 1);
    Increase(FirstTouch / 20 * 10);
    Increase(Technique / 20 * 11);
    Increase(LeftFoot / 20 * 2);
    Increase(RightFoot / 20 * 2);
    Increase(Flair / 20 * 13);
    Increase(Corners / 20 * 5);
    Increase(Teamwork / 20 * 6);
    Increase(WorkRate / 20 * 7);
    Increase(LongThrows / 20 * 5);
    Increase(Acceleration / 20 * 13);
    Increase(SetPieces / 20 * 4);
    Increase(Strength / 20 * 5);
    Increase(Stamina / 20 * 8);
    Increase(Pace / 20 * 15);
    Increase(Jumping / 20 * 5);
    Increase(Influence / 20 * 2);
    Increase((21 - Dirtiness) / 20 * 1);
    Increase(Balance / 20 * 2);
    Increase(Bravery / 20 * 2);
    Increase(Consistency / 20 * 2);
    Increase(Aggression / 20 * 2);
    Increase(Agility / 20 * 1);
    Increase(ImportantMatches / 20 * 5);
    Increase((InjuryProneness - 21) / 20 * 5);
    Increase(Versatility / 20 * 1);
    Increase(NaturalFitness / 20 * 5);
    Increase(Determination / 20 * 5);
  end;
  // 293

  Increase(FPlayerData.CurrentAbility / 200 * 25);
  // 25

  // 25 + 293 + 25 = 343
  FWRating:=(FWRating / 343) * 100;
end;

procedure TCM4PlayerScoutRating.CalculateARating;
begin
  FCurrentValue:=@FARating;
  FARating:=0;

  with FPersonData do
  begin
    Increase(Adaptability / 20 * 3);
    Increase(Ambition / 20 * 5);
    Increase(Loyality / 20 * 4);
    Increase(Pressure / 20 * 6);
    Increase(Professionalism / 20 * 3);
    Increase(Sportsmanship / 20 * 2);
    Increase(Temperament / 20 * 1);
    Increase((21 - Controversy) / 20 * 1);
  end;
  // 3 + 5 + 4 + 6 + 3 + 2 + 1 + 1 = 25

  with FPlayerData.PlayingData do
  begin
    Increase(Attacker / 20 * 20);
    Increase(Crossing / 20 * 6);
    Increase(Dribbling / 20 * 15);
    Increase(Finishing / 20 * 20);
    Increase(Heading / 20 * 12);
    Increase(LongShots / 20 * 10);
    Increase(Marking / 20 * 2);
    Increase(OffTheBall / 20 * 13);
    Increase(Passing / 20 * 8);
    Increase(Penalties / 20 * 1);
    Increase(Tackling / 20 * 2);
    Increase(Creativity / 20 * 15);
    Increase(Anticipation / 20 * 11);
    Increase(Decisions / 20 * 1);
    Increase(OneOnOnes / 20 * 12);
    Increase(Positioning / 20 * 2);
    Increase(Reflexes / 20 * 1);
    Increase(ThrowIns / 20 * 1);
    Increase(FirstTouch / 20 * 13);
    Increase(Technique / 20 * 8);
    Increase(LeftFoot / 20 * 2);
    Increase(RightFoot / 20 * 2);
    Increase(Flair / 20 * 10);
    Increase(Corners / 20 * 5);
    Increase(Teamwork / 20 * 4);
    Increase(WorkRate / 20 * 3);
    Increase(LongThrows / 20 * 5);
    Increase(Acceleration / 20 * 15);
    Increase(SetPieces / 20 * 4);
    Increase(Strength / 20 * 8);
    Increase(Stamina / 20 * 3);
    Increase(Pace / 20 * 12);
    Increase(Jumping / 20 * 5);
    Increase(Influence / 20 * 2);
    Increase((21 - Dirtiness) / 20 * 1);
    Increase(Balance / 20 * 2);
    Increase(Bravery / 20 * 2);
    Increase(Consistency / 20 * 2);
    Increase(Aggression / 20 * 7);
    Increase(Agility / 20 * 1);
    Increase(ImportantMatches / 20 * 5);
    Increase((InjuryProneness - 21) / 20 * 5);
    Increase(Versatility / 20 * 1);
    Increase(NaturalFitness / 20 * 5);
    Increase(Determination / 20 * 5);
  end;
  // 289

  Increase(FPlayerData.CurrentAbility / 200 * 25);
  // 25

  // 25 + 289 + 25 = 339
  FARating:=(FARating / 339) * 100;
end;

procedure TCM4PlayerScoutRating.Increase(Addition: Double);
begin
  FCurrentValue^:=FCurrentValue^ + Addition;
end;

end.
