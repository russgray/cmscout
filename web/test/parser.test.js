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

// corruption is reported, not silently accepted
assert.throws(() => P.parseSave(new ArrayBuffer(20)), /valid CM4 saved game/);
const fx = build(146);
const cut = ab(fx.save.subarray(0, fx.save.length - 3000));
assert.throws(() => P.parseSave(cut), /corrupt|game_db/i);
console.log('all parser tests passed');
