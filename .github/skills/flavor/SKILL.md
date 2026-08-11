---
name: flavor
description: Rules and patterns for Flutter flavors in this app. Use when adding flavor variables, modifying flavor config, changing the bundle ID / application ID / package name, modifying productFlavors in build.gradle.kts, modifying xcconfig files, running dart run pigeon, or working with ConfigHolder, ConfigEntity, FlavorEnum, or the Pigeon FlavorApi.
---

## Overview

| Flavor | App Name     | Bundle/App ID | App ID suffix |
|--------|--------------|---------------|---------------|
| `dev`  | MangaTek Dev | `fr.groupany.flutter.mangatek.dev` | `.dev` |
| `prod` | MangaTek     | `fr.groupany.flutter.mangatek.prod` | `.prod` |

Flavor values flow: **native → Pigeon `FlavorApi` → `ConfigHolder` → `ConfigEntity`** (initialized before `runApp`).

`ConfigHolder` calls `FlavorApi` directly — no intermediate datasource layer.

---

## Architecture

```
Android productFlavors                iOS xcconfigs (dev/prod.xcconfig)
  FlavorApiImpl.kt                          FlavorApiImpl.swift
        └──────── Pigeon FlavorApi (generated) ──────┘
                    ConfigHolder.initialize()
                          ConfigEntity
```

---

## File map

| File | Role |
|------|------|
| `pigeon/flavor.pigeon.dart` | Pigeon contract |
| `lib/core/data/datasources/flavor/flavor.pigeon.g.dart` | Generated Dart — **do not edit** |
| `lib/core/domain/enum/flavor.enum.dart` | `FlavorEnum { dev, prod }` + `fromString()` |
| `lib/core/domain/entities/config.entity.dart` | `ConfigEntity` (all flavor values) |
| `lib/core/helpers/config_holder.dart` | Singleton; static getters for each field |
| `android/app/build.gradle.kts` | `productFlavors` definition |
| `android/app/src/<flavor>/res/values/strings.xml` | Per-flavor string resources |
| `android/.../pigeon/FlavorApiImpl.kt` | Android implementation |
| `android/.../pigeon/PigeonFlavor.g.kt` | Generated Kotlin — **do not edit** |
| `ios/Flutter/dev.xcconfig` / `prod.xcconfig` | Per-flavor variables |
| `ios/Flutter/Debug-dev.xcconfig` etc. | Build-type + flavor combos |
| `ios/Runner/Info.plist` | Uses `$(APP_NAME)`, `$(APP_FLAVOR)` |
| `ios/Runner/Pigeons/FlavorApiImpl.swift` | iOS implementation |
| `ios/Runner/Pigeons/PigeonFlavor.g.swift` | Generated Swift — **do not edit** |

---

## Current flavor variables

| Variable | Android | iOS `infoDictionary` key | `ConfigEntity` field |
|----------|---------|--------------------------|----------------------|
| Flavor | `BuildConfig.FLAVOR` | `APP_FLAVOR` | `FlavorEnum flavor` |
| App name | `R.string.app_name` | `CFBundleDisplayName` | `String appName` |
| Is prod | derived | derived | `bool isProd` |

---

## Adding a new flavor variable (checklist)

Example: `apiUrl`.

| Step | File | Action |
|------|------|--------|
| 1 | `src/dev/res/values/strings.xml` | `<string name="api_url">https://dev.api.com</string>` |
| 1 | `src/prod/res/values/strings.xml` | `<string name="api_url">https://api.com</string>` |
| 2 | `FlavorApiImpl.kt` | `override fun getApiUrl() = context.getString(R.string.api_url)` |
| 3 | `ios/Flutter/dev.xcconfig` | `API_URL = https://dev.api.com` |
| 3 | `ios/Flutter/prod.xcconfig` | `API_URL = https://api.com` |
| 4 | `ios/Runner/Info.plist` | `<key>API_URL</key><string>$(API_URL)</string>` |
| 5 | `FlavorApiImpl.swift` | `func getApiUrl() throws -> String { Bundle.main.infoDictionary?["API_URL"] as? String ?? "" }` |
| 6 | `pigeon/flavor.pigeon.dart` | Add `String getApiUrl();` to `FlavorApi` |
| 7 | terminal | `dart run pigeon --input pigeon/flavor.pigeon.dart` |
| 8 | `config.entity.dart` | Add `final String apiUrl;` field + default + props |
| 9 | terminal | `dart run build_runner build --delete-conflicting-outputs` |
| 10 | `config_holder.dart` | `apiUrl: await flavorApi.getApiUrl()` in `initialize()` + `static String get apiUrl` |
