//
//  TuyaSmartSDK.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartSDK
#define TuyaSmart_TuyaSmartSDK

#import <Foundation/Foundation.h>

@interface TuyaSmartSDK : NSObject

/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 *  调试模式
 */
@property (nonatomic, assign) BOOL debugMode;

/**
 *  初始化涂鸦智能SDK
 *
 *  @param appKey    涂鸦智能AppKey
 *  @param secretKey 涂鸦智能SecretKey
 */
- (void)startWithAppKey:(NSString *)appKey secretKey:(NSString *)secretKey;

@end


#endif
