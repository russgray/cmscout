unit frmAboutUnit;

interface

uses
  Forms, Controls, StdCtrls, Classes, ShellApi, Windows;

type
  TfrmAbout = class(TForm)
    btnOK: TButton;
    lblAbout1: TLabel;
    lblAbout2: TLabel;
    lblAbout3: TLabel;
    procedure lblAbout3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.lblAbout3Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://www.nygreen.net', '', '', SW_SHOW);
end;

end.
