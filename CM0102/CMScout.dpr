program CMScout;

uses
  Forms,
  frmMainUnit in 'frmMainUnit.pas' {FfrmMain},
  frmOptionsUnit in 'frmOptionsUnit.pas' {FfrmOptions},
  frmPSearchUnit in 'frmPSearchUnit.pas' {FfrmPSearch},
  frmClubUnit in 'frmClubUnit.pas' {FfrmClub},
  frmPlayerUnit in 'frmPlayerUnit.pas' {FfrmPlayer};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CM Scout 2.00';
  Application.CreateForm(TFfrmMain, FfrmMain);
  Application.CreateForm(TFfrmOptions, FfrmOptions);
  Application.CreateForm(TFfrmPSearch, FfrmPSearch);
  Application.CreateForm(TFfrmClub, FfrmClub);
  Application.CreateForm(TFfrmPlayer, FfrmPlayer);
  Application.Run;
end.
