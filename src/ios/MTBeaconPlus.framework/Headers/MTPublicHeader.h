//
//  MTPublicHeader.h
//  MTBeaconPlus
//
//  Created by SACRELEE on 9/21/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSInteger, FrameType) {
    FrameNone = -3,
    FrameConnectable = -2,
    FrameUnknown = -1,
    FrameTLM = 0,
    FrameHTSensor,
    FrameAccSensor,
    FrameLightSensor,
    FrameQlock,
    FrameDFU,
    FrameRoambee,
    
    FrameUID = 100,
    FrameiBeacon,
    FrameURL,
    FrameDeviceInfo,
};

#define MTNAValue 10000000000.0
