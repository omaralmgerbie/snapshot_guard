import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:snapshot_guard/snapshot_guard.dart';
import 'package:snapshot_guard/snapshot_guard_platform_interface.dart';
import 'package:snapshot_guard/snapshot_guard_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSnapshotGuardPlatform
    with MockPlatformInterfaceMixin
    implements SnapshotGuardPlatform {

  final BehaviorSubject<bool> _guardStatusSubject = BehaviorSubject.seeded(false);

  @override
  Future<bool?> toggleGuard() => Future.value(true);

  @override
  Stream<bool> get guardStatusStream => _guardStatusSubject.stream;

  
  @override
  Future<bool?> switchGuardStatus(bool status) {
    _guardStatusSubject.add(status);
    return Future.value(status);
  }
}

void main() {
  final SnapshotGuardPlatform initialPlatform = SnapshotGuardPlatform.instance;

  test('$MethodChannelSnapshotGuard is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSnapshotGuard>());
  });

  test('toggleGuard', () async {
    SnapshotGuard snapshotGuardPlugin = SnapshotGuard();
    MockSnapshotGuardPlatform fakePlatform = MockSnapshotGuardPlatform();
    SnapshotGuardPlatform.instance = fakePlatform;

    expect(await snapshotGuardPlugin.toggleGuard(), true);
  });

  test('switchGuardStatus', () async {
    SnapshotGuard snapshotGuardPlugin = SnapshotGuard();
    MockSnapshotGuardPlatform fakePlatform = MockSnapshotGuardPlatform();
    SnapshotGuardPlatform.instance = fakePlatform;

    expect(await snapshotGuardPlugin.switchGuardStatus(true), true);
    expect(await snapshotGuardPlugin.switchGuardStatus(false), false);
  });
}
