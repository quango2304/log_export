import 'package:flutter_test/flutter_test.dart';
import 'package:log_export/log_export.dart';
import 'package:log_export/log_export_platform_interface.dart';
import 'package:log_export/log_export_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLogExportPlatform
    with MockPlatformInterfaceMixin
    implements LogExportPlatform {

  @override
  Future<String?> getLogFileExportedPath() => Future.value('');

  @override
  void init() {
  }
}

void main() {
  final LogExportPlatform initialPlatform = LogExportPlatform.instance;

  test('$MethodChannelLogExport is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLogExport>());
  });

  test('getPlatformVersion', () async {
    MockLogExportPlatform fakePlatform = MockLogExportPlatform();
    LogExportPlatform.instance = fakePlatform;

    expect(await LogExport.getLogFileExportedPath(), '');
  });
}
