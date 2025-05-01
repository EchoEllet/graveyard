# 🌟 Brand and Ownership Information

This document contains details about files and data that are specific to the project’s brand or business owner.
This information is for internal use and should be replaced when forking or adapting this project.

TODO: Complete this page later.

## 📁 Important Data

### 🌍 Google and Firebase

Remove the following files:

- **`lib/firebase_options.dart`**
- **`firebase.json`**
- **`.crashlytics`**
- **`/android/app/google-services.json`**
- **`/ios/Runner/GoogleService-Info.plist`**
- **`/ios/firebase_app_id_file.json`**
- **`/macos/Runner/GoogleService-Info.plist`**
- **`/macos/firebase_app_id_file.json`**

Then [configure your Firebase project with your app](https://firebase.google.com/docs/flutter/setup)
using [FlutterFire CLI](https://pub.dev/packages/flutterfire_cli) or manually for each platform.

### 🎨 Branding

Replace the files in **`/dev_assets`** with your own, then run:

```shell
dart run icons_launcher:create
dart run flutter_native_splash:create
```

To replace them for each platform (e.g. `android`, `iOS`).

### 🌐 App Data

Navigate to the [`Client Constants`](../lib/common/constants/constants.dart) file and replace the data with your own,
such as developer name, URL, social media info, privacy policy, and server base URL.

The same thing for [`Server Constants`](../server/src/main/kotlin/net/freshplatform/Constants.kt).

There are other places such as the repository URL in [`pubspec.yaml`](../pubspec.yaml).

## 📝 Notes for Forking

- Please ensure to **remove** or **replace** any brand-specific data with your own information before using this project.
- If you have any questions about what to keep or remove, feel free to reach out to the original maintainers.

## ❗️ Disclaimer

The information in this file is intended for use by the original project owner and is not meant for distribution.
If you’re forking this project, make sure to clean up any sensitive or brand-specific content.

Thank you for following these guidelines and happy coding! 🎉
