import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:log_export/log_export_method_channel.dart';

void main() {
  MethodChannelLogExport platform = MethodChannelLogExport();
  const MethodChannel channel = MethodChannel('log_export');

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
    expect(await platform.getLogFileExportedPath(), '42');
  });
}
