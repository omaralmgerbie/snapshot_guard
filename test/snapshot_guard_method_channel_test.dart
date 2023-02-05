import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapshot_guard/snapshot_guard_method_channel.dart';

void main() {
  MethodChannelSnapshotGuard platform = MethodChannelSnapshotGuard();
  const MethodChannel channel = MethodChannel('snapshot_guard');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
