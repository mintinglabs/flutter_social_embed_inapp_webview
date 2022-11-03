#import "SocialEmbedInappWebviewPlugin.h"
#if __has_include(<social_embed_inapp_webview/social_embed_inapp_webview-Swift.h>)
#import <social_embed_inapp_webview/social_embed_inapp_webview-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "social_embed_inapp_webview-Swift.h"
#endif

@implementation SocialEmbedInappWebviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSocialEmbedInappWebviewPlugin registerWithRegistrar:registrar];
}
@end
