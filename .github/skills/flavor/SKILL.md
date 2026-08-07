---
name: flavor
description: Rules and patterns for Flutter flavors in this app. Use when adding flavor variables, modifying flavor config, or working with ConfigHolder, ConfigEntity, FlavorEnum, or the Pigeon FlavorApi.
---

## Overview

This project uses two flavors: **dev** and **prod**.

| Flavor | App Name     | App ID suffix |
|--------|--------------|---------------|
| `dev`  | MangaTek Dev | `.dev`        |
| `prod` | MangaTek     | *(none)*      |

Flavor values are read from native platform code at startup via **Pigeon** (`FlavorApi`), then stored in a `ConfigHolder` singleton as a `ConfigEntity` before `runApp` is called.

---

## Architecture

```
Android productFlavors          iOS xcconfigs
(build.gradle.kts)              (dev.xcconfig / prod.xcconfig)
        │                                │
        ▼                                ▼
FlavorApiImpl.kt             FlavorApiImpl.swift
(reads BuildConfig.FLAVOR    (reads Bundle.main.infoDictionary
 + R.string.app_name)         + CFBundleDisplayName)
        │                                │
        └──────────── Pigeon ────────────┘
                    FlavorApi (generated)
                         │
                  ConfigHolder.initialize()
                  (calls FlavorApi directly)
                         │
                    ConfigEntity
                  (FlavorEnum, appName, isProd)
```

**Key rule:** `ConfigHolder` calls `FlavorApi` directly — there is no intermediate datasource layer for flavor.

---

## File map

| File | Role |
|------|------|
| `pigeon/flavor.pigeon.dart` | Pigeon contract — defines `FlavorApi` methods |
| `lib/core/data/datasources/flavor/flavor.pigeon.g.dart` | Generated Dart pigeon code — **do not edit** |
| `lib/core/domain/enum/flavor.enum.dart` | `FlavorEnum` with `dev`/`prod` cases + `fromString()` |
| `lib/core/domain/entities/config.entity.dart` | `ConfigEntity` — holds all flavor values |
| `lib/core/domain/entities/config.entity.g.dart` | Generated `copyWith` — **do not edit** |
| `lib/core/helpers/config_holder.dart` | Singleton — calls `FlavorApi`, stores `ConfigEntity` |
| `android/app/build.gradle.kts` | Android product flavors definition |
| `android/app/src/dev/res/values/strings.xml` | Dev app name string resource |
| `android/app/src/prod/res/values/strings.xml` | Prod app name string resource |
| `android/app/src/main/kotlin/.../pigeon/FlavorApiImpl.kt` | Android Pigeon implementation |
| `android/app/src/main/kotlin/.../pigeon/PigeonFlavor.g.kt` | Generated Kotlin pigeon code — **do not edit** |
| `ios/Flutter/dev.xcconfig` | iOS dev flavor variables (`APP_NAME`, `APP_FLAVOR`, `BUNDLE_SUFFIX`) |
| `ios/Flutter/prod.xcconfig` | iOS prod flavor variables |
| `ios/Flutter/Debug-dev.xcconfig` etc. | Per build-type xcconfigs that include the base + flavor xcconfig |
| `ios/Runner/Info.plist` | Uses `$(APP_NAME)` and `$(APP_FLAVOR)` |
| `ios/Runner/Pigeons/FlavorApiImpl.swift` | iOS Pigeon implementation |
| `ios/Runner/Pigeons/PigeonFlavor.g.swift` | Generated Swift pigeon code — **do not edit** |
| `ios/Runner/AppDelegate.swift` | Registers `FlavorApiSetup` in `didInitializeImplicitFlutterEngine` |

---

## Current flavor variables

| Variable | Android source | iOS source | `ConfigEntity` field |
|----------|---------------|------------|----------------------|
| Flavor name | `BuildConfig.FLAVOR` | `infoDictionary["APP_FLAVOR"]` | `FlavorEnum flavor` |
| App name | `R.string.app_name` | `infoDictionary["CFBundleDisplayName"]` | `String appName` |
| Is prod | derived (`flavor == "prod"`) | derived | `bool isProd` |

---

## How to add a new flavor variable

Example: adding `apiUrl` (a per-flavor API base URL).

### 1. Android — string resource

Add to `android/app/src/dev/res/values/strings.xml`:
```xml
<string name="api_url">https://api.dev.example.com</string>
```

Add to `android/app/src/prod/res/values/strings.xml`:
```xml
<string name="api_url">https://api.example.com</string>
```

### 2. Android — `FlavorApiImpl.kt`

```kotlin
override fun getApiUrl(): String = context.getString(R.string.api_url)
```

### 3. iOS — xcconfig

Add to `ios/Flutter/dev.xcconfig`:
```
API_URL = https://api.dev.example.com
```

Add to `ios/Flutter/prod.xcconfig`:
```
API_URL = https://api.example.com
```

### 4. iOS — `Info.plist`

```xml
<key>API_URL</key>
<string>$(API_URL)</string>
```

### 5. iOS — `FlavorApiImpl.swift`

```swift
func getApiUrl() throws -> String {
    return Bundle.main.infoDictionary?["API_URL"] as? String ?? ""
}
```

### 6. Pigeon contract — `pigeon/flavor.pigeon.dart`

```dart
@HostApi()
abstract class FlavorApi {
  String getFlavor();
  String getAppName();
  bool isProd();
  String getApiUrl(); // add this
}
```

### 7. Regenerate Pigeon

```bash
dart run pigeon --input pigeon/flavor.pigeon.dart
```

This regenerates:
- `lib/core/data/datasources/flavor/flavor.pigeon.g.dart`
- `android/app/src/main/kotlin/com/groupany/mangatek_flutter/pigeon/PigeonFlavor.g.kt`
- `ios/Runner/Pigeons/PigeonFlavor.g.swift`

### 8. `ConfigEntity` — add field

```dart
@CopyWith()
class ConfigEntity extends Equatable {
  final FlavorEnum flavor;
  final String appName;
  final bool isProd;
  final String apiUrl; // add this

  const ConfigEntity({
    this.flavor = FlavorEnum.dev,
    this.appName = '',
    this.isProd = false,
    this.apiUrl = '', // add this
  });

  @override
  List<Object?> get props => [flavor, appName, isProd, apiUrl]; // add apiUrl
}
```

Then regenerate:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 9. `ConfigHolder` — read value and expose getter

In `initialize()`:
```dart
_instance.currentConfig = ConfigEntity(
  flavor: FlavorEnum.fromString(await flavorApi.getFlavor()),
  appName: await flavorApi.getAppName(),
  isProd: await flavorApi.isProd(),
  apiUrl: await flavorApi.getApiUrl(), // add this
);
```

Add static getter:
```dart
static String get apiUrl => _instance.currentConfig.apiUrl;
```

---

## Registering Pigeon on iOS (reference)

Registration happens in `AppDelegate.swift` inside `didInitializeImplicitFlutterEngine`, which fires **before** the Dart VM starts:

```swift
func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
  GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  FlavorApiSetup.setUp(
    binaryMessenger: engineBridge.pluginRegistry.registrar(forPlugin: "FlavorApi")!.messenger(),
    api: FlavorApiImpl()
  )
}
```

> ⚠️ Do **not** register pigeon after `super.application(...)` returns — the Dart thread may already be running at that point, causing a channel-error.

## Registering Pigeon on Android (reference)

Registration happens in `MainActivity.kt` inside `configureFlutterEngine`:

```kotlin
override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
  super.configureFlutterEngine(flutterEngine)
  FlavorApi.setUp(
    flutterEngine.dartExecutor.binaryMessenger,
    FlavorApiImpl(this)
  )
}
```
