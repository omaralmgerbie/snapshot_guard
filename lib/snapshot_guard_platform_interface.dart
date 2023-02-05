import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'snapshot_guard_method_channel.dart';

abstract class SnapshotGuardPlatform extends PlatformInterface {
  /// Constructs a SnapshotGuardPlatform.
  SnapshotGuardPlatform() : super(token: _token);

  static final Object _token = Object();

  static SnapshotGuardPlatform _instance = MethodChannelSnapshotGuard();

  /// The default instance of [SnapshotGuardPlatform] to use.
  ///
  /// Defaults to [MethodChannelSnapshotGuard].
  static SnapshotGuardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SnapshotGuardPlatform] when
  /// they register themselves.
  static set instance(SnapshotGuardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> hideSnapshot() {
    throw UnimplementedError('hideSnapshot() has not been implemented.');
  }
}
