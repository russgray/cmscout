object frmTeamSearch: TfrmTeamSearch
  Left = 191
  Top = 114
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Team Search'
  ClientHeight = 138
  ClientWidth = 171
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblClub: TLabel
    Left = 8
    Top = 8
    Width = 24
    Height = 13
    Caption = 'Club:'
  end
  object lblSquad: TLabel
    Left = 8
    Top = 56
    Width = 34
    Height = 13
    Caption = 'Squad:'
  end
  object btnOK: TButton
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 88
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object cmbClub: TComboBox
    Left = 8
    Top = 24
    Width = 155
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnChange = cmbClubChange
  end
  object cmbSquad: TComboBox
    Left = 8
    Top = 72
    Width = 155
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
end
