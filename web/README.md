# CM Scout for the browser

`cmscout.html` is a single, self-contained HTML file that ports two Delphi apps in this
repository to the browser:

- **CM Scout 3.10** (repository root) for Championship Manager 4 and CM 03/04 (`.cm4` saves)
- **CM Scout 2.00** (`CM0102/`) for Championship Manager 01/02 (`.sav` saves, compressed or not)

Open it directly from disk or host it anywhere as a static file. It has no dependencies and
makes no network requests. Save files are read locally and never uploaded. The page detects
which game a save comes from and switches its columns, filters and player view to match.

## What it does

| Original (Delphi)                           | Browser port                                                      |
|---------------------------------------------|-------------------------------------------------------------------|
| Load a saved game                           | **Load saved game…**, parsed in a Web Worker; game detected automatically |
| Optional `lang_db.dat` + language choice (CM4 only) | **lang_db.dat…** button; language under **Settings**     |
| Player Search dialog                        | Search panel on the left, same filters per game, plus saved searches |
| Team Search                                 | **Team search…** (type to filter clubs)                           |
| CM4: load / save `.slf` shortlists          | **Load shortlist…** / **Export shortlist** (same binary format)   |
| CM 01/02: save `.pls` scout lists, CSV/TXT  | **Export scout list** (same binary format, "Interested" option under Settings); **Export CSV** for both games |
| Sortable columns, show/hide, reorder        | Same columns per game; click to sort, drag to reorder, drag edge to resize |
| Player info window                          | Double-click a row (or Enter); ← / → step through the list        |
| Settings in the registry                    | Settings in `localStorage`                                        |

Additions:
- **Starred players**: click ☆ in a row (or press Space) to keep a personal shortlist across sessions.
- **Saved searches**: name and recall filter sets.
- The last loaded game and `lang_db.dat` are cached in IndexedDB, so a reload doesn't need the
  file again. You can turn this off under Settings. A parsed save is far larger than
  localStorage allows, so only small data goes there.
- The name search ignores accents ("goncalves" finds "Gonçalves").
- Columns, filters, saved searches and stars are kept separately for each game.

## What is stored where

- `localStorage["cmscout.v1"]`: settings, plus per game (`games.cm4`, `games.cm0102`): column
  layout, sort, current filters, saved searches, stars.
- IndexedDB `cmscout/kv`: `game` (parsed player data from the last save) and `lang` (raw `lang_db.dat`).

## Differences from the originals

Both games:
- An empty min or max box means "no limit". In the originals, setting only a minimum on some
  ranges (e.g. Value, Age) left the maximum at 0 and excluded everyone.
- Nation, Based and Division filters are stored by unique ID, so saved searches keep working
  across saves from the same game.
- Scout rating formulas are ported exactly, quirks included. For CM 01/02 the weights are
  extracted from `ScoutRatingUnit.pas` by script, and the tests check each divisor equals the
  sum of its weights.

CM4 / CM 03/04:
- If the chosen language isn't in `lang_db.dat`, the first language in the file is used
  (the original jumped to a fixed offset).
- A playing-data record shared by two players is converted only once. The original would
  convert it twice.

CM 01/02:
- Dates are shown with the real calendar. The original's date display subtracted a day in leap
  years, which put January and February dates one day early.
- The player window's "Protected" line uses day 244 of 2001 as the search filter does; the
  original window compared the year with 244 by mistake.
- Players with no first name, second name or nation don't crash the list (the original
  dereferenced them).
- A save missing a required block shows which block is missing instead of a generic error.
- CSV export quotes fields that contain `;` or `"`. The original's TXT export isn't ported;
  use CSV.

## Tests

The real game data isn't in the repo, so the fixture generators write **synthetic** saves in the
layout each Delphi loader expects:

- `test/make-fixture.js`: CM4 / CM 03/04 save and `lang_db.dat`. Covers every record type,
  every version branch (110–147), contracts, clauses, filter lists, injuries and bans.
- `test/make-fixture-0102.js`: CM 01/02 save, plain or run-length compressed. Covers the block
  table, all record types used, the contract table's pre-records, loans, non-players in squads
  and windows-1252 names.

These tests check that the port is internally consistent. They don't prove compatibility with
real saves.

```sh
cd web/test
node parser.test.js                 # parsers: CM4 DB versions 110..147, CM 01/02 plain + compressed
node e2e.test.js [shotsDir]         # Playwright, CM4: load, filter, sort, team search, shortlists, cache restore
node e2e-0102.test.js [shotsDir]    # Playwright, CM 01/02: filters, team search, .pls + CSV export, game switching
                                    # with shotsDir, both save a numbered 2x screenshot of each step
node make-fixture.js out 146 100000              # big synthetic CM4 save for performance checks
node make-fixture-0102.js out 100000 --compressed  # big synthetic CM 01/02 save
```
