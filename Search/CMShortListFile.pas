unit CMShortListFile;

interface

uses
  Classes, SysUtils, CM4SupportClasses;

type
  TCMShortListFile = class
  private
    FPlayerList: TList;
    function GetPlayer(Index: Integer): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddPlayer(UniqueID: Integer);
    procedure SaveFile(FileName: string);
    procedure LoadFile(FileName: string);
    procedure Clear;
    function Count: Integer;

    property Player[Index: Integer]: Integer read GetPlayer; default;
  end;

const
  SHORTLIST_HEADER: array[0..11] of Byte = (0, 46, 0, 115, 0, 108, 0, 102, 0, 1, 0, 0);

implementation

{ TCMShortListFile }

procedure TCMShortListFile.AddPlayer(UniqueID: Integer);
begin
  FPlayerList.Add(Pointer(UniqueID));
end;

procedure TCMShortListFile.Clear;
begin
  FPlayerList.Clear;
end;

function TCMShortListFile.Count: Integer;
begin
  Result:=FPlayerList.Count;
end;

constructor TCMShortListFile.Create;
begin
  FPlayerList:=TList.Create;
end;

destructor TCMShortListFile.Destroy;
begin
  FPlayerList.Free;
  inherited;
end;

function TCMShortListFile.GetPlayer(Index: Integer): Integer;
begin
  Result:=Integer(FPlayerList[Index]);
end;

procedure TCMShortListFile.LoadFile(FileName: string);
var
  SLFile: TFileStream;
  j, Temp, Input: Integer;
  Header: array[0..11] of Byte;
begin
  Clear;
  
  try
    SLFile:=TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  except
    on EFileStreamError do
      raise EAccessDeniedError.Create('Couldn''t read from Shortlist File, make sure the file exists.');
  end;

  try
    SLFile.Read(Header, 12);

    if CompareMem(@Header, @SHORTLIST_HEADER, 12) then
    begin
      SLFile.Read(Temp, 4);

      for j:=0 to Temp - 1 do
      begin
        SLFile.Read(Input, 4);
        FPlayerList.Add(Pointer(Input));
      end;
    end
    else
      raise EFileCorruptError.Create('The file doesn''t seem to be a valid Shortlist file.');
  finally
    SLFile.Free;
  end;
end;

procedure TCMShortListFile.SaveFile(FileName: string);
var
  SLFile: TFileStream;
  j, Output: Integer;
begin
  try
    SLFile:=TFileStream.Create(FileName, fmCreate);
  except
    on EFileStreamError do
      raise EAccessDeniedError.Create('Couldn''t write to Shortlist File, make sure no other program is reading or writing to it.');
  end;

  try
    SLFile.Write(SHORTLIST_HEADER, 12);
    SLFile.Write(FPlayerList.Count, 4);

    for j:=0 to FPlayerList.Count - 1 do
    begin
      Output:=Integer(FPlayerList[j]);
      SLFile.Write(Output, 4);
    end;
  finally
    SLFile.Free;
  end;
end;

end.