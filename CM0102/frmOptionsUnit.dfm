object FfrmOptions: TFfrmOptions
  Left = 192
  Top = 107
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Preferences'
  ClientHeight = 300
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FpcOptions: TPageControl
    Left = 5
    Top = 8
    Width = 337
    Height = 257
    ActivePage = FtsGeneral
    TabIndex = 0
    TabOrder = 0
    object FtsGeneral: TTabSheet
      Caption = '&General'
      object FlblGameDirectory: TLabel
        Left = 4
        Top = 40
        Width = 76
        Height = 13
        Caption = 'G&ame Directory:'
        FocusControl = FedGameDirectory
      end
      object FsbGameDirectory: TSpeedButton
        Left = 302
        Top = 56
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          040000000000800000000000000000000000100000001000000000000000187B
          9C00188BB800189CC60040FF400021A5CE005ABDCE0039BDD60052C0EB007BE2
          FB0081E1FF008CF5FD0099FCFF00A5FFFF00F7FFFF00FFFFFF00441111111111
          4444433333333333144433C9999999993144339C999999997144357CBBBBBBBA
          8144385DCCCCCCCC8614393BCCCCCCCC8C143A36FFEFFFFFAF143B8333333333
          33143CBBBBBFFFFF31443FCCCCF33333344445FFFF3444444444445555444444
          0004444444444444400444444444044404044444444440004444}
        OnClick = FsbGameDirectoryClick
      end
      object FlblSaveDirectory: TLabel
        Left = 4
        Top = 96
        Width = 73
        Height = 13
        Caption = 'Save Directory:'
        FocusControl = FedSaveDirectory
      end
      object FspSaveDirectory: TSpeedButton
        Left = 302
        Top = 112
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          040000000000800000000000000000000000100000001000000000000000187B
          9C00188BB800189CC60040FF400021A5CE005ABDCE0039BDD60052C0EB007BE2
          FB0081E1FF008CF5FD0099FCFF00A5FFFF00F7FFFF00FFFFFF00441111111111
          4444433333333333144433C9999999993144339C999999997144357CBBBBBBBA
          8144385DCCCCCCCC8614393BCCCCCCCC8C143A36FFEFFFFFAF143B8333333333
          33143CBBBBBFFFFF31443FCCCCF33333344445FFFF3444444444445555444444
          0004444444444444400444444444044404044444444440004444}
        OnClick = FspSaveDirectoryClick
      end
      object FedGameDirectory: TEdit
        Left = 4
        Top = 56
        Width = 296
        Height = 21
        TabOrder = 0
      end
      object FedSaveDirectory: TEdit
        Left = 4
        Top = 112
        Width = 296
        Height = 21
        TabOrder = 1
      end
      object FcbInterested: TCheckBox
        Left = 4
        Top = 192
        Width = 261
        Height = 17
        Caption = 'Save Scout Lists With &Interested Filter'
        TabOrder = 2
      end
    end
    object FtsColumns: TTabSheet
      Caption = '&Columns'
      ImageIndex = 1
      object FclColumns: TCheckListBox
        Left = 4
        Top = 4
        Width = 320
        Height = 203
        ItemHeight = 13
        TabOrder = 0
      end
      object FcbDefaultColumns: TCheckBox
        Left = 4
        Top = 211
        Width = 133
        Height = 17
        Caption = 'Use Default Columns'
        TabOrder = 1
        OnClick = FcbDefaultColumnsClick
      end
    end
  end
  object FbtnOK: TButton
    Left = 187
    Top = 271
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object FbtnCancel: TButton
    Left = 267
    Top = 271
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object FdiaDir: TdfsBrowseDirectoryDlg
    Caption = 'Select Directory'
    ShowSelectionInStatus = False
    Left = 312
    Top = 8
  end
end
