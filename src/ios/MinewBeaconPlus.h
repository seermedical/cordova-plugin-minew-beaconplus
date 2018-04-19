#import <Cordova/CDVPlugin.h>
// #import <MTBeaconPlus/MTBeaconPlus.h>

@interface MinewBeaconPlus : CDVPlugin {
}

// The hooks for our plugin commands
- (void)bleStatus:(CDVInvokedUrlCommand *)command;
- (void)startScan:(CDVInvokedUrlCommand *)command;
- (void)stopScan:(CDVInvokedUrlCommand *)command;

@end
