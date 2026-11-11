# Orbits brand kit

The app, the website and the staff dashboard share one mark and two ways of
setting it with the name. These files are copied from the backend repo's
`brand/orbits/` (gemics-backend), where they are generated; change them
there and copy them across.

| Piece | Looks like | Use it for |
|---|---|---|
| **Logo** `orbits-logo*` | the mark as an icon, then the word "orbits" | The main logo, wherever the name must read at a glance: sign-in and onboarding headers, store listing, share images, emails, anything small. |
| **Wordmark** `orbits-wordmark*` | the mark is the "o" of "orbits" | Where there is room to be playful: splash screen, empty states, merch, banners. Not below about 24 px tall, where the mark stops reading as an "o". |
| **Mark** `orbits-mark.svg` | the mark alone | Launcher icon, notification icon, avatars, a compact top bar. |

The letters are Outfit Bold, outlined (no font needed), at −0.02 em with the
font's kerning. In both settings the mark runs from the top of the "b" and
"t" to the bottom of the "o", so the logo's height is its mark's height; in
the logo the gap after the mark is a quarter of the mark.

## In the app

`assets/brand/orbits-logo.svg` and `assets/brand/orbits-wordmark.svg` are
ready for `flutter_svg`: tight viewBox, no print margin, no millimetre sizes,
one colour. Declare them in `pubspec.yaml` under `assets:` and draw them the
way `BrandMark` draws `mark.svg`, sized by height:

```dart
SvgPicture.asset(
  'assets/brand/orbits-logo.svg', // or orbits-wordmark.svg
  height: 28,
  excludeFromSemantics: true,
  colorFilter: ColorFilter.mode(context.palette.foreground, BlendMode.srcIn),
)
```

The logo is 4.73 times as wide as it is tall and the wordmark 3.75 times.
`BrandLockup` currently sets "rbits" in Alexandria; switching it to
`orbits-wordmark.svg` makes the app match the website exactly.

## Files

| File | Colour |
|---|---|
| `orbits-logo.*`, `orbits-wordmark.*` | Indigo `#5B5BD6`. Light backgrounds. |
| `…-on-dark.*` | Light indigo `#7C7CF0`. Dark backgrounds. |
| `…-black.*` | Black. |
| `…-white.*` | White. |
| `…-current.svg` | `currentColor`, recolour freely. |

- SVG and PDF are vector; PNGs are 6000 px wide with a transparent background,
  about 50 cm at 300 dpi, for print and store artwork.
- The logo artwork is 297.5 × 66.9 mm and the wordmark 237.2 × 66.9 mm, each
  with a thin transparent margin. Keep at least the height of the "r" clear
  around either.
- `orbits-preview.png` shows both on light and on dark.
- Outfit is under the SIL Open Font License (`Outfit-OFL.txt`).
