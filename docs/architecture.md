# Ozone app architecture

Ozone (code package `tonits`) is the player app for eFootball competitions. It talks to one Go API
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
    data/                   Models and the repository (HTTP); no Flutter
    application/
      <feature>_providers.dart  Every provider of the feature, and only those
      *_controller.dart     Notifiers and services, one class per file
    ui/                     Screens, and widgets/ used only by them
```

Every feature has the same shape. Providers are declared only in the
feature's `application/<feature>_providers.dart`, so there is one place to
look for a feature's state and one file for tests to override. Classes
(notifiers, services, value types) live in their own files next to it.
Screen-only features (Home, Profile, Onboarding) have just `ui/` and use
other features' providers.

A dependency points down or sideways into `core`: `ui → application → data
→ core`. A feature uses another feature through its `application` providers
and its presentational widgets. For example, Home reads
`openCompetitionsProvider` and shows `CompetitionRow`. It never calls
another feature's repository directly.

Shared building blocks:

- `core/api/paged.dart`: `PagedNotifier`, one implementation of "first page,
  load more, refresh" for every cursor-paginated list.
- `core/widgets/paged_list_view.dart`: the matching list with
  pull-to-refresh, infinite scroll and loading, empty and error states.
- `core/widgets/widgets.dart`: the design system, one component per file.
- `core/widgets/feedback.dart`: `confirmAction`, `showMessage`,
  `popWithMessage` and `copyToClipboard`, so every feature confirms and
  reports the same way.
- `core/widgets/busy_state.dart`: the `BusyState` mixin for screens that run
  one action at a time and show its error.
- `core/phone_number.dart` and `core/kenyan_phone.dart`: phone numbers in
  international form, shared by onboarding, the account and M-Pesa.
- `core/clock.dart`: a ticking clock provider for countdowns; tests freeze
  it.
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
turn JSON into typed models and nothing else.

**Models: freezed + json_serializable.** Every API model is a freezed class
whose fields follow the OpenAPI schema, with `@JsonKey` for renames and
`readValue` for nested values the screens read flat. Parsing is `checked`,
so a missing or mistyped field fails with the key's name instead of a vague
cast error, and every enum names an `unknownEnumValue` so a value the app
doesn't know yet never crashes it. The app only reads JSON (requests are
built by hand), so no `toJson` is generated (see `build.yaml`). After
changing a model, run `dart run build_runner build`; the generated
`*.freezed.dart` and `*.g.dart` files are committed.

**Sessions.** Players sign in with Google or Apple (`IdentityProvider`
fakes stand in for both in tests). The refresh token lives in
`flutter_secure_storage`, and the access token only in memory.
`AuthController` restores at launch, rotates on 401 and drives the router's
redirect, including holding unfinished accounts on onboarding.

**Design system.** Tokens come from the staff dashboard (`TonitsPalette`, light
and dark). Components live one per file in `core/widgets/` and read colours
from `context.palette`, never hard-coded. Screens stay minimal: one title, the
content and one primary action, with no decorative imagery.

**Text and languages.** Every player-facing string is in
`lib/l10n/app_en.arb`, generated into `AppLocalizations` by gen-l10n.
Widgets read `context.l10n`; code without a context (controllers, the
screenshot uploader) reads `l10nProvider`; pure helpers such as
`describeError`, `Format.dateTime` and the validators take the
`AppLocalizations` as a parameter. English is written in fragments, one
per area (`lib/l10n/parts/*.json`), merged by `tool/l10n_merge.py` so
parallel work doesn't collide in one file. Counts use ICU plurals.

To add a language (Swahili and Hindi are planned), add
`lib/l10n/app_sw.arb` or `app_hi.arb` with the same keys, translated, and
run `flutter gen-l10n`; the app picks the device's language when it is
supported and falls back to English. Country names are still English.

**Automated checks.** `.github/workflows/ci.yml` runs on every push and pull
request: the generated models and strings must be up to date, then
`dart format`, `flutter analyze --fatal-infos` and `flutter test`, on the
pinned Flutter version.

**Formatting.** `intl` formats dates and money in the device locale. Money
arrives in minor units with a currency code (`entryFeeMinor` + `currency`).

## Designing ahead of the API

The app may be designed around data the API doesn't serve yet. Each such
feature is written up in `docs/backend-requests.md` with the contract it
expects. The app ships with a fallback, such as hiding a section or computing
from data that exists, so it never depends on an unreleased endpoint.

## Navigation map

```text
/welcome                      Signed out: continue with Google or Apple
/onboarding                   A new account's username, Konami ID, country
                              and phone; the router keeps it here until done
/home                         Tab 1: the player's overview (rating card,
                              up next or the competitions open now, recent
                              results)
/competitions                 Tab 2: discovery
/matches                      Tab 3: active and history
/matches/:id                  A match room; /report reports the score
/rankings                     Tab 4: global and country ladders
/profile                      Tab 5: account and sign-out; name, email and
                              phone edit screens nest under it
```

Detail routes (`/competitions/:id`, `/matches/:id`) nest under their tab so
the bottom bar stays visible and back returns to the list.

## Testing

- Unit tests for parsing, validators, formatting and the API client.
- Provider tests with `ProviderContainer` overrides for notifiers.
- Widget tests per screen, including `test/layout_test.dart`, which renders
  every screen on a small phone with enlarged text so that overflow fails.
- `test/screenshots_test.dart` renders PNGs for design review on demand.
