unit ScoutRatingUnit;

{ $Id: ScoutRatingUnit.pas,v 1.3 2002/05/10 16:55:46 michael Exp $ }

interface

uses
  CMDataRepresentation, SysUtils;

function ScoutRatingDbl(Player: PStaff): Double;
function ScoutRating(Player: PStaff): String;
procedure ScoutPlayer(Player: PStaff);
function GKScoutRating(Player: PStaff): Double;
function DScoutRating(Player: PStaff): Double;
function DMScoutRating(Player: PStaff): Double;
function MScoutRating(Player: PStaff): Double;
function AMScoutRating(Player: PStaff): Double;
function WScoutRating(Player: PStaff): Double;
function AScoutRating(Player: PStaff): Double;

implementation

function ScoutRatingDbl(Player: PStaff): Double;
begin
  Result:=0;

  if (not Player.Player.Scouted) then
    ScoutPlayer(Player);

  if (Player.Player.Goalkeeper >= 15) then
    if (Player.Player.GKScout > Result) then
      Result:=Player.Player.GKScout;

  if ((Player.Player.Defender >= 15) or (Player.Player.Sweeper >= 15)) then
    if (Player.Player.DScout > Result) then
      Result:=Player.Player.DScout;

  if (Player.Player.DefensiveMidfielder >= 15) then
    if (Player.Player.DMScout > Result) then
      Result:=Player.Player.DMScout;

  if (Player.Player.Midfielder >= 15) then
    if (Player.Player.MScout > Result) then
      Result:=Player.Player.MScout;

  if (Player.Player.AttackingMidfielder >= 15) then
    if (Player.Player.AMScout > Result) then
      Result:=Player.Player.AMScout;

  if (((Player.Player.Midfielder >= 15) or (Player.Player.AttackingMidfielder >= 15) or (Player.Player.WingBack >= 15)) and ((Player.Player.LeftSide >= 15) or (Player.Player.RightSide >= 15))) then
    if (Player.Player.WScout > Result) then
      Result:=Player.Player.WScout;

  if (Player.Player.Attacker >= 15) then
    if (Player.Player.AScout > Result) then
      Result:=Player.Player.AScout;
end;

function ScoutRating(Player: PStaff): String;
var
  dblRes: Double;
begin
  if (not Player.Player.Scouted) then
    ScoutPlayer(Player);

  dblRes:=0;
  Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (?)';

  if (Player.Player.Goalkeeper >= 15) then
    if (Player.Player.GKScout > dblRes) then
    begin
      dblRes:=Player.Player.GKScout;
      Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (G)';
    end;

  if ((Player.Player.Defender >= 15) or (Player.Player.Sweeper >= 15)) then
    if (Player.Player.DScout > dblRes) then
    begin
      dblRes:=Player.Player.DScout;
      Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (D)';
    end;

  if (Player.Player.DefensiveMidfielder >= 15) then
    if (Player.Player.DMScout > dblRes) then
    begin
      dblRes:=Player.Player.DMScout;
      Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (DM)';
    end;

  if (Player.Player.Midfielder >= 15) then
    if (Player.Player.MScout > dblRes) then
    begin
      dblRes:=Player.Player.MScout;
      Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (M)';
    end;

  if (Player.Player.AttackingMidfielder >= 15) then
    if (Player.Player.AMScout > dblRes) then
    begin
      dblRes:=Player.Player.AMScout;
      Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (AM)';
    end;

  if (((Player.Player.Midfielder >= 15) or (Player.Player.AttackingMidfielder >= 15) or (Player.Player.WingBack >= 15)) and ((Player.Player.LeftSide >= 15) or (Player.Player.RightSide >= 15)))then
    if (Player.Player.WScout > dblRes) then
    begin
      dblRes:=Player.Player.WScout;
      Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (W)';
    end;

  if (Player.Player.Attacker >= 15) then
    if (Player.Player.AScout > dblRes) then
    begin
      dblRes:=Player.Player.AScout;
      Result:=FloatToStrF(dblRes, ffFixed, 10, 2) + ' % (A)';
    end;
end;

procedure ScoutPlayer(Player: PStaff);
begin
  Player.Player.GKScout:=GKScoutRating(Player);
  Player.Player.DScout:=DScoutRating(Player);
  Player.Player.DMScout:=DMScoutRating(Player);
  Player.Player.MScout:=MScoutRating(Player);
  Player.Player.AMScout:=AMScoutRating(Player);
  Player.Player.WScout:=WScoutRating(Player);
  Player.Player.AScout:=AScoutRating(Player);
  Player.Player.Scouted:=True;
end;

function GKScoutRating(Player: PStaff): Double;
var
  dblSum: Double;
begin
  dblSum:=0;
  
  with (Player^) do
  begin
    dblSum:=dblSum + Adaptability / 20 * 3;
    dblSum:=dblSum + Ambition / 20 * 5;
    dblSum:=dblSum + Determination / 20 * 6;
    dblSum:=dblSum + Loyality / 20 * 4;
    dblSum:=dblSum + Pressure / 20 * 6;
    dblSum:=dblSum + Professionalism / 20 * 3;
    dblSum:=dblSum + Sportsmanship / 20 * 2;
    dblSum:=dblSum + Temperament / 20 * 1;
  end;
  // 3 + 5 + 6 + 4 + 6 + 3 + 2 + 1 = 30

  with (Player.Player^) do
  begin
    dblSum:=dblSum + CurrentAbility / 200 * 25;
    dblSum:=dblSum + Acceleration / 20 * 4;
    dblSum:=dblSum + Aggression / 20 * 3;
    dblSum:=dblSum + Agility / 20 * 12;
    dblSum:=dblSum + Anticipation / 20 * 6;
    dblSum:=dblSum + Balance / 20 * 8;
    dblSum:=dblSum + Bravery / 20 * 6;
    dblSum:=dblSum + Consistency / 20 * 7;
    dblSum:=dblSum + Decisions / 20 * 6;
    dblSum:=dblSum + Handling / 20 * 20;
    dblSum:=dblSum + Heading / 20 * 1;
    dblSum:=dblSum + ImportantMatches / 20 * 4;
    dblSum:=dblSum + (21 - InjuryProneness) / 20 * 3;
    dblSum:=dblSum + Jumping / 20 * 6;
    dblSum:=dblSum + Leadership / 20 * 8;
    dblSum:=dblSum + LeftFoot / 20 * 3;
    dblSum:=dblSum + NaturalFitness / 20 * 3;
    dblSum:=dblSum + OneOnOnes / 20 * 8;
    dblSum:=dblSum + Passing / 20 * 1;
    dblSum:=dblSum + Positioning / 20 * 20;
    dblSum:=dblSum + Reflexes / 20 * 20;
    dblSum:=dblSum + RightFoot / 20 * 3;
    dblSum:=dblSum + Stamina / 20 * 1;
    dblSum:=dblSum + Strength / 20 * 4;
    dblSum:=dblSum + Tackling / 20 * 6;
    dblSum:=dblSum + Teamwork / 20 * 4;
  end;
  // 25 + 4 + 3 + 12 + 6 + 8 + 6 + 7 + 6 + 20 + 1 + 4 + 3 +
  // 6 + 8 + 3 + 3 + 8 + 1 + 20 + 20 + 3 + 1 + 4 + 6 + 4 = 192
  Result:=dblSum / (192 + 30) * 100;
end;

function DScoutRating(Player: PStaff): Double;
var
  dblSum: Double;
begin
  dblSum:=0;

  with (Player^) do
  begin
    dblSum:=dblSum + Adaptability / 20 * 3;
    dblSum:=dblSum + Ambition / 20 * 5;
    dblSum:=dblSum + Determination / 20 * 6;
    dblSum:=dblSum + Loyality / 20 * 4;
    dblSum:=dblSum + Pressure / 20 * 6;
    dblSum:=dblSum + Professionalism / 20 * 3;
    dblSum:=dblSum + Sportsmanship / 20 * 2;
    dblSum:=dblSum + Temperament / 20 * 5;
  end;
  // 3 + 5 + 6 + 4 + 6 + 3 + 2 + 5 = 34

  with (Player.Player^) do
  begin
    dblSum:=dblSum + CurrentAbility / 200 * 25;
    dblSum:=dblSum + Acceleration / 20 * 9;
    dblSum:=dblSum + Aggression / 20 * 5;
    dblSum:=dblSum + Anticipation / 20 * 10;
    dblSum:=dblSum + Balance / 20 * 2;
    dblSum:=dblSum + Bravery / 20 * 5;
    dblSum:=dblSum + Consistency / 20 * 6;
    dblSum:=dblSum + Crossing / 20 * 4;
    dblSum:=dblSum + Decisions / 20 * 6;
    dblSum:=dblSum + (21 - Dirtiness) / 20 * 4;
    dblSum:=dblSum + Heading / 20 * 9;
    dblSum:=dblSum + ImportantMatches / 20 * 6;
    dblSum:=dblSum + (21 - InjuryProneness) / 20 * 4;
    dblSum:=dblSum + Jumping / 20 * 6;
    dblSum:=dblSum + Leadership / 20 * 6;
    dblSum:=dblSum + LeftFoot / 20 * 5;
    dblSum:=dblSum + Marking / 20 * 20;
    dblSum:=dblSum + NaturalFitness / 20 * 5;
    dblSum:=dblSum + PlayerPace / 20 * 10;
    dblSum:=dblSum + Passing / 20 * 7;
    dblSum:=dblSum + Positioning / 20 * 20;
    dblSum:=dblSum + RightFoot / 20 * 5;
    dblSum:=dblSum + Stamina / 20 * 7;
    dblSum:=dblSum + Strength / 20 * 6;
    dblSum:=dblSum + Tackling / 20 * 20;
    dblSum:=dblSum + Teamwork / 20 * 6;
    dblSum:=dblSum + Versatility / 20 * 3;
    dblSum:=dblSum + WorkRate / 20 * 6;
  end;
  // 25 + 9 + 5 + 10 + 2 + 5 + 6 + 4 + 6 + 4 + 9 + 6 + 4 + 6 +
  // 6 + 5 + 20 + 5 + 10 + 7 + 20 + 5 + 7 + 6 + 20 + 6 + 3 +
  // 6 = 227
  Result:=dblSum / (227 + 34) * 100;
end;

function DMScoutRating(Player: PStaff): Double;
var
  dblSum: Double;
begin
  dblSum:=0;

  with (Player^) do
  begin
    dblSum:=dblSum + Adaptability / 20 * 3;
    dblSum:=dblSum + Ambition / 20 * 5;
    dblSum:=dblSum + Determination / 20 * 6;
    dblSum:=dblSum + Loyality / 20 * 4;
    dblSum:=dblSum + Pressure / 20 * 6;
    dblSum:=dblSum + Professionalism / 20 * 3;
    dblSum:=dblSum + Sportsmanship / 20 * 2;
    dblSum:=dblSum + Temperament / 20 * 5;
  end;
  // 3 + 5 + 6 + 4 + 6 + 3 + 2 + 5 = 34

  with (Player.Player^) do
  begin
    dblSum:=dblSum + CurrentAbility / 200 * 25;
    dblSum:=dblSum + Acceleration / 20 * 4;
    dblSum:=dblSum + Aggression / 20 * 8;
    dblSum:=dblSum + Anticipation / 20 * 6;
    dblSum:=dblSum + Balance / 20 * 2;
    dblSum:=dblSum + Bravery / 20 * 7;
    dblSum:=dblSum + Consistency / 20 * 6;
    dblSum:=dblSum + Crossing / 20 * 2;
    dblSum:=dblSum + Decisions / 20 * 9;
    dblSum:=dblSum + (21 - Dirtiness) / 20 * 4;
    dblSum:=dblSum + Heading / 20 * 8;
    dblSum:=dblSum + ImportantMatches / 20 * 6;
    dblSum:=dblSum + (21 - InjuryProneness) / 20 * 4;
    dblSum:=dblSum + Jumping / 20 * 5;
    dblSum:=dblSum + Leadership / 20 * 6;
    dblSum:=dblSum + LeftFoot / 20 * 5;
    dblSum:=dblSum + Marking / 20 * 8;
    dblSum:=dblSum + NaturalFitness / 20 * 5;
    dblSum:=dblSum + PlayerPace / 20 * 6;
    dblSum:=dblSum + Passing / 20 * 12;
    dblSum:=dblSum + Positioning / 20 * 18;
    dblSum:=dblSum + RightFoot / 20 * 5;
    dblSum:=dblSum + Stamina / 20 * 7;
    dblSum:=dblSum + Strength / 20 * 6;
    dblSum:=dblSum + Tackling / 20 * 13;
    dblSum:=dblSum + Teamwork / 20 * 11;
    dblSum:=dblSum + Versatility / 20 * 4;
    dblSum:=dblSum + WorkRate / 20 * 15;
  end;
  // 25 + 4 + 8 + 6 + 2 + 7 + 6 + 2 + 9 + 4 + 8 + 6 + 4 + 5 +
  // 6 + 5 + 8 + 5 + 6 + 12 + 18 + 5 + 7 + 6 + 13 + 11 + 4 +
  // 15 = 217
  Result:=dblSum / (217 + 34) * 100;
end;

function MScoutRating(Player: PStaff): Double;
var
  dblSum: Double;
begin
  dblSum:=0;

  with (Player^) do
  begin
    dblSum:=dblSum + Adaptability / 20 * 3;
    dblSum:=dblSum + Ambition / 20 * 5;
    dblSum:=dblSum + Determination / 20 * 6;
    dblSum:=dblSum + Loyality / 20 * 4;
    dblSum:=dblSum + Pressure / 20 * 6;
    dblSum:=dblSum + Professionalism / 20 * 3;
    dblSum:=dblSum + Sportsmanship / 20 * 2;
    dblSum:=dblSum + Temperament / 20 * 5;
  end;
  // 3 + 5 + 6 + 4 + 6 + 3 + 2 + 5 = 34

  with (Player.Player^) do
  begin
    dblSum:=dblSum + CurrentAbility / 200 * 25;
    dblSum:=dblSum + Acceleration / 20 * 7;
    dblSum:=dblSum + Aggression / 20 * 3;
    dblSum:=dblSum + Anticipation / 20 * 8;
    dblSum:=dblSum + Balance / 20 * 2;
    dblSum:=dblSum + Bravery / 20 * 3;
    dblSum:=dblSum + Consistency / 20 * 6;
    dblSum:=dblSum + Crossing / 20 * 5;
    dblSum:=dblSum + Decisions / 20 * 7;
    dblSum:=dblSum + (21 - Dirtiness) / 20 * 2;
    dblSum:=dblSum + Dribbling / 20 * 6;
    dblSum:=dblSum + Finishing / 20 * 2;
    dblSum:=dblSum + Flair / 20 * 5;
    dblSum:=dblSum + Heading / 20 * 5;
    dblSum:=dblSum + ImportantMatches / 20 * 6;
    dblSum:=dblSum + (21 - InjuryProneness) / 20 * 4;
    dblSum:=dblSum + Jumping / 20 * 3;
    dblSum:=dblSum + Leadership / 20 * 5;
    dblSum:=dblSum + LeftFoot / 20 * 5;
    dblSum:=dblSum + Marking / 20 * 7;
    dblSum:=dblSum + Movement / 20 * 5;
    dblSum:=dblSum + NaturalFitness / 20 * 5;
    dblSum:=dblSum + PlayerPace / 20 * 6;
    dblSum:=dblSum + Passing / 20 * 18;
    dblSum:=dblSum + Positioning / 20 * 6;
    dblSum:=dblSum + RightFoot / 20 * 5;
    dblSum:=dblSum + Stamina / 20 * 7;
    dblSum:=dblSum + Strength / 20 * 6;
    dblSum:=dblSum + Tackling / 20 * 4;
    dblSum:=dblSum + Teamwork / 20 * 10;
    dblSum:=dblSum + Technique / 20 * 6;
    dblSum:=dblSum + Versatility / 20 * 3;
    dblSum:=dblSum + Vision / 20 * 12;
    dblSum:=dblSum + WorkRate / 20 * 15;
  end;
  // 25 + 7 + 3 + 8 + 2 + 3 + 6 + 5 + 7 + 2 + 6 + 2 + 5 + 5 +
  // 6 + 4 + 3 + 5 + 5 + 7 + 5 + 5 + 6 + 18 + 6 + 5 + 7 + 6 +
  // 4 + 10 + 6 + 3 + 12 + 15 = 224
  Result:=dblSum / (224 + 34) * 100;
end;

function AMScoutRating(Player: PStaff): Double;
var
  dblSum: Double;
begin
  dblSum:=0;

  with (Player^) do
  begin
    dblSum:=dblSum + Adaptability / 20 * 3;
    dblSum:=dblSum + Ambition / 20 * 5;
    dblSum:=dblSum + Determination / 20 * 6;
    dblSum:=dblSum + Loyality / 20 * 4;
    dblSum:=dblSum + Pressure / 20 * 6;
    dblSum:=dblSum + Professionalism / 20 * 3;
    dblSum:=dblSum + Sportsmanship / 20 * 2;
    dblSum:=dblSum + Temperament / 20 * 5;
  end;
  // 3 + 5 + 6 + 4 + 6 + 3 + 2 + 5 = 34

  with (Player.Player^) do
  begin
    dblSum:=dblSum + CurrentAbility / 200 * 25;
    dblSum:=dblSum + Acceleration / 20 * 7;
    dblSum:=dblSum + Aggression / 20 * 5;
    dblSum:=dblSum + Anticipation / 20 * 8;
    dblSum:=dblSum + Balance / 20 * 2;
    dblSum:=dblSum + Bravery / 20 * 3;
    dblSum:=dblSum + Consistency / 20 * 6;
    dblSum:=dblSum + Crossing / 20 * 7;
    dblSum:=dblSum + Decisions / 20 * 9;
    dblSum:=dblSum + (21 - Dirtiness) / 20 * 1;
    dblSum:=dblSum + Dribbling / 20 * 15;
    dblSum:=dblSum + Finishing / 20 * 10;
    dblSum:=dblSum + Flair / 20 * 7;
    dblSum:=dblSum + Heading / 20 * 5;
    dblSum:=dblSum + ImportantMatches / 20 * 6;
    dblSum:=dblSum + (21 - InjuryProneness) / 20 * 4;
    dblSum:=dblSum + Jumping / 20 * 3;
    dblSum:=dblSum + Leadership / 20 * 5;
    dblSum:=dblSum + LeftFoot / 20 * 5;
    dblSum:=dblSum + LongShots / 20 * 11;
    dblSum:=dblSum + Movement / 20 * 10;
    dblSum:=dblSum + NaturalFitness / 20 * 5;
    dblSum:=dblSum + PlayerPace / 20 * 9;
    dblSum:=dblSum + Passing / 20 * 15;
    dblSum:=dblSum + RightFoot / 20 * 5;
    dblSum:=dblSum + Stamina / 20 * 11;
    dblSum:=dblSum + Strength / 20 * 6;
    dblSum:=dblSum + Teamwork / 20 * 10;
    dblSum:=dblSum + Technique / 20 * 7;
    dblSum:=dblSum + Versatility / 20 * 3;
    dblSum:=dblSum + Vision / 20 * 15;
    dblSum:=dblSum + WorkRate / 20 * 2;
  end;
  // 25 + 7 + 5 + 8 + 2 + 3 + 6 + 7 + 9 + 1 + 15 + 10 + 7 +
  // 5 + 6 + 4 + 3 + 5 + 5 + 11 + 10 + 5 + 9 + 15 + 5 + 11 +
  // 6 + 10 + 7 + 3 + 15 + 2 = 242
  Result:=dblSum / (242 + 34) * 100;
end;

function WScoutRating(Player: PStaff): Double;
var
  dblSum: Double;
begin
  dblSum:=0;

  with (Player^) do
  begin
    dblSum:=dblSum + Adaptability / 20 * 3;
    dblSum:=dblSum + Ambition / 20 * 5;
    dblSum:=dblSum + Determination / 20 * 6;
    dblSum:=dblSum + Loyality / 20 * 4;
    dblSum:=dblSum + Pressure / 20 * 6;
    dblSum:=dblSum + Professionalism / 20 * 3;
    dblSum:=dblSum + Sportsmanship / 20 * 2;
    dblSum:=dblSum + Temperament / 20 * 5;
  end;
  // 3 + 5 + 6 + 4 + 6 + 3 + 2 + 5 = 34

  with (Player.Player^) do
  begin
    dblSum:=dblSum + CurrentAbility / 200 * 25;
    dblSum:=dblSum + Acceleration / 20 * 12;
    dblSum:=dblSum + Aggression / 20 * 7;
    dblSum:=dblSum + Anticipation / 20 * 6;
    dblSum:=dblSum + Balance / 20 * 2;
    dblSum:=dblSum + Bravery / 20 * 3;
    dblSum:=dblSum + Consistency / 20 * 6;
    dblSum:=dblSum + Crossing / 20 * 15;
    dblSum:=dblSum + Decisions / 20 * 10;
    dblSum:=dblSum + (21 - Dirtiness) / 20 * 1;
    dblSum:=dblSum + Dribbling / 20 * 20;
    dblSum:=dblSum + Finishing / 20 * 7;
    dblSum:=dblSum + Flair / 20 * 10;
    dblSum:=dblSum + Heading / 20 * 8;
    dblSum:=dblSum + ImportantMatches / 20 * 6;
    dblSum:=dblSum + (21 - InjuryProneness) / 20 * 4;
    dblSum:=dblSum + Jumping / 20 * 5;
    dblSum:=dblSum + Leadership / 20 * 3;
    dblSum:=dblSum + LeftFoot / 20 * 5;
    dblSum:=dblSum + Movement / 20 * 13;
    dblSum:=dblSum + NaturalFitness / 20 * 6;
    dblSum:=dblSum + PlayerPace / 20 * 9;
    dblSum:=dblSum + Passing / 20 * 10;
    dblSum:=dblSum + RightFoot / 20 * 5;
    dblSum:=dblSum + Stamina / 20 * 11;
    dblSum:=dblSum + Strength / 20 * 8;
    dblSum:=dblSum + Teamwork / 20 * 7;
    dblSum:=dblSum + Technique / 20 * 9;
    dblSum:=dblSum + Versatility / 20 * 3;
    dblSum:=dblSum + Vision / 20 * 15;
    dblSum:=dblSum + WorkRate / 20 * 10;
  end;
  // 25 + 12 + 7 + 6 + 2 + 3 + 6 + 15 + 10 + 1 + 20 + 7 + 10 +
  // 8 + 6 + 4 + 5 + 3 + 5 + 13 + 6 + 9 + 10 + 5 + 11 + 8 +
  // 7 + 9 + 3 + 15 + 10 = 261
  Result:=dblSum / (261 + 34) * 100;
end;

function AScoutRating(Player: PStaff): Double;
var
  dblSum: Double;
begin
  dblSum:=0;

  with (Player^) do
  begin
    dblSum:=dblSum + Adaptability / 20 * 3;
    dblSum:=dblSum + Ambition / 20 * 5;
    dblSum:=dblSum + Determination / 20 * 6;
    dblSum:=dblSum + Loyality / 20 * 4;
    dblSum:=dblSum + Pressure / 20 * 6;
    dblSum:=dblSum + Professionalism / 20 * 3;
    dblSum:=dblSum + Sportsmanship / 20 * 2;
    dblSum:=dblSum + Temperament / 20 * 5;
  end;
  // 3 + 5 + 6 + 4 + 6 + 3 + 2 + 5 = 34

  with (Player.Player^) do
  begin
    dblSum:=dblSum + CurrentAbility / 200 * 25;
    dblSum:=dblSum + Acceleration / 20 * 14;
    dblSum:=dblSum + Aggression / 20 * 7;
    dblSum:=dblSum + Anticipation / 20 * 15;
    dblSum:=dblSum + Balance / 20 * 2;
    dblSum:=dblSum + Bravery / 20 * 3;
    dblSum:=dblSum + Consistency / 20 * 5;
    dblSum:=dblSum + Decisions / 20 * 5;
    dblSum:=dblSum + Dribbling / 20 * 8;
    dblSum:=dblSum + Finishing / 20 * 20;
    dblSum:=dblSum + Flair / 20 * 9;
    dblSum:=dblSum + Heading / 20 * 5;
    dblSum:=dblSum + ImportantMatches / 20 * 6;
    dblSum:=dblSum + (21 - InjuryProneness) / 20 * 4;
    dblSum:=dblSum + Jumping / 20 * 3;
    dblSum:=dblSum + Leadership / 20 * 1;
    dblSum:=dblSum + LeftFoot / 20 * 5;
    dblSum:=dblSum + LongShots / 20 * 7;
    dblSum:=dblSum + Movement / 20 * 10;
    dblSum:=dblSum + NaturalFitness / 20 * 4;
    dblSum:=dblSum + PlayerPace / 20 * 13;
    dblSum:=dblSum + Passing / 20 * 10;
    dblSum:=dblSum + RightFoot / 20 * 5;
    dblSum:=dblSum + Stamina / 20 * 7;
    dblSum:=dblSum + Strength / 20 * 6;
    dblSum:=dblSum + Teamwork / 20 * 2;
    dblSum:=dblSum + Technique / 20 * 4;
    dblSum:=dblSum + Versatility / 20 * 3;
    dblSum:=dblSum + Vision / 20 * 3;
    dblSum:=dblSum + WorkRate / 20 * 2;
  end;
  // 25 + 14 + 7 + 15 + 2 + 3 + 5 + 5 + 8 + 20 + 9 + 5 + 6 +
  // 4 + 3 + 1 + 5 + 7 + 10 + 4 + 13 + 10 + 5 + 7 + 6 + 2 +
  // 4 + 3 + 3 + 2 = 213
  Result:=dblSum / (213 + 34) * 100;
end;

end.
 