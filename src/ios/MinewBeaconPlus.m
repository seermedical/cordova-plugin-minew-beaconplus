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

- (void)echo:(CDVInvokedUrlCommand *)command {
  NSString* phrase = [command.arguments objectAtIndex:0];
  NSLog(@"%@", phrase);
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
      for (NSInteger i = 0; i < frames.count; i ++){
        MinewFrame *frame = frames[i];
        // NSLog(@"%@", frame);
        switch(frame.frameType){
          case FrameiBeacon:
            {
              MinewiBeacon *bea = (MinewiBeacon *)frame;
              // NSLog(@"iBeacon:%@, %d, %d",bea.uuid, bea.major, bea.minor);
            }
               break;
          case FrameUID:
            {
               MinewUID *uid = (MinewUID *)frame;
               // NSLog(@"UID:%@, %@", uid.namespaceId, uid.instanceId);
            }
               break;
        }
      }

      // TODO return the device data somehow? I don't know how to look for a specific device yet
      NSString *name = framer.name;
      NSInteger rssi = framer.rssi;          // rssi
      NSInteger battery = framer.battery;    // battery,may nil
      NSString *mac = framer.mac;            // mac address,may nil
      // NSArray *objects = [NSArray arrayWithObjects: name, rssi, battery, mac];
      // NSArray *keys = [NSArray arrayWithObjects: @"name", @"rssi", @"battery", @"string"];
      // NSDictionary *peripheral = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];
      // CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:peripheral];
      // [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

      // Connect to the device
      [manager connectToPeriperal:peri passwordRequire:^(MTPasswordBlock passwordBlock){
        // the length of password string must be 8.
        // !!! read the input content from the UITextField as a password in development.
        NSString *password = @"minew123";
        passwordBlock(password);
      }];
      MTConnectionHandler *con = peri.connector;
      // NSLog(@"%@", con);

      // read HT History from the device
      // [con readSensorHistory:^(MTSensorData *data, EndStatus end){
      //    // a record corresponds to an instance
      //    NSInteger time = data.timestamp;   // the Unix timestamp；
      //    double temp = data.temperature;    // temperature data；
      //    double humi = data.humidity;       // humidity data；
      //    NSInteger index = data.index;      // number of this data；
      //
      //    if (end == EndStatusNone){
      //        NSLog(@"there is no data.");
      //    }
      //    else if (end == EndStatusSuccess) {
      //        NSLog(@"sensor data sync successfully!");
      //    }
      //    else if (end == EndStatusError) {
      //        NSLog(@"something wrong in syncing progress.");
      //    }
      // }];
    }
  }];
}

- (void)stopScan:(CDVInvokedUrlCommand *)command {
  MTCentralManager *manager = [MTCentralManager sharedInstance];
  [manager stopScan];
}

- (void)getDate:(CDVInvokedUrlCommand *)command {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
  [dateFormatter setLocale:enUSPOSIXLocale];
  [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];

  NSDate *now = [NSDate date];
  NSString *iso8601String = [dateFormatter stringFromDate:now];

  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:iso8601String];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
