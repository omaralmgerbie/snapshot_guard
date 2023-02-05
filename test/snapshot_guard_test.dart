import 'package:flutter_test/flutter_test.dart';
import 'package:snapshot_guard/snapshot_guard.dart';
import 'package:snapshot_guard/snapshot_guard_platform_interface.dart';
import 'package:snapshot_guard/snapshot_guard_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSnapshotGuardPlatform
    with MockPlatformInterfaceMixin
    implements SnapshotGuardPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> hideSnapshot() => Future.value(true);
}

void main() {
  final SnapshotGuardPlatform initialPlatform = SnapshotGuardPlatform.instance;

  test('$MethodChannelSnapshotGuard is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSnapshotGuard>());
  });

  test('getPlatformVersion', () async {
    SnapshotGuard snapshotGuardPlugin = SnapshotGuard();
    MockSnapshotGuardPlatform fakePlatform = MockSnapshotGuardPlatform();
    SnapshotGuardPlatform.instance = fakePlatform;

    expect(await snapshotGuardPlugin.getPlatformVersion(), '42');
  });
}
