//
//  TuyaSmartKitConstants.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/2/17.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmartKitConstants_h
#define TuyaSmartKitConstants_h

#import <Foundation/Foundation.h>

typedef void (^TYSuccessHandler)();
typedef void (^TYSuccessDict)(NSDictionary *dict);
typedef void (^TYSuccessString)(NSString *result);
typedef void (^TYSuccessList)(NSArray *list);
typedef void (^TYSuccessBOOL)(BOOL result);
typedef void (^TYSuccessID)(id result);
typedef void (^TYSuccessInt)(int result);
typedef void (^TYSuccessData)(NSData *data);

typedef void (^TYFailureHandler)();
typedef void (^TYFailureError)(NSError *error);

/**
 *  
 * APP错误码枚举定义
 */
typedef NS_ENUM(NSInteger, TPErrorCode) {
    
    //接口请求网络错误 errorcode 不能变
    TUYA_NETWORK_ERROR = 1500,
    
    //一般的错误
    TUYA_COMMON_ERROR,
    
    //面板解压失败
    TUYA_PANEL_DECOMPRESS_ERROR,
    
    //面板大小校验失败
    TUYA_PANEL_SIZE_ERROR,
    
    //本地时间校验失败
    TUYA_TIME_VALIDATE_FAILED,
    
    //设备已离线
    TUYA_GW_OFFLINE,
    
    //用户已注册
    TUYA_USER_HAS_EXISTS,
    
    //非法的dp下发
    TUYA_ILLEGAL_DP_DATA,
    
    //设备已经被重置
    TUYA_DEVICE_HAS_RESET,
    
    //用户登录信息丢失
    TUYA_USER_SESSION_LOSS,
    
    //用户登录信息失效
    TUYA_USER_SESSION_INVALID,
    
    //二维码识别错误
    TUYA_QR_PROTOCOL_NOT_RECOGNIZED,
    
    //超时错误
    TUYA_TIMEOUT_ERROR,
    
    //分享给一个没有注册的账号
    TUYA_USER_NOT_REG_INVITE,
    
    //分享给不同区域的账号
    TUYA_USER_DIFFIENT_COUNTRY,
    
    //短信验证码错误
    TUYA_USER_REG_PHONE_CODE_ERROR,
    
    //短信验证码已使用
    TUYA_SMS_CODE_ALREADY_USED,
    
    //短信验证码已过期
    TUYA_SMS_CODE_EXPIRED,
    
    //短信发送过多
    TUYA_USER_CODE_TRY_TOO_MUCH,
    
    //短信验证码不存在
    TUYA_SMS_CODE_NOT_FOUND,
    
    //账号或密码错误
    TUYA_USER_PASSWD_WRONG,
    
    //邮箱验证码错误
    TUYA_EMAIL_CODE_WRONG,
    
};

#endif /* TuyaSmartKitConstants_h */
