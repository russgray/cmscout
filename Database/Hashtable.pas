unit Hashtable;

interface

type
  PEntry = ^TEntry;
  TEntry = record
    Key: Integer;
    Value: Pointer;
    Next: PEntry;
  end;

  THashtable = class
  private
    FTable: array of PEntry;
    FCount: Integer;
    FCapacity: Integer;
    function GetKeyIndex(Key: Integer): Integer;
    procedure SetCapacity(const Value: Integer);
  public
    constructor Create(Capacity: Integer);
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function ContainsValue(Value: Pointer): Boolean;
    function ContainsKey(Key: Integer): Boolean;
    function Get(Key: Integer): Pointer;
    function Put(Key: Integer; Value: Pointer): Pointer;
    function Remove(Key: Integer): Pointer;
    procedure Clear;
    property Size: Integer read FCount;
    property Capacity: Integer read FCapacity write SetCapacity;
  end;

implementation

constructor THashtable.Create(Capacity: Integer);
begin
  if Capacity = 0 then
    Capacity:=1;
  FCapacity:=Capacity;
  SetLength(FTable, FCapacity);
end;

destructor THashtable.Destroy;
begin
  Clear;
  SetLength(FTable, 0);
  inherited;
end;

function THashtable.GetKeyIndex(Key: Integer): Integer;
begin
  Result:=Abs(Key mod FCapacity);
end;

function THashtable.IsEmpty: Boolean;
begin
  Result:=FCount = 0;
end;

function THashtable.ContainsValue(Value: Pointer): Boolean;
var
  j: Integer;
  Entry: PEntry;
begin
  for j:=FCapacity - 1 downto 0 do
  begin
    Entry:=FTable[j];

    while Entry <> nil do
    begin
      if Value = Entry.Value then
      begin
        Result:=True;
        Exit;
      end;

      Entry:=Entry.Next;
    end;
  end;

  Result:=False;
end;

function THashtable.ContainsKey(Key: Integer): Boolean;
var
  Index: Integer;
  Entry: PEntry;
begin
  Index:=GetKeyIndex(Key);
  Entry:=FTable[Index];

  while Entry <> nil do
  begin
    if Entry.Key = Key then
    begin
      Result:=True;
      Exit;
    end;

    Entry:=Entry.Next;
  end;

  Result:=False;
end;

function THashtable.Get(Key: Integer): Pointer;
var
  Index: Integer;
  Entry: PEntry;
begin
  Index:=GetKeyIndex(Key);
  Entry:=FTable[Index];
  while Entry <> nil do
  begin
    if Entry.Key = Key then
    begin
      Result:=Entry.Value;
      Exit;
    end;
    Entry:=Entry.Next;
  end;
  Result:=nil;
end;

function THashtable.Put(Key: Integer; Value: Pointer): Pointer;
var
  Index: Integer;
  Entry: PEntry;
begin
  Index:=GetKeyIndex(Key);

  // Is the key in the table, then replace and return old value
  Entry:=FTable[Index];
  while Entry <> nil do
  begin
    if Entry.Key = Key then
    begin
      Result:=Entry.Value;
      Entry.Value:=Value;
      Exit;
    end;
    Entry:=Entry.Next;
  end;

  // Create new entry
  New(Entry);
  Entry.Key:=Key;
  Entry.Value:=Value;
  Entry.Next:=FTable[Index];
  FTable[Index]:=Entry;
  Inc(FCount);
  Result:=nil;
end;

function THashtable.Remove(Key: Integer): Pointer;
var
  Index: Integer;
  Entry: PEntry;
  Prev: PEntry;
begin
  Index:=GetKeyIndex(Key);
  Entry:=FTable[Index];
  Prev:=nil;

  while Entry <> nil do
  begin
    if Entry.Key = Key then
    begin
      if Prev <> nil then
        Prev.Next:=Entry.Next
      else
        FTable[Index]:=Entry.Next;
      Dec(FCount);
      Result:=Entry.Value;
      Dispose(Entry);
      Exit;
    end;
    Prev:=Entry;
    Entry:=Entry.Next;
  end;
  Result:=nil;
end;

procedure THashtable.Clear;
var
  j: Integer;
  Entry, Next: PEntry;
begin
  for j:=0 to FCapacity - 1 do
  begin
    Entry:=FTable[j];

    while Entry <> nil do
    begin
      Next:=Entry.Next;
      Dispose(Entry);
      Entry:=Next;
    end;

    FTable[j]:=nil;
  end;
  FCount:=0;
end;

procedure THashtable.SetCapacity(const Value: Integer);
begin
  Clear;
  if Value = 0 then
    FCapacity:=1
  else
    FCapacity:=Value;
  SetLength(FTable, FCapacity);
end;

end.
