import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'log_export_method_channel.dart';

abstract class LogExportPlatform extends PlatformInterface {
  /// Constructs a LogExportPlatform.
  LogExportPlatform() : super(token: _token);

  static final Object _token = Object();

  static LogExportPlatform _instance = MethodChannelLogExport();

  /// The default instance of [LogExportPlatform] to use.
  ///
  /// Defaults to [MethodChannelLogExport].
  static LogExportPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LogExportPlatform] when
  /// they register themselves.
  static set instance(LogExportPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getLogFileExportedPath() {
    throw UnimplementedError('getLogFileExportedPath() has not been implemented.');
  }

  void init() {
    throw UnimplementedError('init() has not been implemented.');
  }
}
