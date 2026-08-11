# mangatek_flutter

A Flutter app to read manga on mobile phone.

## Files generation with build runner

Generated files are not versioned, so it is mandatory to generate them before building the app.
Concerned files:
- images, icons and fonts assets via flutter_gen_runner

```
dart run build_runner build --delete-conflicting-outputs 2>&1 | tee build_runner.log
```
