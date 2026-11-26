unit CMFunctions;

{ $Id: CMFunctions.pas,v 1.7 2002/05/10 19:08:25 michael Exp $ }

interface

uses
  CMDataRepresentation, Classes, SysUtils;

function CMDateToString(CMDate: TCMDate): String;
function CMAge(Today: TCMDate; Born: TCMDate): Byte;
function ShortPosition(Player: PPlayer): String;
function FullPosition(Player: PPlayer): String;
function ContractTypeToStr(CtrType: Byte): String;
function TransferStatusToStr(TraSta: Byte): String;
function SquadStatusToStr(SquSta: Byte): String;
function SquadStatusToLongStr(SquSta: Byte): String;

implementation

function CMDateToString(CMDate: TCMDate): String;
var
  dtDate: TDateTime;
  wrdYear, wrdMonth, wrdDay: Word;
begin
  dtDate:=2 + CMDate.Day;
  if (CMDate.LeapYear = 1) then
    dtDate:=dtDate - 1;
  DecodeDate(dtDate, wrdYear, wrdMonth, wrdDay);
  Result:=IntToStr(wrdDay) + '.' + IntToStr(wrdMonth) + '.' + IntToStr(CMDate.Year);//Copy(IntToStr(CMDate.Year), 3, 2);
end;

function CMAge(Today: TCMDate; Born: TCMDate): Byte;
begin
  Result:=Today.Year - Born.Year;
  If Today.Day < Born.Day then
    Dec(Result);
end;

function ShortPosition(Player: PPlayer): String;
var
  strSites: String;
begin
  Result:='';

  if (Player.Goalkeeper > 14) then
    Result:='GK';
  if (Player.Sweeper > 14) then
    if (Result <> '') then
      Result:=Result + '/SW'
    else
      Result:='SW';
  if (Player.Defender > 14) then
    if (Result <> '') then
      Result:=Result + '/D'
    else
      Result:='D';
  if (Player.DefensiveMidfielder > 14) then
    if (Result <> '') then
      Result:=Result + '/DM'
    else
      Result:='DM';
  if ((Player.Midfielder > 14) and (Player.DefensiveMidfielder <= 14) and (Player.AttackingMidfielder <= 14)) then
    if (Result <> '') then
      Result:=Result + '/M'
    else
      Result:='M';
  if (((Player.AttackingMidfielder > 14) and (Player.DefensiveMidfielder <= 14) and ((Player.Attacker <= 14) or ((Player.Attacker > 14) and (Player.Midfielder > 14)))) or ((Player.WingBack > 14) and (Player.DefensiveMidfielder <= 14) and ((Player.Attacker <= 14) or ((Player.Attacker > 14) and (Player.Midfielder > 14))))) then
    if (Result <> '') then
      Result:=Result + '/AM'
    else
      Result:='AM';
  if (Player.Attacker > 14) then
    if ((Player.AttackingMidfielder > 14) or (Player.LeftSide > 14) or (Player.RightSide > 14) or (Player.FreeRole > 14)) then
    begin
      if (Result <> '') then
        Result:=Result + '/F'
      else
        Result:='F';
    end
    else
    begin
      if (Result <> '') then
        Result:=Result + '/S'
      else
        Result:='S';
    end;

  if (Player.Goalkeeper < 15) then
  begin
    strSites:='';
    if (Player.RightSide > 14) then
      strSites:='R';
    if (Player.LeftSide > 14) then
      strSites:=strSites + 'L';
    if (Player.Central > 14) then
      strSites:=strSites + 'C';
    Result:=Result + ' ' + strSites;
  end;
end;

function FullPosition(Player: PPlayer): String;
var
  strSites: String;
begin
  Result:='';

  if (Player.Goalkeeper > 14) then
    Result:='Goalkeeper';

  if (Player.Sweeper > 14) then
    if (Result <> '') then
      Result:=Result + '/Sweeper'
    else
      Result:='Sweeper';
  if (Player.Defender > 14) then
    if (Result <> '') then
      Result:=Result + '/Defender'
    else
      Result:='Defender';
  if (Player.DefensiveMidfielder > 14) then
    if (Result <> '') then
      Result:=Result + '/Defensive Midfielder'
    else
      Result:='Defensive Midfielder';
  if ((Player.Midfielder > 14) and (Player.DefensiveMidfielder <= 14) and (Player.AttackingMidfielder <= 14)) then
    if (Result <> '') then
      Result:=Result + '/Midfielder'
    else
      Result:='Midfielder';
  if (((Player.AttackingMidfielder > 14) and (Player.DefensiveMidfielder <= 14) and ((Player.Attacker <= 14) or ((Player.Attacker > 14) and (Player.Midfielder > 14)))) or ((Player.WingBack > 14) and (Player.DefensiveMidfielder <= 14) and ((Player.Attacker <= 14) or ((Player.Attacker > 14) and (Player.Midfielder > 14))))) then
    if (Result <> '') then
      Result:=Result + '/Attacking Midfielder'
    else
      Result:='Attacking Midfielder';
  if (Player.Attacker > 14) then
    if ((Player.AttackingMidfielder > 14) or (Player.LeftSide > 14) or (Player.RightSide > 14) or (Player.FreeRole > 14)) then
    begin
      if (Result <> '') then
        Result:=Result + '/Forward'
      else
        Result:='Forward';
    end
    else
    begin
      if (Result <> '') then
        Result:=Result + '/Striker'
      else
        Result:='Striker';
    end;

  if (Player.Goalkeeper < 15) then
  begin
    strSites:=' (';

    if (Player.RightSide > 14) then
      strSites:=strSites + 'Right';

    if (Player.LeftSide > 14) then
    begin
      if (strSites = ' (') then
        strSites:=strSites + 'Left'
      else
        strSites:=strSites + '/Left';
    end;

    if (Player.Central > 14) then
    begin
      if (strSites = ' (') then
        strSites:=strSites + 'Central'
      else
        strSites:=strSites + '/Central';
    end;

    Result:=Result + strSites + ')';
  end;
end;

function ContractTypeToStr(CtrType: Byte): String;
begin
  case CtrType of
    $00     , $40      : Result:='Invalid';
    $01     , $41      : Result:='Full Time Monthly Contract';
    $02     , $42      : Result:='Full Time Contract';
    $03..$04, $43..$44 : Result:='N/A';
    $05     , $45      : Result:='Full Time Trial Contract';
    $06..$07, $46..$47 : Result:='Full Time Loan Contract';
    $08..$3F, $48..$7F : Result:='Full Time Contract';
    $80     , $C0      : Result:='Invalid';
    $81     , $C1      : Result:='Part Time Monthly Contract';
    $82     , $C2      : Result:='Part Time Contract';
    $83..$84, $C3..$C4 : Result:='N/A';
    $85     , $C5      : Result:='Part Time Trial Contract';
    $86..$87, $C6..$C7 : Result:='Part Time Loan Contract';
    $88..$BF, $C8..$FF : Result:='Part Time Contract';
  end;
end;
 
function TransferStatusToStr(TraSta: Byte): String;
begin
  if ((TraSta and 1) = 1) then
    Result:='Transfer listed by club'
  else if ((TraSta and 8) = 8) then
    Result:='Transfer listed by request'
  else if ((TraSta and 2) = 2) then
    Result:='Listed for loan'
  else
    Result:='Unknown';
end;

function SquadStatusToStr(SquSta: Byte): String;
begin
  if ((SquSta and 240) = 0) then
    Result:='Uncertain'
  else if ((SquSta and 224) = 0) then
    Result:='Indispensable To The Club'
  else if ((SquSta and 208) = 0) then
    Result:='Important First Team Player'
  else if ((SquSta and 192) = 0) then
    Result:='Used In A Squad Rotation System'
  else if ((SquSta and 176) = 0) then
    Result:='Backup For The First Team'
  else if ((SquSta and 160) = 0) then
    Result:='Hot Prospect For The Future'
  else if ((SquSta and 144) = 0) then
    Result:='Decent Young Player'
  else if ((SquSta and 128) = 0) then
    Result:='Not Needed By The Club'
  else if ((SquSta and 112) = 0) then
    Result:='On Trial'
  else
    Result:='';
end;

function SquadStatusToLongStr(SquSta: Byte): String;
begin
  if ((SquSta and 240) = 0) then
    Result:='Uncertain'
  else if ((SquSta and 224) = 0) then
    Result:='This player is indispensable to the club'
  else if ((SquSta and 208) = 0) then
    Result:='This player is important first team player'
  else if ((SquSta and 192) = 0) then
    Result:='This player is used in a squad rotation system'
  else if ((SquSta and 176) = 0) then
    Result:='This player is backup for the first team'
  else if ((SquSta and 160) = 0) then
    Result:='This player is hot prospect for the future'
  else if ((SquSta and 144) = 0) then
    Result:='This player is decent young player'
  else if ((SquSta and 128) = 0) then
    Result:='This player is not needed by the club'
  else if ((SquSta and 112) = 0) then
    Result:='This player is on trial'
  else
    Result:='';
end;

end.
