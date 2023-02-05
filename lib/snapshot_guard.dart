
import 'snapshot_guard_platform_interface.dart';

class SnapshotGuard {
  // singleton
  static final SnapshotGuard _instance = SnapshotGuard._internal();
  factory SnapshotGuard() => _instance;
  SnapshotGuard._internal();
  Future<String?> getPlatformVersion() {
    return SnapshotGuardPlatform.instance.getPlatformVersion();
  }

  Future<bool?> hideSnapshot() {
    return SnapshotGuardPlatform.instance.hideSnapshot();
  }
}
