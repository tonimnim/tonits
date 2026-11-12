# Backend requests from the app

What the Orbits app asked of the API (`gemics-backend`) and where each stands.
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

## 6. Contest rules (built, not merged)

**Shown on:** each competition's foot and Profile's Help and legal, as
"Contest rules". Wanted: a third document in
`GET /v1/legal/documents/current`, with `documentType: "contest_rules"`
and a `contentUrl` like Terms and Privacy. Players don't accept it.
**Until then:** the link stays away; the "Apple and Google aren't sponsors"
line shows regardless. The app reads any other new `documentType` as
unknown and ignores it.

Built on the backend branch `feat/contest-rules` (with a `/contest-rules`
page on the website); live once it's merged and deployed. Contest rules
can't be accepted, and sign-up records only Terms and Privacy.

## 7. Blocking a player (built in the backend, not in the app)

**Wanted for:** the stores' user-content rules, beside the existing
message reports. Proposed:

```http
POST   /v1/me/blocks          {"playerId": "…"}   → 201
DELETE /v1/me/blocks/{playerId}                   → 204
GET    /v1/me/blocks                              → cursor page of players
```

A block hides the blocked player's chat messages from the blocker and keeps
the two out of each other's friendly matches; competition matches still
run, since the draw decides them.

Built on the backend branch `feat/player-blocking`, not merged yet. The app
still has no Block action: that's the next app task once the branch lands.

## 8. Account deletion finishes on its own (built, not merged)

A worker deletes a pending request once its 24-hour wait has passed; the
in-app delete still works too. A due deletion can wait on an active
competition, a payment still settling or owning an organization: the
request then reads `blockedReason` and `blockedAt`, is retried daily, and
the player gets an `account.deletion_blocked` inbox item. The app shows the
reason on the deletion screen and opens it from that item. Built on the
backend branch `feat/account-deletion`.

## 9. Legal links that open (built, not merged; blocks release)

**Shown on:** Welcome, onboarding, Profile's Help and legal, the changed
terms dialog and each competition. Every one opens the `contentUrl` from
`GET /v1/legal/documents/current`. Before the fix these pointed at
`tonits.com`, which isn't ours, so every legal link was dead.

**Status:** the backend branch `feat/site-links-and-country-list` builds
each link from `PUBLIC_SITE_URL`. With `https://orbits.games` the terms,
privacy and contest-rules links point at the real site. The local backend
already does; production follows once the branch is merged and deployed.
The website's `/delete-account` page needs the same domain for the Play
listing. **Until then:** nothing to change in the app.

## 10. Notification emails (done)

The backend emails the notifications a player would want with the app
closed: check-in opening, the draw and cancellations under the
Competitions email switch; match ready, forfeits, cancellations and
results to confirm or rejected under Matches. News and offers is saved
but nothing is sent under it yet. Only a verified address gets them.
**In the app:** the switches were already in Profile → Notifications;
their hints now say what each one covers.

## Also noted

- The API's player-facing text now says Orbits.
- Push: the backend already sends through Firebase Cloud Messaging. It
  only needs a service-account key for the Firebase project
  `orbits-37046`. The inbox works without it.
