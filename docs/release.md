# Releasing the app

What a store build needs, none of which is in git.

## Files on the build machine

- `android/app/google-services.json`: the Firebase Android config (project
  `ozone-4ddee`). Every Android build needs it, debug ones too.
- `android/key.properties` and the upload keystore it names:

  ```properties
  storeFile=../keys/ozone-upload.jks
  storePassword=…
  keyAlias=upload
  keyPassword=…
  ```

  `storeFile` is relative to `android/`. Make the keystore once with
  `keytool -genkey -v -keystore keys/ozone-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`
  and back it up somewhere safe: Play only accepts updates signed with it.
  Without `key.properties` a release build is signed with the debug key,
  which Play rejects.
- Google sign-in on Android works only for keys registered on the OAuth
  Android client for `com.ozone`: add the SHA-1 of the upload key and,
  after the first upload, of Play App Signing's key.

## Build

```bash
flutter build appbundle --release --obfuscate --split-debug-info=build/symbols --dart-define=API_URL=https://<production API> --dart-define=GOOGLE_SERVER_CLIENT_ID=<web client id>
```

- `API_URL` must be `https://`; a release build with anything else stops at
  launch (`AppConfig.checkForRelease`).
- Keep `build/symbols` for each release: crash reports can only be read
  with the symbols of the build that crashed.
- Bump `version` in `pubspec.yaml` (the number after `+` for every upload).

## Not set up yet

- iOS: Sign in with Apple needs a `Runner.entitlements` with the capability
  and a development team; Google sign-in needs the reversed iOS client ID
  as a URL scheme in `Info.plist` and `GOOGLE_IOS_CLIENT_ID` at build time.
  Push on iOS is off (`NoPushMessaging`) until APNs is configured.
- Crash reporting: uncaught errors all reach `report()` in
  `lib/core/errors.dart`, which only logs them for now.
