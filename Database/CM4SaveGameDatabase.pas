unit CM4SaveGameDatabase;

interface

uses
  CM4SupportClasses, CM4SaveGameData, CM4LanguageData, SysUtils,
  Classes;

type
  TCM4SaveGameDatabase = class
  private
    FFilename: string;
    FLangDB: string;
    FLoadLangDB: Boolean;

    FDBVersion: SmallInt;

    FOnStatus: TStatusEvent;
    FOnProgress: TProgressEvent;

    FGameDate: TCM4Date;
    FClubs: TCM4ClubContainer;
    FCompetitions: TCM4CompetitionContainer;
    FNations: TCM4NationContainer;
    FFirstNames: TCM4NameContainer;
    FSecondNames: TCM4NameContainer;
    FCommonNames: TCM4NameContainer;
    FTeams: TCM4TeamContainer;
    FPeople: TCM4PersonContainer;
    FPersonData: TCM4PersonDataContainer;
    FPlayingData: TCM4PlayingDataContainer;
    FNonPlayingData: TCM4NonPlayingDataContainer;

    procedure LoadData(DataFile: TCM4FileStream);
    procedure SkipCities(DataFile: TCM4FileStream);
    procedure SkipInjuries(DataFile: TCM4FileStream);
    procedure SkipMedia(DataFile: TCM4FileStream);
    procedure SkipLanguages(DataFile: TCM4FileStream);
    procedure SkipSponsors(DataFile: TCM4FileStream);
    procedure SkipStages(DataFile: TCM4FileStream);
    procedure SkipWeather(DataFile: TCM4FileStream);
    procedure ConvertIndexes;
    procedure SetOnProgress(const Value: TProgressEvent);
    procedure SetOnStatus(const Value: TStatusEvent);

    procedure TriggerStatus(Status: string);
    procedure TriggerProgress(Progress: Integer; Count: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Load;

    property Filename: string read FFilename write FFilename;
    property LangDB: string read FLangDB write FLangDB;
    property LoadLangDB: Boolean read FLoadLangDB write FLoadLangDB;

    property DBVersion: SmallInt read FDBVersion;

    property GameDate: TCM4Date read FGameDate;
    property Clubs: TCM4ClubContainer read FClubs;
    property Competitions: TCM4CompetitionContainer read FCompetitions;
    property Nations: TCM4NationContainer read FNations;
    property FirstNames: TCM4NameContainer read FFirstNames;
    property SecondNames: TCM4NameContainer read FSecondNames;
    property CommonNames: TCM4NameContainer read FCommonNames;
    property Teams: TCM4TeamContainer read FTeams;
    property People: TCM4PersonContainer read FPeople;
    property PersonData: TCM4PersonDataContainer read FPersonData;
    property PlayingData: TCM4PlayingDataContainer read FPlayingData;
    property NonPlayingData: TCM4NonPlayingDataContainer read FNonPlayingData;

    property OnStatus: TStatusEvent read FOnStatus write SetOnStatus;
    property OnProgress: TProgressEvent read FOnProgress write SetOnProgress;
  end;

  TCM4SaveGameHeader = array[0..12] of Byte;

const
  SAVE_HEADER: array[0..12] of Byte = (0, 46, 0, 99, 0, 109, 0, 52, 0, 1, 0, 0, 0);

implementation

{ TCM4SaveGameDatabase }

procedure TCM4SaveGameDatabase.Clear;
begin
  FClubs.Clear;
  FCompetitions.Clear;
  FNations.Clear;
  FFirstNames.Clear;
  FSecondNames.Clear;
  FCommonNames.Clear;
  FTeams.Clear;
  FPeople.Clear;
  FPersonData.Clear;
  FPlayingData.Clear;
  FNonPlayingData.Clear;
end;

constructor TCM4SaveGameDatabase.Create;
begin
  LoadLangDB:=False;
  
  FGameDate:=TCM4Date.Create;
  FClubs:=TCM4ClubContainer.Create;
  FCompetitions:=TCM4CompetitionContainer.Create;
  FNations:=TCM4NationContainer.Create;
  FFirstNames:=TCM4NameContainer.Create;
  FSecondNames:=TCM4NameContainer.Create;
  FCommonNames:=TCM4NameContainer.Create;
  FTeams:=TCM4TeamContainer.Create;
  FPeople:=TCM4PersonContainer.Create;
  FPersonData:=TCM4PersonDataContainer.Create;
  FPlayingData:=TCM4PlayingDataContainer.Create;
  FNonPlayingData:=TCM4NonPlayingDataContainer.Create;
end;

destructor TCM4SaveGameDatabase.Destroy;
begin
  FGameDate.Free;
  FClubs.Free;
  FCompetitions.Free;
  FNations.Free;
  FFirstNames.Free;
  FSecondNames.Free;
  FCommonNames.Free;
  FTeams.Free;
  FPeople.Free;
  FPersonData.Free;
  FPlayingData.Free;
  FNonPlayingData.Free;
  inherited;
end;

procedure TCM4SaveGameDatabase.Load;
var
  DataFile: TCM4FileStream;
  Header: array[0..12] of Byte;
  TableHeader: Byte;
  TableFilename: array[0..55] of Byte;
  TableExtension: array[0..7] of Byte;
  TableLength: Integer;
  LanguageDB: TCM4LangDB;
begin
  TriggerStatus('Clearing Memory');
  Clear;

  try
    DataFile:=TCM4FileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  except
    on EFileStreamError do
      raise EAccessDeniedError.Create('Couldn''t access the file, make sure no other program is writing to the file.');
  end;

  try
    DataFile.Read(Header, 13);

    if CompareMem(@Header, @SAVE_HEADER, 13) then
    begin
      DataFile.Skip(54);

      TriggerStatus('Finding game_db.dat');
      
      while (DataFile.Size - DataFile.Position >= 69) do
      begin
        DataFile.Read(TableHeader, 1);

        if TableHeader = 2 then
        begin
          DataFile.Read(TableFilename, 56);
          DataFile.Read(TableExtension, 8);
          DataFile.Read(TableLength, 4);

          if (PWideChar(@TableFilename) = 'game_db') and (PWideChar(@TableExtension) = 'dat') then
          begin
            LoadData(DataFile);
            Break;
          end
          else
            DataFile.Skip(TableLength);
        end;
      end;
    end
    else
      raise EFileCorruptError.Create('The file doesn''t seem to be a valid CM4 saved game.'); 
  finally
    DataFile.Free;
  end;

  if LoadLangDB then
  begin
    LanguageDB:=TCM4LangDB.Create;
    LanguageDB.LangDB:=LangDB;
    LanguageDB.OnStatus:=OnStatus;
    LanguageDB.OnProgress:=OnProgress;

    try
      LanguageDB.Load(Clubs, Competitions, Nations);
    finally
      LanguageDB.Free;
    end;
  end;
end;

procedure TCM4SaveGameDatabase.LoadData(DataFile: TCM4FileStream);
var
  byHeader: Byte;
  wrdHeader: Word;
  strHeader: array[0..2] of WideChar;
begin
  // Check Header
  DataFile.Read(byHeader, 1);
  DataFile.Read(wrdHeader, 2);
  DataFile.Read(strHeader, 6);
  DataFile.Read(FDBVersion, 2);

  if (byHeader <> 0) or (wrdHeader <> 46) or (strHeader <> 'dat') then
    raise EFileCorruptError.Create('The file doesn''t seem to be a valid CM4 saved game.');

  if (DBVersion <> 110) and (DBVersion <> 112) and (DBVersion <> 113) and (DBVersion <> 115) then
    raise EFileCorruptError.Create('Unknown database version: ' + IntToStr(DBVersion));

  // Skip game_db.dat header
  DataFile.Skip(6);
  FGameDate.Load(DataFile);
  DataFile.Skip(6);
  
  // Skip Awards
  DataFile.SkipIntArray(43);

  // Skip Cities
  SkipCities(DataFile);

  // Load Clubs
  TriggerStatus('Loading Clubs');
  FClubs.Load(DataFile, DBVersion);

  // Load Competitions
  TriggerStatus('Loading Competitions');
  FCompetitions.Load(DataFile, DBVersion);

  // Skip Continents
  DataFile.SkipIntArray(17);

  // Skip Injuries
  SkipInjuries(DataFile);
  
  // Skip Media
  SkipMedia(DataFile);

  // Skip Languages
  SkipLanguages(DataFile);

  // Load Nations
  TriggerStatus('Loading Nations');
  FNations.Load(DataFile, DBVersion);

  // Load First Names
  TriggerStatus('Loading First Names');
  FFirstNames.Load(DataFile, DBVersion);

  // Load Second Names
  TriggerStatus('Loading Second Names');
  FSecondNames.Load(DataFile, DBVersion);

  // Load Common Names
  TriggerStatus('Loading Common Names');
  FCommonNames.Load(DataFile, DBVersion);

  // Skip Regions
  DataFile.SkipIntArray(9);

  // Skip Sponsors
  SkipSponsors(DataFile);

  // Skip Stadiums
  DataFile.SkipIntArray(47);

  // Skip Stadium Changes
  DataFile.SkipIntArray(38);

  // Skip Stages
  SkipStages(DataFile);

  // Load Teams
  TriggerStatus('Loading Teams');
  FTeams.Load(DataFile, DBVersion);

  // Skip Weather
  SkipWeather(DataFile);

  // Skip Player Types
  DataFile.SkipIntArray(10);

  // Load People
  TriggerStatus('Loading People');
  FPeople.Load(DataFile, DBVersion);

  // Load Person Data
  TriggerStatus('Loading Person Data');
  FPersonData.Load(DataFile, DBVersion);

  // Load Playing Data
  TriggerStatus('Loading Playing Data');
  FPlayingData.Load(DataFile, DBVersion);

  // Load Non Playing Data
  TriggerStatus('Loading Non Playing Data');
  FNonPlayingData.Load(DataFile, DBVersion);

  // Skip Competition Histories
  // DataFile.SkipIntArray(31);

  // Skip Starting Loans
  // DataFile.SkipIntArray(25);

  // Skip Starting Injuries
  // DataFile.SkipIntArray(28);

  // Skip Starting Confidence
  // DataFile.SkipIntArray(17);

  // Skip Starting Future Transfers
  // DataFile.SkipIntArray(30);

  // Skip Starting Club Debts
  // DataFile.SkipIntArray(24);

  // Skip Staff Languages
  // DataFile.SkipIntArray(9);

  ConvertIndexes;
end;

procedure TCM4SaveGameDatabase.SkipCities(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  TriggerStatus('Skipping Cities');
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(19);
    DataFile.SkipWideString;
    DataFile.Skip(11);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4SaveGameDatabase.SkipInjuries(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  TriggerStatus('Skipping Injuries');
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(2);
    DataFile.SkipWideString;
    DataFile.Skip(17);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4SaveGameDatabase.SkipMedia(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  TriggerStatus('Skipping Media');
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(2);
    DataFile.SkipByteArray(4);
    DataFile.Skip(14);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4SaveGameDatabase.SkipLanguages(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  TriggerStatus('Skipping Languages');
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(21);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4SaveGameDatabase.SkipSponsors(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  TriggerStatus('Skipping Sponsors');
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(10);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4SaveGameDatabase.SkipStages(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  TriggerStatus('Skipping Stages');
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(9);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4SaveGameDatabase.SkipWeather(DataFile: TCM4FileStream);
var
  Count, j: Integer;
begin
  TriggerStatus('Skipping Weather');
  DataFile.Read(Count, 4);
  for j:=0 to Count - 1 do
  begin
    DataFile.Skip(1);
    DataFile.SkipWideString;
    DataFile.Skip(87);
    TriggerProgress(j, Count);
  end;
end;

procedure TCM4SaveGameDatabase.ConvertIndexes;
begin
  Clubs.ConvertIndexes(Nations, People, Competitions, Teams);
  Competitions.ConvertIndexes(Nations);
  Nations.ConvertIndexes(Teams);
  Teams.ConvertIndexes(Competitions, People, Clubs, Nations);
  People.ConvertIndexes(FirstNames, SecondNames, CommonNames, Nations, Teams, PersonData, Clubs, NonPlayingData, PlayingData);
end;

procedure TCM4SaveGameDatabase.SetOnProgress(const Value: TProgressEvent);
begin
  FOnProgress:=Value;
  FClubs.OnProgress:=FOnProgress;
  FClubs.OnStatus:=FOnStatus;
  FCompetitions.OnProgress:=FOnProgress;
  FCompetitions.OnStatus:=FOnStatus;
  FNations.OnProgress:=FOnProgress;
  FNations.OnStatus:=FOnStatus;
  FFirstNames.OnProgress:=FOnProgress;
  FSecondNames.OnProgress:=FOnProgress;
  FCommonNames.OnProgress:=FOnProgress;
  FTeams.OnProgress:=FOnProgress;
  FTeams.OnStatus:=FOnStatus;
  FPeople.OnProgress:=FOnProgress;
  FPeople.OnStatus:=FOnStatus;
  FPersonData.OnProgress:=FOnProgress;
  FPlayingData.OnProgress:=FOnProgress;
  FNonPlayingData.OnProgress:=FOnProgress;
end;

procedure TCM4SaveGameDatabase.SetOnStatus(const Value: TStatusEvent);
begin
  FOnStatus:=Value;
end;

procedure TCM4SaveGameDatabase.TriggerProgress(Progress, Count: Integer);
begin
  if Assigned(FOnProgress) then
  begin
    if Count > 0 then
      FOnProgress(Trunc((Progress + 1) / Count * 100))
    else
      FOnProgress(100);
  end;
end;

procedure TCM4SaveGameDatabase.TriggerStatus(Status: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Status);
end;

end.
