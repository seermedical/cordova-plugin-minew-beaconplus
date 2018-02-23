#import <Cordova/CDVPlugin.h>
// #import <MTBeaconPlus/MTBeaconPlus.h>

@interface MinewBeaconPlus : CDVPlugin {
}

// The hooks for our plugin commands
- (void)echo:(CDVInvokedUrlCommand *)command;
- (void)bleStatus:(CDVInvokedUrlCommand *)command;
- (void)startScan:(CDVInvokedUrlCommand *)command;
- (void)getDate:(CDVInvokedUrlCommand *)command;

@end
