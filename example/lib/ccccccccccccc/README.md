# oceanmtech_dmt

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

<!-- Generate Hive Adapters -->

dart run build_runner build --delete-conflicting-outputs

flutter build apk --split-per-abi --release
flutter build appbundle --target-platform android-arm64 --release
flutter build apk --target-platform android-arm64 --release
Ready to build

flutter build apk --release --dart-define="VERSION=1"
