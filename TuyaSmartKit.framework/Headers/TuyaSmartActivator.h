//
//  TuyaSmartActivator.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartActivator
#define TuyaSmart_TuyaSmartActivator

#import <Foundation/Foundation.h>
#import "TuyaSmartKitConstants.h"

@class TuyaSmartDeviceModel;

typedef enum : NSUInteger {
    TYActivatorModeEZ,
    TYActivatorModeAP
} TYActivatorMode;

@class TuyaSmartActivator;

@protocol TuyaSmartActivatorDelegate<NSObject>

@required

/// 配置状态更新的回调
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error;

@end

/// 配网相关功能
@interface TuyaSmartActivator : NSObject


/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  获取当前Wifi的SSID名称
 */
+ (NSString *)currentWifiSSID;

/**
 *  获取当前Wifi的BSSID名称
 */
+ (NSString *)currentWifiBSSID;


@property (nonatomic, weak) id<TuyaSmartActivatorDelegate> delegate;


/**
 *
 *  获取配网Token（有效期10分钟）
 *
 *  @param success 操作成功回调，返回配网Token
 *  @param failure 操作失败回调
 */
- (void)getToken:(TYSuccessString)success failure:(TYFailureError)failure;

/**
 *
 *  OEM配网
 *  获取配网Token（有效期10分钟）
 *
 *  @param productKey 产品Id
 *  @param success 操作成功回调，返回配网Token
 *  @param failure 操作失败回调
 */
- (void)getTokenWithProductKey:(NSString *)productKey success:(TYSuccessString)success failure:(TYFailureError)failure;

/**
 *  开始配网
 *
 *  @param mode     配网模式, EZ或AP模式
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param token    配网Token
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)startConfigWiFi:(TYActivatorMode)mode
                   ssid:(NSString *)ssid
               password:(NSString *)password
                  token:(NSString *)token
                timeout:(NSTimeInterval)timeout;

/**
 *  开始EZ模式多设备配网
 *
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param token    配网Token
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)startEZMultiConfigWiFiWithSsid:(NSString *)ssid
                              password:(NSString *)password
                                 token:(NSString *)token
                               timeout:(NSTimeInterval)timeout;


/**
 *  停止配网
 */
- (void)stopConfigWiFi;

@end

#endif
