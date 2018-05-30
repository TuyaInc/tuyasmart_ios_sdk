//
//  TuyaSmartShareDeviceOwnerModel.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2018/5/29.
//  Copyright © 2018年 Tuya. All rights reserved.
//

#import "TYModel.h"

@interface TuyaSmartShareDeviceOwnerModel : TYModel

//账号注册来源 0,邮箱,1,手机
@property (nonatomic, assign) NSInteger                 regFrom;

//设备拥有者的手机号
@property (nonatomic, strong) NSString                  *mobile;

//设备拥有者的邮箱
@property (nonatomic, strong) NSString                  *email;

//设备拥有者的头像
@property (nonatomic, strong) NSString                  *headPic;

//设备拥有者的名称
@property (nonatomic, strong) NSString                  *name;



@end
