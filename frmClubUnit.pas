unit frmClubUnit;

{ $Id: frmClubUnit.pas,v 1.1 2003/04/24 18:27:32 nygreen Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFfrmClub = class(TForm)
    FbtnOK: TButton;
    FbtnCancel: TButton;
    FcmbClub: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FfrmClub: TFfrmClub;

implementation

{$R *.DFM}

end.
