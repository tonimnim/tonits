# Backend requests from the app

Features the Tonits app is designed around that the API (`gemics-backend`,
OpenAPI 0.9.0) doesn't serve yet. Each entry says what the app shows, the
contract it expects, and what the app does until it ships.

## 1. Rating history

**Shown on:** Home, the player card's 30-day rating line.

```http
GET /v1/players/{id}/rating-history?gameId=efootball-mobile&days=30
```

```json
{
  "data": [
    { "at": "2026-09-10T00:00:00Z", "rating": 1490 },
    { "at": "2026-09-11T00:00:00Z", "rating": 1496 }
  ]
}
```

- Oldest first. One point per day that the rating changed is enough; the app
  draws a line through whatever points it gets.
- `days` bounded to 7–365. Public, under the same visibility rules as
  `GET /v1/players/{id}`.
- Source: `player_game_ratings` changes are already written in the
  confirmed-match transaction, so this is a projection of existing writes.

**Until then:** the app treats `404` as "no history" and leaves the line out
(`PlayersRepository.ratingHistory`).

## 2. "Around me" on the ladder

**Shown on:** Home, the country ladder slice (two places above and below the
player).

```http
GET /v1/rankings?gameId=efootball-mobile&scope=country&country=KE&around=me&span=2
```

- `around=me` (authenticated) returns the `span` rows either side of the
  caller, in the existing `RankingPage` shape. It returns an empty `data` when
  the caller is unranked.

**Until then:** the app reads the first 50 places and finds the player there
(`myRankNeighbourhoodProvider`). Players ranked below 50th see the top three
instead of their own slice.

## 3. Goal totals

**Shown on:** Home, "Goals per match".

Add to `PublicGameRating` (and `PublicRecord`):

```json
{ "goalsFor": 54, "goalsAgainst": 31 }
```

**Until then:** the app averages goals over the last 20 confirmed matches and
labels the tile with the sample size ("Last 20 matches").

## 4. Country default for new players

New players default to `countryCode: "KE"` until they save a phone number or
choose a country (`PATCH /v1/me`). Tonits launches in Kenya, India and the US,
so:

- `POST /v1/auth/register` should accept an optional `countryCode`, making
  sign-up a single atomic call. The app currently registers and then calls
  `PATCH /v1/me`, and shows a "retry" notice if the second call fails.

## Also noted

- `GET /v1/legal/documents/current` returns `gamics.io` URLs; they should
  point at Tonits.
- The OpenAPI title and descriptions still say "Gamics".
