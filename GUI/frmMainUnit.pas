unit frmMainUnit;

interface

uses
  Forms, Dialogs, Menus, VTHeaderPopup, ImgList, Controls,
  Classes, ActnList, ComCtrls, CMScoutControls, ToolWin,
  VirtualTrees, CM4SaveGameDatabase, CMScoutSearch, Registry,
  SysUtils;

type
  TfrmMain = class(TForm)
    lvPlayers: TVirtualStringTree;
    mmnuMenu: TMainMenu;
    tbToolBar: TToolBar;
    mnuFile: TMenuItem;
    mnuSearch: TMenuItem;
    mnuHelp: TMenuItem;
    sbStatusBar: TCMScoutStatusBar;
    aclActions: TActionList;
    acLoadGame: TAction;
    mnuLoadGame: TMenuItem;
    diaLoadGame: TOpenDialog;
    ilMenu: TImageList;
    tbtnLoadGame: TToolButton;
    pmnuHeaders: TVTHeaderPopupMenu;
    mnuLine1: TMenuItem;
    acOptions: TAction;
    mnuOptions: TMenuItem;
    mnuLine2: TMenuItem;
    acExit: TAction;
    mnuExit: TMenuItem;
    acPlayerSearch: TAction;
    tbtnSeparator1: TToolButton;
    tbtnPlayerSearch: TToolButton;
    mnuPlayerSearch: TMenuItem;
    acTeamSearch: TAction;
    mnuTeamSearch: TMenuItem;
    tbtnTeamSearch: TToolButton;
    ilDisabledMenu: TImageList;
    acSave: TAction;
    tbtnSave: TToolButton;
    mnuSave: TMenuItem;
    diaSave: TSaveDialog;
    acLoadShortlist: TAction;
    mnuLoadShortlist: TMenuItem;
    mnuAbout: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acLoadGameExecute(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acOptionsExecute(Sender: TObject);
    procedure acPlayerSearchExecute(Sender: TObject);
    procedure lvPlayersHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure acTeamSearchExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure lvPlayersDblClick(Sender: TObject);
    procedure acLoadShortlistExecute(Sender: TObject);
    procedure mnuAboutClick(Sender: TObject);
  private
    FCMData: TCM4SaveGameDatabase;
    FCMSearch: TCMScoutSearch;
    FGameDir: string;
    FSaveDir: string;
    FLangDB: string;
    FLoadLangDB: Boolean;

    procedure OnProgress(Progress: Integer);
    procedure OnStatus(Status: string);
    procedure ReadOptions;
    procedure SaveOptions;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  frmOptionsUnit, frmPlayerInfoUnit, frmAboutUnit;

{$R *.dfm}

procedure TfrmMain.ReadOptions;
var
  CMReg: TRegistry;
  CMPath: string;
  j: Integer;
begin
  FLoadLangDB:=False;
  
  CMReg:=TRegistry.Create;

  try
    if CMReg.OpenKey('Software\nygreen.net\CMScout', False) then
    begin
      FGameDir:=CMReg.ReadString('GameDir');
      FSaveDir:=CMReg.ReadString('SaveDir');
      FLangDB:=CMReg.ReadString('LangDB');

      if CMReg.ValueExists('LoadLangDB') then
        FLoadLangDB:=CMReg.ReadBool('LoadLangDB');

      if CMReg.ValueExists('WindowHeight') then
        Height:=CMReg.ReadInteger('WindowHeight');
      if CMReg.ValueExists('WindowWidth') then
        Width:=CMReg.ReadInteger('WindowWidth');
      if CMReg.ValueExists('WindowLeft') then
        Left:=CMReg.ReadInteger('WindowLeft');
      if CMReg.ValueExists('WindowTop') then
        Top:=CMReg.ReadInteger('WindowTop');
      if CMReg.ValueExists('WindowState') then
        WindowState:=TWindowState(CMReg.ReadInteger('WindowState'));

      if CMReg.OpenKey('Columns\Players', False) then
      begin
        for j:=0 to lvPlayers.Header.Columns.Count - 1 do
        begin
          if CMReg.ValueExists('Position' + IntToStr(j)) then
            lvPlayers.Header.Columns[j].Position:=CMReg.ReadInteger('Position' + IntToStr(j));
          if CMReg.ValueExists('Visible' + IntToStr(j)) then
          begin
            if CMReg.ReadBool('Visible' + IntToStr(j)) then
              lvPlayers.Header.Columns[j].Options:=lvPlayers.Header.Columns[j].Options + [coVisible]
            else
              lvPlayers.Header.Columns[j].Options:=lvPlayers.Header.Columns[j].Options - [coVisible];
          end;
          if CMReg.ValueExists('Width' + IntToStr(j)) then
            lvPlayers.Header.Columns[j].Width:=CMReg.ReadInteger('Width' + IntToStr(j));
        end;
      end;
    end;

    if (FGameDir = '') or (FSaveDir = '') or (FLangDB = '') then
    begin
      CMReg.CloseKey;
      if CMReg.OpenKey('Software\Sports Interactive Ltd\Installs\Championship Manager 4', False) then
      begin
        if CMReg.ValueExists('Path') then
        begin
          CMPath:=CMReg.ReadString('Path');
          if CMPath <> '' then
          begin
            CMPath:=IncludeTrailingPathDelimiter(CMPath);
            if FGameDir = '' then
              FGameDir:=CMPath + 'user data\games';
            if FSaveDir = '' then
              FSaveDir:=CMPath + 'user data';
            if FLangDB = '' then
            begin
              FLangDB:=CMPath + 'data\lang_db.dat';
              FLoadLangDB:=FileExists(FLangDB);
            end;
          end;
        end;
      end;
    end;
  finally
    CMReg.Free;
  end;
end;

procedure TfrmMain.SaveOptions;
var
  CMReg: TRegistry;
  j: Integer;
begin
  CMReg:=TRegistry.Create;

  try
    if CMReg.OpenKey('Software\nygreen.net\CMScout', True) then
    begin
      CMReg.WriteString('GameDir', FGameDir);
      CMReg.WriteString('SaveDir', FSaveDir);
      CMReg.WriteString('LangDB', FLangDB);
      CMReg.WriteBool('LoadLangDB', FLoadLangDB);
      CMReg.WriteInteger('WindowState', Integer(WindowState));

      if WindowState = wsMaximized then
      begin
        Visible:=False;
        WindowState:=wsNormal;
        Visible:=True;
      end;

      CMReg.WriteInteger('WindowHeight', Height);
      CMReg.WriteInteger('WindowWidth', Width);
      CMReg.WriteInteger('WindowLeft', Left);
      CMReg.WriteInteger('WindowTop', Top);

      if CMReg.OpenKey('Columns\Players', True) then
      begin
        for j:=0 to lvPlayers.Header.Columns.Count - 1 do
        begin
          CMReg.WriteInteger('Position' + IntToStr(j), lvPlayers.Header.Columns[j].Position);
          CMReg.WriteBool('Visible' + IntToStr(j), coVisible in lvPlayers.Header.Columns[j].Options);
          CMReg.WriteInteger('Width' + IntToStr(j), lvPlayers.Header.Columns[j].Width);
        end;
      end;
    end;
  finally
    CMReg.Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ReadOptions;
  FCMData:=TCM4SaveGameDatabase.Create;
  FCMData.OnStatus:=OnStatus;
  FCMData.OnProgress:=OnProgress;

  FCMSearch:=TCMScoutSearch.Create(lvPlayers);
  FCMSearch.CMData:=FCMData;
  FCMSearch.OnStatus:=OnStatus;
  FCMSearch.OnProgress:=OnProgress;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveOptions;
  FCMSearch.Free;
  FCMData.Free;
end;

procedure TfrmMain.acLoadGameExecute(Sender: TObject);
begin
  diaLoadGame.InitialDir:=FGameDir;
  diaLoadGame.Filter:='CM4 Saved Games (*.cm4)|*.cm4';
  diaLoadGame.Title:='Load Saved Game';

  if diaLoadGame.Execute then
  begin
    FGameDir:=ExtractFileDir(diaLoadGame.FileName);
    
    FCMData.Filename:=diaLoadGame.FileName;
    FCMData.LoadLangDB:=FLoadLangDB;
    FCMData.LangDB:=FLangDB;
    
    frmMain.Update;
    sbStatusBar.PBVisible:=True;

    acPlayerSearch.Enabled:=False;
    acTeamSearch.Enabled:=False;
    acSave.Enabled:=False;
    acLoadShortlist.Enabled:=False;

    FCMSearch.Clear;

    try
      try
        FCMData.Load;

        FCMSearch.CMData:=FCMData;
        
        sbStatusBar.Date:=FCMData.GameDate.Date;
        sbStatusBar.Status:=Copy(ExtractFileName(diaLoadGame.FileName), 1, Length(ExtractFileName(diaLoadGame.FileName)) - Length(ExtractFileExt(diaLoadGame.FileName)));

        acPlayerSearch.Enabled:=True;
        acTeamSearch.Enabled:=True;
        acLoadShortlist.Enabled:=True;
      finally
        sbStatusBar.PBVisible:=False;
      end;
    except
      sbStatusBar.Date:=0;
      sbStatusBar.Status:='';
      raise;
    end;
  end;
end;

procedure TfrmMain.OnStatus(Status: string);
begin
  sbStatusBar.Status:=Status;
  frmMain.Update;
end;

procedure TfrmMain.OnProgress(Progress: Integer);
begin
  sbStatusBar.Position:=Progress;
end;

procedure TfrmMain.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.acOptionsExecute(Sender: TObject);
var
  j: Integer;
begin
  frmOptions.edGameDir.Text:=FGameDir;
  frmOptions.edSaveDir.Text:=FSaveDir;
  frmOptions.edLangDB.Text:=FLangDB;
  frmOptions.cbLoadLangDB.Checked:=FLoadLangDB;

  frmOptions.lbColumns.Clear;
  
  for j:=0 to lvPlayers.Header.Columns.Count - 1 do
    frmOptions.lbColumns.Checked[frmOptions.lbColumns.Items.AddObject(lvPlayers.Header.Columns[j].Text, Pointer(j))]:=coVisible in lvPlayers.Header.Columns[j].Options;
  frmOptions.lbColumns.ItemEnabled[frmOptions.lbColumns.Items.IndexOfObject(Pointer(0))]:=False;

  if frmOptions.ShowModal = mrOK then
  begin
    FGameDir:=frmOptions.edGameDir.Text;
    FSaveDir:=frmOptions.edSaveDir.Text;
    FLangDB:=frmOptions.edLangDB.Text;
    FLoadLangDB:=frmOptions.cbLoadLangDB.Checked;

    if frmOptions.cbDefaultColumns.Checked then
    begin
      for j:=0 to 9 do
        lvPlayers.Header.Columns[j].Options:=lvPlayers.Header.Columns[j].Options + [coVisible];
      for j:=10 to lvPlayers.Header.Columns.Count - 1 do
        lvPlayers.Header.Columns[j].Options:=lvPlayers.Header.Columns[j].Options - [coVisible];
    end
    else
    begin
      for j:=0 to frmOptions.lbColumns.Count - 1 do
        if frmOptions.lbColumns.Checked[j] then
          lvPlayers.Header.Columns[Integer(frmOptions.lbColumns.Items.Objects[j])].Options:=lvPlayers.Header.Columns[Integer(frmOptions.lbColumns.Items.Objects[j])].Options + [coVisible]
        else
          lvPlayers.Header.Columns[Integer(frmOptions.lbColumns.Items.Objects[j])].Options:=lvPlayers.Header.Columns[Integer(frmOptions.lbColumns.Items.Objects[j])].Options - [coVisible];
    end;
  end;
end;

procedure TfrmMain.acPlayerSearchExecute(Sender: TObject);
var
  Status: string;
begin
  Status:=sbStatusBar.Status;
  sbStatusBar.PBVisible:=True;
  FCMSearch.Search;
  sbStatusBar.PBVisible:=False;
  sbStatusBar.Status:=Status;
  sbStatusBar.PBText:=IntToStr(FCMSearch.Count) + ' Players Found';

  acSave.Enabled:=FCMSearch.Count > 0;
end;

procedure TfrmMain.lvPlayersHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if (Button = mbLeft) then
  begin
    if lvPlayers.Header.SortColumn <> Column then
    begin
      lvPlayers.Header.SortColumn:=Column;
      lvPlayers.Header.SortDirection:=sdAscending;
    end
    else
    begin
      if lvPlayers.Header.SortDirection = sdDescending then
        lvPlayers.Header.SortDirection:=sdAscending
      else
        lvPlayers.Header.SortDirection:=sdDescending;
    end;
  end;
end;

procedure TfrmMain.acTeamSearchExecute(Sender: TObject);
var
  Status: string;
begin
  Status:=sbStatusBar.Status;
  FCMSearch.TeamSearch;
  sbStatusBar.PBText:=IntToStr(FCMSearch.Count) + ' Players Found';
  sbStatusBar.Status:=Status;

  acSave.Enabled:=FCMSearch.Count > 0;
end;

procedure TfrmMain.acSaveExecute(Sender: TObject);
begin
  diaSave.InitialDir:=FSaveDir;
  if diaSave.Execute then
  begin
    FSaveDir:=ExtractFileDir(diaSave.FileName);
    FCMSearch.SaveShortlist(diaSave.FileName);
  end;
end;

procedure TfrmMain.lvPlayersDblClick(Sender: TObject);
begin
  if lvPlayers.SelectedCount = 1 then
  begin
    frmPlayerInfo.CMData:=FCMData;
    frmPlayerInfo.Player:=Pointer(lvPlayers.GetNodeData(lvPlayers.GetFirstSelected)^);
    frmPlayerInfo.ShowModal;
  end;
end;

procedure TfrmMain.acLoadShortlistExecute(Sender: TObject);
var
  TempFile: string;
begin
  TempFile:=diaLoadGame.FileName;
  diaLoadGame.FileName:='';
  diaLoadGame.InitialDir:=FSaveDir;
  diaLoadGame.Filter:='CM4 Shortlist File (*.slf)|*.slf';
  diaLoadGame.Title:='Load Shortlist';

  if diaLoadGame.Execute then
  begin
    FSaveDir:=ExtractFileDir(diaLoadGame.FileName);
    sbStatusBar.PBText:='Loading Shortlist File';

    try
      FCMSearch.LoadShortList(diaLoadGame.FileName);
    finally
      diaLoadGame.FileName:=TempFile;
      sbStatusBar.PBText:=IntToStr(FCMSearch.Count) + ' Players Found';
      acSave.Enabled:=FCMSearch.Count > 0;
    end;
  end;
end;

procedure TfrmMain.mnuAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

end.
