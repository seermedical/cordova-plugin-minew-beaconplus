//
//  MTTriggerData.h
//  BeaconPlusSwiftUI
//
//  Created by SACRELEE on 8/23/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TriggerType) {
    TriggerTypeUndefined = 0,
    TriggerTypeNone = 1,
    
    TriggerTypeMotionLater,
    TriggerTypeBtnPushLater,
    TriggerTypeBtnReleaLater,
    TriggerTypeBtnStapLater,
    TriggerTypeBtnDtapLater,
    TriggerTypeBtnTtapLater,
    
    TriggerTypeTempAbove,
    TriggerTypeTempBelow,
    TriggerTypeHumiAbove,
    TriggerTypeHumiBelow,
    TriggerTypeLuxAbove,
    TriggerTypeLuxBelow
};

@interface MTTriggerData : NSObject

@property (nonatomic, assign, readonly) TriggerType type;

@property (nonatomic, assign, readonly) NSInteger slotNumber;

@property (nonatomic, assign, readonly) NSInteger value;

@property (nonatomic, assign, readonly) NSInteger maxValue;

@property (nonatomic, assign, readonly) NSInteger minValue;

@property (nonatomic, assign) NSUInteger advInterval;

@property (nonatomic, assign) NSInteger radioTxpower;

// if yes the correspond slot will advertise data even not in trigger condition
// default YES
@property (nonatomic, assign) BOOL always;

- (instancetype)initWithSlot:(NSInteger)slotNumber paramSupport:(BOOL)sup triggerType:(TriggerType)type value:(NSInteger)value;

- (instancetype)initWithType:(TriggerType)type;

@end


