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

// PARAMETERS
  NSInteger triggerSlot = 5;
  NSInteger triggerValue = 5;                           // constantly broadcast Xs when single click the button.

  MTCentralManager *manager = [MTCentralManager sharedInstance];
  // start scanning task
  [manager startScan:^(NSArray<MTPeripheral *> *peris){
    NSInteger N = [peris count];
    for(NSInteger i = 0; i < N; i ++){
        MTPeripheral *peri = peris[i];
        if ([peri.identifier isEqualToString:id]){
          // Connect to the device
          [manager connectToPeriperal:peri passwordRequire:^(MTPasswordBlock passwordBlock){
              NSString *password = @"minew123";
              passwordBlock(password);
          }];
          // listen the change of device connection state
          MTConnectionHandler *con = peri.connector;
          con.statusChangedHandler = ^(ConnectionStatus status, NSError *error) {
            if (status == 11){
              NSLog(@"connected to %@",id);

              // create a trigger instance
              MTTriggerData *trigger1 = [[MTTriggerData alloc]initWithSlot:triggerSlot paramSupport:true triggerType:TriggerTypeBtnPushLater value:triggerValue];
              trigger1.advInterval = 100;
              trigger1.radioTxpower = 4;
              // write to the device.
              [con writeTrigger:trigger1 completion:^(BOOL success1){

                if (success1) {
                  NSLog(@"first trigger set");
                }

              }];

              // create 2nd trigger instance
              MTTriggerData *trigger2 = [[MTTriggerData alloc]initWithSlot:triggerSlot paramSupport:true triggerType:TriggerTypeBtnReleaLater value:triggerValue];
              trigger2.advInterval = 0;
              trigger2.radioTxpower = 0;
              // write to the device.
              [con writeTrigger:trigger2 completion:^(BOOL success2){

                if (success2) {
                  NSLog(@"second trigger set");
                }

                //disconnect & TODO ?stop scan
                [manager disconnectFromPeriperal:peri];
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:success2];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
              }];

            }
          };
        }
    }
  }];
}

-(void)getFrames:(CDVInvokedUrlCommand *)command {
  NSString* id = [command.arguments objectAtIndex:0];

  MTCentralManager *manager = [MTCentralManager sharedInstance];
  // start scanning task
  [manager startScan:^(NSArray<MTPeripheral *> *peris){
    NSInteger N = [peris count];
    for(NSInteger i = 0; i < N; i ++){
        MTPeripheral *peri = peris[i];
        if ([peri.identifier isEqualToString:id]) {
          MTFrameHandler *framer = peri.framer;
          NSArray *frames = framer.advFrames;
          NSInteger F = [frames count];
          if (F > 4){
            MinewFrame *frame = frames[4];
            NSLog(@"%d, %d, %d",frame.slotRadioTxpower,frame.slotAdvTxpower,frame.slotAdvInterval);
          }
        }
    }
  }];
}


@end
