# CM Scout 01/02 for the browser

`cmscout.html` is a single, self-contained HTML file that ports **CM Scout 2.00** (the Delphi
source in [`../CM0102/`](../CM0102/)) for **Championship Manager 01/02** to the browser.
Open it directly from disk or host it anywhere as a static file. It has no dependencies and
makes no network requests. Save files are read locally and never uploaded.

## What it does

| Original (Delphi)                           | Browser port                                                      |
|---------------------------------------------|-------------------------------------------------------------------|
| Open a `.sav` saved game (compressed or not) | **Load saved game…**, parsed in a Web Worker                     |
| Player Search dialog                        | Search panel on the left, same filters, plus saved searches       |
| Team Search (club squad)                    | **Team search…** (type to filter clubs)                           |
| Save `.pls` scout list ("Interested" option) | **Export scout list** (same binary format; option under **Settings**) |
| Save CSV / TXT                              | **Export CSV** of the visible columns                             |
| Sortable columns, show/hide                 | Same columns; click to sort, drag to reorder, drag edge to resize |
| Player info window                          | Double-click a row (or Enter); ← / → step through the list        |
| Settings in the registry                    | Settings in `localStorage`                                        |

Additions:
- **Starred players**: click ☆ in a row (or press Space) to keep a personal shortlist across sessions.
- **Saved searches**: name and recall filter sets.
- The last loaded game is cached in IndexedDB, so a reload doesn't need the file again. You can
  turn this off under Settings. A parsed save is far larger than localStorage allows, so only
  small data goes there.
- The name search ignores accents ("kjaer" finds "Kjær").

## What is stored where

- `localStorage["cmscout.v1"]`: settings, plus under `games.cm0102` the column layout, sort,
  current filters, saved searches and stars.
- IndexedDB `cmscout/kv`: `game` (parsed player data from the last save).

## Differences from the original

- An empty min or max box means "no limit". In the original, setting only a minimum on some
  ranges (e.g. Value, Age) left the maximum at 0 and excluded everyone.
- Nation, Based and Division filters are stored by unique ID, so saved searches keep working
  across saves from the same game.
- Scout rating formulas are ported exactly. The weights are extracted from
  `ScoutRatingUnit.pas` by script, and the tests check each divisor equals the sum of its weights.
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

The real game data isn't in the repo, so `test/make-fixture.js` writes a **synthetic** save,
plain or run-length compressed, in the layout `CMDatabase.pas` reads. It covers the block table,
all record types used, the contract table's pre-records, loans, non-players in squads and
windows-1252 names. These tests check that the port is internally consistent. They don't prove
compatibility with real saves.

```sh
cd web/test
node parser.test.js                 # parser: plain + compressed saves, conversions, ratings, corrupt input
node e2e.test.js [shotsDir]         # Playwright: filters, team search, player view, .pls + CSV export, cache restore
                                    # with shotsDir, saves a numbered 2x screenshot of each step
node make-fixture.js out 100000 --compressed   # big synthetic save for performance checks
```
