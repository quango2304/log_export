import Flutter
import UIKit
import Darwin
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let test = OSLog(subsystem: subsystem, category: "Test")
}

public class SwiftLogExportPlugin: NSObject, FlutterPlugin {
    var logFileUrl:String? = nil
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "log_export", binaryMessenger: registrar.messenger())
        let instance = SwiftLogExportPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    private func redirectStreamToFile() {
        let noDebuggerAttached = isatty(STDERR_FILENO) != 1
        if (noDebuggerAttached) {
            let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let logfileUrl = documentsUrl.appendingPathComponent("stdout_stderr_export.txt")
            logfileUrl.withUnsafeFileSystemRepresentation { path in
                guard let path = path else {
                    return
                }
                freopen(path, "a+", stderr)
                freopen(path, "a+", stdout)
            }
            self.logFileUrl = logfileUrl.relativePath
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "getLogFileExportedPath") {
            result(self.logFileUrl)
        } else if(call.method == "init") {
            self.redirectStreamToFile()
            result(nil)
        }
        else {
            result(nil)
        }
    }
}
