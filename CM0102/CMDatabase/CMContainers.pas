unit CMContainers;

{ $Id: CMContainers.pas,v 1.1.1.1 2002/04/20 21:33:42 michael Exp $ }

interface

uses
  Classes, CMDataRepresentation;

type
  TCMContainer = class
  private
    Flist: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    function GetPointer(Index: Integer): Pointer;
  end;

  TBlocks = class(TCMContainer)
  private
    function Get(Index: Integer): PBlock;
  public
    procedure Add(Block: PBlock);
    property Items[Index: Integer]: PBlock read Get; default;
  end;

  TNations = class(TCMContainer)
  private
    function Get(Index: Integer): PNation;
  public
    procedure Add(Nation: PNation);
    property Items[Index: Integer]: PNation read Get; default;
  end;

  TDivisions = class(TCMContainer)
  private
    function Get(Index: Integer): PDivision;
  public
    procedure Add(Division: PDivision);
    property Items[Index: Integer]: PDivision read Get; default;
  end;

  TClubs = class(TCMContainer)
  private
    function Get(Index: Integer): PClub;
  public
    procedure Add(Club: PClub);
    property Items[Index: Integer]: PClub read Get; default;
  end;

  TNames = class(TCMContainer)
  private
    function Get(Index: Integer): PName;
  public
    procedure Add(Name: PName);
    property Items[Index: Integer]: PName read Get; default;
  end;

  TPlayers = class(TCMContainer)
  private
    function Get(Index: Integer): PPlayer;
  public
    procedure Add(Player: PPlayer);
    property Items[Index: Integer]: PPlayer read Get; default;
  end;

  TNonPlayers = class(TCMContainer)
  private
    function Get(Index: Integer): PNonPlayer;
  public
    procedure Add(NonPlayer: PNonPlayer);
    property Items[Index: Integer]: PNonPlayer read Get; default;
  end;

  TContracts = class(TCMContainer)
  private
    function Get(Index: Integer): PContract;
  public
    procedure Add(Contract: PContract);
    property Items[Index: Integer]: PContract read Get; default;
  end;

  TStaffs = class(TCMContainer)
  private
    function Get(Index: Integer): PStaff;
  public
    procedure Add(Staff: PStaff);
    property Items[Index: Integer]: PStaff read Get; default;
  end;

implementation

constructor TCMContainer.Create;
begin
  inherited Create;
  Flist:=TList.Create;
end;

destructor TCMContainer.Destroy;
var
  j: Integer;
begin
  for j:=0 to Flist.Count - 1 do
    Dispose(Flist[j]);
  Flist.Free;
  inherited Destroy;
end;

function TCMContainer.Count: Integer;
begin
  Result:=Flist.Count;
end;

function TCMContainer.GetPointer(Index: Integer): Pointer;
begin
  Result:=Flist[Index];
end;

{ TBlocks }

procedure TBlocks.Add(Block: PBlock);
begin
  Flist.Add(Block);
end;

function TBlocks.Get(Index: Integer): PBlock;
begin
  Result:=PBlock(Flist[Index]);
end;

{ TNations }

procedure TNations.Add(Nation: PNation);
begin
  Flist.Add(Nation);
end;

function TNations.Get(Index: Integer): PNation;
begin
  Result:=PNation(Flist[Index]);
end;

{ TDivisions }

procedure TDivisions.Add(Division: PDivision);
begin
  Flist.Add(Division);
end;

function TDivisions.Get(Index: Integer): PDivision;
begin
  Result:=PDivision(Flist[Index]);
end;

{ TClubs }

procedure TClubs.Add(Club: PClub);
begin
  Flist.Add(Club);
end;

function TClubs.Get(Index: Integer): PClub;
begin
  Result:=PClub(Flist[Index]);
end;

{ TNames }

procedure TNames.Add(Name: PName);
begin
  Flist.Add(Name);
end;

function TNames.Get(Index: Integer): PName;
begin
  Result:=PName(Flist[Index]);
end;

{ TPlayers }

procedure TPlayers.Add(Player: PPlayer);
begin
  Flist.Add(Player);
end;

function TPlayers.Get(Index: Integer): PPlayer;
begin
  Result:=PPlayer(Flist[Index]);
end;

{ TNonPlayers }

procedure TNonPlayers.Add(NonPlayer: PNonPlayer);
begin
  Flist.Add(NonPlayer);
end;

function TNonPlayers.Get(Index: Integer): PNonPlayer;
begin
  Result:=PNonPlayer(Flist[Index]);
end;

{ TContracts }

procedure TContracts.Add(Contract: PContract);
begin
  Flist.Add(Contract);
end;

function TContracts.Get(Index: Integer): PContract;
begin
  Result:=PContract(Flist[Index]);
end;

{ TStaffs }

procedure TStaffs.Add(Staff: PStaff);
begin
  Flist.Add(Staff);
end;

function TStaffs.Get(Index: Integer): PStaff;
begin
  Result:=PStaff(Flist[Index]);
end;

end.
