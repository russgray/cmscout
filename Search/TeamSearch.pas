unit TeamSearch;

interface

uses
  Forms, Controls, StdCtrls, Classes, CM4SaveGameDatabase,
  CM4SaveGameData;

type
  TfrmTeamSearch = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblClub: TLabel;
    cmbClub: TComboBox;
    lblSquad: TLabel;
    cmbSquad: TComboBox;
    procedure cmbClubChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SetCMData(const Value: TCM4SaveGameDatabase);
    { Private declarations }
  public
    property CMData: TCM4SaveGameDatabase write SetCMData;
  end;

implementation

{$R *.dfm}

{ TfrmTeamSearch }

procedure TfrmTeamSearch.SetCMData(const Value: TCM4SaveGameDatabase);
var
  j: Integer;
begin
  cmbClub.Clear;
  for j:=0 to Value.Clubs.Count - 1 do
    if (Value.Clubs[j].Teams.Count > 0) and (not (Value.Clubs[j] is TCM4LeagueBodyClub)) then
      cmbClub.AddItem(Value.Clubs[j].Name, Value.Clubs[j]);
end;

procedure TfrmTeamSearch.cmbClubChange(Sender: TObject);
var
  j: Integer;
  Club: TCM4Club;
begin
  cmbSquad.Clear;
  if cmbClub.ItemIndex <> -1 then
  begin
    Club:=TCM4Club(cmbClub.Items.Objects[cmbClub.ItemIndex]);
    cmbSquad.AddItem('All Squads', nil);
    for j:=0 to Club.Teams.Count - 1 do
      cmbSquad.AddItem(Club.Teams[j].SquadName, Club.Teams[j]);
    cmbSquad.ItemIndex:=0;
  end;
end;

procedure TfrmTeamSearch.FormShow(Sender: TObject);
begin
  cmbClub.SetFocus;
end;

end.
