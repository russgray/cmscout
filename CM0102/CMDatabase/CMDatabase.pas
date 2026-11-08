unit CMDatabase;

{ $Id: CMDatabase.pas,v 1.2 2002/05/10 19:47:55 michael Exp $ }

interface

uses
  CMFunctions, CMDataRepresentation, CMContainers, Classes,
  CMCompressedFileStream, SysUtils;

type
  TStatusEvent = procedure(Sender: TObject; Status: String) of object;
  TProgressEvent = procedure(Sender: TObject; Position: Integer) of object;
  
  TCMDatabase = class(TComponent)
  private
    FboLoaded: Boolean;
    FstrFileName: String;
    FcfsFile: TCMCompressedFileStream;
    FOnStatus: TStatusEvent;
    FOnProgress: TProgressEvent;
    FboCompressed: Boolean;
    FcmdGameDate: TCMDate;
    FlstBlock: TBlocks;
    FlstNation: TNations;
    FlstDivision: TDivisions;
    FlstClub: TClubs;
    FlstFirstName,
    FlstSecondName,
    FlstCommonName: TNames;
    FlstPlayer: TPlayers;
    FlstNonPlayer: TNonPlayers;
    FlstStaff: TStaffs;
    FlstContract: TContracts;
    procedure ExecuteStatus(Text: String);
    procedure ExecuteProgress(Position: Integer);
    function AssignPointer(ptr: Pointer; Container: TCMContainer): Pointer;
    function LoadNations: Boolean;
    function LoadDivisions: Boolean;
    function LoadClubs: Boolean;
    function LoadNames: Boolean;
    function LoadPlayers: Boolean;
    function LoadNonPlayers: Boolean;
    function LoadStaffs: Boolean;
    function LoadContracts: Boolean;
    procedure PlayerConvert(Player: PPlayer);
    function LowConvert(Attribute: ShortInt; Ability: Word): Byte;
    function HighConvert(Attribute: ShortInt; Ability: Word): Byte;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Load: Boolean;
    procedure UnLoad;
    property GameDate: TCMDate read FcmdGameDate;
    property Nation: TNations read FlstNation;
    property Division: TDivisions read FlstDivision;
    property Club: TClubs read FlstClub;
    property Staff: TStaffs read FlstStaff;
    property Block: TBlocks read FlstBlock;
  published
    property Filename: String read FstrFilename write FstrFilename;
    property OnStatus: TStatusEvent read FOnStatus write FOnStatus;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nygreen', [TCMDatabase]);
end;

constructor TCMDatabase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FstrFileName:='';
  FboLoaded:=False;
end;

destructor TCMDatabase.Destroy;
begin
  UnLoad;
  inherited Destroy;
end;

procedure TCMDatabase.UnLoad;
begin
  if (FboLoaded) then
  begin
    FlstBlock.Free;
    FlstNation.Free;
    FlstDivision.Free;
    FlstClub.Free;
    FlstFirstName.Free;
    FlstSecondName.Free;
    FlstCommonName.Free;
    FlstPlayer.Free;
    FlstNonPlayer.Free;
    FlstStaff.Free;
    FlstContract.Free;
  end;
  FboLoaded:=False;
end;

procedure TCMDatabase.ExecuteStatus(Text: String);
begin
  if (Assigned(FOnStatus)) then
    FOnStatus(Self, Text);
end;

procedure TCMDatabase.ExecuteProgress(Position: Integer);
begin
  if (Assigned(FOnProgress)) then
    FOnProgress(Self, Position);
end;

function TCMDatabase.Load: Boolean;
var
  filLoad: TFileStream;
  j,
  intTemp: Integer;
  newBlock: PBlock;
  buffer: array[0..3943] of Byte;
begin
  UnLoad;

  FlstBlock:=TBlocks.Create;
  FlstNation:=TNations.Create;
  FlstDivision:=TDivisions.Create;
  FlstClub:=TClubs.Create;
  FlstFirstName:=TNames.Create;
  FlstSecondName:=TNames.Create;
  FlstCommonName:=TNames.Create;
  FlstPlayer:=TPlayers.Create;
  FlstNonPlayer:=TNonPlayers.Create;
  FlstStaff:=TStaffs.Create;
  FlstContract:=TContracts.Create;

  FboLoaded:=True;

  try
    filLoad:=TFileStream.Create(FstrFileName, fmOpenRead or fmShareDenyWrite);

    try
      filLoad.Read(intTemp, 4);
      FboCompressed:=(intTemp = 4);

      ExecuteStatus('Loading Blocks');

      filLoad.Seek(4, soFromCurrent);
      filLoad.Read(intTemp, 4);

      for j:=0 to intTemp - 1 do
      begin
        New(newBlock);
        filLoad.Read(newBlock^, BlockSize);
        FlstBlock.Add(newBlock);
        ExecuteProgress(Round(j / (intTemp - 1) * 100));
      end;

      Result:=True;
    finally
      filLoad.Free;
    end;

    try
      FcfsFile:=TCMCompressedFileStream.Create(FstrFileName, fmOpenRead or fmShareDenyWrite, FboCompressed);

      j:=0;
      while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'general.dat')) do
        Inc(j);

      FcfsFile.Seek(FlstBlock[j].Position, soFromBeginning);
      FcfsFile.Read(buffer, 3944);
      FcfsFile.Read(FcmdGameDate, SizeOf(TCMDate));
    except
      Result:=False;
    end;
    
    try
      if (Result) then
        Result:=LoadNations;
      if (Result) then
        Result:=LoadDivisions;
      if (Result) then
        Result:=LoadClubs;
      if (Result) then
        Result:=LoadNames;
      if (Result) then
        Result:=LoadPlayers;
      if (Result) then
        Result:=LoadNonPlayers;
      if (Result) then
        Result:=LoadStaffs;
      if (Result) then
        Result:=LoadContracts;
    finally
      FcfsFile.Free;
    end;
  except
    Result:=False;
  end;
end;

function TCMDatabase.AssignPointer(ptr: Pointer; Container: TCMContainer): Pointer;
begin
  if ((LongInt(ptr) >= 0) and (LongInt(ptr) < Container.Count)) then
    Result:=Container.GetPointer(LongInt(ptr))
  else
    Result:=nil;
end;

function TCMDatabase.LoadNations: Boolean;
var
  newNation: PNation;
  j,
  intCount: Integer;
begin
  try
    ExecuteStatus('Loading Nations');
    
    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'nation.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div NationSize;

    for j:=0 to intCount - 1 do
    begin
      New(newNation);
      FcfsFile.Read(newNation^, NationSize);
      FlstNation.Add(newNation);
      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    for j:=0 to intCount - 1 do
    begin
      FlstNation[j]^.Rival1:=AssignPointer(FlstNation[j]^.Rival1, FlstNation);
      FlstNation[j]^.Rival2:=AssignPointer(FlstNation[j]^.Rival2, FlstNation);
      FlstNation[j]^.Rival3:=AssignPointer(FlstNation[j]^.Rival3, FlstNation);
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

function TCMDatabase.LoadDivisions: Boolean;
var
  newDivision: PDivision;
  j,
  intCount: Integer;
begin
  try
    ExecuteStatus('Loading Divisions');
    
    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'club_comp.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div DivisionSize;

    for j:=0 to intCount - 1 do
    begin
      New(newDivision);
      FcfsFile.Read(newDivision^, DivisionSize);
      FlstDivision.Add(newDivision);
      FlstDivision[j]^.Nation:=AssignPointer(FlstDivision[j]^.Nation, FlstNation);
      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

function TCMDatabase.LoadClubs: Boolean;
var
  newClub: PClub;
  j,
  intCount: Integer;
begin
  try
    ExecuteStatus('Loading Clubs');
    
    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'club.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div ClubSize;

    for j:=0 to intCount - 1 do
    begin
      New(newClub);
      FcfsFile.Read(newClub^, ClubSize);
      FlstClub.Add(newClub);

      FlstClub[j]^.Nation:=AssignPointer(FlstClub[j]^.Nation, FlstNation);
      FlstClub[j]^.Division:=AssignPointer(FlstClub[j]^.Division, FlstDivision);
      FlstClub[j]^.LastDivision:=AssignPointer(FlstClub[j]^.LastDivision, FlstDivision);
      FlstClub[j]^.ReserveDivision:=AssignPointer(FlstClub[j]^.ReserveDivision, FlstDivision);

      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    for j:=0 to intCount - 1 do
    begin
      FlstClub[j]^.Rival1:=AssignPointer(FlstClub[j]^.Rival1, FlstClub);
      FlstClub[j]^.Rival2:=AssignPointer(FlstClub[j]^.Rival2, FlstClub);
      FlstClub[j]^.Rival3:=AssignPointer(FlstClub[j]^.Rival3, FlstClub);
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

function TCMDatabase.LoadNames: Boolean;
var
  newName: PName;
  j,
  intCount: Integer;
begin
  try
    ////////////////////////////////////////////////////////
    //                    First Names                     //
    ////////////////////////////////////////////////////////
    ExecuteStatus('Loading First Names');
    
    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'first_names.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div NameSize;

    for j:=0 to intCount - 1 do
    begin
      New(newName);
      FcfsFile.Read(newName^, NameSize);
      FlstFirstName.Add(newName);
      FlstFirstName[j]^.Nation:=AssignPointer(FlstFirstName[j]^.Nation, FlstNation);
      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    ////////////////////////////////////////////////////////
    //                   Second Names                     //
    ////////////////////////////////////////////////////////
    ExecuteStatus('Loading Second Names');

    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'second_names.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div NameSize;

    for j:=0 to intCount - 1 do
    begin
      New(newName);
      FcfsFile.Read(newName^, NameSize);
      FlstSecondName.Add(newName);
      FlstSecondName[j]^.Nation:=AssignPointer(FlstSecondName[j]^.Nation, FlstNation);
      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    ////////////////////////////////////////////////////////
    //                   Common Names                     //
    ////////////////////////////////////////////////////////
    ExecuteStatus('Loading Common Names');

    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'common_names.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div NameSize;

    for j:=0 to intCount - 1 do
    begin
      New(newName);
      FcfsFile.Read(newName^, NameSize);
      FlstCommonName.Add(newName);
      FlstCommonName[j]^.Nation:=AssignPointer(FlstCommonName[j]^.Nation, FlstNation);
      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

function TCMDatabase.LoadPlayers: Boolean;
var
  newPlayer: PPlayer;
  j,
  intCount: Integer;
begin
  try
    ExecuteStatus('Loading Players');
    
    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'player.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div PlayerSize;

    for j:=0 to intCount - 1 do
    begin
      New(newPlayer);
      FcfsFile.Read(newPlayer^, PlayerSize);
      newPlayer.Scouted:=False;
      FlstPlayer.Add(newPlayer);
      PlayerConvert(newPlayer);
      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

function TCMDatabase.LoadNonPlayers: Boolean;
var
  newNonPlayer: PNonPlayer;
  j,
  intCount: Integer;
begin
  try
    ExecuteStatus('Loading Non Players');
    
    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'nonplayer.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div NonPlayerSize;

    for j:=0 to intCount - 1 do
    begin
      New(newNonPlayer);
      FcfsFile.Read(newNonPlayer^, NonPlayerSize);
      FlstNonPlayer.Add(newNonPlayer);
      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

function TCMDatabase.LoadStaffs: Boolean;
var
  newStaff: PStaff;
  j, s,
  intCount: Integer;
begin
  try
    ExecuteStatus('Loading Staff');
    
    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'staff.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    intCount:=FlstBlock[j]^.Size div StaffSize;

    for j:=0 to intCount - 1 do
    begin
      New(newStaff);
      FcfsFile.Read(newStaff^, StaffSize);
      newStaff^.Contract:=nil;
      newStaff^.LoanContract:=nil;
      FlstStaff.Add(newStaff);

      FlstStaff[j]^.FirstName:=AssignPointer(FlstStaff[j]^.FirstName, FlstFirstName);
      FlstStaff[j]^.SecondName:=AssignPointer(FlstStaff[j]^.SecondName, FlstSecondName);
      FlstStaff[j]^.CommonName:=AssignPointer(FlstStaff[j]^.CommonName, FlstCommonName);
      FlstStaff[j]^.Nation:=AssignPointer(FlstStaff[j]^.Nation, FlstNation);
      FlstStaff[j]^.SecondNation:=AssignPointer(FlstStaff[j]^.SecondNation, FlstNation);
      FlstStaff[j]^.NationalJob:=AssignPointer(FlstStaff[j]^.NationalJob, FlstNation);
      FlstStaff[j]^.ClubJob:=AssignPointer(FlstStaff[j]^.ClubJob, FlstClub);
      FlstStaff[j]^.Player:=AssignPointer(FlstStaff[j]^.Player, FlstPlayer);
      FlstStaff[j]^.NonPlayer:=AssignPointer(FlstStaff[j]^.NonPlayer, FlstNonPlayer);

      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    for j:=0 to FlstClub.Count - 1 do
    begin
      FlstClub[j]^.FavStaff1:=AssignPointer(FlstClub[j]^.FavStaff1, FlstStaff);
      FlstClub[j]^.FavStaff2:=AssignPointer(FlstClub[j]^.FavStaff2, FlstStaff);
      FlstClub[j]^.FavStaff3:=AssignPointer(FlstClub[j]^.FavStaff3, FlstStaff);
      FlstClub[j]^.DisStaff1:=AssignPointer(FlstClub[j]^.DisStaff1, FlstStaff);
      FlstClub[j]^.DisStaff2:=AssignPointer(FlstClub[j]^.DisStaff2, FlstStaff);
      FlstClub[j]^.DisStaff3:=AssignPointer(FlstClub[j]^.DisStaff3, FlstStaff);
      FlstClub[j]^.Chairman:=AssignPointer(FlstClub[j]^.Chairman, FlstStaff);
      FlstClub[j]^.Manager:=AssignPointer(FlstClub[j]^.Manager, FlstStaff);
      FlstClub[j]^.AssistantManager:=AssignPointer(FlstClub[j]^.AssistantManager, FlstStaff);

      for s:=0 to 2 do
        FlstClub[j]^.Directors[s]:=AssignPointer(FlstClub[j]^.Directors[s], FlstStaff);
      for s:=0 to 49 do
        FlstClub[j]^.Squad[s]:=AssignPointer(FlstClub[j]^.Squad[s], FlstStaff);
      for s:=0 to 4 do
        FlstClub[j]^.Coaches[s]:=AssignPointer(FlstClub[j]^.Coaches[s], FlstStaff);
      for s:=0 to 6 do
        FlstClub[j]^.Scouts[s]:=AssignPointer(FlstClub[j]^.Scouts[s], FlstStaff);
      for s:=0 to 2 do
        FlstClub[j]^.Physios[s]:=AssignPointer(FlstClub[j]^.Physios[s], FlstStaff);
      for s:=0 to 19 do
        FlstClub[j]^.TeamSelected[s]:=AssignPointer(FlstClub[j]^.TeamSelected[s], FlstStaff);
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

function TCMDatabase.LoadContracts: Boolean;
var
  newContract: PContract;
  j,
  intCount,
  intPreCount: Integer;
  byPre: array[0..20] of Byte;
begin
  try
    ExecuteStatus('Loading Contracts');

    j:=0;
    while ((j < FlstBlock.Count) and (FlstBlock[j]^.Name <> 'contract.dat')) do
      Inc(j);

    FcfsFile.Seek(FlstBlock[j]^.Position, soFromBeginning);
    FcfsFile.Read(intPreCount, 4);
    FcfsFile.Read(intCount, 4);

    for j:=0 to intPreCount - 1 do
      FcfsFile.Read(byPre, 21);

    if (intPreCount > 0) then
      Move(byPre[17], intCount, 4);

    for j:=0 to intCount - 1 do
    begin
      New(newContract);
      FcfsFile.Read(newContract^, ContractSize);
      FlstContract.Add(newContract);

      FlstContract[j]^.Club:=AssignPointer(FlstContract[j]^.Club, FlstClub);
      FlstContract[j]^.TransferArrangedFor:=AssignPointer(FlstContract[j]^.TransferArrangedFor, FlstClub);

      if ((FlstContract[j].ID >= 0) and (FlstContract[j].ID < FlstStaff.Count)) then
      begin
        if (FlstStaff[FlstContract[j].ID].Contract = nil) then
          FlstStaff[FlstContract[j].ID].Contract:=FlstContract[j]
        else
        begin
          if (FlstStaff[FlstContract[j].ID].Contract.Club = FlstStaff[FlstContract[j].ID].ClubJob) then
          begin
            FlstStaff[FlstContract[j].ID].LoanContract:=FlstStaff[FlstContract[j].ID].Contract;
            FlstStaff[FlstContract[j].ID].Contract:=FlstContract[j];
          end
          else
            FlstStaff[FlstContract[j].ID].LoanContract:=FlstContract[j];
        end;
      end;

      ExecuteProgress(Round(j / (intCount - 1) * 100));
    end;

    Result:=True;
  except
    Result:=False;
  end;
end;

procedure TCMDatabase.PlayerConvert(Player: PPlayer);
begin
  with (Player^) do
  begin
    Anticipation:=HighConvert(Anticipation, CurrentAbility);
    Decisions:=HighConvert(Decisions, CurrentAbility);
    Heading:=HighConvert(Heading, CurrentAbility);
    LongShots:=HighConvert(LongShots, CurrentAbility);
    Passing:=HighConvert(Passing, CurrentAbility);
    Penalties:=HighConvert(Penalties, CurrentAbility);
    Positioning:=HighConvert(Positioning, CurrentAbility);
    Tackling:=HighConvert(Tackling, CurrentAbility);

    if (Goalkeeper >= 15) then
    begin
      Handling:=HighConvert(Handling, CurrentAbility);
      Reflexes:=HighConvert(Reflexes, CurrentAbility);
      OneOnOnes:=HighConvert(OneOnOnes, CurrentAbility);

      Crossing:=LowConvert(Crossing, CurrentAbility);
      Dribbling:=LowConvert(Dribbling, CurrentAbility);
      Finishing:=LowConvert(Finishing, CurrentAbility);
      Marking:=LowConvert(Marking, CurrentAbility);
      Movement:=LowConvert(Movement, CurrentAbility);
      ThrowIns:=LowConvert(ThrowIns, CurrentAbility);
      Vision:=LowConvert(Vision, CurrentAbility);
    end
    else
    begin
      Handling:=LowConvert(Handling, CurrentAbility);
      Reflexes:=LowConvert(Reflexes, CurrentAbility);
      OneOnOnes:=LowConvert(OneOnOnes, CurrentAbility);

      Crossing:=HighConvert(Crossing, CurrentAbility);
      Dribbling:=HighConvert(Dribbling, CurrentAbility);
      Finishing:=HighConvert(Finishing, CurrentAbility);
      Marking:=HighConvert(Marking, CurrentAbility);
      Movement:=HighConvert(Movement, CurrentAbility);
      ThrowIns:=HighConvert(ThrowIns, CurrentAbility);
      Vision:=HighConvert(Vision, CurrentAbility);
    end;
  end;
end;

function TCMDatabase.HighConvert(Attribute: ShortInt; Ability: Word): Byte;
var
  dblTemp,
  dblResult: Double;
begin
  dblTemp:=(Attribute / 10) + (Ability / 20) + 10;
  dblResult:=(dblTemp * dblTemp / 30) + (dblTemp / 3) + 0.5;
  if (dblResult < 1) then
    dblResult:=1;
  if (dblResult > 20) then
    dblResult:=20;
  Result:=Trunc(dblResult);
end;

function TCMDatabase.LowConvert(Attribute: ShortInt; Ability: Word): Byte;
var
  dblTemp,
  dblResult: Double;
begin
  dblTemp:=(Attribute / 10) + (Ability / 200) + 10;
  dblResult:=(dblTemp * dblTemp / 30) + (dblTemp / 3) + 0.5;
  if (dblResult < 1) then
    dblResult:=1;
  if (dblResult > 20) then
    dblResult:=20;
  Result:=Trunc(dblResult);
end;

end.
