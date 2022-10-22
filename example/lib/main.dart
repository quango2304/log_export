import 'package:flutter/material.dart';
import 'dart:async';
import 'package:log_export/log_export.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  const isStagingEnvironment = true;
  WidgetsFlutterBinding.ensureInitialized();
  if(isStagingEnvironment) {
    LogExport.init();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String logFileExportedPath = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> exportLog() async {
    print("coming to exportLog log");
    String logFileExportedPath = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      logFileExportedPath =
          await LogExport.getLogFileExportedPath() ?? '';
      if(logFileExportedPath.isNotEmpty == true) {
        Share.shareFiles([logFileExportedPath], text: 'Log file');
      }
    } catch (e,s) {
      print("exportLog error $e $s");
    }
    if (!mounted) return;

    setState(() {
      this.logFileExportedPath = logFileExportedPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('logCatExportedPath: $logFileExportedPath\n'),
              TextButton(onPressed: () {
                exportLog();
              }, child: Text("export log"))
            ],
          ),
        ),
      ),
    );
  }
}
