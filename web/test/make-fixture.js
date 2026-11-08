// Generates a synthetic CM4 / CM 03-04 saved game (and lang_db.dat) laid out the
// way the original Delphi loader reads them. Used only to smoke-test the HTML
// port before real save files are available; it is NOT a real game database.
//
//   node make-fixture.js <outdir> [dbVersion]   (default dbVersion 146)
'use strict';
const fs = require('fs');
const path = require('path');

class W {
  constructor() { this.chunks = []; this.len = 0; }
  raw(b) { this.chunks.push(Buffer.from(b)); this.len += b.length; return this; }
  u8(v) { const b = Buffer.alloc(1); b.writeUInt8(v & 255); return this.raw(b); }
  i8(v) { const b = Buffer.alloc(1); b.writeInt8(v); return this.raw(b); }
  bool(v) { return this.u8(v ? 1 : 0); }
  u16(v) { const b = Buffer.alloc(2); b.writeUInt16LE(v); return this.raw(b); }
  i16(v) { const b = Buffer.alloc(2); b.writeInt16LE(v); return this.raw(b); }
  i32(v) { const b = Buffer.alloc(4); b.writeInt32LE(v); return this.raw(b); }
  pad(n, fill = 0xAB) { return this.raw(Buffer.alloc(n, fill)); }
  ws(s) { this.i32(s.length); if (s.length) { this.raw(Buffer.from(s, 'utf16le')); this.u16(0); } return this; }
  wfixed(s, bytes) { const b = Buffer.alloc(bytes); b.write(s, 'utf16le'); return this.raw(b); }
  date(y, d) { return this.u16(d).u16(y); }
  byteArr(size, n) { this.u8(n); return this.pad(size * n); }
  wordArr(size, n) { this.u16(n); return this.pad(size * n); }
  intArr(size, n) { this.i32(n); return this.pad(size * n); }
  list8(a) { this.u8(a.length); a.forEach(x => this.i32(x)); return this; }
  list16(a) { this.u16(a.length); a.forEach(x => this.i32(x)); return this; }
  ascii(s) { return this.raw(Buffer.from(s, 'latin1')); }
  buf() { return Buffer.concat(this.chunks); }
}

// deterministic RNG
let seed = 12345;
function rnd() { seed = (seed * 1103515245 + 12345) & 0x7fffffff; return seed / 0x7fffffff; }
function ri(a, b) { return a + Math.floor(rnd() * (b - a + 1)); }
function pick(a) { return a[ri(0, a.length - 1)]; }

function build(v, opts) {
  opts = opts || {};
  const ge145 = v >= 145;
  const w = new W();
  const db = new W();
  const tail = (id, uid) => db.i32(id).i32(uid);

  // ---- world definition
  const nations = [
    { n: 'England', s: 'England', eu: 2, uid: 1001 },
    { n: 'Brazil', s: 'Brazil', eu: 1, uid: 1002 },
    { n: 'Norway', s: 'Norway', eu: 0, uid: 1003 },
    { n: 'France', s: 'France', eu: 2, uid: 1004 },
  ];
  const comps = [
    { s: 'Premiership', n: 'English Premier Division', nt: 4, nation: 0, uid: 2001 },
    { s: 'Div 1', n: 'English First Division', nt: 4, nation: 0, uid: 2002 },
    { s: '', n: '', nt: 0, nation: 2, uid: 2003 }, // name only via lang_db
  ];
  const clubs = [
    { n: 'Northbridge United', s: 'Northbridge', nation: 0, lb: false, uid: 3001, div: 0, fin: 1 },
    { n: 'Southport Rovers', s: 'Southport', nation: 0, lb: false, uid: 3002, div: 1, fin: 0 },
    { n: 'Fjordvik IL', s: 'Fjordvik', nation: 2, lb: false, uid: 3003, div: 2, fin: 0 },
    { n: 'League Body', s: 'League', nation: 0, lb: true, uid: 3004, div: 0, fin: 0 },
  ];
  // teams: one first team per real club, plus reserves for club 0, plus a national team
  const teams = [];
  clubs.forEach((c, ci) => { if (!c.lb) teams.push({ rt: 10, tt: 0, ct: 0, c: ci, div: c.div, rep: 5000 - ci * 1000, uid: 4000 + teams.length, pl: [] }); });
  teams.push({ rt: 10, tt: 1, ct: 0, c: 0, div: 1, rep: 2500, uid: 4100, pl: [] });         // Northbridge Reserves
  teams.push({ rt: 11, tt: 0, ct: 1, c: 0, div: -1, rep: 8000, uid: 4200, pl: [] });         // England national team
  clubs.forEach((c, ci) => { c.teams = teams.map((t, ti) => (t.ct === 0 && t.c === ci ? ti : -1)).filter(x => x >= 0); });
  nations.forEach((n, ni) => { n.teams = teams.map((t, ti) => (t.ct === 1 && t.c === ni ? ti : -1)).filter(x => x >= 0); });

  const first = ['John', 'Lars', 'Pierre', 'Carlos', 'Tom', 'Ola', 'Marc', 'Rafael', 'Jamie', 'Sven', 'Luís', 'André'];
  const second = ['Smith', 'Hansen', 'Dubois', 'Silva', 'Brown', 'Nilsen', 'Martin', 'Souza', 'Clark', 'Berg', 'Gonçalves', 'Øvrebø'];
  const common = ['Ronaldinho', 'Zé'];

  // people: index 0..: a mix of record types
  const people = [];
  const personData = [], playingData = [];
  const NP = opts.players || 60;
  for (let j = 0; j < NP; j++) {
    const ti = j < 20 ? 0 : j < 32 ? 1 : j < 44 ? 2 : j < 50 ? 3 : -1; // 50..59 free agents
    const gk = j % 11 === 0;
    const pd = new Array(65).fill(0).map(() => ri(-30, 40));
    // positions are absolute 1..20
    for (let k = 0; k < 12; k++) pd[k] = 1;
    if (gk) { pd[0] = 20; pd[11] = 20; }
    else {
      const role = j % 5;
      if (role === 0) { pd[2] = 20; pd[11] = 20; }
      if (role === 1) { pd[4] = 20; pd[10] = 18; }
      if (role === 2) { pd[5] = 19; pd[9] = 16; }
      if (role === 3) { pd[6] = 20; pd[11] = 20; }
      if (role === 4) { pd[3] = 17; pd[4] = 16; pd[11] = 20; }
    }
    // absolute attributes 1..20 for the rest (indices 37..64)
    for (let k = 37; k < 65; k++) pd[k] = ri(1, 20);
    playingData.push(pd);
    personData.push(new Array(8).fill(0).map(() => ri(1, 20)));
    const ca = ri(40, 190);
    const contracts = [];
    if (ti >= 0) {
      const t = teams[ti];
      contracts.push({ t: 0, ft: j % 7 !== 0, b: j % 9 === 0, ct: t.ct, c: t.c, w: ri(500, 40000), e: [2004 + (j % 4), ri(0, 360)],
        ss: j % 8, ts: [0, 1, 2, 8, 16, 64][j % 6], h: ri(-20, 20), ps: (j + 3) % 8, n: (j % 30) + 1,
        cl: j % 4 === 0 ? [[0, 1000000 + j * 1000], [9, 500000], [2, 250000], [77, 1]] : j % 4 === 1 ? [[1, 750000]] : [] });
      if (j === 25) contracts.unshift({ t: 1, ct: 0, c: 0, w: 1000, e: [2004, 150], ss: 4, ts: 0, h: 0, ps: 4, n: 33 }); // on loan at club 0
      if (j === 45) contracts.push({ t: 5, ft: true, team: 0, ct: 0, c: 3, w: 0, e: [2005, 0], ss: 0, ts: 0, h: 0, ps: 0, n: 0 });
    } else if (j === 50) {
      contracts.push({ t: 2, ct: 0, c: 1, w: 200, e: [2003, 300], ss: 0, ts: 0, h: 0, ps: 0, n: 0 }); // trial
    }
    if (ti >= 0) teams[ti].pl.push(people.length);
    if (j < 4) teams[teams.length - 1].pl.push(people.length); // national team call-ups
    people.push({
      rt: j === 7 ? 3 : 2, f: j % 13 === 5 ? -1 : j % first.length, s: j % second.length, cn: j === 3 ? 0 : j === 17 ? 1 : -1,
      dob: [1970 + (j % 20), ri(0, 364)], nat: j % 4, apps: j % 3 === 0 ? ri(0, 60) : 0, goals: j % 6 === 0 ? ri(0, 20) : 0,
      team: ti >= 0 ? ti : -1, joined: [2000 + (j % 3), ri(0, 364)], pd: j, pld: j,
      hr: ri(100, 9000), cr: ri(100, 9000), wr: ri(100, 9000), ca, pa: Math.min(200, ca + ri(0, 40)),
      val: ri(0, 20000) * 1000, sv: ri(0, 20000) * 1000, contracts, an: j === 10 ? [3] : j === 11 ? [1, 3] : [],
      offers: j === 12 ? [{ type: 0 }, ...(ge145 ? [{ type: 255 }] : [])] : [],
    });
  }
  // non-player record types sprinkled in (must be parsed and skipped)
  const extra = [
    { rt: 1 }, { rt: 4 }, { rt: 5 }, { rt: 6 }, { rt: 7 }, { rt: 8 }, { rt: 9 },
  ];
  const pdOther = personData.length;
  personData.push([10, 10, 10, 10, 10, 10, 10, 10]);
  extra.forEach(x => people.push(Object.assign({ f: 0, s: 0, cn: -1, dob: [1960, 10], nat: 0, apps: 0, goals: 0, team: 0, joined: [2000, 0], pd: pdOther, contracts: [], an: [], offers: [] }, x)));
  teams[0].pl.push(NP); // a non-player in a squad list: must be ignored by team search

  // ================= game_db.dat =================
  function gameDb() {
    const g = db;
    g.u8(0).u16(46).wfixed('dat', 6).i16(v);
    g.pad(6); g.date(2003, 200); g.pad(6);
    if (ge145) g.pad(10);
    g.intArr(ge145 ? 45 : 43, 2);                                    // awards
    g.i32(2); for (let j = 0; j < 2; j++) { g.pad(19); g.ws('City' + j); g.pad(11); } // cities

    // clubs
    g.i32(clubs.length);
    clubs.forEach((c, ci) => {
      g.u8(c.lb ? 12 : 0);
      if (c.lb) g.pad(9);
      g.i32(c.nation); g.pad(1); g.ws(c.s + ' Nick'); g.pad(1); g.ws('');
      g.pad(17); g.i32(-1); g.pad(2); g.list8([]); g.list8([1, 2]);
      g.u8(c.fin);
      if (c.fin === 0) g.pad(4);
      else { g.pad(421); if (v > 110) g.pad(16); if (v >= 115) g.pad(1); }
      g.i32(ci === 0 ? 77 : 0); if (ci === 0) g.pad(13);
      g.wordArr(4, 2);
      const infos = ci === 0 ? [5, 6, 1, 2, 3, 4, 7, 0, 8] : [];
      g.u16(infos.length);
      infos.forEach((t, k) => {
        g.u8(t);
        if (t === 5) g.pad(10); else if (t === 6) g.pad(15); else if (t === 1) g.pad(1); else if (t === 2) g.pad(5);
        else if (t === 3) { g.bool(true); g.byteArr(4, 3); g.pad(5); }
        else if (t === 4) g.pad(16); else if (t === 7) g.pad(12);
        else if (t === 0) { g.pad(1); if (v > 110) g.pad(4); } else if (t === 8) g.pad(1);
      });
      g.byteArr(6, 1); g.pad(12); g.wordArr(4, 3); g.byteArr(5, 2); g.pad(5);
      // TeamCont
      g.u8(0); g.pad(2); g.ws(c.n); g.ws(c.s); g.byteArr(6, 2); g.list8(c.teams); g.byteArr(8, 1);
      tail(ci, c.uid);
    });

    // competitions
    g.i32(comps.length);
    comps.forEach((c, k) => {
      g.u8(0); g.pad(11); g.u8(c.nt); g.pad(1);
      if (c.nt === 4) { g.ws(c.s); g.ws(c.n); }
      g.pad(4); g.i32(c.nation); g.pad(13); tail(k, c.uid);
    });
    g.intArr(17, 1);                                                  // continents
    g.i32(1); g.pad(1); g.ws('Broken leg'); g.pad(2); g.ws('BL'); g.pad(17);       // injuries
    g.i32(1); g.pad(1); g.ws('Paper'); g.pad(1); g.ws('P'); g.pad(2); g.byteArr(4, 2); g.pad(14); // media
    g.i32(1); g.pad(1); g.ws('English'); g.pad(21);                   // languages

    // nations
    g.i32(nations.length);
    nations.forEach((n, k) => {
      g.u8(0); g.pad(51); g.byteArr(2, 1); g.byteArr(4, 1); g.byteArr(4, 0); g.wordArr(4, 1);
      for (let j = 0; j < 8; j++) { g.pad(2); g.byteArr(4, j % 2); }
      if (ge145) { if (k === 1) { g.u16(1); g.pad(13); for (let j = 0; j < 4; j++) g.ws('Imp' + j); } else g.u16(0); }
      g.pad(2); g.u8(n.eu); g.pad(5); if (ge145) g.pad(1); g.pad(12); g.byteArr(4, 2); g.pad(1); if (v >= 147) g.pad(1);
      g.u8(1); g.pad(2); g.ws(n.n); g.ws(n.s); g.byteArr(6, 0); g.list8(n.teams); g.byteArr(8, 0);
      tail(k, n.uid);
    });

    const names = arr => { g.i32(arr.length); arr.forEach((s, k) => { g.u8(0); g.ws(s); g.pad(6); tail(k, 5000 + k); }); };
    names(first); names(second); names(common);
    g.intArr(9, 0);                                                   // regions
    g.i32(1); g.pad(1); g.ws('Sponsor'); g.pad(1); g.ws('Sp'); g.pad(10);
    g.intArr(ge145 ? 48 : 47, 2);                                    // stadiums
    g.intArr(38, 1);                                                  // stadium changes
    g.i32(1); g.pad(1); g.ws('A'); g.pad(1); g.ws('B'); g.pad(1); g.ws(''); g.pad(9); // stages

    // teams
    g.i32(teams.length);
    teams.forEach((t, k) => {
      g.u8(t.rt);
      if (t.rt === 11) { g.pad(13); if (ge145) g.pad(1); }
      g.pad(1); g.u16(t.rep); g.i32(t.div); g.pad(4); if (ge145) g.pad(4); g.pad(4); g.i32(-1); g.pad(19);
      g.list8([]); g.list16(t.pl); g.list8([]); g.byteArr(4, 2); g.pad(1); g.wordArr(ge145 ? 12 : 11, 1); g.pad(4); if (ge145) g.pad(8);
      g.i8(t.tt); g.u8(t.ct); g.pad(1); g.i32(t.c); tail(k, t.uid);
    });
    g.i32(1); g.pad(1); g.ws('Sunny'); g.pad(87);                    // weather
    g.intArr(10, 0);                                                  // player types

    // people
    const contract = c => {
      if (c.t === 0) {
        g.bool(c.ft); g.bool(c.b); g.pad(18); g.u8(c.cl.length); g.pad(6);
        c.cl.forEach(x => { g.i8(x[0] > 127 ? -1 : x[0]); g.i32(x[1]); });
      } else if (c.t === 1) g.pad(ge145 ? 6 : 7);
      else if (c.t === 5) { g.bool(c.ft); g.i32(c.team); g.pad(2); }
      if (ge145 && c.t !== 2) g.pad(1);
      g.u8(c.ct); g.i32(c.c); g.i32(c.w); g.date(c.e[0], c.e[1]); g.i8(c.ss); g.i8(c.ts); g.pad(8);
      if (ge145) g.date(2001, 5);
      g.i8(c.h); g.i8(c.ps); g.pad(1); g.i8(c.n); g.pad(1); if (ge145) g.pad(2);
    };
    const playerData = p => {
      g.i16(p.hr).i16(p.cr).i16(p.wr).i16(p.ca).i16(p.pa).i32(p.pld).pad(4).i32(p.val).pad(20).i32(p.sv);
      g.bool(true); g.pad(16); g.pad(4);
      g.bool(true);
      g.u8(2); [0, 7].forEach(fx => { g.pad(10); g.i8(fx); g.pad(fx === 0 ? 1 : 7); g.pad(16); g.pad(ge145 ? 10 : 9); });
      g.u8(1); g.pad(18); g.bool(true); g.pad(39);
      g.bool(true); g.pad(26);
      g.u8(5); [0, 1, 2, 3, 4].forEach(bt => { g.i8(bt); g.pad(bt === 0 ? 3 : bt === 3 ? 8 : bt === 4 ? 4 : 5); });
      g.pad(38);
      if (ge145) { g.bool(true); g.u8(1); g.pad(5); g.u8(2); g.pad(10); g.bool(true); g.pad(29); g.pad(10); g.bool(false); }
    };
    const nonPlayerData = () => { g.pad(10); g.pad(1); g.i32(0); };
    const person = (p, idx) => {
      g.i32(p.f).i32(p.s).i32(p.cn).date(p.dob[0], p.dob[1]).i32(p.nat).u8(p.apps).u8(p.goals);
      if (ge145) g.pad(2);
      g.i32(-1).u8(0).date(1900, 0).i32(p.team).u8(0).date(p.joined[0], p.joined[1]).pad(1).i32(p.pd).pad(4).byteArr(4, 1).pad(8);
      g.u8(p.contracts.length); p.contracts.forEach(c => { g.u8(c.t); contract(c); });
      g.u8(p.offers.length);
      p.offers.forEach(o => { g.u8(o.type); g.pad(6); if (!ge145 || o.type !== 255) contract({ t: 0, ft: true, b: false, cl: [], ct: 0, c: 1, w: 9, e: [2005, 1], ss: 1, ts: 0, h: 0, ps: 1, n: 0 }); });
      const prefs = [{ rt: 1 }, { rt: 2, rel: 3 }].concat(p.an.map(n => ({ rt: 2, rel: 9, n })));
      g.bool(true); g.u8(prefs.length);
      prefs.forEach(x => { g.u8(x.rt); if (x.rt === 2) { g.u8(x.rel); if (x.rel === 9) { g.pad(2); g.i32(x.n); } else g.pad(6); } else g.pad(7); });
      g.wordArr(4, 2);
      if (ge145) { const hn = idx % 2 === 0; g.bool(hn); if (hn) { g.ws('Nick'); g.pad(4); } }
      g.pad(1);
      tail(idx, 9000 + idx);
    };
    const filterLists = () => {
      const lists = [];
      lists.push(() => { g.ascii('slfttslf'); g.i32(1); g.ascii('daqstlif'); g.ws('F'); g.pad(5); g.i32(3); g.ascii('rfqs'); g.pad(10); g.ascii('rfsp'); g.pad(2); g.ascii('rfpv'); g.pad(3); g.pad(10); });
      lists.push(() => { g.ascii('tslttslf'); g.i32(0); });
      lists.push(() => { g.ascii('tslntslf'); g.i32(1); g.ascii('swentlif'); g.ws('N'); g.pad(5); g.i32(2); g.ascii('rfsn'); g.pad(1); g.ascii('rfcn'); g.pad(2); g.pad(4); });
      lists.push(() => { g.ascii('ltontslf'); g.i32(1); g.ascii('etontlif'); g.ws(''); g.pad(5); g.i32(1); g.ascii('rftn'); g.pad(9); });
      lists.push(() => { g.ascii('tslhtslf'); g.i32(1); g.ascii('ntantlif'); g.ws('H'); g.pad(5); g.i32(1); g.ascii('rftn'); g.pad(2); g.intArr(8, 2); g.pad(8); });
      g.i32(lists.length); lists.forEach(f => f());
    };
    g.i32(people.length);
    people.forEach((p, idx) => {
      g.u8(p.rt);
      switch (p.rt) {
        case 1: nonPlayerData(); person(p, idx); break;
        case 2: playerData(p); person(p, idx); break;
        case 3: playerData(p); nonPlayerData(); person(p, idx); if (ge145) g.pad(2); break;
        case 4: g.pad(24); person(p, idx); break;
        case 5: g.ws('Old'); g.ws('Timer'); g.pad(2); tail(idx, 9000 + idx); break;
        case 6: g.pad(1); tail(idx, 9000 + idx); break;
        case 7: g.pad(6); tail(idx, 9000 + idx); break;
        case 8: person(p, idx); break;
        case 9:
          g.pad(ge145 ? 16 : 12); g.ws('secret'); if (ge145) g.pad(1); g.pad(67); g.byteArr(8, 1); g.pad(96);
          filterLists(); if (v >= 115) g.pad(4); g.pad(1);
          if (ge145) { g.pad(11); g.byteArr(32, 1); g.pad(1); }
          nonPlayerData(); person(p, idx); break;
      }
    });
    g.i32(personData.length); personData.forEach((d, k) => { g.u8(0); d.forEach(x => g.i8(x)); tail(k, 0); });
    g.i32(playingData.length); playingData.forEach((d, k) => { g.u8(0); d.forEach(x => g.i8(x)); if (ge145) g.pad(1); tail(k, 0); });
    g.i32(1); g.u8(0); g.pad(28); tail(0, 0);
    g.pad(64); // trailing tables the loader never reads
  }
  gameDb();
  const dbBuf = db.buf();

  // ================= save container =================
  const hv = ge145 ? 2 : 1;
  w.u8(0).u16(46).wfixed('cm4', 6).u16(hv);
  w.pad(hv === 1 ? 2 : 6); w.pad(54);
  const table = (name, ext, body) => { if (hv === 2) w.pad(4); w.u8(2); w.wfixed(name, 56); w.wfixed(ext, 8); w.i32(body.length); w.raw(body); };
  if (hv === 2) w.pad(4); w.u8(0);            // a non-table header byte the loader steps over
  table('news', 'dat', Buffer.alloc(100, 7));
  table('game_db', 'dat', dbBuf);
  table('other', 'dat', Buffer.alloc(80, 1));

  return { save: w.buf(), people, clubs, nations, comps, teams, first, second, common };
}

function buildLang() {
  const g = new W();
  g.u8(0).u16(46).wfixed('dat', 6).u16(146).pad(1);
  // two languages: 8 (English) and 7 (Dutch)
  g.u8(2);
  const header = 12 + 1 + 16;
  const sections = {};
  const body = lang => {
    const b = new W();
    b.pad(12);
    const tbl = (n, f) => { b.i32(n); for (let j = 0; j < n; j++) f(j); };
    const sfx = lang === 7 ? ' (NL)' : '';
    tbl(1, () => { b.pad(4); b.ws('City'); b.pad(1); b.ws('C'); b.pad(1); });
    tbl(3, j => { b.i32(3001 + j); b.ws(['Northbridge United FC', 'Southport Rovers AFC', 'Fjordvik Idrettslag'][j] + sfx); b.pad(1); b.ws(['Northbridge Utd', 'Southport', 'Fjordvik'][j] + sfx); b.pad(1); b.ws('x'); b.pad(1); b.ws('The Bridge'); b.pad(1); b.ws(''); });
    tbl(1, () => { b.pad(4); b.ws('Europe'); b.pad(1); b.ws('E'); b.ws('Eur'); b.ws('E'); b.pad(1); b.ws('EU'); b.pad(1); b.u8(2); b.ws('a'); b.ws('b'); });
    tbl(1, () => { b.pad(4); b.ws('Inj'); b.pad(1); b.ws('I'); b.pad(1); });
    tbl(4, j => { b.i32(1001 + j); b.ws(['England', 'Brazil', 'Norway', 'France'][j] + sfx); b.pad(1); b.ws(['England', 'Brazil', 'Norway', 'France'][j] + sfx); b.pad(1); b.ws('x'); b.ws(['English', 'Brazilian', 'Norwegian', 'French'][j]); b.u8(1); b.ws('alt'); });
    tbl(1, () => { b.pad(4); b.ws('Award'); b.pad(1); b.ws('A'); b.pad(1); });
    tbl(1, () => { b.pad(4); b.ws('Stadium'); b.pad(1); });
    tbl(1, () => { b.pad(4); b.ws('S1'); b.pad(1); b.ws('S2'); b.pad(1); b.ws('S3'); b.pad(1); });
    tbl(3, j => { b.i32(2001 + j); b.ws(['English Premier Division', 'English First Division', 'Norwegian Premier League'][j] + sfx); b.pad(1); b.ws(['Premiership', 'Div 1', 'Tippeligaen'][j] + sfx); b.pad(1); b.ws('z'); });
    return b.buf();
  };
  const en = body(8), nl = body(7);
  sections[7] = header; sections[8] = header + nl.length;
  g.i32(7).i32(sections[7]).i32(8).i32(sections[8]);
  g.raw(nl); g.raw(en);
  return g.buf();
}

if (require.main === module) {
  const out = process.argv[2] || path.join(__dirname, 'fixtures');
  const v = +(process.argv[3] || 146);
  const players = +(process.argv[4] || 60);
  fs.mkdirSync(out, { recursive: true });
  const r = build(v, { players });
  const file = path.join(out, `test-v${v}${players !== 60 ? '-' + players : ''}.cm4`);
  fs.writeFileSync(file, r.save);
  fs.writeFileSync(path.join(out, 'lang_db.dat'), buildLang());
  console.log(`wrote ${file} (${r.save.length} bytes) and lang_db.dat`);
}
module.exports = { build, buildLang };
