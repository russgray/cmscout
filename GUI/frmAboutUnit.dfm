object frmAbout: TfrmAbout
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'About'
  ClientHeight = 95
  ClientWidth = 193
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblAbout1: TLabel
    Left = 8
    Top = 8
    Width = 177
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'CM Scout v. 3.00'
  end
  object lblAbout2: TLabel
    Left = 8
    Top = 24
    Width = 177
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'by Michael Nygreen'
  end
  object lblAbout3: TLabel
    Left = 8
    Top = 40
    Width = 177
    Height = 13
    Cursor = crHandPoint
    Alignment = taCenter
    AutoSize = False
    Caption = 'http://www.nygreen.net/'
    OnClick = lblAbout3Click
  end
  object btnOK: TButton
    Left = 56
    Top = 64
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
