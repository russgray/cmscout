unit CMScoutControls;

interface

uses
  ComCtrls, SysUtils, Classes, StdCtrls, Forms, Graphics;

type
  TCMScoutStatusBar = class(TCustomStatusBar)
  private
    FStatus: string;
    FPBText: string;
    FDate: TDateTime;
    FDateFormat: TFormatSettings;
    FProgressBar: TProgressBar;
    procedure SetDate(const Value: TDateTime);
    function GetPBVisible: Boolean;
    procedure SetPBVisible(const Value: Boolean);
    function GetPosition: Integer;
    procedure SetPBText(const Value: string);
    procedure SetPosition(const Value: Integer);
    procedure SetStatus(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
  published
    property Status: string read FStatus write SetStatus;
    property Position: Integer read GetPosition write SetPosition;
    property PBText: string read FPBText write SetPBText;
    property Date: TDateTime read FDate write SetDate;
    property PBVisible: Boolean read GetPBVisible write SetPBVisible;
  end;

  TInfoGroupBox = class(TGroupBox)
  private
    FTop: Integer;
    FLeftLabels: TList;
    FRightLabels: TList;
    FBoxes: TList;
    FPanel: TScrollBox;
    FMaxHeight: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;

    procedure Clear;
    procedure AddInfo(Name, Info: string; Highlight: Boolean = False);
    procedure AddBox(Box: TInfoGroupBox);

  published
    property MaxHeight: Integer read FMaxHeight write FMaxHeight;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nygreen', [TCMScoutStatusBar, TInfoGroupBox]);
end;

{ TCMScoutStatusBar }

constructor TCMScoutStatusBar.Create(AOwner: TComponent);
begin
  inherited;

  FDateFormat.DateSeparator:='.';
  FDateFormat.ShortDateFormat:='dd.mm.yyyy';

  Panels.Add;
  Panels.Add;
  Panels.Add;

  Panels[0].Width:=150;
  Panels[2].Width:=100;

  FProgressBar:=TProgressBar.Create(Self);
  FProgressBar.Parent:=Self;
  FProgressBar.Visible:=False;
end;

destructor TCMScoutStatusBar.Destroy;
begin
  FProgressBar.Free;
  inherited;
end;

function TCMScoutStatusBar.GetPBVisible: Boolean;
begin
  Result:=FProgressBar.Visible;
end;

function TCMScoutStatusBar.GetPosition: Integer;
begin
  Result:=FProgressBar.Position;
end;

procedure TCMScoutStatusBar.SetDate(const Value: TDateTime);
begin
  FDate:=Value;
  if FDate <> 0 then
    Panels[2].Text:=DateToStr(FDate, FDateFormat);
end;

procedure TCMScoutStatusBar.SetPBText(const Value: string);
begin
  FPBText:=Value;
  Panels[1].Text:=FPBText;
end;

procedure TCMScoutStatusBar.SetPBVisible(const Value: Boolean);
begin
  FProgressBar.Position:=0;
  FProgressBar.Visible:=Value;
end;

procedure TCMScoutStatusBar.SetPosition(const Value: Integer);
begin
  FProgressBar.Position:=Value;
end;

procedure TCMScoutStatusBar.SetStatus(const Value: string);
begin
  FStatus:=Value;
  Panels[0].Text:=FStatus;
end;

procedure TCMScoutStatusBar.Update;
begin
  inherited;
  Panels[1].Width:=Width - 245;
  FProgressBar.Left:=Panels[0].Width + 4;   
  FProgressBar.Top:=4;
  FProgressBar.Height:=Height - 6;
  FProgressBar.Width:=Panels[1].Width - 6;
end;

{ TInfoGroupBox }

procedure TInfoGroupBox.AddBox(Box: TInfoGroupBox);
begin
  Box.Parent:=FPanel;
  Box.Top:=FTop;
  Box.Left:=0;
  Box.Width:=FPanel.Width - 2;
  Inc(FTop, Box.Height + 2);
  FBoxes.Add(Box);
  Invalidate;
end;

procedure TInfoGroupBox.AddInfo(Name, Info: string; Highlight: Boolean = False);
var
  NewLabel: TLabel;
begin
  if (FLeftLabels.Count = 0) or (TLabel(FLeftLabels[FLeftLabels.Count - 1]).Caption <> Name) then
  begin
    NewLabel:=TLabel.Create(FPanel);
    NewLabel.Parent:=FPanel;
    NewLabel.Caption:=Name;
    NewLabel.Left:=0;
    NewLabel.Top:=FTop;
    FLeftLabels.Add(NewLabel);
  end;

  NewLabel:=TLabel.Create(FPanel);
  NewLabel.Parent:=FPanel;
  NewLabel.Caption:=Info;
  NewLabel.Left:=FPanel.Width - NewLabel.Width - 2;
  NewLabel.Top:=FTop;

  if Highlight then
    NewLabel.Font.Color:=clHotLight;
    
  FRightLabels.Add(NewLabel);

  Inc(FTop, 13);

  Invalidate;
end;

procedure TInfoGroupBox.Clear;
var
  j: Integer;
begin
  for j:=0 to FLeftLabels.Count - 1 do
    TLabel(FLeftLabels[j]).Free;
  FLeftLabels.Clear;
  for j:=0 to FRightLabels.Count - 1 do
    TLabel(FRightLabels[j]).Free;
  FRightLabels.Clear;
  for j:=0 to FBoxes.Count - 1 do
    TInfoGroupBox(FBoxes[j]).Free;
  FBoxes.Clear;
  FTop:=0;

  Invalidate;
end;

constructor TInfoGroupBox.Create(AOwner: TComponent);
begin
  inherited;
  FTop:=0;
  MaxHeight:=-1;
  FLeftLabels:=TList.Create;
  FRightLabels:=TList.Create;
  FBoxes:=TList.Create;

  FPanel:=TScrollBox.Create(Self);
  FPanel.Parent:=Self;
  FPanel.BorderStyle:=bsNone;
  FPanel.ParentBackground:=True;
  FPanel.HorzScrollBar.Visible:=False;
  FPanel.VertScrollBar.Tracking:=True;
  FPanel.Top:=16;
  FPanel.Left:=8;
  FPanel.Width:=Width - 14;
  FPanel.Height:=Height - 24;
end;

destructor TInfoGroupBox.Destroy;
begin
  Clear;
  FLeftLabels.Free;
  FRightLabels.Free;
  FBoxes.Free;
  FPanel.Free;
  inherited;
end;

procedure TInfoGroupBox.Invalidate;
var
  j: Integer;
begin
  inherited;

  if (FMaxHeight <> -1) and (FTop + 24 > FMaxHeight) then
    Height:=FMaxHeight
  else
    Height:=FTop + 24;

  FPanel.Width:=Width - 14;
  FPanel.Height:=Height - 24;

  for j:=0 to FRightLabels.Count - 1 do
    TLabel(FRightLabels[j]).Left:=FPanel.ClientWidth - TLabel(FRightLabels[j]).Width - 2;

  for j:=0 to FBoxes.Count - 1 do
  begin
    TInfoGroupBox(FBoxes[j]).Width:=FPanel.ClientWidth - 2;
    TInfoGroupBox(FBoxes[j]).Invalidate;
  end;
end;

end.
