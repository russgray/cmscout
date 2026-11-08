unit TextWriter;

{ $Id: TextWriter.pas,v 1.1 2002/04/25 22:13:07 michael Exp $ }

interface

uses
  VirtualTrees, SearchUnit, CMDataRepresentation;

type
  TTextWriter = class
  private
    FlvPlayers: TVirtualStringTree;
    FlcPlayers: TListContents;
    FfilWrite: TextFile;
    FstCurrentPlayer: PStaff;
    procedure StartHeader; virtual; abstract;
    procedure PrintHeaderColumn(Text: String; Index: Integer); virtual; abstract;
    procedure EndHeader; virtual; abstract;
    procedure StartPlayers; virtual; abstract;
    procedure StartPlayer; virtual; abstract;
    procedure PrintPlayerColumn(Text: String); virtual; abstract;
    procedure EndPlayer; virtual; abstract;
    procedure EndPlayers; virtual; abstract;
  public
    constructor Create(Filename: String; Players: TListContents; List: TVirtualStringTree);
    destructor Destroy; override;
    procedure WriteTextFile;
  end;

  TCSVWriter = class(TTextWriter)
  private
    FboFirst: Boolean;
    procedure StartHeader; override;
    procedure PrintHeaderColumn(Text: String; Index: Integer); override;
    procedure EndHeader; override;
    procedure StartPlayers; override;
    procedure StartPlayer; override;
    procedure PrintPlayerColumn(Text: String); override;
    procedure EndPlayer; override;
    procedure EndPlayers; override;
  end;

  TTXTWriter = class(TTextWriter)
  private
    FboFirst: Boolean;
    FintIndex: Integer;
    FintColSize: array of Integer;
    procedure StartHeader; override;
    procedure PrintHeaderColumn(Text: String; Index: Integer); override;
    procedure EndHeader; override;
    procedure StartPlayers; override;
    procedure StartPlayer; override;
    procedure PrintPlayerColumn(Text: String); override;
    procedure EndPlayer; override;
    procedure EndPlayers; override;
  end;

implementation

{ TTextWriter }

constructor TTextWriter.Create(Filename: String; Players: TListContents; List: TVirtualStringTree);
begin
  FlvPlayers:=List;
  FlcPlayers:=Players;
  AssignFile(FfilWrite, Filename);
  Rewrite(FfilWrite);
end;

destructor TTextWriter.Destroy;
begin
  CloseFile(FfilWrite);
  inherited Destroy;
end;

procedure TTextWriter.WriteTextFile;
var
  intColumn: Integer;
  vnTemp: PVirtualNode;
  srTemp: PStaffRecord;
begin
  StartHeader;

  intColumn:=FlvPlayers.Header.Columns.GetFirstVisibleColumn;
  while (intColumn >= 0) do
  begin
    PrintHeaderColumn(FlvPlayers.Header.Columns[intColumn].Text, intColumn);
    intColumn:=FlvPlayers.Header.Columns.GetNextVisibleColumn(intColumn);
  end;

  EndHeader;

  StartPlayers;

  vnTemp:=FlvPlayers.GetFirst;

  while (vnTemp <> nil) do
  begin
    StartPlayer;

    srTemp:=FlvPlayers.GetNodeData(vnTemp);
    FstCurrentPlayer:=srTemp.Staff;

    intColumn:=FlvPlayers.Header.Columns.GetFirstVisibleColumn;
    while (intColumn >= 0) do
    begin
      PrintPlayerColumn(FlcPlayers.GetColumnText(intColumn, FstCurrentPlayer));
      intColumn:=FlvPlayers.Header.Columns.GetNextVisibleColumn(intColumn);
    end;

    EndPlayer;

    vnTemp:=FlvPlayers.GetNext(vnTemp);
  end;

  EndPlayers;
end;

{ TCSVWriter }

procedure TCSVWriter.StartHeader;
begin
  FboFirst:=True;
end;

procedure TCSVWriter.PrintHeaderColumn(Text: String; Index: Integer);
begin
  if (FboFirst) then
  begin
    Write(FfilWrite, Text);
    FboFirst:=False;
  end
  else
    Write(FfilWrite, ';', Text);
end;

procedure TCSVWriter.EndHeader;
begin
  Writeln(FfilWrite);
end;

procedure TCSVWriter.StartPlayers;
begin
  // Nothing Needs To Be Done here
end;

procedure TCSVWriter.StartPlayer;
begin
  FboFirst:=True;
end;

procedure TCSVWriter.PrintPlayerColumn(Text: String);
begin
  if (FboFirst) then
  begin
    Write(FfilWrite, Text);
    FboFirst:=False;
  end
  else
    Write(FfilWrite, ';', Text);
end;

procedure TCSVWriter.EndPlayer;
begin
  Writeln(FfilWrite);
end;

procedure TCSVWriter.EndPlayers;
begin
  // Nothing to be done here
end;

{ TTXTWriter }

procedure TTXTWriter.StartHeader;
begin
  Writeln(FfilWrite, '***This list was automatically written by CM Scout***');
  Writeln(FfilWrite);
  FboFirst:=True;
  FintIndex:=0;
end;

procedure TTXTWriter.PrintHeaderColumn(Text: String; Index: Integer);
var
  j: Integer;
begin
  SetLength(FintColSize, FintIndex + 1);
  FintColSize[FintIndex]:=Length(Text);
  for j:=0 to FlcPlayers.Count - 1 do
    if (Length(FlcPlayers.GetColumnText(Index, FlcPlayers[j])) > FintColSize[FintIndex]) then
      FintColSize[FintIndex]:=Length(FlcPlayers.GetColumnText(Index, FlcPlayers[j]));
  Inc(FintColSize[FintIndex]);

  if (FboFirst) then
  begin
    Write(FfilWrite, Text, StringOfChar(' ', FintColSize[FintIndex] - Length(Text)));
    FboFirst:=False;
  end
  else
    Write(FfilWrite, '| ', Text, StringOfChar(' ', FintColSize[FintIndex] - Length(Text)));

  Inc(FintIndex);
end;

procedure TTXTWriter.EndHeader;
var
  j: Integer;
begin
  Writeln(FfilWrite, '|');

  if (Length(FintColSize) > 0) then
  begin
    Write(FfilWrite, StringOfChar(' ', FintColSize[0]));
    for j:=1 to Length(FintColSize) - 1 do
      Write(FfilWrite, '| ', StringOfChar(' ', FintColSize[j]));
    Writeln(FfilWrite, '|');
  end;
end;

procedure TTXTWriter.StartPlayers;
begin
  // Nothing to be done here
end;

procedure TTXTWriter.StartPlayer;
begin
  FboFirst:=True;
  FintIndex:=0;
end;

procedure TTXTWriter.PrintPlayerColumn(Text: String);
begin
  if (FboFirst) then
  begin
    Write(FfilWrite, Text, StringOfChar(' ', FintColSize[FintIndex] - Length(Text)));
    FboFirst:=False;
  end
  else
    Write(FfilWrite, '| ', Text, StringOfChar(' ', FintColSize[FintIndex] - Length(Text)));

  Inc(FintIndex);
end;

procedure TTXTWriter.EndPlayer;
begin
  Writeln(FfilWrite, '|');
end;

procedure TTXTWriter.EndPlayers;
begin
  // Nothing to be done here
end;

end.
