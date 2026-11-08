unit CMCompressedFileStream;

{ $Id: CMCompressedFileStream.pas,v 1.1.1.1 2002/04/20 21:33:42 michael Exp $ }

interface

uses
  Classes;

const
  BUFFER_SIZE = 64 * 1024;
  
type
  TCMCompressedFileStream = class
  private
    FfilStream: TFileStream;
    Fbuffer: array[0..BUFFER_SIZE - 1] of Byte;
    FboCompressed,
    FboBufEmpty: Boolean;
    FintPos: LongInt;
    FintReadPos: LongInt;
    FintBufPos: LongInt;
  public
    constructor Create(const FileName: string; Mode: Word; Compressed: Boolean);
    destructor Destroy; override;
    function Seek(Offset: Longint; Origin: Word): Longint;
    function Read(var Buffer; Count: Longint): Longint;
  end;

implementation

constructor TCMCompressedFileStream.Create(const FileName: string; Mode: Word; Compressed: Boolean);
begin
  inherited Create;
  FboCompressed:=Compressed;
  FintPos:=0;
  FintReadPos:=0;
  FintBufPos:=0;
  FboBufEmpty:=True;
  FfilStream:=TFileStream.Create(FileName, Mode);
end;

destructor TCMCompressedFileStream.Destroy;
begin
  FfilStream.Free;
  inherited Destroy;
end;

function TCMCompressedFileStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  FintPos:=FfilStream.Seek(Offset, Origin);
  Result:=FintPos;
end;

function TCMCompressedFileStream.Read(var Buffer; Count: Longint): Longint;
var
  intNewBufPos: Integer;
  byByteCount,
  byMultByte: Byte;
  poTemp: Pointer;
begin
  if (not FboCompressed) then
    Result:=FfilStream.Read(Buffer, Count)
  else
  begin
    if (Count > BUFFER_SIZE) then
    begin
      Result:=0;
      Exit;
    end;

    if ((FintPos <> FintReadPos + BUFFER_SIZE) or (FboBufEmpty)) then
    begin
      FboBufEmpty:=False;
      FintBufPos:=0;
      FintReadPos:=FfilStream.Position;
      FintPos:=FintReadPos + FfilStream.Read(Fbuffer, BUFFER_SIZE);
    end;

    if (BUFFER_SIZE - FintBufPos < (Count * 2)) then
    begin
      GetMem(poTemp, BUFFER_SIZE - FintBufPos);
      Move(Fbuffer[FintBufPos], poTemp^, BUFFER_SIZE - FintBufPos);
      Move(poTemp^, Fbuffer[0], BUFFER_SIZE - FintBufPos);
      FintReadPos:=FintPos - (BUFFER_SIZE - FintBufPos);
      FintPos:=FintReadPos + FfilStream.Read(Fbuffer[BUFFER_SIZE - FintBufPos], BUFFER_SIZE - (BUFFER_SIZE - FintBufPos)) + (BUFFER_SIZE - FintBufPos);
      FintBufPos:=0
    end;

    intNewBufPos:=0;

    while (intNewBufPos < Count) do
    begin
      if (Fbuffer[FintBufPos] <= 128) then
      begin
        Byte(Pointer(Integer(@Buffer) + intNewBufPos)^):=Fbuffer[FintBufPos];
        Inc(intNewBufPos);
        Inc(FintBufPos);
      end
      else
      begin
        byByteCount:=Fbuffer[FintBufPos] - 128;
        Inc(FintBufPos);
        byMultByte:=Fbuffer[FintBufPos];
        Inc(FintBufPos);
        if (byByteCount + intNewBufPos > Count) then
        begin
          Dec(FintBufPos, 2);
          Fbuffer[FintBufPos]:=byByteCount - (Count - intNewBufPos) + 128;
          byByteCount:=Count - intNewBufPos;
        end;
        FillChar(Byte(Pointer(Integer(@Buffer) + intNewBufPos)^), byByteCount, byMultByte);
        Inc(intNewBufPos, byByteCount);
      end;
      if (FintBufPos > BUFFER_SIZE) then
        FboBufEmpty:=True;
    end;

    Result:=Count;
  end;
end;

end.
