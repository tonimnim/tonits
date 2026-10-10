# Tonits app architecture

Tonits is the player app for eFootball competitions. It talks to one Go API
(`gemics-backend/services/api`, contract in `openapi/openapi.yaml`). This
document is the plan the code follows; change it when a decision changes.

## Principles

- **Feature-first.** Code for one product area lives together. Shared code
  lives in `core/` only once two features need it.
- **Server state is the source of truth.** The app caches API responses and
  invalidates them after mutations. It never invents a result (a match score,
  a payment) locally. Actions come from the server's `allowedActions` and
  `lifecycle`, not from the UI guessing.
- **Small widgets with one job.** A screen composes sections, and sections
  compose design-system components. Nothing grows into a 500-line file.
- **Everything injectable.** No global singletons. Every dependency is a
  provider that tests override with fakes.

## Layers

```text
lib/
  main.dart                 Bootstrap: ProviderScope + TonitsApp
  app/                      App-wide wiring
    app.dart                MaterialApp.router, themes
    router.dart             go_router routes and the auth redirect
    shell/                  Bottom navigation shell
  core/                     Shared, feature-agnostic code
    api/                    HTTP client, errors, cursor pages
    providers.dart          Root providers (API client, token store)
    theme.dart              Tokens (TonitsPalette) and ThemeData
    format.dart             Dates, money, counts
    widgets/                The design system (buttons, fields, cards…)
  features/<feature>/
    data/                   Models (fromJson) and the repository (HTTP)
    application/            Providers and notifiers: state and use cases
    ui/                     Screens, and widgets/ used only by them
```

A dependency points down or sideways into `core`: `ui → application → data
→ core`. A feature uses another feature through its `application` providers
and its presentational widgets. For example, Home reads `nextMatchProvider`
and shows `MatchCard`. It never calls another feature's repository directly.

Shared building blocks:

- `core/api/paged.dart`: `PagedNotifier`, one implementation of "first page,
  load more, refresh" for every cursor-paginated list.
- `core/widgets/paged_list_view.dart`: the matching list with
  pull-to-refresh, infinite scroll and loading, empty and error states.
- `core/widgets/widgets.dart`: the design system, one component per file.
- `core/routes.dart`: every route path; `app/shell/app_tab.dart` defines the
  tabs once for both the bar and the router.

## Decisions

**State and dependency injection: flutter_riverpod.** Providers give dependency
injection, async loading and error state, and cache invalidation. For example,
registering for a competition invalidates the competitions list, Home and
Matches with one `ref.invalidate`. Notifiers hold state that changes; plain
`FutureProvider`s hold read-only server data. Tests use `ProviderScope`
overrides instead of mocking frameworks.

**Navigation: go_router 17.** It gives declarative routes and one `redirect`
for auth. A `StatefulShellRoute.indexedStack` drives the bottom navigation, so
each tab keeps its own stack and scroll position. URL-shaped routes let push
notifications deep-link by `data.kind` later. 17.x, not 18: 18 depends on the
standalone `material_ui` package, which would put a second copy of Material in
the app (see the same issue with google_fonts 9).

**Networking: package:http behind `ApiClient`.** One place adds
`X-Request-ID`, the bearer token and the serialized 401 refresh. Repositories
turn JSON into typed models and nothing else. Hand-written `fromJson` matches
the OpenAPI schemas. Code generation (freezed, json_serializable) is deferred
until the model count makes it pay for itself.

**Sessions.** The refresh token lives in `flutter_secure_storage`, and the
access token only in memory. `AuthController` restores at launch, rotates on
401 and drives the router's redirect.

**Design system.** Tokens come from the staff dashboard (`TonitsPalette`, light
and dark). Components live one per file in `core/widgets/` and read colours
from `context.palette`, never hard-coded. Screens stay minimal: one title, the
content and one primary action, with no decorative imagery.

**Formatting.** `intl` formats dates and money in the device locale. Money
arrives in minor units with a currency code (`entryFeeMinor` + `currency`).

## Designing ahead of the API

The app may be designed around data the API doesn't serve yet. Each such
feature is written up in `docs/backend-requests.md` with the contract it
expects. The app ships with a fallback, such as hiding a section or computing
from data that exists, so it never depends on an unreleased endpoint.

## Navigation map

```text
/sign-in                      Signed out (register and reset are pushed)
/home                         Tab 1: the player's overview (rating, stats,
                              ladder slice, recent results, up next,
                              competitions closing soon)
/competitions                 Tab 2: discovery
/matches                      Tab 3: active and history
/rankings                     Tab 4: global and country ladders
/profile                      Tab 5: account and sign-out
```

Detail routes (`/competitions/:id`, `/matches/:id`) nest under their tab so
the bottom bar stays visible and back returns to the list.

## Testing

- Unit tests for parsing, validators, formatting and the API client.
- Provider tests with `ProviderContainer` overrides for notifiers.
- Widget tests per screen, including `test/layout_test.dart`, which renders
  every screen on a small phone with enlarged text so that overflow fails.
- `test/screenshots_test.dart` renders PNGs for design review on demand.
