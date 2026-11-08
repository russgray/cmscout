// Generates a synthetic Championship Manager 01/02 saved game laid out the way
// CM Scout 2.00 (CM0102/CMDatabase/CMDatabase.pas) reads it. Test data only.
//
//   node make-fixture-0102.js <outdir> [players] [--compressed]
'use strict';
const fs = require('fs');
const path = require('path');

let seed = 4242;
function rnd() { seed = (seed * 1103515245 + 12345) & 0x7fffffff; return seed / 0x7fffffff; }
function ri(a, b) { return a + Math.floor(rnd() * (b - a + 1)); }

function cstr(buf, off, s, len) { Buffer.from(s, 'latin1').copy(buf, off, 0, len - 1); }
function date(buf, off, y, d, leap) { buf.writeUInt16LE(d, off); buf.writeUInt16LE(y, off + 2); buf.writeInt32LE(leap ? 1 : 0, off + 4); }

// Run-length encoding as decoded by CMCompressedFileStream.pas:
// byte <= 128 literal; byte > 128 => repeat next byte (byte - 128) times.
function rle(data) {
  const out = [];
  let i = 0;
  while (i < data.length) {
    let run = 1;
    while (i + run < data.length && data[i + run] === data[i] && run < 127) run++;
    if (run >= 3 || data[i] > 128) { out.push(128 + run, data[i]); i += run; }
    else { out.push(data[i]); i++; }
  }
  return Buffer.from(out);
}

const ATTR = ['Acceleration','Aggression','Agility','Anticipation','Balance','Bravery','Consistency','Corners','Crossing','Decisions','Dirtiness','Dribbling','Finishing','Flair','FreeKicks','Handling','Heading','ImportantMatches','InjuryProneness','Jumping','Leadership','LeftFoot','LongShots','Marking','Movement','NaturalFitness','OneOnOnes','PlayerPace','Passing','Penalties','Positioning','Reflexes','RightFoot','Stamina','Strength','Tackling','Teamwork','Technique','ThrowIns','Versatility','Vision','WorkRate'];

function build(opts) {
  seed = 4242;
  opts = opts || {};
  const NP = opts.players || 40;
  const compressed = !!opts.compressed;
  const nations = [
    { id: 11, n: 'England', s: 'England', nat: 'English', gm: 2 },
    { id: 12, n: 'Brazil', s: 'Brazil', nat: 'Brazilian', gm: 1 },
    { id: 13, n: 'Denmark', s: 'Denmark', nat: 'Danish', gm: 2 },
  ];
  const divisions = [
    { id: 21, n: 'English Premier Division', s: 'Premier', nation: 0 },
    { id: 22, n: 'Danish Superliga', s: 'Superliga', nation: 2 },
  ];
  const clubs = [
    { id: 31, n: 'Kingsbury Athletic', s: 'Kingsbury', nation: 0, div: 0, rep: 7000 },
    { id: 32, n: 'Aalvik Boldklub', s: 'Aalvik', nation: 2, div: 1, rep: 4200 },
    { id: 33, n: 'Riverside Town', s: 'Riverside', nation: 0, div: 0, rep: 5100 },
  ];
  const first = ['Peter', 'Jens', 'Marcos', 'Gary', 'Søren', 'Ian'];
  const second = ['Hughes', 'Larsen', 'Oliveira', 'Wright', 'Kjær', 'Moore'];
  const common = ['', 'Juninho']; // index 0 = empty common name

  // staff: players first, then a few non-players
  const staff = [];
  for (let j = 0; j < NP; j++) {
    const club = j < 14 ? 0 : j < 26 ? 1 : j < 34 ? 2 : -1;
    staff.push({ id: 7000 + j, player: j, club, f: j % first.length, s: j % second.length, c: j === 4 ? 1 : 0,
      dob: [1970 + (j % 15), ri(0, 360), (1970 + (j % 15)) % 4 === 0], nat: j % 3, nat2: j === 5 ? 0 : -1,
      apps: j % 4 === 0 ? ri(1, 50) : 0, goals: j % 8 === 0 ? ri(1, 10) : 0, wage: ri(100, 30000), value: ri(0, 5000) * 1000,
      pers: [ri(1, 20), ri(1, 20), ri(1, 20), ri(1, 20), ri(1, 20), ri(1, 20), ri(1, 20), ri(1, 20)] });
  }
  for (let j = 0; j < 3; j++) staff.push({ id: 9000 + j, player: -1, club: 0, f: 0, s: 0, c: 0, dob: [1950, 10, false], nat: 0, nat2: -1, apps: 0, goals: 0, wage: 1, value: 0, pers: [10, 10, 10, 10, 10, 10, 10, 10] });

  const players = [];
  for (let j = 0; j < NP; j++) {
    const gk = j % 9 === 0;
    const pos = new Array(12).fill(1);
    if (gk) pos[0] = 20;
    else {
      const r = j % 4;
      if (r === 0) { pos[2] = 20; pos[10] = 20; }        // D C
      if (r === 1) { pos[4] = 18; pos[9] = 17; }         // M L
      if (r === 2) { pos[5] = 19; pos[8] = 16; }         // AM R
      if (r === 3) { pos[6] = 20; pos[10] = 20; }        // S C
    }
    const at = ATTR.map(() => ri(-40, 40));
    // unconverted attributes are already 1..20
    ['Acceleration','Aggression','Agility','Balance','Bravery','Consistency','Corners','Dirtiness','Flair','FreeKicks','ImportantMatches','InjuryProneness','Jumping','Leadership','LeftFoot','NaturalFitness','PlayerPace','RightFoot','Stamina','Strength','Teamwork','Technique','Versatility','WorkRate']
      .forEach(k => { at[ATTR.indexOf(k)] = ri(1, 20); });
    const ca = ri(30, 190);
    players.push({ id: 5000 + j, num: (j % 25) + 1, ca, pa: Math.min(200, ca + ri(0, 30)), hr: ri(100, 8000), cr: ri(100, 8000), wr: ri(100, 8000), pos, at, morale: ri(1, 20) });
  }

  // contracts (contract ID = staff index)
  const contracts = [];
  staff.forEach((s, si) => {
    if (s.club < 0 || s.player < 0) return;
    const c = { sid: si, club: s.club, wage: s.wage, gb: si % 3 === 0 ? 500 : -1, ab: -1, cb: si % 5 === 0 ? 200 : -1,
      np: si % 6 === 0 ? 2 : 0, mf: si % 4 === 0 ? 1 : 0, npl: si % 7 === 0 ? 1 : 0, rel: si % 5 === 0 ? 1 : 0, mj: 0, fee: 250000 + si * 1000,
      st: [2000 + (si % 3), ri(0, 360)], e: [2002 + (si % 4), ri(0, 360)], t: [0x02, 0x82, 0x01, 0x42, 0x85, 0xC2][si % 6], b: si % 10 === 0,
      arr: si === 3 ? 2 : -1, ts: [0, 1, 8, 2, 9, 0][si % 6], ss: (si % 9) << 4 };
    if (si === 6) {
      // on loan at club 0 (ClubJob) from club 2: loan-club contract first, parent contract second
      contracts.push(Object.assign({}, c, { club: 0, t: 0x06, e: [2002, 150] }));
      contracts.push(Object.assign({}, c, { club: 2 }));
      return;
    }
    contracts.push(c);
  });

  // ---- block payloads
  const general = Buffer.alloc(3944 + 8 + 100, 0x11);
  date(general, 3944, 2002, 220, false);

  const nationBuf = Buffer.alloc(nations.length * 290, 0);
  nations.forEach((n, i) => {
    const o = i * 290;
    nationBuf.writeInt32LE(n.id, o); cstr(nationBuf, o + 4, n.n, 51); cstr(nationBuf, o + 56, n.s, 26); cstr(nationBuf, o + 87, n.nat, 26);
    nationBuf.writeUInt8(n.gm, o + 127);
    nationBuf.writeInt32LE(-1, o + 272); nationBuf.writeInt32LE(-1, o + 276); nationBuf.writeInt32LE(-1, o + 280);
  });
  const divBuf = Buffer.alloc(divisions.length * 107, 0);
  divisions.forEach((d, i) => { const o = i * 107; divBuf.writeInt32LE(d.id, o); cstr(divBuf, o + 4, d.n, 51); cstr(divBuf, o + 56, d.s, 26); divBuf.writeInt32LE(d.nation, o + 93); divBuf.writeUInt16LE(500, o + 105); });
  const clubBuf = Buffer.alloc(clubs.length * 581, 0);
  clubs.forEach((c, ci) => {
    const o = ci * 581;
    clubBuf.writeInt32LE(c.id, o); cstr(clubBuf, o + 4, c.n, 51); cstr(clubBuf, o + 56, c.s, 26);
    clubBuf.writeInt32LE(c.nation, o + 83); clubBuf.writeInt32LE(c.div, o + 87); clubBuf.writeInt32LE(-1, o + 91); clubBuf.writeInt32LE(-1, o + 96);
    clubBuf.writeUInt16LE(c.rep, o + 128);
    const squad = staff.map((s, si) => (s.club === ci ? si : -1)).filter(x => x >= 0); // includes non-players for club 0
    for (let k = 0; k < 50; k++) clubBuf.writeInt32LE(k < squad.length ? squad[k] : -1, o + 215 + k * 4);
  });
  const nameBuf = arr => { const b = Buffer.alloc(arr.length * 60, 0); arr.forEach((n, i) => { cstr(b, i * 60, n, 51); b.writeInt32LE(100 + i, i * 60 + 51); b.writeInt32LE(0, i * 60 + 55); b.writeUInt8(1, i * 60 + 59); }); return b; };
  const playerBuf = Buffer.alloc(players.length * 70, 0);
  players.forEach((p, i) => {
    const o = i * 70;
    playerBuf.writeInt32LE(p.id, o); playerBuf.writeUInt8(p.num, o + 4);
    [p.ca, p.pa, p.hr, p.cr, p.wr].forEach((v, k) => playerBuf.writeUInt16LE(v, o + 5 + k * 2));
    p.pos.forEach((v, k) => playerBuf.writeInt8(v, o + 15 + k));
    p.at.forEach((v, k) => playerBuf.writeInt8(v, o + 27 + k));
    playerBuf.writeUInt8(p.morale, o + 69);
  });
  const staffBuf = Buffer.alloc(staff.length * 110, 0);
  staff.forEach((s, i) => {
    const o = i * 110;
    staffBuf.writeInt32LE(s.id, o); staffBuf.writeInt32LE(s.f, o + 4); staffBuf.writeInt32LE(s.s, o + 8); staffBuf.writeInt32LE(s.c, o + 12);
    date(staffBuf, o + 16, s.dob[0], s.dob[1], s.dob[2]); staffBuf.writeUInt16LE(s.dob[0], o + 24);
    staffBuf.writeInt32LE(s.nat, o + 26); staffBuf.writeInt32LE(s.nat2, o + 30); staffBuf.writeUInt8(s.apps, o + 34); staffBuf.writeUInt8(s.goals, o + 35);
    staffBuf.writeInt32LE(-1, o + 36);
    staffBuf.writeInt32LE(s.club, o + 57); date(staffBuf, o + 62, 2000, 100, false); date(staffBuf, o + 70, 2004, 150, false);
    staffBuf.writeInt32LE(s.wage, o + 78); staffBuf.writeInt32LE(s.value, o + 82);
    s.pers.forEach((v, k) => staffBuf.writeUInt8(v, o + 86 + k));
    staffBuf.writeInt32LE(s.player, o + 97); staffBuf.writeInt32LE(-1, o + 101); staffBuf.writeInt32LE(s.player < 0 ? 0 : -1, o + 105);
  });
  const PRE = 2;
  const conBuf = Buffer.alloc(8 + PRE * 21 + contracts.length * 80, 0);
  conBuf.writeInt32LE(PRE, 0); conBuf.writeInt32LE(999, 4); // the real count comes from the last pre record
  for (let k = 0; k < PRE; k++) conBuf.writeInt32LE(k === PRE - 1 ? contracts.length : 77, 8 + k * 21 + 17);
  contracts.forEach((c, i) => {
    const o = 8 + PRE * 21 + i * 80;
    conBuf.writeInt32LE(c.sid, o); conBuf.writeInt32LE(c.club, o + 4); conBuf.writeInt32LE(c.wage, o + 12);
    conBuf.writeInt32LE(c.gb, o + 16); conBuf.writeInt32LE(c.ab, o + 20); conBuf.writeInt32LE(c.cb, o + 24);
    [c.np, c.mf, c.npl, c.rel, c.mj].forEach((v, k) => conBuf.writeUInt8(v, o + 28 + k));
    conBuf.writeInt32LE(c.fee, o + 33); date(conBuf, o + 37, c.st[0], c.st[1], false); date(conBuf, o + 45, c.e[0], c.e[1], false);
    conBuf.writeUInt8(c.t, o + 53); conBuf.writeUInt8(c.b ? 1 : 0, o + 73); conBuf.writeInt32LE(c.arr, o + 74);
    conBuf.writeUInt8(c.ts, o + 78); conBuf.writeUInt8(c.ss, o + 79);
  });

  const blocks = [
    ['general.dat', general], ['nation.dat', nationBuf], ['club_comp.dat', divBuf], ['club.dat', clubBuf],
    ['first_names.dat', nameBuf(first)], ['second_names.dat', nameBuf(second)], ['common_names.dat', nameBuf(common)],
    ['player.dat', playerBuf], ['nonplayer.dat', Buffer.alloc(68 * 3, 0)], ['staff.dat', staffBuf], ['contract.dat', conBuf],
    ['news.dat', Buffer.alloc(300, 0x42)],
  ];
  const header = Buffer.alloc(12 + blocks.length * 268, 0);
  header.writeInt32LE(compressed ? 4 : 3, 0);
  header.writeInt32LE(blocks.length, 8);
  const bodies = [];
  let pos = header.length;
  blocks.forEach(([name, data], i) => {
    const body = compressed ? rle(data) : data;
    const o = 12 + i * 268;
    header.writeInt32LE(pos, o); header.writeInt32LE(data.length, o + 4); cstr(header, o + 8, name, 260);
    bodies.push(body); pos += body.length;
  });
  return { save: Buffer.concat([header].concat(bodies)), staff, players, contracts, clubs, nations };
}

if (require.main === module) {
  const out = process.argv[2] || path.join(__dirname, 'fixtures');
  const n = +(process.argv[3] || 40);
  const compressed = process.argv.includes('--compressed');
  fs.mkdirSync(out, { recursive: true });
  const r = build({ players: n, compressed });
  const file = path.join(out, `test-0102${compressed ? '-compressed' : ''}${n !== 40 ? '-' + n : ''}.sav`);
  fs.writeFileSync(file, r.save);
  console.log(`wrote ${file} (${r.save.length} bytes)`);
}
module.exports = { build, rle };
