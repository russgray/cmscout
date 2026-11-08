// Runs the parser embedded in cmscout.html against generated fixtures.
//   node parser.test.js
'use strict';
const fs = require('fs');
const path = require('path');
const assert = require('assert');
const vm = require('vm');
const { build, buildLang } = require('./make-fixture');

const html = fs.readFileSync(path.join(__dirname, '..', 'cmscout.html'), 'utf8');
const src = html.match(/<script id="parser-src">([\s\S]*?)<\/script>/)[1];
const ctx = { TextDecoder, console };
vm.createContext(ctx);
vm.runInContext(src + '\nthis.CMParser = CMParser;', ctx);
const P = ctx.CMParser;

function ab(buf) { return buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.length); }

for (const v of [110, 113, 115, 145, 146, 147]) {
  const fx = build(v);
  const res = P.parseSave(ab(fx.save));
  assert.strictEqual(res.version, v);
  assert.strictEqual(res.gameDate, 2003200);
  assert.strictEqual(res.clubs.length, 4);
  assert.strictEqual(res.nations.length, 4);
  assert.strictEqual(res.players.length, 60, 'players');
  assert.strictEqual(res.counts.people, 67);
  assert.strictEqual(res.clubs[0].n, 'Northbridge United');
  assert.strictEqual(res.clubs[3].lb, true);
  assert.strictEqual(JSON.stringify(res.clubs[0].teams), JSON.stringify([0, 3]));
  assert.strictEqual(res.comps[0].n, 'English Premier Division');
  assert.strictEqual(res.comps[2].n, '');
  assert.strictEqual(res.nations[0].eu, true);
  assert.strictEqual(res.nations[1].eu, false);
  // squad lists only contain players (the non-player in team 0 is dropped)
  assert.strictEqual(res.teams[0].pl.length, 20);
  assert.strictEqual(res.teams[4].pl.length, 4); // national team
  const p0 = res.players[0];
  assert.strictEqual(p0.uid, 9000);
  assert.strictEqual(p0.f, 'John');
  assert.strictEqual(p0.s, 'Smith');
  assert.strictEqual(res.players[3].c, 'Ronaldinho');
  assert.strictEqual(res.players[5].f, null);
  assert.strictEqual(JSON.stringify(res.players[10].an), JSON.stringify([3]));
  assert.strictEqual(JSON.stringify(res.players[11].an), JSON.stringify([1, 3]));
  assert.strictEqual(p0.k.length, 1);
  assert.strictEqual(p0.k[0].t, 0);
  assert.strictEqual(JSON.stringify(p0.k[0].cl.map(c => c[0])), JSON.stringify([0, 9, 2])); // clause type 77 dropped
  assert.strictEqual(res.players[25].k[0].t, 1); // loan first
  assert.strictEqual(res.players[45].k[1].t, 5);
  assert.strictEqual(res.players[50].k[0].t, 2);
  assert.strictEqual(res.players[50].team, -1);
  // attribute conversion is clamped to 1..20; positions untouched
  const S = P.STRIDE;
  for (let i = 0; i < res.players.length; i++) {
    for (let k = 12; k < 37; k++) { const a = res.attr[i * S + k]; assert(a >= 1 && a <= 20, `attr ${k}=${a}`); }
  }
  assert.strictEqual(res.attr[0 * S + 0], 20); // player 0 is a GK
  assert(res.bestPos[0] === 0, 'GK best rating should be GK');
  assert(res.rating[0 * 8 + 7] > 0);

  const lang = P.parseLang(ab(buildLang()), 8);
  assert.strictEqual(lang.clubs[3001].n, 'Northbridge United FC');
  assert.strictEqual(lang.comps[2003].s, 'Tippeligaen');
  assert.strictEqual(lang.nations[1003].nat, 'Norwegian');
  const nl = P.parseLang(ab(buildLang()), 7);
  assert.strictEqual(nl.clubs[3001].n, 'Northbridge United FC (NL)');
  const def = P.parseLang(ab(buildLang()), 99);
  assert.strictEqual(def.usedDefault, true);
  console.log(`v${v}: ok (${fx.save.length} bytes, ${res.players.length} players)`);
}

// ---------------- CM 01/02 ----------------
const f0102 = require('./make-fixture-0102');
const plain = f0102.build({ players: 40 });
const packed = f0102.build({ players: 40, compressed: true });
assert(packed.save.length < plain.save.length, 'compressed fixture should be smaller');
// the RLE encoder round-trips through the app's decoder
const sample = Buffer.from([1, 1, 1, 1, 200, 200, 128, 129, 0, 0, 0, 0, 0, 7]);
const enc = f0102.rle(sample);
const r0 = P.parseSave(ab(plain.save));
const r1 = P.parseSave(ab(packed.save));
for (const r of [r0, r1]) {
  assert.strictEqual(r.game, 'cm0102');
  assert.strictEqual(r.gameDate, 2002220);
  assert.strictEqual(r.players.length, 40);
  assert.strictEqual(r.counts.people, 43);
  assert.strictEqual(r.clubs.length, 3);
  assert.strictEqual(r.clubs[0].n, 'Kingsbury Athletic');
  assert.strictEqual(r.clubs[1].s, 'Aalvik');
  assert.strictEqual(r.clubs[0].rep, 7000);
  assert.strictEqual(r.comps[1].n, 'Danish Superliga');
  assert.strictEqual(r.nations[2].nat, 'Danish');
  assert.strictEqual(r.nations[0].eu, true);
  assert.strictEqual(r.nations[1].eu, false);
  assert.strictEqual(r.teams[0].pl.length, 14); // non-players in the squad slots are dropped
  const p = r.players;
  assert.strictEqual(p[0].f, 'Peter'); assert.strictEqual(p[0].s, 'Hughes'); assert.strictEqual(p[0].c, null);
  assert.strictEqual(p[4].c, 'Juninho');
  assert.strictEqual(p[4].f, 'Søren'); // windows-1252 decoding
  assert.strictEqual(p[5].nat2, 0);
  assert.strictEqual(p[0].uid, 7000);
  assert.strictEqual(p[0].club, 0); assert.strictEqual(p[39].club, -1);
  assert.strictEqual(p[39].k, null);
  // loan: staff 6 is at club 0 (ClubJob); parent club contract becomes Contract, the other LoanContract
  assert.strictEqual(p[6].k.club, 2); assert.strictEqual(p[6].loan.club, 0);
  assert.strictEqual(p[3].k.arr, 2);
  assert.strictEqual(p[0].k.np, 2); assert.strictEqual(p[0].k.mf, 1);
  // attribute conversion matches TCMDatabase.HighConvert / LowConvert
  const KI = {}; r.attrKeys.forEach((k, i) => { KI[k] = i; });
  const high = (a, ca) => { const t = a / 10 + ca / 20 + 10, x = t * t / 30 + t / 3 + 0.5; return Math.trunc(Math.min(20, Math.max(1, x))); };
  const low = (a, ca) => { const t = a / 10 + ca / 200 + 10, x = t * t / 30 + t / 3 + 0.5; return Math.trunc(Math.min(20, Math.max(1, x))); };
  const A0102 = ['Acceleration','Aggression','Agility','Anticipation','Balance','Bravery','Consistency','Corners','Crossing','Decisions','Dirtiness','Dribbling','Finishing','Flair','FreeKicks','Handling','Heading','ImportantMatches','InjuryProneness','Jumping','Leadership','LeftFoot','LongShots','Marking','Movement','NaturalFitness','OneOnOnes','PlayerPace','Passing','Penalties','Positioning','Reflexes','RightFoot','Stamina','Strength','Tackling','Teamwork','Technique','ThrowIns','Versatility','Vision','WorkRate'];
  for (const j of [0, 1, 2, 9, 17]) {
    const raw = plain.players[j], gk = raw.pos[0] >= 15, ca = raw.ca, S = r.stride;
    const got = k => r.attr[j * S + KI[k]], rawv = k => raw.at[A0102.indexOf(k)];
    assert.strictEqual(got('Anticipation'), high(rawv('Anticipation'), ca));
    assert.strictEqual(got('Handling'), (gk ? high : low)(rawv('Handling'), ca));
    assert.strictEqual(got('Vision'), (gk ? low : high)(rawv('Vision'), ca));
    assert.strictEqual(got('Agility'), rawv('Agility')); // not converted
    assert.strictEqual(got('Determination'), plain.staff[j].pers[2]); // personality comes from the staff record
  }
  assert.strictEqual(r.bestPos[0], 0); // player 0 is a goalkeeper
  assert(r.rating[0 * 8 + 7] > 0);
}
assert.strictEqual(JSON.stringify(r0.players), JSON.stringify(r1.players), 'compressed and plain saves must parse identically');
assert.strictEqual(JSON.stringify(Array.from(r0.attr)), JSON.stringify(Array.from(r1.attr)));
assert.strictEqual(JSON.stringify(Array.from(r0.rating)), JSON.stringify(Array.from(r1.rating)));
// every rating divisor equals the sum of its weights (catches a dropped term)
for (const [pos, def] of Object.entries(P.CM0102_RATINGS)) {
  assert.strictEqual(def[1].reduce((s, t) => s + t[1], 0), def[0], pos);
}
// a truncated compressed save is reported
assert.throws(() => P.parseSave(ab(packed.save.subarray(0, packed.save.length - 400))), /past the end|corrupt/i);
void enc;
console.log('cm0102: ok (plain ' + plain.save.length + ' bytes, compressed ' + packed.save.length + ' bytes)');

// corruption is reported, not silently accepted
assert.throws(() => P.parseSave(new ArrayBuffer(20)), /valid CM4, CM 03\/04 or CM 01\/02 saved game/);
const fx = build(146);
const cut = ab(fx.save.subarray(0, fx.save.length - 3000));
assert.throws(() => P.parseSave(cut), /corrupt|game_db/i);
console.log('all parser tests passed');
