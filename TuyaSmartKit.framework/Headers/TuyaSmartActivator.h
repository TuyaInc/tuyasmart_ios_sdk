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

typedef enum : NSUInteger {
    TYActivatorStateSearch, //搜索设备
    TYActivatorStateConfigure, //配置设备
    TYActivatorStateDeviceLogin, //设备上线至涂鸦云
    TYActivatorStateOK, //配网成功
    TYActivatorStateFailed, //配网失败
    TYActivatorStateTimeOut, //配网超时
    TYActivatorStateNetworkError, //网络错误
} TYActivatorState;

@class TuyaSmartActivator;

@protocol TuyaSmartActivatorDelegate<NSObject>

@required
/// 配置状态更新的回调
- (void)activator:(TuyaSmartActivator *)activator didUpdateState:(TYActivatorState)state device:(TuyaSmartDeviceModel *)deviceModel;

@optional
- (void)smartActivator:(TuyaSmartActivator *)activator didReceiveState:(TYActivatorState)state __deprecated_msg("Use activator:didUpdateState:device: instead");

@end

/// 配网相关功能
@interface TuyaSmartActivator : NSObject

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
 *  AP模式, 获取SSID列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getSSIDList:(TYSuccessDict)success failure:(TYFailureHandler)failure;

/**
 *  配置WiFi信息
 *
 *  @param mode     配网模式, EZ或AP模式
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param timeout  超时时间, 默认为100秒
 */
- (void)startConfigWiFi:(TYActivatorMode)mode ssid:(NSString *)ssid password:(NSString *)password timeout:(NSTimeInterval)timeout;

/**
 *  取消配置WiFi
 */
- (void)stopConfigWiFi;


/// 激活模式, EZ模式或AP模式
@property (nonatomic, assign) TYActivatorMode mode __deprecated_msg("Deprecated");;

/// 设置AP模式专用的热点名称前缀
@property (nonatomic, strong) NSString *SSIDPrefix __deprecated_msg("Deprecated");


@end

@interface TuyaSmartActivator (Deprecated)

/** 初始化方法
 @param mode 激活模式, EZ模式或AP模式.
 @param SSIDPrefix AP模式对应的SSID前缀.
 */
+ (instancetype)activatorWithMode:(TYActivatorMode)mode SSIDPrefix:(NSString *)SSIDPrefix __deprecated_msg("Replaced by [TuyaSmartActivator activator]");

/** 配置WiFi信息
 @param SSID 连接的热点名称
 @param password 热点密码
 @param timeout 超时时间, 单位秒.
 */
- (void)startWithSSID:(NSString *)ssid password:(NSString *)password timeout:(NSTimeInterval)timeout __deprecated_msg("Deprecated");

@end

#endif
