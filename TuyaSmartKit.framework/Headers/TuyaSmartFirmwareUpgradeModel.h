//
//  TuyaFirmwareUpgradeInfo.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYModel.h"

@interface TuyaSmartFirmwareUpgradeModel : TYModel

@property (nonatomic, strong) NSString  *desc;
@property (nonatomic, assign) NSInteger upgradeStatus; //0:无新版本 1:有新版本 2:在升级中
@property (nonatomic, strong) NSString  *version;
@property (nonatomic, strong) NSString  *currentVersion;
@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic, assign) NSInteger upgradeType;//0:app提醒升级 2:app强制升级 3:检测升级

@end
