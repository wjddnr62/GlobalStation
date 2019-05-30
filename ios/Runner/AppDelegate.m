#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel* nativeChannel = [FlutterMethodChannel                                           methodChannelWithName:@"flutter.native/helper"
                                           binaryMessenger:controller];
    __weak  typeof(self) weakSelf = self;
    [nativeChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"helloFromNativeCode"  isEqualToString:call.method]) {
            
            NSString *strNative = [weakSelf helloFromNativeCode];
            result(strNative);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
    [GeneratedPluginRegistrant  registerWithRegistry:self];
    return [super  application:application didFinishLaunchingWithOptions:launchOptions];
}
- (NSString *)helloFromNativeCode {
    NSURL *url = [NSURL URLWithString:@"http://ga.oig.kr/laon_api/api/asset/sound/P/1/S1/11"];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                     error:NULL];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    return  @"Hello From Native IOS Code";
}

@end
