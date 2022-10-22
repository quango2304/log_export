#import "LogExportPlugin.h"
#if __has_include(<log_export/log_export-Swift.h>)
#import <log_export/log_export-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "log_export-Swift.h"
#endif

@implementation LogExportPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLogExportPlugin registerWithRegistrar:registrar];
}
@end
