// Runs the parser embedded in cmscout.html against generated CM 01/02 fixtures.
//   node parser.test.js
'use strict';
const fs = require('fs');
const path = require('path');
const assert = require('assert');
const vm = require('vm');
const fixture = require('./make-fixture');

const html = fs.readFileSync(path.join(__dirname, '..', 'cmscout.html'), 'utf8');
const src = html.match(/<script id="parser-src">([\s\S]*?)<\/script>/)[1];
const ctx = { TextDecoder, console };
vm.createContext(ctx);
vm.runInContext(src + '\nthis.CMParser = CMParser;', ctx);
const P = ctx.CMParser;

function ab(buf) { return buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.length); }
const json = x => JSON.stringify(x);

const plain = fixture.build({ players: 40 });
const packed = fixture.build({ players: 40, compressed: true });
assert(packed.save.length < plain.save.length, 'compressed fixture should be smaller');
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
  const ATTR = ['Acceleration','Aggression','Agility','Anticipation','Balance','Bravery','Consistency','Corners','Crossing','Decisions','Dirtiness','Dribbling','Finishing','Flair','FreeKicks','Handling','Heading','ImportantMatches','InjuryProneness','Jumping','Leadership','LeftFoot','LongShots','Marking','Movement','NaturalFitness','OneOnOnes','PlayerPace','Passing','Penalties','Positioning','Reflexes','RightFoot','Stamina','Strength','Tackling','Teamwork','Technique','ThrowIns','Versatility','Vision','WorkRate'];
  for (const j of [0, 1, 2, 9, 17]) {
    const raw = plain.players[j], gk = raw.pos[0] >= 15, ca = raw.ca, S = r.stride;
    const got = k => r.attr[j * S + KI[k]], rawv = k => raw.at[ATTR.indexOf(k)];
    assert.strictEqual(got('Anticipation'), high(rawv('Anticipation'), ca));
    assert.strictEqual(got('Handling'), (gk ? high : low)(rawv('Handling'), ca));
    assert.strictEqual(got('Vision'), (gk ? low : high)(rawv('Vision'), ca));
    assert.strictEqual(got('Agility'), rawv('Agility')); // not converted
    assert.strictEqual(got('Determination'), plain.staff[j].pers[2]); // personality comes from the staff record
  }
  assert.strictEqual(r.bestPos[0], 0); // player 0 is a goalkeeper
  assert(r.rating[0 * 8 + 7] > 0);
}
assert.strictEqual(json(r0.players), json(r1.players), 'compressed and plain saves must parse identically');
assert.strictEqual(json(Array.from(r0.attr)), json(Array.from(r1.attr)));
assert.strictEqual(json(Array.from(r0.rating)), json(Array.from(r1.rating)));
// every rating divisor equals the sum of its weights (catches a dropped term)
for (const [pos, def] of Object.entries(P.CM0102_RATINGS)) {
  assert.strictEqual(def[1].reduce((s, t) => s + t[1], 0), def[0], pos);
}
// corruption is reported, not silently accepted
assert.throws(() => P.parseSave(ab(packed.save.subarray(0, packed.save.length - 400))), /past the end|corrupt/i);
assert.throws(() => P.parseSave(new ArrayBuffer(20)), /valid Championship Manager 01\/02 saved game/);
// a CM4 / 03-04 save is rejected
const cm4 = Buffer.alloc(4000); Buffer.from([0, 46, 0, 99, 0, 109, 0, 52, 0, 2, 0]).copy(cm4);
assert.throws(() => P.parseSave(ab(cm4)), /valid Championship Manager 01\/02 saved game/);
console.log('all parser tests passed (plain ' + plain.save.length + ' bytes, compressed ' + packed.save.length + ' bytes)');
