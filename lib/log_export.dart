import 'dart:io';
import 'package:flutter/foundation.dart';

import 'log_export_platform_interface.dart';

class LogExport {
  static bool _inited = false;
  ///   try {
  ///      logFileExportedPath =
  ///          await LogExport.getLogFileExportedPath() ?? '';
  ///      if(logFileExportedPath.isNotEmpty == true) {
  ///        Share.shareFiles([logFileExportedPath], text: 'Log file');
  ///      }
  ///    } catch (e,s) {
  ///      print("exportLog error $e $s");
  ///    }
  /// export the logcat on Android and stdout & stderr on iOS
  /// must call LogExport.init() first
  /// on Android, can export the file any time
  /// on iOS, the log file can be exported only when there's not any debugger attached (if you disconnect debugger, you need to relaunch the app before this function work)
  static Future<String?> getLogFileExportedPath() async {
    if (!_inited) {
      throw UnimplementedError('Must call LogExport.init() first');
    }
    return LogExportPlatform.instance.getLogFileExportedPath();
  }

  /// should only call this in staging environment, because on iOS call this method will redirect the stdout and stderr stream to a log file.
  /// must call WidgetsFlutterBinding.ensureInitialized(); before this if you init this function in main()
  /// void main() {
  ///    const isStagingEnvironment = true;
  ///    WidgetsFlutterBinding.ensureInitialized();
  ///    if(isStagingEnvironment) {
  ///      LogExport.init();
  ///    }
  ///    runApp(const MyApp());
  ///  }
  static void init() {
    _inited = true;
    if (Platform.isAndroid) {
      return;
    }
    LogExportPlatform.instance.init();
  }
}
