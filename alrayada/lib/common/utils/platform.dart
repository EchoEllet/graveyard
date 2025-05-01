import 'package:flutter/foundation.dart'
    show kIsWeb, kDebugMode, TargetPlatform, defaultTargetPlatform;

// AppleOS

@pragma('vm:platform-const-if', !kDebugMode)
bool get isAppleOS =>
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.macOS;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isAppleOSApp => !kIsWeb && isAppleOS;

// Theme System

@pragma('vm:platform-const-if', !kDebugMode)
bool get isCupertino => isAppleOS;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isMaterial => !isCupertino;
