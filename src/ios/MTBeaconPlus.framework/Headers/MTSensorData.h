//
//  MTSensorData.h
//  BeaconPlusSwiftUI
//
//  Created by SACRELEE on 8/10/17.
//  Copyright © 2017 MinewTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTSensorData : NSObject


@property (nonatomic, assign, readonly) NSInteger timestamp;

@property (nonatomic, assign, readonly) double temperature;

@property (nonatomic, assign, readonly) double humidity;

@property (nonatomic, assign, readonly) NSInteger index;

- (void)updateStamp:(NSInteger)timestamp;

@end
