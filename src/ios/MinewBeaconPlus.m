#import "MinewBeaconPlus.h"

#import <Cordova/CDVAvailability.h>
#import <MTBeaconPlus/MTBeaconPlus.h>

@implementation MinewBeaconPlus

- (void)pluginInitialize {
  [super pluginInitialize];
}

- (void)bleStatus:(CDVInvokedUrlCommand *)command {
  // TODO parse these state numbers to meaningful strings
  MTCentralManager *manager = [MTCentralManager sharedInstance];
  manager.stateBlock = ^(PowerState state) {
     CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:state];
     [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
  };
}

- (void)startScan:(CDVInvokedUrlCommand *)command {
  MTCentralManager *manager = [MTCentralManager sharedInstance];
  // start scanning task
  [manager startScan:^(NSArray<MTPeripheral *> *peris){
    NSInteger N = [peris count];
    for(NSInteger i = 0; i < N; i ++) {
      MTPeripheral *peri = peris[i];
      // get FrameHandler of a device.
      // **some properties maybe nil
      MTFrameHandler *framer = peri.framer;
      NSArray *frames = framer.advFrames;    // all data frames of device（such as:iBeacon，UID，URL...）

      // TODO return the device data somehow? I don't know how to look for a specific device yet
      NSString *name = framer.name;
      NSInteger rssi = framer.rssi;          // rssi
      NSInteger battery = framer.battery;    // battery,may nil
      NSString *mac = framer.mac;            // mac address,may nil

      // Connect to the device
      [manager connectToPeriperal:peri passwordRequire:^(MTPasswordBlock passwordBlock){
        // the length of password string must be 8.
        // !!! read the input content from the UITextField as a password in development.
        NSString *password = @"minew123";
        passwordBlock(password);
      }];
      MTConnectionHandler *con = peri.connector;
      // NSLog(@"%@", con);

    }
  }];
}

- (void)stopScan:(CDVInvokedUrlCommand *)command {
  MTCentralManager *manager = [MTCentralManager sharedInstance];
  [manager stopScan];
}


@end
