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
empty `data` when unranked. The app uses it, with `span=1`, to pin the
player's own row under the Rankings list when they're further down than the
rows loaded.

## 3. Goal totals (not needed now)

Asked for Home's "Goals per match" as `goalsFor` and `goalsAgainst` on
`PublicGameRating`, and declined as off the launch path. Home no longer
shows goals, so the app doesn't need them.

## 4. Series reported as games won (done)

A best of 3 or 5 is reported as games won (`homeScore`/`awayScore`, such as
2–1), with no per-game scores. Screenshots of every game are sent only after
the opponent rejects the result.

## 5. Starting rating and levels (done)

Every rating carries a `level` (`RatingLevel`: `beginner`, `amateur`,
`semi_pro`, `professional`, `world_class`, `legend`), worked out from the
rating by the server, so the bands can change without an app release. A
profile lists a player with no rated match at 1500, `amateur`, with no
ranks. The app shows the level under the rating on Home and after the
handle on each ladder row. It reads a level it doesn't know as none, and
against an older server still shows a new player 1,500, without a level.

## 6. Contest rules (open)

**Shown on:** each competition's foot and Profile's Help and legal, as
"Contest rules". Wanted: a third document in
`GET /v1/legal/documents/current`, with `documentType: "contest_rules"`
and a `contentUrl` like Terms and Privacy. Players don't accept it.
**Until then:** the link stays away; the "Apple and Google aren't sponsors"
line shows regardless. The app reads any other new `documentType` as
unknown and ignores it.

## 7. Blocking a player (open)

**Wanted for:** the stores' user-content rules, beside the existing
message reports. Proposed:

```http
POST   /v1/me/blocks          {"playerId": "…"}   → 201
DELETE /v1/me/blocks/{playerId}                   → 204
GET    /v1/me/blocks                              → cursor page of players
```

A block hides the blocked player's chat messages from the blocker and keeps
the two out of each other's friendly matches; competition matches still
run, since the draw decides them. **Until then:** the app has no Block
action.

## Also noted

- The legal documents link to `tonits.com`, and player-facing API text says
  Tonits; the app is now Ozone.
- Push notifications reach the device through Firebase Cloud Messaging once
  the backend moves delivery there; the inbox works without them.
