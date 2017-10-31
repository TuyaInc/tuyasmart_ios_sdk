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

//群组唯一标识符
@property (nonatomic, strong) NSString  *groupId;

//产品唯一标识符
@property (nonatomic, strong) NSString  *productId;

//群组创建时间
@property (nonatomic, assign) long long    time;

//群组名称
@property (nonatomic, strong) NSString  *name;

//群组iconUrl
@property (nonatomic, strong) NSString  *iconUrl;

//设备在线状态
@property (nonatomic, assign) BOOL      isOnline;

//设备是否是分享的
@property (nonatomic, assign) BOOL      isShare;

//主设备
@property (nonatomic, strong) TuyaSmartDeviceModel *mainDevice;

//设备列表
@property (nonatomic, strong) NSArray<TuyaSmartDeviceModel *> *deviceList;

@end

#endif
