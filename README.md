# log_export

A flutter plugin that help you export logcat on Android or stdout and stderr on iOS to a log file, so whenever your
tester create a bug, they can attach this file to the ticket.

## note

On Android, can export the file any time, on iOS, the log file can be exported only when there's not any debugger
attached (if you disconnect debugger, you need to relaunch the app before this function work)

## example

init the plugin

```
     void main() {
        const isStagingEnvironment = true;
        WidgetsFlutterBinding.ensureInitialized();
        if(isStagingEnvironment) {
         LogExport.init();
        }
        runApp(const MyApp());
     } 
```

export the log file

```
    try {
      final logFileExportedPath =
          await LogExport.getLogFileExportedPath() ?? '';
      if(logFileExportedPath.isNotEmpty == true) {
        Share.shareFiles([logFileExportedPath], text: 'Log file');
      }
    } catch (e,s) {
      print("exportLog error $e $s");
    }
```

