# CM Scout for the browser

`cmscout.html` is a single, self-contained HTML file that ports CM Scout 3.10 (the Delphi
app in this repository) to the browser. Open it directly from disk or host it anywhere as a
static file. It has no dependencies and makes no network requests. Save files are read
locally and never uploaded.

## What it does

| Original (Delphi)                           | Browser port                                                      |
|---------------------------------------------|-------------------------------------------------------------------|
| Load `.cm4` saved game (CM4 + CM 03/04, DB v110–147) | **Load saved game…**, parsed in a Web Worker               |
| Optional `lang_db.dat` + language choice    | **lang_db.dat…** button; language under **Settings**              |
| Player Search dialog (General / Contract / Attributes 1–3) | Search panel on the left, same filters, plus saved searches |
| Team Search                                 | **Team search…** (type to filter clubs)                           |
| Load / save `.slf` shortlist files          | **Load shortlist…** / **Export shortlist** (same binary format)   |
| 106 sortable columns, show/hide, reorder    | Same columns; click to sort, drag to reorder, drag edge to resize |
| Player info window                          | Double-click a row (or Enter); ← / → step through the list        |
| Settings in the registry                    | Settings in `localStorage`                                        |

Additions:
- **Starred players**: click ☆ in a row (or press Space) to keep a personal shortlist across sessions.
- **Saved searches**: name and recall filter sets.
- The last loaded game and `lang_db.dat` are cached in IndexedDB, so a reload doesn't need the
  file again. You can turn this off under Settings. A parsed save is far larger than
  localStorage allows, so only small data goes there.
- The name search ignores accents ("goncalves" finds "Gonçalves").

## What is stored where

- `localStorage["cmscout.v1"]`: settings, column layout, current filters, saved searches, stars.
- IndexedDB `cmscout/kv`: `game` (parsed player data from the last save) and `lang` (raw `lang_db.dat`).

## Differences from the original

- An empty min or max box means "no limit". In the original, setting only a minimum on some
  ranges (e.g. Value) left the maximum at 0 and excluded everyone.
- Nation, Based and Division filters are stored by unique ID, so saved searches keep working
  across saves from the same game.
- If the chosen language isn't in `lang_db.dat`, the first language in the file is used
  (the original jumped to a fixed offset).
- A playing-data record shared by two players is converted only once. The original would
  convert it twice.
- Scout rating formulas are ported exactly, quirks included: the goalkeeper divisor is 333,
  and outfield ratings use `(InjuryProneness - 21)`.

## Tests

The real game data isn't in the repo, so `test/make-fixture.js` writes a **synthetic** save and
`lang_db.dat` in the layout the Delphi loader expects. It covers every record type, every
version branch (110–147), contracts, clauses, filter lists, injuries and bans. These tests
check that the port is internally consistent. They don't prove compatibility with real saves.

```sh
cd web/test
node parser.test.js            # parser against fixtures for DB versions 110..147
node e2e.test.js [shotsDir]    # Playwright: load, filter, sort, team search, shortlists, cache restore
node make-fixture.js out 146 100000   # big synthetic save for performance checks
```
