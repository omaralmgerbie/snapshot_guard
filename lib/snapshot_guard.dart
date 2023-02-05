
import 'snapshot_guard_platform_interface.dart';

class SnapshotGuard {
  // singleton
  static final SnapshotGuard _instance = SnapshotGuard._internal();
  factory SnapshotGuard() => _instance;
  SnapshotGuard._internal();

  Future<bool?> toggleGuard() {
    return SnapshotGuardPlatform.instance.toggleGuard();
  }

  Future<bool?> switchGuardStatus(bool status) {
    return SnapshotGuardPlatform.instance.switchGuardStatus(status);
  }

  Stream<bool> get onGuardStatusChanged {
    return SnapshotGuardPlatform.instance.guardStatusStream;
  }
}
