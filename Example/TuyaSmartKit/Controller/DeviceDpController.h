//
//  DeviceDpController.h
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/16.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@class TuyaSmartSchemaModel;

@interface DeviceDpController : BaseController

@property (nonatomic, strong) NSString *devId;
@property (nonatomic, strong) id dpValue;
@property (nonatomic, strong) TuyaSmartSchemaModel *schema;

@end
