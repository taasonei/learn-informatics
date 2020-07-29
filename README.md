# Learn Informatics

## Description

Learn Informatics is a Flutter application for Android devices. The app is intended for use by students to study Computer Science. Anonymous users only have access to lecture materials while registered users have full access to the course.

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup)

For help getting started with Flutter, view Flutter
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Dependencies in pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2
  firebase_core: ^0.4.4+3
  firebase_auth: ^0.16.0
  cloud_firestore: ^0.13.5
  firebase_storage: ^3.1.6
  flutter_spinkit: ^4.1.2
  rflutter_alert: ^1.0.3
  provider: ^4.0.5
  webview_flutter: ^0.3.22+1
```

- [`firebase_core`](https://pub.dev/packages/firebase_core) - enables connecting to Firebase apps;
- [`firebase_auth`](https://pub.dev/packages/firebase_auth) - for user authentication in the app;
- [`cloud_firestore`](https://pub.dev/packages/cloud_firestore) - user data and data for tests are stored in Firestore;
- [`firebase_storage`](https://pub.dev/packages/firebase_storage) - lectures, labs and other documents are stored in Firebase Storage;
- [`flutter_spinkit`](https://pub.dev/packages/flutter_spinkit) - load screen animations;
- [`rflutter_alert`](https://pub.dev/packages/rflutter_alert) - for a pop-up menu in the testing mode;
- [`provider`](https://pub.dev/packages/provider) - to listen logged in user or not;
- [`webview_flutter`](https://pub.dev/packages/webview_flutter) - to show docs from Storage;

## Screenshots

Welcome screen  | Login screen  | Course list
:---: | :---: | :---:
![](https://user-images.githubusercontent.com/58473570/88846487-5a8f8c00-d1ee-11ea-8a36-42c8b35ce09b.jpg) | ![](https://user-images.githubusercontent.com/58473570/88846913-f7eac000-d1ee-11ea-88cf-deedc87b5f20.jpg) | ![](https://user-images.githubusercontent.com/58473570/88848373-0cc85300-d1f1-11ea-9c9c-6ef17ace25a9.jpg)



Lecture list  | WebView screen  | Test screen
:---: | :---: | :---:
![](https://user-images.githubusercontent.com/58473570/88848868-b7407600-d1f1-11ea-86da-c3d87957e4e6.jpg) | ![](https://user-images.githubusercontent.com/58473570/88848922-c6272880-d1f1-11ea-918d-8db38d53dab6.jpg) | ![](https://user-images.githubusercontent.com/58473570/88848960-d63f0800-d1f1-11ea-985d-8daf7e6a2e00.jpg)