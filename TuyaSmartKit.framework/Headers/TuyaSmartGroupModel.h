//
//  TuyaSmartGroupModel.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/4/20.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartGroupModel
#define TuyaSmart_TuyaSmartGroupModel

#import "TYModel.h"
#import "TuyaSmartDevice.h"

@interface TuyaSmartGroupModel : TYModel

@property (nonatomic, strong) NSString  *groupId;
@property (nonatomic, strong) NSString  *productId;

@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *iconUrl;

@property (nonatomic, assign) BOOL      isShare;
@property (nonatomic, assign) BOOL      isOnline;

@property (nonatomic, strong) TuyaSmartDeviceModel *mainDevice;
@property (nonatomic, strong) NSArray<TuyaSmartDeviceModel *> *deviceList;

@end

#endif