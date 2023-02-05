
import 'snapshot_guard_platform_interface.dart';

class SnapshotGuard {
  // singleton
  static final SnapshotGuard _instance = SnapshotGuard._internal();
  factory SnapshotGuard() => _instance;
  SnapshotGuard._internal();

  static Future<bool?> toggleGuard() {
    return SnapshotGuardPlatform.instance.toggleGuard();
  }

  static Future<bool?> switchGuardStatus(bool status) {
    return SnapshotGuardPlatform.instance.switchGuardStatus(status);
  }

  static Stream<bool> get onGuardStatusChanged {
    return SnapshotGuardPlatform.instance.guardStatusStream;
  }

  static bool get isGuardEnabled {
    return SnapshotGuardPlatform.instance.isGuardEnabled;
  }
}
