//
//  TuyaSmartFeedback.h
//  TuyaSmartKit
//
//  Created by 高森 on 16/4/8.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYModel.h"
#import "TuyaSmartKitConstants.h"

typedef enum : NSUInteger {
    TYFeedbackQuestion,
    TYFeedbackAnswer,
} TYFeedbackType;


@interface TYFeedbackTalkListModel : TYModel

@property (nonatomic, strong) NSString          *dateTime;
@property (nonatomic, strong) NSString          *hdId;
@property (nonatomic, assign) NSUInteger        hdType;
@property (nonatomic, strong) NSString          *title;
@property (nonatomic, strong) NSString          *content;

@end

@interface TYFeedbackModel : TYModel

@property (nonatomic, assign) TYFeedbackType    type;
@property (nonatomic, assign) NSTimeInterval    ctime;
@property (nonatomic, assign) NSUInteger        uniqueId;
@property (nonatomic, strong) NSString          *content;

@end

@interface TYFeedbackItemModel : TYModel

@property (nonatomic, strong) NSString      *hdId;
@property (nonatomic, assign) NSUInteger    hdType;
@property (nonatomic, strong) NSString      *title;

@end

@interface TYFeedbackTypeListModel : TYModel

@property (nonatomic, strong) NSArray<TYFeedbackItemModel *> *list;
@property (nonatomic, strong) NSString *type;

@end

/// 意见反馈相关功能
@interface TuyaSmartFeedback : NSObject

#pragma mark - 获取反馈

/**
 *  获取反馈会话列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFeedbackTalkList:(void (^)(NSArray<TYFeedbackTalkListModel *> *list))success
                    failure:(TYFailureHandler)failure;

/**
 *  获取反馈列表
 *
 *  @param hdId    hdId
 *  @param hdType  hdType
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFeedbackList:(NSString *)hdId
                 hdType:(NSUInteger)hdType
                success:(void (^)(NSArray<TYFeedbackModel *> *list))success
                failure:(TYFailureHandler)failure;

#pragma mark - 添加反馈

/**
 *  获取反馈类型列表
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)getFeedbackTypeList:(void (^)(NSArray<TYFeedbackTypeListModel *> *list))success
                    failure:(TYFailureHandler)failure;

/**
 *  添加反馈
 *
 *  @param content 反馈内容
 *  @param hdId    hdId
 *  @param hdType  hdType
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)addFeedback:(NSString *)content
               hdId:(NSString *)hdId
             hdType:(NSUInteger)hdType
            success:(TYSuccessHandler)success
            failure:(TYFailureHandler)failure;


/// 取消未完成的操作
- (void)cancelRequest;

@end
