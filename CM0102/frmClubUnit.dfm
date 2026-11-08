object FfrmClub: TFfrmClub
  Left = 192
  Top = 107
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Choose Club'
  ClientHeight = 70
  ClientWidth = 164
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FbtnOK: TButton
    Left = 4
    Top = 37
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object FbtnCancel: TButton
    Left = 84
    Top = 37
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object FcmbClub: TComboBox
    Left = 4
    Top = 8
    Width = 156
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
end
