# mangatek_flutter

A Flutter app to read manga on mobile phone.

## Firebase configuration

Firebase config files are **not versioned** and must be downloaded from the Firebase Console before building the app.

| File | Flavor | Firebase app |
|------|--------|-------------|
| `android/app/src/dev/google-services.json` | dev | MangaTek Dev (Android) |
| `android/app/src/prod/google-services.json` | prod | MangaTek Prod (Android) |
| `ios/config/dev/GoogleService-Info.plist` | dev | MangaTek Dev (iOS) |
| `ios/config/prod/GoogleService-Info.plist` | prod | MangaTek Prod (iOS) |

For each app, go to **Project settings → Your apps → select the app → Download config file** and place it at the path listed above.

## Files generation with build runner

Generated files are not versioned, so it is mandatory to generate them before building the app.
Concerned files:
- images, icons and fonts assets via flutter_gen_runner

```
dart run build_runner build --delete-conflicting-outputs 2>&1 | tee build_runner.log
```
