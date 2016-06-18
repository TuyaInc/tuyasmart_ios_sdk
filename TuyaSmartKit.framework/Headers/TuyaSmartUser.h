//
//  TuyaSmartUser.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/8/31.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartKitConstants.h"
#import "TuyaSmartDeviceModel.h"
#import "TuyaSmartGroupModel.h"


/// 当用户登录信息过期后发出的通知
FOUNDATION_EXPORT NSString * const TuyaSmartUserNotificationUserSessionInvalid;

/// 用户相关功能
@interface TuyaSmartUser : NSObject

/**
 *  单例
 */
+ (instancetype)sharedInstance;

/// 昵称
@property (nonatomic, strong, readonly) NSString *nickname;

/// 用户名
@property (nonatomic, strong, readonly) NSString *userName;

/// 手机号
@property (nonatomic, strong, readonly) NSString *phoneNumber;

/// 是否已登录
@property (nonatomic, assign, readonly) BOOL isLogin;

/// 设备列表
@property (nonatomic, strong, readonly) NSArray<TuyaSmartDeviceModel *> *deviceArray;

/// 群组列表
@property (nonatomic, strong, readonly) NSArray<TuyaSmartGroupModel *> *groupList;

#pragma mark - 手机验证码登录

/**
 *  发送验证码，用于手机验证码登录/注册，手机密码重置
 *
 *  @param countryCode 国家区号
 *  @param phoneNumber 手机号
 *  @param type        0 手机验证码登录 1 手机验证码注册 2 手机密码重置
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)sendVerifyCode:(NSString *)countryCode
           phoneNumber:(NSString *)phoneNumber
                  type:(NSInteger)type
               success:(TYSuccessHandler)success
               failure:(TYFailureError)failure;

/**
 *  发送验证码，用于手机验证码绑定手机号，更换手机号
 *
 *  @param countryCode 国家区号
 *  @param phoneNumber 手机号
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)sendBindVerifyCode:(NSString *)countryCode
               phoneNumber:(NSString *)phoneNumber
                   success:(TYSuccessHandler)success
                   failure:(TYFailureError)failure;

/**
 *  手机验证码登录
 *
 *  @param countryCode 国家区号
 *  @param phoneNumber 手机号
 *  @param code        验证码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)login:(NSString *)countryCode
  phoneNumber:(NSString *)phoneNumber
         code:(NSString *)code
      success:(TYSuccessHandler)success
      failure:(TYFailureError)failure;

/**
 *  手机绑定
 *
 *  @param countryCode 国家区号
 *  @param phoneNumber 手机号
 *  @param code        验证码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)mobileBinding:(NSString *)countryCode
          phoneNumber:(NSString *)phoneNumber
                 code:(NSString *)code
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure;

#pragma mark - 手机密码登录

/**
 *  手机注册
 *
 *  @param countryCode 国家区号
 *  @param phoneNumber 邮箱
 *  @param password    密码
 *  @param code        验证码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)registerByPhone:(NSString *)countryCode
            phoneNumber:(NSString *)phoneNumber
               password:(NSString *)password
                   code:(NSString *)code
                success:(TYSuccessHandler)success
                failure:(TYFailureError)failure;

/**
 *  手机密码登录
 *
 *  @param countryCode 国家区号
 *  @param phoneNumber 手机号
 *  @param password    密码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)loginByPhone:(NSString *)countryCode
         phoneNumber:(NSString *)phoneNumber
            password:(NSString *)password
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;

/**
 *  手机密码重置
 *
 *  @param countryCode 国家区号
 *  @param phoneNumber 手机号
 *  @param newPassword 新密码
 *  @param code        验证码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)resetPasswordByPhone:(NSString *)countryCode
                 phoneNumber:(NSString *)phoneNumber
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;

#pragma mark - 邮箱登录

/**
 *  邮箱注册
 *
 *  @param countryCode 国家区号
 *  @param email       邮箱
 *  @param password    密码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)registerByEmail:(NSString *)countryCode
                  email:(NSString *)email
               password:(NSString *)password
                success:(TYSuccessHandler)success
                failure:(TYFailureError)failure;

/**
 *  邮箱登录
 *
 *  @param countryCode 国家区号
 *  @param email       邮箱
 *  @param password    密码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)loginByEmail:(NSString *)countryCode
               email:(NSString *)email
            password:(NSString *)password
             success:(TYSuccessHandler)success
             failure:(TYFailureError)failure;

/**
 *  发送验证码，用于邮箱密码重置
 *
 *  @param countryCode 国家区号
 *  @param email       邮箱
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)sendVerifyCodeByEmail:(NSString *)countryCode
                        email:(NSString *)email
                      success:(TYSuccessHandler)success
                      failure:(TYFailureError)failure;

/**
 *  邮箱密码重置
 *
 *  @param countryCode 国家区号
 *  @param email       邮箱
 *  @param newPassword 新密码
 *  @param code        验证码
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)resetPasswordByEmail:(NSString *)countryCode
                       email:(NSString *)email
                 newPassword:(NSString *)newPassword
                        code:(NSString *)code
                     success:(TYSuccessHandler)success
                     failure:(TYFailureError)failure;

#pragma mark - uid登录

/**
 *  uid注册
 *
 *  @param uid         uid
 *  @param password    密码
 *  @param countryCode 国家区号
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)registerByUid:(NSString *)uid
             password:(NSString *)password
          countryCode:(NSString *)countryCode
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure;

/**
 *  uid登录
 *
 *  @param uid         uid
 *  @param password    密码
 *  @param countryCode 国家区号
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)loginByUid:(NSString *)uid
          password:(NSString *)password
       countryCode:(NSString *)countryCode
           success:(TYSuccessHandler)success
           failure:(TYFailureError)failure;

/**
 *  uid密码重置
 *
 *  @param uid         uid
 *  @param newPassword 新密码
 *  @param countryCode 国家区号
 *  @param success     操作成功回调
 *  @param failure     操作失败回调
 */
- (void)resetPasswordByUid:(NSString *)uid
               newPassword:(NSString *)newPassword
               countryCode:(NSString *)countryCode
                   success:(TYSuccessHandler)success
                   failure:(TYFailureError)failure;

#pragma mark - 


/**
 *  登出
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)loginOut:(TYSuccessHandler)success
         failure:(TYFailureError)failure;

/**
 *  修改昵称
 *
 *  @param nickname 昵称
 *  @param success  操作成功回调
 *  @param failure  操作失败回调
 */
- (void)updateNickname:(NSString *)nickName
               success:(TYSuccessHandler)success
               failure:(TYFailureError)failure;

/**
 *  同步设备列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)syncDeviceWithCloud:(TYSuccessHandler)success
                    failure:(TYFailureHandler)failure;

/**
 *  获取体验中心设备列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getExperienceDeviceWithCloud:(TYSuccessList)success
                             failure:(TYFailureError)failure;

#pragma mark - 消息中心

/**
 *  获取消息类型列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getMessageGroup:(TYSuccessList)success
                failure:(TYFailureError)failure;

/**
 *  获取消息列表
 *
 *  @param msgType 消息类型
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getMessageList:(NSInteger)msgType
               success:(TYSuccessList)success
               failure:(TYFailureError)failure;

#pragma mark -

/// 取消未完成的操作
- (void)cancelRequest;

@end
