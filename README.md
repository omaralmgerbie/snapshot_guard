

# snapshot_guard
snapshot_guard is a Flutter plugin that implements a feature to prevent users from taking screenshots or screen recordings of the user interface.


|             | Android | iOS    |
|-------------|---------|--------|
| **Support** | SDK 17+ | iOS 12+ |

## Install

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  snapshot_guard: <latest_version>
```

In your library add the following import:

```dart
import 'package:snapshot_guard/snapshot_guard.dart';
```


## Usage
To use the plugin, simply import the package in your Flutter project and use the provided `SnapshotGuard.toggleGuard()` method. This method can be called anywhere on the app and will toggle the guard ON/OFF.

Example:

```dart
import 'package:snapshot_guard/snapshot_guard.dart';

void main() async {
  await SnapshotGuard.toggleGuard();
  // or 
  await SnapshotGuard.switchGuardStatus(true);
  runApp(MyApp());
}
```
to listen to Guard status changes use `SnapshotGuard.onGuardStatusChanged` or directly get the value via `SnapshotGuard.isGuardEnabled`.

## Platform Support
SnapshotGuard currently supports iOS and Android.

## Limitations
Please note that SnapshotGuard does not guarantee 100% protection against screenshots or screen recordings. It is possible for determined users to bypass the screenshot prevention measures. This plugin is meant to provide a basic level of protection against casual screenshots or screen recordings.



