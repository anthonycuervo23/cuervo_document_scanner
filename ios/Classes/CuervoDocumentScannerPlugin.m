#import "CuervoDocumentScannerPlugin.h"
#if __has_include(<cuervo_document_scanner/cuervo_document_scanner-Swift.h>)
#import <cuervo_document_scanner/cuervo_document_scanner-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cuervo_document_scanner-Swift.h"
#endif

@implementation CuervoDocumentScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCuervoDocumentScannerPlugin registerWithRegistrar:registrar];
}
@end
