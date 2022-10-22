import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'log_export_platform_interface.dart';

/// An implementation of [LogExportPlatform] that uses method channels.
class MethodChannelLogExport extends LogExportPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('log_export');

  @override
  Future<String?> getLogFileExportedPath() async {
    final version = await methodChannel.invokeMethod<String>('getLogFileExportedPath');
    return version;
  }

  @override
  void init() {
    methodChannel.invokeMethod('init');
  }
}
