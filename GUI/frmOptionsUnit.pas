unit frmOptionsUnit;

interface

uses
  Forms, Dialogs, Controls, StdCtrls, CheckLst, Buttons,
  ComCtrls, Classes, FileCtrl, CM4ComboBox;

type
  TfrmOptions = class(TForm)    
    pcOptions: TPageControl;
    tsGeneral: TTabSheet;
    tsColumns: TTabSheet;
    btnCancel: TButton;
    btnOK: TButton;
    edGameDir: TEdit;
    edLangDB: TEdit;
    lblGameDir: TLabel;
    lblSaveDir: TLabel;
    lblLangDB: TLabel;
    cbLoadLangDB: TCheckBox;
    edSaveDir: TEdit;
    diaFindLangDB: TOpenDialog;
    btnGameDir: TBitBtn;
    btnSaveDir: TBitBtn;
    btnLangDB: TBitBtn;
    cbDefaultColumns: TCheckBox;
    lbColumns: TCheckListBox;
    cmbLanguage: TIntegerComboBox;
    lblLanguage: TLabel;
    procedure btnGameDirClick(Sender: TObject);
    procedure btnSaveDirClick(Sender: TObject);
    procedure btnLangDBClick(Sender: TObject);
    procedure cbDefaultColumnsClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

procedure TfrmOptions.btnGameDirClick(Sender: TObject);
var
  Directory: string;
begin
  Directory:=edGameDir.Text;
  if SelectDirectory('Find Game Directory', '', Directory) then
    edGameDir.Text:=Directory;
end;

procedure TfrmOptions.btnSaveDirClick(Sender: TObject);
var
  Directory: string;
begin
  Directory:=edSaveDir.Text;
  if SelectDirectory('Find Save Directory', '', Directory) then
    edSaveDir.Text:=Directory;
end;

procedure TfrmOptions.btnLangDBClick(Sender: TObject);
begin
  diaFindLangDB.FileName:=edLangDB.Text;
  if diaFindLangDB.Execute then
    edLangDB.Text:=diaFindLangDB.FileName;
end;

procedure TfrmOptions.cbDefaultColumnsClick(Sender: TObject);
begin
  lbColumns.Enabled:=not cbDefaultColumns.Checked;
end;

constructor TfrmOptions.Create(AOwner: TComponent);
begin
  inherited;
  cmbLanguage.AddInteger('English', 8);
  cmbLanguage.AddInteger('Dutch', 7);
  cmbLanguage.AddInteger('French', 10);
  cmbLanguage.AddInteger('German', 11);
  cmbLanguage.AddInteger('Italian', 15);
  cmbLanguage.AddInteger('Polish', 18);
  cmbLanguage.AddInteger('Portuguese', 19);
  cmbLanguage.AddInteger('Norwegian', 22);
  cmbLanguage.AddInteger('Spanish', 24);
  cmbLanguage.AddInteger('Swedish', 30);
  cmbLanguage.AddInteger('Danish', 32);
end;

end.
