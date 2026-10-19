# Backend requests from the app

What the Ozone app asked of the API (`gemics-backend`) and where each stands.
Each open entry says what the app shows, the contract it expects, and what
the app does until it ships.

## 1. Rating history (built, not used)

`GET /v1/players/{id}/rating-history` was built for a 30-day rating line on
Home. Home no longer draws that line, so the app doesn't call it.

## 2. "Around me" on the ladder (done)

```http
GET /v1/rankings?gameId=efootball-mobile&scope=country&country=KE&around=me&span=2
```

Authenticated; returns the `span` places either side of the caller, or an
empty `data` when unranked. The app uses it for Home's ladder slice (two
places either side, the top three when unranked) and, with `span=1`, to pin
the player's own row under the Rankings list when they're further down than
the rows loaded.

## 3. Goal totals (deferred)

**Shown on:** Home, "Goals per match". Wanted on `PublicGameRating`:

```json
{ "goalsFor": 54, "goalsAgainst": 31 }
```

Declined for now as off the launch path. **Until then:** the app averages
goals over the last 20 confirmed matches.

## 4. Series reported as games won (done)

A best of 3 or 5 is reported as games won (`homeScore`/`awayScore`, such as
2–1), with no per-game scores. Screenshots of every game are sent only after
the opponent rejects the result.

## Also noted

- The legal documents link to `tonits.com`, and player-facing API text says
  Tonits; the app is now Ozone.
- Push notifications reach the device through Firebase Cloud Messaging once
  the backend moves delivery there; the inbox works without them.
