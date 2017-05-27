//
//  TuyaSmartMember.h
//  TuyaSmartKit
//
//  Created by 高森 on 15/12/29.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartMember
#define TuyaSmart_TuyaSmartMember

#import <Foundation/Foundation.h>
#import "TuyaSmartMemberModel.h"
#import "TuyaSmartDeviceModel.h"

typedef enum : NSUInteger {
    TYRelationshipDear,
    TYRelationshipFather,
    TYRelationshipMother,
    TYRelationshipSon,
    TYRelationshipDaughter,
    TYRelationshipFriend,
    TYRelationshipOther
} TYRelationship;

/// 共享设备相关功能
@interface TuyaSmartMember : NSObject

/**
*  获取共享成员列表
*
*  @param success 操作成功回调, 返回成员列表
*  @param failure 操作失败回调
*/
- (void)getMemberList:(void(^)(NSArray<TuyaSmartMemberModel *> *list))success
              failure:(TYFailureHandler)failure;

/**
 *  添加共享
 *
 *  @param name         备注名称
 *  @param phoneCode    区号
 *  @param userAccount  用户名(手机号/邮箱)
 *  @param relationship 关系
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)addNewMember:(NSString *)name
           phoneCode:(NSString *)phoneCode
         userAccount:(NSString *)userAccount
        relationship:(TYRelationship)relationship
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;

/**
 *  添加共享(uid)
 *
 *  @param name         备注名称
 *  @param uid          uid
 *  @param relationship 关系
 *  @param success      操作成功回调
 *  @param failure      操作失败回调
 */
- (void)addNewMember:(NSString *)name
                 uid:(NSString *)uid
        relationship:(TYRelationship)relationship
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;

/**
 *  修改共享成员备注名称
 *
 *  @param memberId 共享成员Id
 *  @param name     备注名称
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
- (void)modifyMemberName:(NSInteger)memberId
                    name:(NSString *)name
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure;

/**
 *  修改接收到的共享的成员备注名称
 *
 *  @param memberId 共享成员Id
 *  @param name     备注名称
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
- (void)modifyReceiveMemberName:(NSInteger)memberId
                           name:(NSString *)name
                        success:(TYSuccessHandler)success
                        failure:(TYFailureError)failure;

/**
 *  删除共享(发出和收到的)
 *
 *  @param memberId 共享成员Id
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
- (void)removeMember:(NSInteger)memberId
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;

/**
 *  获取收到的共享列表
 *
 *  @param success 操作成功回调, 返回成员列表
 *  @param failure 操作失败回调
 */
- (void)getReceiveMemberList:(void(^)(NSArray<TuyaSmartMemberModel *> *list))success
                     failure:(TYFailureHandler)failure;

/// 取消未完成的操作
- (void)cancelRequest;

@end


#endif
