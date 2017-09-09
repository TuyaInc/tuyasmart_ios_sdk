//
//  TuyaSmartSceneManager.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/5.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartCityModel.h"
#import "TuyaSmartSceneDPModel.h"

@interface TuyaSmartSceneManager : NSObject

/**
 *  单例
 */
+ (instancetype)sharedInstance;

/**
 获取场景列表
 
 @param success 操作成功回调, 返回场景列表
 @param failure 操作失败回调
 */
- (void)getSceneList:(void(^)(NSArray<TuyaSmartSceneModel *> *list))success
             failure:(TYFailureError)failure;

/**
 获取场景条件列表
 
 @param success 操作成功回调，返回场景条件列表
 @param failure 操作失败回调
 */
- (void)getConditionList:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                 failure:(TYFailureError)failure;

/**
 获取任务设备列表
 
 @param success 操作成功回调，返回任务设备列表
 @param failure 操作失败回调
 */
- (void)getActionDeviceList:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                    failure:(TYFailureError)failure;

/**
 获取条件设备列表
 
 @param success 操作成功回调，返回条件设备列表
 @param failure 操作失败回调
 */
- (void)getConditionDeviceList:(void(^)(NSArray<TuyaSmartDeviceModel *> *list))success
                       failure:(TYFailureError)failure;

/**
 获取任务中的设备的DP列表
 
 @param deviceId 设备id
 @param success 操作成功回调，返回任务设备DP列表
 @param failure 操作失败回调
 */
- (void)getActionDeviceDPList:(NSString *)deviceId
                      success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                      failure:(TYFailureError)failure;

/**
 获取条件中的设备的DP列表
 
 @param deviceId 设备id
 @param success 操作成功回调，返回条件设备DP列表
 @param failure 操作失败回调
 */
- (void)getCondicationDeviceDPList:(NSString *)deviceId
                           success:(void(^)(NSArray<TuyaSmartSceneDPModel *> *list))success
                           failure:(TYFailureError)failure;

/**
 获取城市列表
 
 @param countryCode 国家码
 @param success 操作成功回调，返回城市列表
 @param failure 操作失败回调
 */
- (void)getCityList:(NSString *)countryCode
            success:(void(^)(NSArray<TuyaSmartCityModel *> *list))success
            failure:(TYFailureError)failure;

/**
 根据经纬度获取城市信息
 
 @param latitude 经度
 @param longitude 纬度
 @param success 操作成功回调，返回城市信息
 @param failure 操作失败回调
 */
- (void)getCityInfo:(NSString *)latitude
          longitude:(NSString *)longitude
            success:(void(^)(TuyaSmartCityModel *model))success
            failure:(TYFailureError)failure;

/**
 根据城市id获取城市信息
 
 @param cityId 城市id
 @param success 操作成功回调，返回城市信息
 @param failure 操作失败回调
 */
- (void)getCityInfoByCityId:(NSString *)cityId
                    success:(void(^)(TuyaSmartCityModel *model))success
                    failure:(TYFailureError)failure;

/**
 取消操作
 */
- (void)cancelRequest;

@end
