package com.quango.logexport.log_export

import android.os.Environment
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import java.io.IOException
import java.util.*


/** LogExportPlugin */
class LogExportPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var packageName : String
  private lateinit var context: Context
  private lateinit var logFile: File
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "log_export")
    context = flutterPluginBinding.applicationContext
    logFile = File(context.getFilesDir().toString() + "/logcat_export.txt")
    if(logFile.exists()) {
      logFile.delete()
    }
    packageName = context.packageName
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getLogFileExportedPath") {
      logFile.createNewFile()
      val pid = android.os.Process.myPid();
      val cmd = "logcat -d --pid=${pid} -f ${logFile.absolutePath}"
      val process = Runtime.getRuntime().exec(cmd)
      process.waitFor()
      result.success(logFile.absolutePath)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
