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

/// 此方法已废弃，请使用[TuyaSmartActivatorDelegate activator:didUpdateState:device:]方法代替
- (void)smartActivator:(TuyaSmartActivator *)activator didReceiveState:(TYActivatorState)state __deprecated_msg("Please use [TuyaSmartActivatorDelegate activator:didUpdateState:device:] instead.");

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
 *  获取配网Token（有效期10分钟）
 *
 *  @param success 操作成功回调，返回配网Token
 *  @param failure 操作失败回调
 */
- (void)getToken:(TYSuccessString)success failure:(TYFailureError)failure;

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
 *  停止配网
 */
- (void)stopConfigWiFi;


/// 配网模式, EZ模式或AP模式
@property (nonatomic, assign) TYActivatorMode mode __deprecated;

/// 设置AP模式专用的热点名称前缀
@property (nonatomic, strong) NSString *SSIDPrefix __deprecated;


@end

@interface TuyaSmartActivator (Deprecated)

/**
 *  AP模式, 获取SSID列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 *  @param 此方法已废弃，请参照最新开发文档迁移至v3配网方式。AP配网版本号3.0以上的设备固件不支持此方法获取SSID列表。
 */
- (void)getSSIDList:(TYSuccessDict)success failure:(TYFailureHandler)failure __deprecated;

/**
 *  开始配网
 *
 *  @param mode     配网模式, EZ或AP模式
 *  @param ssid     路由器热点名称
 *  @param password 路由器热点密码
 *  @param timeout  超时时间, 默认为100秒
 *  @param 此方法已废弃，请参照最新开发文档迁移至v3配网方式。AP配网版本号3.0以上的设备固件将无法使用此方法进行配网。
 */
- (void)startConfigWiFi:(TYActivatorMode)mode ssid:(NSString *)ssid password:(NSString *)password timeout:(NSTimeInterval)timeout __deprecated_msg("Please use [TuyaSmartActivator getToken:failure:] and [TuyaSmartActivator startConfigWiFi:ssid:password:token:timeout:] instead.");


/** 初始化方法
 @param mode 激活模式, EZ模式或AP模式.
 @param SSIDPrefix AP模式对应的SSID前缀.
 */
+ (instancetype)activatorWithMode:(TYActivatorMode)mode SSIDPrefix:(NSString *)SSIDPrefix __deprecated_msg("Replaced by [TuyaSmartActivator activator]");

/** 开始配网
 @param SSID 连接的热点名称
 @param password 热点密码
 @param timeout 超时时间, 单位秒.
 */
- (void)startWithSSID:(NSString *)ssid password:(NSString *)password timeout:(NSTimeInterval)timeout __deprecated;

@end

#endif
