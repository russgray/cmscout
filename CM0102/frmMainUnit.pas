unit frmMainUnit;

{ $Id: frmMainUnit.pas,v 1.6 2002/05/10 20:36:34 michael Exp $ }

interface

uses
  Forms, ComCtrls, dfsStatusBar, TB2Item, Classes, ActnList,
  ImgList, Controls, CMDatabase, Menus, TB2Dock, TB2Toolbar,
  VirtualTrees, Registry, Windows, SysUtils, Dialogs,
  CMFunctions, VTHeaderPopup, SearchUnit, ScoutList,
  CMDataRepresentation, TextWriter;

type
  TFfrmMain = class(TForm)
    FlvPlayers: TVirtualStringTree;
    FmnuMain: TMainMenu;
    FtdTop: TTBDock;
    FtbActions: TTBToolbar;
    FmnuiFile: TMenuItem;
    FmnuiOpen: TMenuItem;
    FcdData: TCMDatabase;
    FaclActions: TActionList;
    FimglActions: TTBImageList;
    FacOpen: TAction;
    FtbtnOpen: TTBItem;
    FstbStatus: TdfsStatusBar;
    FdiaOpen: TOpenDialog;
    FmnuiOptions: TMenuItem;
    FmnuiPreferences: TMenuItem;
    FpopHeader: TVTHeaderPopupMenu;
    FtbtnSep1: TTBSeparatorItem;
    FtbtnPlayerSearch: TTBItem;
    FactPlayerSearch: TAction;
    FactTeamSearch: TAction;
    FtbtnTeamSearch: TTBItem;
    FactSave: TAction;
    FtbtnSave: TTBItem;
    FmnuiSave: TMenuItem;
    FmnuiSep1: TMenuItem;
    FmnuiExit: TMenuItem;
    FmnuiSearch: TMenuItem;
    FmnuiPlayerSearch: TMenuItem;
    FmnuiTeamSearch: TMenuItem;
    FmnuiHelp: TMenuItem;
    FmnuiAbout: TMenuItem;
    FdiaSave: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FacOpenExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FcdDataProgress(Sender: TObject; Position: Integer);
    procedure FcdDataStatus(Sender: TObject; Status: String);
    procedure FmnuiPreferencesClick(Sender: TObject);
    procedure FactPlayerSearchExecute(Sender: TObject);
    procedure FactTeamSearchExecute(Sender: TObject);
    procedure psSearchStatus(Sender: TObject; Status: String);
    procedure psSearchProgress(Sender: TObject; Position: Integer);
    procedure FlvPlayersHeaderClick(Sender: TVTHeader;
      Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure FmnuiExitClick(Sender: TObject);
    procedure FactSaveExecute(Sender: TObject);
    procedure FpopHeaderAddHeaderPopupItem(const Sender: TBaseVirtualTree;
      const Column: TColumnIndex; var Cmd: TAddPopupItemType);
    procedure FlvPlayersDblClick(Sender: TObject);
    procedure FmnuiAboutClick(Sender: TObject);
  private
    FboInterested: Boolean;
    FstrGameDir,
    FstrSaveDir,
    FstrGameName: String;
    FlcPlayers: TListContents;
  public
    { Public declarations }
  end;

const
  REG_KEY_VALUE = 'Software\easyWare\CM Scout 2.00';
  REG_KEY_GAME_VALUE = 'Software\Sports Interactive Ltd\Championship Manager 01-02';
  DEFAULT_COLUMNS: array[0..8] of Integer = (41, 43, 11, 51, 0, 53, 3, 71, 59);

var
  FfrmMain: TFfrmMain;

implementation

uses
  frmOptionsUnit, frmPSearchUnit, frmClubUnit, frmPlayerUnit;

{$R *.dfm}

procedure TFfrmMain.FormResize(Sender: TObject);
begin
  FstbStatus.Panels[1].Width:=FstbStatus.Width - 240;
end;

procedure TFfrmMain.FormCreate(Sender: TObject);
var
  regProg: TRegistry;
  j: Integer;
begin
  FlcPlayers:=TListContents.Create(FlvPlayers, FcdData);
  
  regProg:=TRegistry.Create;
  regProg.RootKey:=HKEY_CURRENT_USER;

  if (regProg.OpenKey(REG_KEY_VALUE, False)) then
  begin
    try
      FfrmMain.Width:=regProg.ReadInteger('WindowWidth');
    except
      FfrmMain.Width:=796;
    end;

    try
      FfrmMain.Height:=regProg.ReadInteger('WindowHeight');
    except
      FfrmMain.Height:=425;
    end;

    try
      FfrmMain.Left:=regProg.ReadInteger('WindowLeft');
      FfrmMain.Top:=regProg.ReadInteger('WindowTop');
    except
      FfrmMain.Top:=(Screen.Height - FfrmMain.Height) div 2;
      FfrmMain.Left:=(Screen.Width - FfrmMain.Width) div 2;
    end;

    try
      FfrmMain.WindowState:=TWindowState(regProg.ReadInteger('WindowState'));
    except
      FfrmMain.WindowState:=wsNormal;
    end;

    try
      FboInterested:=regProg.ReadBool('Interested');
    except
      FboInterested:=False;
    end;

    try
      FstrGameDir:=regProg.ReadString('GameDir');
    except
      FstrGameDir:='';
    end;

    try
      FstrSaveDir:=regProg.ReadString('SaveDir');
    except
      FstrSaveDir:='';
    end;

    if (regProg.OpenKey('Columns\Players', False)) then
    begin
      for j:=0 to FlvPlayers.Header.Columns.Count - 1 do
      begin
        try
          FlvPlayers.Header.Columns[j].Position:=regProg.ReadInteger('Position' + IntToStr(j));
          FlvPlayers.Header.Columns[j].Width:=regProg.ReadInteger('Width' + IntToStr(j));
          if (regProg.ReadBool('Visible' + IntToStr(j))) then
            FlvPlayers.Header.Columns[j].Options:=FlvPlayers.Header.Columns[j].Options + [coVisible]
          else
            FlvPlayers.Header.Columns[j].Options:=FlvPlayers.Header.Columns[j].Options - [coVisible]
        except
        end;
      end;
    end;
  end
  else
  begin
    FfrmMain.Width:=796;
    FfrmMain.Height:=425;
    FfrmMain.Top:=(Screen.Height - FfrmMain.Height) div 2;
    FfrmMain.Left:=(Screen.Width - FfrmMain.Width) div 2;

    FboInterested:=False;
  end;

  if ((FstrGameDir = '') or (FstrSaveDir = '')) then
  begin
    regProg.RootKey:=HKEY_LOCAL_MACHINE;
    if (regProg.OpenKey(REG_KEY_GAME_VALUE, False)) then
    begin
      if (FstrGameDir = '') then
      begin
        try
          FstrGameDir:=regProg.ReadString('Location');
        except
          FstrGameDir:='';
        end;
      end;

      if (FstrSaveDir = '') then
      begin
        try
          FstrSaveDir:=regProg.ReadString('Location') + '\Search';
        except
          FstrSaveDir:='';
        end;
      end;

      if (FstrGameDir = '') then
        FstrGameDir:=ExtractFilePath(ParamStr(0));
      if (FstrSaveDir = '\Search') then
        FstrSaveDir:=ExtractFilePath(ParamStr(0));
    end
    else
    begin
      if (FstrGameDir = '') then
        FstrGameDir:=ExtractFilePath(ParamStr(0));
      if (FstrSaveDir = '') then
        FstrSaveDir:=ExtractFilePath(ParamStr(0));
    end;
  end;
end;

procedure TFfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  regProg: TRegistry;
  j: Integer;
begin
  regProg:=TRegistry.Create;
  regProg.RootKey:=HKEY_CURRENT_USER;

  if (regProg.OpenKey(REG_KEY_VALUE , True)) then
  begin
    regProg.WriteInteger('WindowState', Integer(FfrmMain.WindowState));

    if (FfrmMain.WindowState = wsMaximized) then
    begin
      FfrmMain.Visible:=False;
      FfrmMain.WindowState:=wsNormal;
      FfrmMain.Visible:=True;
    end;

    regProg.WriteInteger('WindowHeight', FfrmMain.Height);
    regProg.WriteInteger('WindowWidth', FfrmMain.Width);
    regProg.WriteInteger('WindowTop', FfrmMain.Top);
    regProg.WriteInteger('WindowLeft', FfrmMain.Left);

    regProg.WriteBool('Interested', FboInterested);
    
    regProg.WriteString('GameDir', FstrGameDir);
    regProg.WriteString('SaveDir', FstrSaveDir);
  end;

  if (regProg.OpenKey('Columns\Players', True)) then
  begin
    for j:=0 to FlvPlayers.Header.Columns.Count - 1 do
    begin
      regProg.WriteInteger('Position' + IntToStr(j), FlvPlayers.Header.Columns[j].Position);
      regProg.WriteInteger('Width' + IntToStr(j), FlvPlayers.Header.Columns[j].Width);
      regProg.WriteBool('Visible' + IntToStr(j), coVisible in FlvPlayers.Header.Columns[j].Options);
    end;
  end;

  regProg.Free;
end;

procedure TFfrmMain.FacOpenExecute(Sender: TObject);
var
  j: Integer;
begin
  FdiaOpen.InitialDir:=FstrGameDir;
  FdiaOpen.Title:='Open a Saved Game';
  if (FdiaOpen.Execute) then
  begin
    FstrGameDir:=ExtractFilePath(FdiaOpen.Filename);
    FcdData.Filename:=FdiaOpen.Filename;

    // Update menu/toolbar items
    FactPlayerSearch.Enabled:=False;
    FactTeamSearch.Enabled:=False;
    FactSave.Enabled:=False;

    FstbStatus.Panels[1].Text:='';
    FstbStatus.Panels[1].GaugeAttrs.Position:=0;
    FstbStatus.Panels[1].PanelType:=sptGauge;
    FstbStatus.Panels[1].BorderWidth:=0;
    FstbStatus.Panels[1].Alignment:=taCenter;

    FstbStatus.Panels[0].Text:='Clearing List';
    FfrmMain.Update;
    FlvPlayers.Clear;

    if (FcdData.Load) then
    begin
      FstrGameName:=Copy(ExtractFileName(FdiaOpen.Filename), 1, Length(ExtractFileName(FdiaOpen.Filename)) - 4);
      FstbStatus.Panels[0].Text:=FstrGameName;
      FstbStatus.Panels[1].PanelType:=sptNormal;
      FstbStatus.Panels[1].BorderWidth:=1;
      FstbStatus.Panels[1].Alignment:=taLeftJustify;
      FstbStatus.Panels[1].Text:='';
      FstbStatus.Panels[2].Text:=CMDateToString(FcdData.GameDate);

      // Update menu/toolbar items
      FactTeamSearch.Enabled:=True;
      FactPlayerSearch.Enabled:=True;

      // Opdater nation, based og division listerne i Search
      FfrmPSearch.FcmbNation.Clear;
      FfrmPSearch.FcmbBased.Clear;
      FfrmPSearch.FcmbDivision.Clear;
      FfrmClub.FcmbClub.Clear;

      for j:=0 to FcdData.Nation.Count - 1 do
      begin
        FfrmPSearch.FcmbNation.Items.AddObject(FcdData.Nation[j].ShortName, Pointer(FcdData.Nation[j]));
        FfrmPSearch.FcmbBased.Items.AddObject(FcdData.Nation[j].ShortName, Pointer(FcdData.Nation[j]));
      end;

      for j:=0 to FcdData.Division.Count - 1 do
        FfrmPSearch.FcmbDivision.Items.AddObject(FcdData.Division[j].Name, Pointer(FcdData.Division[j]));

      for j:=0 to FcdData.Club.Count - 1 do
        FfrmClub.FcmbClub.Items.AddObject(FcdData.Club[j].ShortName, Pointer(FcdData.Club[j]));
    end
    else
    begin
      MessageBox(Handle, 'An error occured while trying to open the file!', 'Open Error', MB_OK or MB_ICONERROR);
      FcdData.UnLoad;
      FstbStatus.Panels[0].Text:='';
      FstbStatus.Panels[1].PanelType:=sptNormal;
      FstbStatus.Panels[1].BorderWidth:=1;
      FstbStatus.Panels[1].Alignment:=taLeftJustify;
      FstbStatus.Panels[1].Text:='';
      FstbStatus.Panels[2].Text:='';
    end;
  end;
end;

procedure TFfrmMain.FcdDataProgress(Sender: TObject; Position: Integer);
begin
  FstbStatus.Panels[1].GaugeAttrs.Position:=Position;
  FstbStatus.Update;
end;

procedure TFfrmMain.FcdDataStatus(Sender: TObject; Status: String);
begin
  FstbStatus.Panels[0].Text:=Status;
  FstbStatus.Update;
end;

procedure TFfrmMain.FmnuiPreferencesClick(Sender: TObject);
var
  j: Integer;
begin
  FfrmOptions.Left:=FfrmMain.Left + ((FfrmMain.Width - FfrmOptions.Width) div 2);
  FfrmOptions.Top:=FfrmMain.Top + ((FfrmMain.Height - FfrmOptions.Height) div 2);

  FfrmOptions.FedGameDirectory.Text:=FstrGameDir;
  FfrmOptions.FedSaveDirectory.Text:=FstrSaveDir;
  FfrmOptions.FcbInterested.Checked:=FboInterested;

  FfrmOptions.FcbDefaultColumns.Checked:=False;
  FfrmOptions.FclColumns.Items.Clear;
  
  for j:=0 to FlvPlayers.Header.Columns.Count - 1 do
  begin
    FfrmOptions.FclColumns.Items.Add(FlvPlayers.Header.Columns[j].Text);
    FfrmOptions.FclColumns.Checked[j]:=coVisible in FlvPlayers.Header.Columns[j].Options;
  end;
  // Disable the Name column, so that it is always visible
  FfrmOptions.FclColumns.ItemEnabled[41]:=False;

  if (FfrmOptions.ShowModal = mrOK) then
  begin
    FstrGameDir:=FfrmOptions.FedGameDirectory.Text;
    FstrSaveDir:=FfrmOptions.FedSaveDirectory.Text;
    FboInterested:=FfrmOptions.FcbInterested.Checked;

    if (FfrmOptions.FcbDefaultColumns.Checked) then
    begin
      for j:=0 to FlvPlayers.Header.Columns.Count - 1 do
        FlvPlayers.Header.Columns[j].Options:=FlvPlayers.Header.Columns[j].Options - [coVisible];

      for j:=0 to Length(DEFAULT_COLUMNS) - 1 do
      begin
        FlvPlayers.Header.Columns[DEFAULT_COLUMNS[j]].Options:=FlvPlayers.Header.Columns[DEFAULT_COLUMNS[j]].Options + [coVisible];
        FlvPlayers.Header.Columns[DEFAULT_COLUMNS[j]].Position:=j;
      end;
    end
    else
    begin
      for j:=0 to FlvPlayers.Header.Columns.Count - 1 do
        if (FfrmOptions.FclColumns.Checked[j]) then
          FlvPlayers.Header.Columns[j].Options:=FlvPlayers.Header.Columns[j].Options + [coVisible]
        else
          FlvPlayers.Header.Columns[j].Options:=FlvPlayers.Header.Columns[j].Options - [coVisible];
    end;
  end;
end;

procedure TFfrmMain.FactPlayerSearchExecute(Sender: TObject);
var
  psSearch: TPlayerSearch;
begin
  FfrmPSearch.Left:=FfrmMain.Left + ((FfrmMain.Width - FfrmPSearch.Width) div 2);
  FfrmPSearch.Top:=FfrmMain.Top + ((FfrmMain.Height - FfrmPSearch.Height) div 2);
  if (FfrmPSearch.ShowModal = mrOK) then
  begin
    FstbStatus.Panels[1].Text:='';
    FstbStatus.Panels[1].PanelType:=sptGauge;
    FstbStatus.Panels[1].Alignment:=taCenter;
    FstbStatus.Panels[1].BorderWidth:=0;
    psSearch:=TPlayerSearch.Create(FcdData, FlcPlayers);
    psSearch.OnStatus:=psSearchStatus;
    psSearch.OnProgress:=psSearchProgress;
    FstbStatus.Panels[0].Text:='Clearing List';
    FstbStatus.Update;

    FlcPlayers.Clear;
    psSearch.Search;
    FlcPlayers.Update;
    
    FstbStatus.Panels[0].Text:=FstrGameName;
    FstbStatus.Panels[1].PanelType:=sptNormal;
    FstbStatus.Panels[1].BorderWidth:=1;
    FstbStatus.Panels[1].Alignment:=taLeftJustify;
    FstbStatus.Panels[1].Text:=IntToStr(FlcPlayers.Count) + ' Players Found.';
    psSearch.Free;

    // Update menu/toolbar items
    FactSave.Enabled:=(FlcPlayers.Count > 0);
  end;
end;

procedure TFfrmMain.psSearchStatus(Sender: TObject; Status: String);
begin
  FstbStatus.Panels[0].Text:=Status;
  FstbStatus.Update;
end;

procedure TFfrmMain.psSearchProgress(Sender: TObject; Position: Integer);
begin
  FstbStatus.Panels[1].GaugeAttrs.Position:=Position;
  FstbStatus.Update;
end;

procedure TFfrmMain.FactTeamSearchExecute(Sender: TObject);
var
  clChoosenClub: PClub;
  j: Integer;
begin
  FfrmClub.Left:=FfrmMain.Left + ((FfrmMain.Width - FfrmClub.Width) div 2);
  FfrmClub.Top:=FfrmMain.Top + ((FfrmMain.Height - FfrmClub.Height) div 2);
  if (FfrmClub.ShowModal = mrOK) then
  begin
    if (FfrmClub.FcmbClub.ItemIndex > -1) then
    begin
      FstbStatus.Panels[0].Text:='Clearing List';
      FstbStatus.Update;
      FlcPlayers.Clear;
      clChoosenClub:=PClub(FfrmClub.FcmbClub.Items.Objects[FfrmClub.FcmbClub.ItemIndex]);
      FstbStatus.Panels[1].Text:=clChoosenClub.ShortName + ', Reputation: ' + IntToStr(clChoosenClub.Reputation);

      for j:=0 to 49 do
        if (clChoosenClub.Squad[j] <> nil) then
          FlcPlayers.Add(clChoosenClub.Squad[j]);

      FlcPlayers.Update;

      FstbStatus.Panels[0].Text:=FstrGameName;

      // Update menu/toolbar items
      FactSave.Enabled:=(FlcPlayers.Count > 0);
    end;
  end;
end;

procedure TFfrmMain.FlvPlayersHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if (Button = mbLeft) then
  begin
    if (FlvPlayers.Header.SortColumn <> Column) then
    begin
      FlvPlayers.Header.SortColumn:=Column;
      FlvPlayers.Header.SortDirection:=sdAscending;
    end
    else
    begin
      if (FlvPlayers.Header.SortDirection = sdDescending) then
        FlvPlayers.Header.SortDirection:=sdAscending
      else
        FlvPlayers.Header.SortDirection:=sdDescending;
    end;
  end;
end;

procedure TFfrmMain.FmnuiExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFfrmMain.FactSaveExecute(Sender: TObject);
var
  slList: TScoutList;
  twWriter: TTextWriter;
begin
  FdiaSave.InitialDir:=FstrSaveDir;
  FdiaSave.Title:='Save a Scout List';

  if (FdiaSave.Execute) then
  begin
    if (ExtractFileExt(FdiaSave.FileName) = '.pls') then
    begin
      FstrSaveDir:=ExtractFilePath(FdiaSave.Filename);

      slList:=TScoutList.Create(FdiaSave.Filename, FlcPlayers);
      slList.WriteList(FboInterested);
      slList.Free;
    end
    else if (ExtractFileExt(FdiaSave.FileName) = '.csv') then
    begin
      FstrSaveDir:=ExtractFilePath(FdiaSave.Filename);

      twWriter:=TCSVWriter.Create(FdiaSave.FileName, FlcPlayers, FlvPlayers);
      twWriter.WriteTextFile;
      twWriter.Free;
    end
    else if (ExtractFileExt(FdiaSave.FileName) = '.txt') then
    begin
      FstrSaveDir:=ExtractFilePath(FdiaSave.Filename);

      twWriter:=TTXTWriter.Create(FdiaSave.FileName, FlcPlayers, FlvPlayers);
      twWriter.WriteTextFile;
      twWriter.Free;
    end;
  end;
end;

procedure TFfrmMain.FpopHeaderAddHeaderPopupItem(
  const Sender: TBaseVirtualTree; const Column: TColumnIndex;
  var Cmd: TAddPopupItemType);
begin
  if (Column = 41) then
    Cmd:=apDisabled
  else
    Cmd:=apNormal;
end;

procedure TFfrmMain.FlvPlayersDblClick(Sender: TObject);
var
  Data: PStaffRecord;
begin
  if (FlvPlayers.SelectedCount = 1) then
  begin
    Data:=FlvPlayers.GetNodeData(FlvPlayers.GetFirstSelected);
    FfrmPlayer.ShowPlayer(Data.Staff);
  end;
end;

procedure TFfrmMain.FmnuiAboutClick(Sender: TObject);
begin
  MessageBox(Handle, 'CM Scout 2.00, by Michael Nygreen', 'CM Scout 2.00', 0);
end;

end.
