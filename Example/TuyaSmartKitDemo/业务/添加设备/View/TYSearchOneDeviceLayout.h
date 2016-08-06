//
//  TYSearchOneDeviceLayout.h
//  TuyaSmart
//
//  Created by 高森 on 16/1/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseLayout.h"
//#import "TuyaSmartActivator.h"

@interface TYSearchOneDeviceLayout : TPBaseLayout

- (void)setProgress:(CGFloat)progress;
- (void)setState:(TYActivatorState)state;

@end
