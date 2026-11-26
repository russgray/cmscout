unit frmOptionsUnit;

{ $Id: frmOptionsUnit.pas,v 1.2 2002/04/25 22:13:07 michael Exp $ }

interface

uses
  Forms, StdCtrls, ComCtrls, Classes, Controls, CheckLst,
  Buttons, BrowseDr, Graphics;

type
  TFfrmOptions = class(TForm)
    FpcOptions: TPageControl;
    FtsGeneral: TTabSheet;
    FtsColumns: TTabSheet;
    FbtnOK: TButton;
    FbtnCancel: TButton;
    FclColumns: TCheckListBox;
    FlblGameDirectory: TLabel;
    FedGameDirectory: TEdit;
    FsbGameDirectory: TSpeedButton;
    FlblSaveDirectory: TLabel;
    FedSaveDirectory: TEdit;
    FspSaveDirectory: TSpeedButton;
    FcbInterested: TCheckBox;
    FdiaDir: TdfsBrowseDirectoryDlg;
    FcbDefaultColumns: TCheckBox;
    procedure FsbGameDirectoryClick(Sender: TObject);
    procedure FspSaveDirectoryClick(Sender: TObject);
    procedure FcbDefaultColumnsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FfrmOptions: TFfrmOptions;

implementation

{$R *.DFM}

procedure TFfrmOptions.FsbGameDirectoryClick(Sender: TObject);
begin
  FdiaDir.Title:='Select Game Directory:';
  FdiaDir.Selection:=FedGameDirectory.Text;
  if (FdiaDir.Execute) then
    if (FdiaDir.Selection[Length(FdiaDir.Selection)] <> '\') then
      FedGameDirectory.Text:=FdiaDir.Selection + '\'
    else
      FedGameDirectory.Text:=FdiaDir.Selection;
end;

procedure TFfrmOptions.FspSaveDirectoryClick(Sender: TObject);
begin
  FdiaDir.Title:='Select Save Directory:';
  FdiaDir.Selection:=FedSaveDirectory.Text;
  if (FdiaDir.Execute) then
    if (FdiaDir.Selection[Length(FdiaDir.Selection)] <> '\') then
      FedSaveDirectory.Text:=FdiaDir.Selection + '\'
    else
      FedSaveDirectory.Text:=FdiaDir.Selection;
end;

procedure TFfrmOptions.FcbDefaultColumnsClick(Sender: TObject);
begin
  if (FcbDefaultColumns.Checked) then
    FclColumns.Color:=clBtnFace
  else
    FclColumns.Color:=clWindow;

  FclColumns.Enabled:=not FcbDefaultColumns.Checked;
end;

end.
