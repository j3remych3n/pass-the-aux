# aux_ui

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Setup

This project comes with the Spotify SDK bundled. In order to get up and running, please follow the steps below:

* Run flutter pub get in order to grab dependencies.
* Open android/app under this project in Android Studio
* Under the build.gradle file that specifies spotify_sdk, change the dependencies to read:

```
dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    // -- spotify
    implementation project(':spotify-auth-release-1.2.3')
    implementation project(':spotify-app-remote-release-0.7.0')
    implementation "com.google.code.gson:gson:2.8.5"
    // -- events
    implementation "com.github.stuhlmeier:kotlin-events:v2.0"
}
```



