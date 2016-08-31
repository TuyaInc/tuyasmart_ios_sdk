//
//  TYPanelBaseViewController.h
//  TuyaSmartKitDemo
//
//  Created by 冯晓 on 16/8/30.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "ATBaseViewController.h"

@interface TYPanelBaseViewController : ATBaseViewController <TuyaSmartDeviceDelegate>


@property (nonatomic, strong) NSString *devId;

@property (nonatomic, strong) TuyaSmartDevice *device;


- (void)updateOfflineView;

@end
