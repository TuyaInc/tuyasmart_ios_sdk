//
//  TuyaSmartDeviceShare.h
//  TuyaSmartKitExample
//
//  Created by 冯晓 on 2017/7/15.
//  Copyright © 2017年 tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartShareMemberModel.h"
#import "TuyaSmartShareDeviceModel.h"
#import "TuyaSmartShareMemberDetailModel.h"
#import "TuyaSmartReceiveMemberDetailModel.h"
#import "TuyaSmartShareDeviceOwnerModel.h"


///  共享设备相关功能 （基于设备维度的共享）
@interface TuyaSmartDeviceShare : NSObject


/**
 获取当前用户的所有可分享设备
 
 @return 设备列表
 */
- (NSArray <TuyaSmartShareDeviceModel *> *)getShareDeviceList;


/**
 获取所有主动共享的用户列表

 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getShareMemberList:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                   failure:(TYFailureError)failure;


/**
 获取单个主动共享的用户共享数据

 @param memberId 共享成员ID
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getShareMemberDetail:(NSInteger)memberId
                     success:(void(^)(TuyaSmartShareMemberDetailModel *model))success
                     failure:(TYFailureError)failure;


/**
 获取所有收到共享的用户列表

 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getReceiveMemberList:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                     failure:(TYFailureError)failure;


/**
 获取单个收到共享的用户共享数据

 @param memberId 共享成员ID
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getReceiveMemberDetail:(NSInteger)memberId
                       success:(void(^)(TuyaSmartReceiveMemberDetailModel *model))success
                       failure:(TYFailureError)failure;


/**
 删除主动共享者

 @param memberId 共享成员ID
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeShareMember:(NSInteger)memberId
                  success:(TYSuccessHandler)success
                  failure:(TYFailureError)failure;


/**
 删除收到共享者

 @param memberId 共享成员ID
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeReceiveMember:(NSInteger)memberId
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;


/**
 修改主动共享者的昵称

 @param memberId 共享成员ID
 @param name 昵称
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)updateShareMemberName:(NSInteger)memberId
                         name:(NSString *)name
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;


/**
 修改收到共享者的昵称

 @param memberId 共享成员ID
 @param name 昵称
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)updateReceiveMemberName:(NSInteger)memberId
                           name:(NSString *)name
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;


/**
 单设备添加共享

 @param memberId 共享成员ID
 @param devId 设备号
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)addDeviceShare:(NSInteger)memberId
                 devId:(NSString *)devId
               success:(TYSuccessHandler)success
               failure:(TYFailureError)failure;


/**
 单设备删除共享

 @param memberId 共享成员ID
 @param devId 设备号
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeDeviceShare:(NSInteger)memberId
                    devId:(NSString *)devId
                  success:(TYSuccessHandler)success
                  failure:(TYFailureError)failure;


/**
 删除收到的共享的设备

 @param devId 设备号
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)removeDeviceShare:(NSString *)devId
                  success:(TYSuccessHandler)success
                  failure:(TYFailureError)failure;


/**
 设置新添加设备是否自动共享

 @param enable 是否启用
 @param memberId 共享成员ID
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)enableNewDeviceAutoShare:(BOOL)enable
                        memberId:(NSInteger)memberId
                         success:(TYSuccessHandler)success failure:(TYFailureError)failure;


/**
 获取单设备共享用户列表(面板中体现)

 @param devId 设备号
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getDeviceShareMemberList:(NSString *)devId
                         success:(void(^)(NSArray<TuyaSmartShareMemberModel *> *list))success
                         failure:(TYFailureError)failure;


/**
 添加单个设备到共享用户 (增量)

 @param countryCode 国家码
 @param userAccount 账号
 @param devIds 设备数组
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)addDeviceShareToMember:(NSString *)countryCode
                   userAccount:(NSString *)userAccount
                        devIds:(NSArray *)devIds
                       success:(void(^)(TuyaSmartShareMemberModel *model))success
                       failure:(TYFailureError)failure;

/**
 添加共享用户 (全量)

 @param countryCode 国家码
 @param userAccount 账号
 @param devIds 设备数组
 @param autoSharing 是否开启新添加设备是否自动共享
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)addMemberShare:(NSString *)countryCode
           userAccount:(NSString *)userAccount
                devIds:(NSArray *)devIds
           autoSharing:(BOOL)autoSharing
               success:(void(^)(TuyaSmartShareMemberModel *model))success
               failure:(TYFailureError)failure;



/**
 查询共享设备的所有者信息

 @param devId 设备Id
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)getDeviceSharedInfo:(NSString *)devId
                    success:(void(^)(TuyaSmartShareDeviceOwnerModel *model))success
                    failure:(TYFailureError)failure;




@end
