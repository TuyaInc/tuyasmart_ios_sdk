//
//  TuysSmartDeviceModel.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/12.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYModel.h"
#import "TuyaSmartSchemaModel.h"

@interface TuyaSmartDeviceModel : TYModel


//设备唯一标识符
@property (nonatomic, strong) NSString     *devId;

//设备名称
@property (nonatomic, strong) NSString     *name;

//设备icon的地址
@property (nonatomic, strong) NSString     *iconUrl;

//设备的能力值
@property (nonatomic, assign) NSInteger    ability;

//设备在线状态
@property (nonatomic, assign) BOOL         isOnline;

//设备是否是分享的
@property (nonatomic, assign) BOOL         isShare;

//设备UI包的唯一标识符
@property (nonatomic, strong) NSString     *uiId;

//设备UI包的版本号
@property (nonatomic, strong) NSString     *uiVersion;
@property (nonatomic, strong) NSString     *uiPhase;

//设备
@property (nonatomic, strong) NSString     *verSw;
@property (nonatomic, strong) NSDictionary *uiConfig;

//设备的当前dp点
@property (nonatomic, strong) NSDictionary *dps;
@property (nonatomic, strong) NSString     *productId;
@property (nonatomic, strong) NSString     *uiType;
@property (nonatomic, assign) BOOL         rnFind;
@property (nonatomic, assign) BOOL         supportGroup;
@property (nonatomic, assign) double       pv;//网关协议版本
@property (nonatomic, assign) double       bv;//硬件基线版本

//设备的schema定义
@property (nonatomic, strong) NSString     *schema;
@property (nonatomic, strong) NSArray<TuyaSmartSchemaModel *> *schemaArray;


@end
