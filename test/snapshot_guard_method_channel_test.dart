import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapshot_guard/snapshot_guard_method_channel.dart';

void main() {
  MethodChannelSnapshotGuard platform = MethodChannelSnapshotGuard();
  const MethodChannel channel = MethodChannel('snapshot_guard');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'toggleGuard':
          return true;
        case 'switchGuardStatus':
          return methodCall.arguments;
        default:
          return false;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('toggleGuard', () async {
    expect(await platform.toggleGuard(), true);
  });

  test('switchGuardStatus', () async {
    expect(await platform.switchGuardStatus(true), true);
    expect(await platform.switchGuardStatus(false), false);
  });
}
