program CMScout;

uses
  Forms,
  frmMainUnit in 'frmMainUnit.pas' {frmMain},
  frmOptionsUnit in 'frmOptionsUnit.pas' {frmOptions},
  frmPlayerInfoUnit in 'frmPlayerInfoUnit.pas' {frmPlayerInfo},
  frmAboutUnit in 'frmAboutUnit.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CM Scout 3.00';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.CreateForm(TfrmPlayerInfo, frmPlayerInfo);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
