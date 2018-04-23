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
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:10];

  // start scanning task
  [manager startScan:^(NSArray<MTPeripheral *> *peris){
    NSInteger N = [peris count];
    for(NSInteger i = 0; i < N; i ++){
        MTPeripheral *peri = peris[i];
        NSString *address = peri.identifier;
        // [dict setObject:[MTPeripheral peri] forKey:address];
        dict[address] = peri;
        // MTFrameHandler *framer = peri.framer;
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:address];
        [result setKeepCallback:[NSNumber numberWithBool:YES]];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
    // CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsMultipart:peris];
    // [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
  }];
}

- (void)stopScan:(CDVInvokedUrlCommand *)command {
  MTCentralManager *manager = [MTCentralManager sharedInstance];
  [manager stopScan];
}

-(void)setTrigger:(CDVInvokedUrlCommand *)command {
  NSString* id = [command.arguments objectAtIndex:0];
}


@end
