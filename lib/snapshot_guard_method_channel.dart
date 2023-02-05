import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'snapshot_guard_platform_interface.dart';

/// An implementation of [SnapshotGuardPlatform] that uses method channels.
class MethodChannelSnapshotGuard extends SnapshotGuardPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('snapshot_guard');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> hideSnapshot() async {
    final result = await methodChannel.invokeMethod<bool>('hideSnapshot');
    return result;
  }
}
