unit CM4LanguageData;

interface

uses
  CM4SupportClasses, CM4SaveGameData, SysUtils, Classes;

type
  TCM4LangDB = class
  private
    FLangDB: string;
    FLanguageID: Integer;

    FOnStatus: TStatusEvent;
    FOnProgress: TProgressEvent;
    
    procedure SkipCities(DataFile: TCM4FileStream);
    procedure LoadClubs(DataFile: TCM4FileStream;
      Clubs: TCM4ClubContainer);
    procedure SkipContinents(DataFile: TCM4FileStream);
    procedure LoadNations(DataFile: TCM4FileStream;
      Nations: TCM4NationContainer);
    procedure SkipInjuries(DataFile: TCM4FileStream);
    procedure LoadCompetitions(DataFile: TCM4FileStream;
      Competitions: TCM4CompetitionContainer);
    procedure SkipAwards(DataFile: TCM4FileStream);
    //procedure SkipMedia(DataFile: TCM4FileStream);
    //procedure SkipPlayerDescriptions(DataFile: TCM4FileStream);
    //procedure SkipRegions(DataFile: TCM4FileStream);
    procedure SkipStadiums(DataFile: TCM4FileStream);
    procedure SkipStages(DataFile: TCM4FileStream);

    procedure TriggerStatus(Status: string);
    procedure TriggerProgress(Progress, Count: Integer);
  public
    procedure Load(Clubs: TCM4ClubContainer; Competitions: TCM4CompetitionContainer; Nations: TCM4NationContainer);
    property LangDB: string read FLangDB write FLangDB;
    property LanguageID: Integer read FLanguageID write FLanguageID;
    property OnStatus: TStatusEvent read FOnStatus write FOnStatus;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
  end;

implementation

{ TCM4LangDB }

procedure TCM4LangDB.Load(Clubs: TCM4ClubContainer;
  Competitions: TCM4CompetitionContainer; Nations: TCM4NationContainer);
var
  DataFile: TCM4FileStream;
  ByteHeader: Byte;
  WordHeader: Word;
  StrHeader: array[1..3] of WideChar;
  DBVersion: Word;
  Count: Byte;
  Offset, j, Lang, LangOff: Integer;
begin
  try
    DataFile:=TCM4FileStream.Create(LangDB, fmOpenRead or fmShareDenyWrite);
  except
    on EFileStreamError do
      raise EAccessDeniedError.Create('Couldn''t access lang_db.dat, make sure the path is correct or disable the loading of lang_db.dat.');
  end;

  try
    DataFile.Read(ByteHeader, 1);
    DataFile.Read(WordHeader, 2);
    DataFile.Read(StrHeader, 6);
    DataFile.Read(DBVersion, 2);
    DataFile.Skip(1);

    if (ByteHeader <> 0) or (WordHeader <> 46) or (StrHeader <> 'dat') or (DBVersion < 110) or (DBVersion > 200) then
      raise EFileCorruptError.Create('The lang_db.dat doesn''t seem to be a valid Language DB for CM4.');

    DataFile.Read(Count, 1);
    Offset:=161;

    for j:=0 to Count - 1 do
    begin
      DataFile.Read(Lang, 4);
      DataFile.Read(LangOff, 4);
      if Lang = LanguageID then
        Offset:=LangOff;
    end;

    DataFile.Seek(Offset + 12, soFromBeginning);

    TriggerStatus('Skipping Cities');
    SkipCities(DataFile);
    TriggerStatus('Loading Clubs');
    LoadClubs(DataFile, Clubs);
    TriggerStatus('Skipping Continents');
    SkipContinents(DataFile);
    TriggerStatus('Skipping Injuries');
    SkipInjuries(DataFile);
    TriggerStatus('Loading Nations');
    LoadNations(DataFile, Nations);
    TriggerStatus('Skipping Awards');
    SkipAwards(DataFile);
    TriggerStatus('Skipping Stadiums');
    SkipStadiums(DataFile);
    TriggerStatus('Skipping Stages');
    SkipStages(DataFile);
    TriggerStatus('Loading Competitions');
    LoadCompetitions(DataFile, Competitions);
    // SkipRegions(DataFile);
    // SkipPlayerDescriptions(DataFile);
    // SkipMedia(DataFile);
  finally
    DataFile.Free;
  end;
end;

procedure TCM4LangDB.SkipCities(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.LoadClubs(DataFile: TCM4FileStream; Clubs: TCM4ClubContainer);
var
  Count, j, UniqueID: Integer;
  Club: TCM4Club;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Read(UniqueID, 4);
    Club:=Clubs.UniqueClub[UniqueID];

    if Club <> nil then
    begin
      Club.Name:=DataFile.ReadWideString;
      DataFile.Skip(1);
      Club.ShortName:=DataFile.ReadWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
      DataFile.Skip(1);
      Club.NickName1:=DataFile.ReadWideString;
      DataFile.Skip(1);
      Club.NickName2:=DataFile.ReadWideString;
    end
    else
    begin
      DataFile.SkipWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
    end;
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.SkipContinents(DataFile: TCM4FileStream);
var
  Count, j, s: Integer;
  AltNamesCount: Byte;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.SkipWideString;
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);

    DataFile.Read(AltNamesCount, 1);
    for s:=0 to AltNamesCount - 1 do
      DataFile.SkipWideString;
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.SkipInjuries(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.LoadNations(DataFile: TCM4FileStream; Nations: TCM4NationContainer);
var
  Count, j, s, UniqueID: Integer;
  AltNamesCount: Byte;
  Nation: TCM4Nation;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Read(UniqueID, 4);
    Nation:=Nations.UniqueNation[UniqueID];

    if Nation <> nil then
    begin
      Nation.Name:=DataFile.ReadWideString;
      DataFile.Skip(1);
      Nation.ShortName:=DataFile.ReadWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
      Nation.Nationality:=DataFile.ReadWideString;
    end
    else
    begin
      DataFile.SkipWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
      DataFile.SkipWideString;
    end;

    DataFile.Read(AltNamesCount, 1);
    for s:=0 to AltNamesCount - 1 do
      DataFile.SkipWideString;
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.SkipAwards(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.SkipStadiums(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.SkipStages(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.LoadCompetitions(DataFile: TCM4FileStream; Competitions: TCM4CompetitionContainer);
var
  Count, j, UniqueID: Integer;
  Competition: TCM4Competition;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Read(UniqueID, 4);
    Competition:=Competitions.UniqueCompetition[UniqueID];

    if Competition <> nil then
    begin
      Competition.Name:=DataFile.ReadWideString;
      DataFile.Skip(1);
      Competition.ShortName:=DataFile.ReadWideString;
    end
    else
    begin
      DataFile.SkipWideString;
      DataFile.Skip(1);
      DataFile.SkipWideString;
    end;

    DataFile.Skip(1);
    DataFile.SkipWideString;
    TriggerProgress(j, Count);
  end;
end;

{procedure TCM4LangDB.SkipRegions(DataFile: TCM4FileStream);
var
  Count, j, s: Integer;
  AltNamesCount: Byte;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;

    DataFile.Read(AltNamesCount, 1);
    for s:=0 to AltNamesCount - 1 do
      DataFile.SkipWideString;
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.SkipPlayerDescriptions(DataFile: TCM4FileStream);
var
  Count, j, s: Integer;
  AltNamesCount: Byte;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(5);

    DataFile.Read(AltNamesCount, 1);
    for s:=0 to AltNamesCount - 1 do
      DataFile.SkipWideString;
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4LangDB.SkipMedia(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(4);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    TriggerProgress(j, Count);
  end;
end;}

procedure TCM4LangDB.TriggerProgress(Progress, Count: Integer);
begin
  if Assigned(FOnProgress) then
  begin
    if Count > 0 then
      FOnProgress(Trunc((Progress + 1) / Count * 100))
    else
      FOnProgress(100);
  end;
end;

procedure TCM4LangDB.TriggerStatus(Status: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Status);
end;

end.
