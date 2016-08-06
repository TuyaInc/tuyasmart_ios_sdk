//
//  TYPanelViewController.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/7/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "ATTableViewController.h"

@interface TYPanelViewController : ATBaseViewController <TuyaSmartDeviceDelegate>

@property (nonatomic, strong) NSString *devId;

@end
