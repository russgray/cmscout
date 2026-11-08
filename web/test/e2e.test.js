// Browser test for cmscout.html (Championship Manager 01/02), using generated fixtures.
//   node e2e.test.js [screenshotDir]
'use strict';
const fs = require('fs');
const os = require('os');
const path = require('path');
const assert = require('assert');
const { chromium } = require('playwright');
const fixture = require('./make-fixture');

(async () => {
  const shots = process.argv[2];
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'cmscout-'));
  const save = path.join(tmp, 'Kingsbury 2002.sav');
  const fx = fixture.build({ players: 40, compressed: true });
  fs.writeFileSync(save, fx.save);
  const url = 'file://' + path.join(__dirname, '..', 'cmscout.html');

  const browser = await chromium.launch();
  const ctx = await browser.newContext({ viewport: { width: 1400, height: 860 }, deviceScaleFactor: shots ? 2 : 1, acceptDownloads: true });
  const page = await ctx.newPage();
  let shotN = 0;
  const shot = async name => { if (shots) await page.screenshot({ path: path.join(shots, String(++shotN).padStart(2, '0') + '-' + name + '.png') }); };
  const errors = [];
  page.on('pageerror', e => errors.push(e.message));
  page.on('console', m => { if (m.type() === 'error') errors.push(m.text()); });
  const count = () => page.evaluate(() => window.CMScout.view.list.length);
  await page.goto(url);

  // load a compressed CM 01/02 save
  await page.setInputFiles('#fileSave', save);
  await page.waitForFunction(() => window.CMScout.db && window.CMScout.db.game === 'cm0102');
  assert.match(await page.textContent('#gameInfo'), /CM 01\/02 \(compressed\) · 40 players/);
  assert.match(await page.textContent('#gameInfo'), /09\.08\.2002/); // 1 Jan 2002 + 220 days
  assert.strictEqual(await page.textContent('#btnSaveSl'), 'Export scout list');

  await page.click('#btnSearch');
  assert.strictEqual(await count(), 40);
  // CM 01/02 default columns: Name, Nation, Club, Position, Ability, Pot Ability, Age, Value, Scout Rating
  const heads = await page.$$eval('.ghead [data-col]', els => els.map(e => e.dataset.col));
  assert.deepStrictEqual(heads, ['name', 'nation', 'club', 'pos', 'ca', 'pa', 'age', 'value', 'sr']);
  await shot('all-players');

  // goalkeepers (players 0, 9, 18, 27, 36)
  await page.check('[data-pos="Goalkeeper"]');
  await page.click('#btnSearch');
  assert.deepStrictEqual(await page.evaluate(() => window.CMScout.view.list.map(p => p.uid).sort()), [7000, 7009, 7018, 7027, 7036]);
  await page.uncheck('[data-pos="Goalkeeper"]');

  // club reputation (CM 01/02-only filter): Kingsbury is 7000
  assert.ok(await page.isVisible('[data-rmin="clubRep"]'));
  assert.ok(await page.isHidden('[data-rmin="squadRep"]'));
  await page.fill('[data-rmin="clubRep"]', '6000');
  await page.click('#btnSearch');
  assert.strictEqual(await count(), 14);
  await shot('club-rep-filter');
  await page.fill('[data-rmin="clubRep"]', '');

  // contract tab: CM 01/02 options
  await page.click('.tabs button[data-tab="tContract"]');
  assert.strictEqual(await page.$$eval('#f_contractType option', o => o.length), 9);
  assert.strictEqual(await page.$$eval('#f_squadStatus option', o => o.length), 10);
  assert.strictEqual(await page.$$eval('#f_transfer option', o => o.length), 4);
  await page.selectOption('#f_contract', '0'); // free transfer
  await page.click('#btnSearch');
  assert.strictEqual(await count(), 6);
  await page.selectOption('#f_contract', '');
  await page.selectOption('#f_transfer', { label: 'Transfer Listed By Club' });
  await page.click('#btnSearch');
  assert.strictEqual(await count(), 11);
  await shot('contract-tab-transfer-listed');
  await page.selectOption('#f_transfer', '');
  await page.check('[data-f="nonPlaying"]');
  await page.click('#btnSearch');
  const np = await page.evaluate(() => window.CMScout.view.list.map(p => p.k.npl));
  assert.ok(np.length > 0 && np.every(x => x >= 1));
  await page.uncheck('[data-f="nonPlaying"]');

  // attributes tab uses the in-game names (Vision -> Creativity)
  await page.click('.tabs button[data-tab="tAttr"]');
  assert.ok(await page.$('label[for="am_Vision"]:text("Creativity")'));
  await page.fill('[data-amin="Vision"]', '14');
  await page.click('#btnSearch');
  const vis = await page.evaluate(() => { const d = window.CMScout.db; return window.CMScout.view.list.every(p => d.attr[p.i * d.stride + d.ki.Vision] >= 14); });
  assert.ok(vis);
  await shot('attributes-creativity-14');
  await page.click('#btnReset');
  await page.click('.tabs button[data-tab="tGeneral"]');

  // team search: one squad per club, squad picker hidden
  await page.click('#btnTeam');
  assert.ok(await page.isHidden('#squadSel'));
  await page.fill('#clubFind', 'kings');
  await page.selectOption('#clubList', { index: 0 });
  await shot('team-search');
  await page.click('#teamOk');
  await page.waitForFunction(() => window.CMScout.view.mode === 'team');
  assert.strictEqual(await count(), 14); // non-players in the squad slots are left out
  await page.click('.ghead [data-col="name"]');

  // player 6 is on loan at Kingsbury from Riverside
  const row = await page.evaluate(() => window.CMScout.view.list.findIndex(p => p.uid === 7006));
  await page.dblclick(`[data-row="${row}"]`);
  await page.waitForSelector('#dlgPlayer[open]');
  assert.match(await page.textContent('#piBody'), /On loan from Riverside/);
  assert.match(await page.textContent('#piBody'), /Set Pieces/);
  await shot('player-detail');
  await page.keyboard.press('Escape');

  // export .pls scout list (ScoutList.pas layout)
  const [dl] = await Promise.all([page.waitForEvent('download'), page.click('#btnSaveSl')]);
  const pls = path.join(tmp, 'list.pls');
  await dl.saveAs(pls);
  assert.match(dl.suggestedFilename(), /\.pls$/);
  const b = fs.readFileSync(pls);
  assert.strictEqual(b.length, 6 + 15 + 86 + 15 + 237 + 8 + 4 + 14 * 41 + 186);
  assert.deepStrictEqual([...b.subarray(0, 6)], [0x9E, 0x4A, 0x02, 0x00, 0x01, 0x04]);
  assert.strictEqual(b.subarray(6, 21).toString('latin1'), 'CM Scout Search');
  assert.strictEqual(b.readInt32LE(367), 14);
  const firstUid = b.readInt32LE(371 + 12);
  assert.ok(firstUid >= 7000 && firstUid < 7014);
  assert.strictEqual(b[371 + 40], 0xFF);
  assert.deepStrictEqual([...b.subarray(b.length - 186, b.length - 180)], [0x81, 0x00, 0x14, 0x14, 0x84, 0xA8]);

  // CSV export of visible columns
  const [csv] = await Promise.all([page.waitForEvent('download'), page.click('#btnCsv')]);
  const csvPath = path.join(tmp, 'list.csv');
  await csv.saveAs(csvPath);
  const lines = fs.readFileSync(csvPath, 'utf8').replace(/^﻿/, '').trim().split(/\r\n/);
  assert.strictEqual(lines[0], 'Name;Nation;Club;Position;Ability;Pot Ability;Age;Value;Scout Rating');
  assert.strictEqual(lines.length, 15);

  // star a player, set a filter, reload: CM 01/02 comes back from the cache with its own settings
  await page.click('[data-star="0"]');
  await page.fill('[data-rmin="ca"]', '100');
  await page.waitForTimeout(400);
  await page.reload();
  await page.waitForFunction(() => window.CMScout.db && window.CMScout.db.game === 'cm0102', null, { timeout: 10000 });
  assert.strictEqual(await page.inputValue('[data-rmin="ca"]'), '100');
  assert.strictEqual(await page.textContent('#starCount'), '1');
  await shot('after-reload');

  // a CM4 / 03-04 save is rejected with a clear message, and the loaded game stays
  const cm4 = path.join(tmp, 'Other game.cm4');
  const cm4buf = Buffer.alloc(4000); Buffer.from([0, 46, 0, 99, 0, 109, 0, 52, 0, 2, 0]).copy(cm4buf);
  fs.writeFileSync(cm4, cm4buf);
  await page.setInputFiles('#fileSave', cm4);
  await page.waitForSelector('#dlgError[open]');
  assert.match(await page.textContent('#errText'), /valid Championship Manager 01\/02 saved game/);
  await page.keyboard.press('Escape');
  assert.strictEqual(await page.evaluate(() => window.CMScout.db.players.length), 40);

  // a truncated save reports an error
  const bad = path.join(tmp, 'bad.sav');
  fs.writeFileSync(bad, fx.save.subarray(0, fx.save.length - 500));
  await page.setInputFiles('#fileSave', bad);
  await page.waitForSelector('#dlgError[open]');
  assert.match(await page.textContent('#errText'), /past the end|corrupt/i);
  await shot('truncated-save-error');

  assert.deepStrictEqual(errors.filter(e => !/past the end|corrupt|valid Championship Manager/i.test(e)), []);
  await browser.close();
  console.log('e2e ok');
})().catch(e => { console.error(e); process.exit(1); });
