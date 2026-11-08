// Browser smoke test for cmscout.html using generated fixtures.
//   node e2e.test.js [screenshotDir]
'use strict';
const fs = require('fs');
const os = require('os');
const path = require('path');
const assert = require('assert');
const { chromium } = require('playwright');
const { build, buildLang } = require('./make-fixture');

(async () => {
  const shots = process.argv[2];
  const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'cmscout-'));
  const save = path.join(tmp, 'Northbridge 2003.cm4');
  const lang = path.join(tmp, 'lang_db.dat');
  fs.writeFileSync(save, build(146).save);
  fs.writeFileSync(lang, buildLang());
  const url = 'file://' + path.join(__dirname, '..', 'cmscout.html');

  const browser = await chromium.launch();
  const ctx = await browser.newContext({ viewport: { width: 1400, height: 860 }, deviceScaleFactor: shots ? 2 : 1, acceptDownloads: true });
  let shotN = 0;
  const shot = async name => { if (shots) await page.screenshot({ path: path.join(shots, String(++shotN).padStart(2, '0') + '-' + name + '.png') }); };
  const page = await ctx.newPage();
  const errors = [];
  page.on('pageerror', e => errors.push(e.message));
  page.on('console', m => { if (m.type() === 'error') errors.push(m.text()); });
  await page.goto(url);
  await shot('empty');

  // load save
  await page.setInputFiles('#fileSave', save);
  await page.waitForFunction(() => window.CMScout.db && window.CMScout.db.players.length === 60);
  assert.match(await page.textContent('#gameInfo'), /Northbridge 2003/);
  assert.match(await page.textContent('#gameInfo'), /20\.07\.2003/); // 1 Jan + 200 days

  // search everything
  await page.click('#btnSearch');
  assert.strictEqual(await page.evaluate(() => window.CMScout.view.list.length), 60);
  assert.match(await page.textContent('#resultsCount'), /60 players found/);
  await shot('all-players');

  // position filter: goalkeepers only (players 0, 11, 22, ...)
  await page.check('[data-pos="Goalkeeper"]');
  await page.click('#btnSearch');
  const gks = await page.evaluate(() => window.CMScout.view.list.map(p => p.uid).sort((a, b) => a - b));
  assert.deepStrictEqual(gks, [9000, 9011, 9022, 9033, 9044, 9055]);
  await shot('goalkeepers-filter');
  await page.uncheck('[data-pos="Goalkeeper"]');

  // name filter matches common names and is accent-insensitive
  await page.fill('#f_name', 'ronaldinho');
  await page.click('#btnSearch');
  assert.strictEqual(await page.evaluate(() => window.CMScout.view.list.length), 1);
  await page.fill('#f_name', 'goncalves');
  await page.press('#f_name', 'Enter');
  assert.ok(await page.evaluate(() => window.CMScout.view.list.length) >= 1);
  await page.fill('#f_name', '');

  // nation filter includes additional nationalities: France (idx 3) players + players 10/11
  await page.selectOption('#f_nation', { label: 'France' });
  await page.click('#btnSearch');
  const fr = await page.evaluate(() => window.CMScout.view.list.map(p => p.uid));
  assert.ok(fr.includes(9010) && fr.includes(9011) && fr.includes(9003));
  await page.selectOption('#f_nation', '');

  // free transfer = no club
  await page.click('.tabs button[data-tab="tContract"]');
  await page.selectOption('#f_contract', '0');
  await page.click('#btnSearch');
  assert.strictEqual(await page.evaluate(() => window.CMScout.view.list.length), 10);
  await shot('contract-tab-free-transfers');
  await page.selectOption('#f_contract', '');

  // attribute range
  await page.click('.tabs button[data-tab="tAttr"]');
  await page.fill('[data-amin="Pace"]', '15');
  await page.click('#btnSearch');
  const pace = await page.evaluate(() => { const d = window.CMScout.db, A = 51; return window.CMScout.view.list.every(p => d.attr[p.i * 73 + A] >= 15); });
  assert.ok(pace);
  await shot('attributes-tab-pace-15');
  await page.click('#btnReset');
  await page.click('.tabs button[data-tab="tGeneral"]');

  // saved search persists in localStorage
  await page.fill('[data-rmin="age"]', '20');
  await page.fill('[data-rmax="age"]', '25');
  page.once('dialog', d => d.accept('Young'));
  await page.click('#btnPresetSave');
  await page.waitForTimeout(300);
  const stored = await page.evaluate(() => JSON.parse(localStorage.getItem('cmscout.v1')));
  assert.deepStrictEqual(stored.presets.Young.age, ['20', '25']);
  await page.click('#btnSearch');
  const ages = await page.evaluate(() => window.CMScout.view.list.length);
  assert.ok(ages > 0 && ages < 60);

  // sort by Ability: first click = highest first
  await page.click('.ghead [data-col="ca"]');
  const cas = await page.evaluate(() => window.CMScout.view.list.map(p => p.ca));
  assert.deepStrictEqual(cas, cas.slice().sort((a, b) => b - a));
  await page.click('.ghead [data-col="name"]');

  // lang_db names
  await page.setInputFiles('#fileLang', lang);
  await page.waitForFunction(() => document.querySelector('#btnLangLabel').textContent.includes('✓'));
  assert.ok(await page.$('#f_division option:text("Norwegian Premier League")'));

  // team search
  await page.click('#btnTeam');
  await page.fill('#clubFind', 'north');
  await page.selectOption('#clubList', { index: 0 });
  await page.dispatchEvent('#clubList', 'change');
  await shot('team-search-dialog');
  await page.click('#teamOk');
  await page.waitForFunction(() => window.CMScout.view.mode === 'team');
  assert.strictEqual(await page.evaluate(() => window.CMScout.view.list.length), 26); // first team 20 + reserves 6
  assert.match(await page.textContent('#resultsTitle'), /Northbridge United FC/);
  await shot('team-search-results-with-lang-names');

  // export shortlist, then load it back
  const [dl] = await Promise.all([page.waitForEvent('download'), page.click('#btnSaveSl')]);
  const slf = path.join(tmp, 'team.slf');
  await dl.saveAs(slf);
  const b = fs.readFileSync(slf);
  assert.deepStrictEqual([...b.subarray(0, 12)], [0, 46, 0, 115, 0, 108, 0, 102, 0, 1, 0, 0]);
  assert.strictEqual(b.readInt32LE(12), 26);
  await page.click('#btnSearch');
  await page.setInputFiles('#fileSl', slf);
  await page.waitForFunction(() => window.CMScout.view.mode === 'shortlist');
  assert.strictEqual(await page.evaluate(() => window.CMScout.view.list.length), 26);

  // stars
  await page.click('[data-star="0"]');
  await page.click('[data-star="1"]');
  assert.strictEqual(await page.textContent('#starCount'), '2');

  // player dialog
  await page.dblclick('[data-row="2"]');
  await page.waitForSelector('#dlgPlayer[open]');
  assert.match(await page.textContent('#piSub'), /Age \d+/);
  await shot('player-detail');
  await page.keyboard.press('ArrowRight');
  await page.keyboard.press('Escape');

  // columns: show a hidden column
  await page.click('#btnColumns');
  await page.check('[data-colvis="wage"]');
  await page.keyboard.press('Escape');
  await page.waitForSelector('#dlgColumns', { state: 'hidden' });
  assert.ok(await page.$('.ghead [data-col="wage"]'));
  assert.strictEqual(await page.evaluate(() => window.CMScout.settings().columns.visible.includes('wage')), true);

  await page.click('#btnSearch');
  await shot('results-with-wage-column');

  // reload: game, lang_db, filters, stars and columns come back from storage
  await page.waitForTimeout(500);
  await page.reload();
  await page.waitForFunction(() => window.CMScout.db && window.CMScout.db.players.length === 60, null, { timeout: 10000 });
  assert.strictEqual(await page.inputValue('[data-rmin="age"]'), '20');
  assert.strictEqual(await page.textContent('#starCount'), '2');
  assert.ok(await page.$('.ghead [data-col="wage"]'));
  await page.waitForFunction(() => document.querySelector('#btnLangLabel').textContent.includes('✓'));
  await page.click('#btnStarred');
  assert.strictEqual(await page.evaluate(() => window.CMScout.view.list.length), 2);
  await shot('after-reload-starred');
  await page.click('#btnSettings');
  await page.waitForSelector('#dlgSettings[open]');
  await shot('settings');
  await page.keyboard.press('Escape');

  // a bad file reports an error instead of crashing
  const bad = path.join(tmp, 'bad.cm4');
  fs.writeFileSync(bad, Buffer.alloc(500, 3));
  await page.setInputFiles('#fileSave', bad);
  await page.waitForSelector('#dlgError[open]');
  assert.match(await page.textContent('#errText'), /valid CM4 saved game/);
  await shot('bad-file-error');

  assert.deepStrictEqual(errors.filter(e => !/valid CM4 saved game/.test(e)), []);
  await browser.close();
  console.log('e2e ok');
})().catch(e => { console.error(e); process.exit(1); });
