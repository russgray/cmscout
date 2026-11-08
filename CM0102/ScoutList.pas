unit ScoutList;

{ $Id: ScoutList.pas,v 1.1 2002/04/25 22:13:07 michael Exp $ }

interface

uses
  SearchUnit, Classes, SysUtils, CMDataRepresentation;

type
  TScoutList = class
  private
    FlcPlayers: TListContents;
    FstrFilename: String;
  public
    constructor Create(Filename: String; Players: TListContents);
    procedure WriteList(Interested: Boolean);
  end;

const
  byPlsStart: array[0..5] of Byte = ($9E, $4A, $02, $00, $01, $04);
  byPlsMid: array[0..7] of Byte = ($7E, $68, $00, $00, $FA, $00, $00, $00);
  byPlsDelimiter: Byte = $FF;
  byPlsEnd: array[0..185] of Byte = ($81, $00, $14, $14, $84, $A8, $AA, $44, $10, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $00, $80, $00, $00, $00, $00, $00,
                                   $FF, $FF, $FF, $FF, $FF, $01, $FF, $FF, $FF, $FF, $FF, $00,
                                   $05, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
                                   $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
                                   $01, $01, $01, $01, $01, $01, $01, $01, $14, $14, $14, $14,
                                   $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14,
                                   $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14,
                                   $14, $14, $14, $00, $00, $01, $01, $01, $01, $01, $01, $01,
                                   $01, $01, $01, $01, $01, $14, $14, $14, $14, $14, $14, $14,
                                   $14, $14, $14, $14, $14, $00, $00, $00, $00, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $81, $00, $00, $00, $04, $00, $00,
                                   $00, $FF, $FF, $00, $00, $00, $00, $01, $00, $01, $FF, $FF,
                                   $FF, $FF, $F2, $FF, $FF, $F2);

  byPlsEIn: array[0..185] of Byte = ($81, $00, $14, $14, $84, $28, $AB, $44, $10, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $00, $80, $00, $00, $00, $00, $00,
                                   $FF, $FF, $FF, $FF, $FF, $01, $FF, $FF, $FF, $FF, $FF, $00,
                                   $05, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
                                   $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
                                   $01, $01, $01, $01, $01, $01, $01, $01, $14, $14, $14, $14,
                                   $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14,
                                   $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14, $14,
                                   $14, $14, $14, $00, $00, $01, $01, $01, $01, $01, $01, $01,
                                   $01, $01, $01, $01, $01, $14, $14, $14, $14, $14, $14, $14,
                                   $14, $14, $14, $14, $14, $00, $00, $00, $00, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
                                   $00, $00, $00, $00, $00, $81, $00, $00, $00, $04, $00, $00,
                                   $00, $FF, $FF, $00, $00, $00, $00, $01, $00, $01, $FF, $FF,
                                   $FF, $FF, $F2, $FF, $FF, $F2);

  byPlsName: array[0..14] of Char = ('C', 'M', ' ', 'S', 'c', 'o', 'u', 't', ' ', 'S', 'e', 'a', 'r', 'c', 'h');
  byPlsManName: array[0..14] of Char = ('M', 'i', 'c', 'h', 'a', 'e', 'l', ' ', 'N', 'y', 'g', 'r', 'e', 'e', 'n');

  byPlsZero: Byte = $00;

implementation

constructor TScoutList.Create(Filename: String; Players: TListContents);
begin
  inherited Create;
  FstrFilename:=Filename;
  FlcPlayers:=Players;
end;

procedure TScoutList.WriteList(Interested: Boolean);
var
  filScoutList: TFileStream;
  j,
  s: Integer;
begin
  filScoutList:=TFileStream.Create(FstrFilename, fmCreate or fmShareDenyWrite);
  filScoutList.Write(byPlsStart, 6);

  filScoutList.Write(byPlsName, 15);
  for j:=0 to 85 do
    filScoutList.Write(byPlsZero, 1);

  filScoutList.Write(byPlsManName, 15);
  for j:=0 to 236 do
    filScoutList.Write(byPlsZero, 1);

  filScoutList.Write(byPlsMid, 8);

  j:=FlcPlayers.Count;
  filScoutList.Write(j, SizeOf(Integer));

  for j:=0 to FlcPlayers.Count - 1 do
  begin
    filScoutList.Write(FlcPlayers[j].FirstName.ID, 4);
    filScoutList.Write(FlcPlayers[j].SecondName.ID, 4);
    filScoutList.Write(FlcPlayers[j].CommonName.ID, 4);
    filScoutList.Write(FlcPlayers[j].ID, 4);
    filScoutList.Write(FlcPlayers[j].DateOfBirth, SizeOf(TCMDate));

    for s:=0 to 19 do
      filScoutList.Write(byPlsZero, 1);
    filScoutList.Write(byPlsDelimiter, 1);
  end;

  if (Interested) then
    filScoutList.Write(byPlsEIn, 186)
  else
    filScoutList.Write(byPlsEnd, 186);

  filScoutList.Free;
end;

end.
