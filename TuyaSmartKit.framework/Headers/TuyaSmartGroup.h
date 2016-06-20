//
//  TuyaSmartGroup.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/4/21.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartGroup
#define TuyaSmart_TuyaSmartGroup

#import <Foundation/Foundation.h>
#import "TuyaSmartGroupModel.h"

@interface TuyaSmartGroup : NSObject

@property (nonatomic, strong) TuyaSmartGroupModel *groupModel;

/**
 *  创建群组
 *
 *  @param name      群组名称
 *  @param devIdList 设备Id列表
 *  @param success   操作成功回调
 *  @param failure   操作失败回调
 */
+ (void)createGroupWithName:(NSString *)name
                  devIdList:(NSArray<NSString *> *)devIdList
                    success:(void (^)(TuyaSmartGroup *group))success
                    failure:(TYFailureError)failure;

/** 获取群组对象
 @param groupId 群组Id
 */
+ (instancetype)groupWithGroupId:(NSString *)groupId;

/** 获取群组对象
 @param groupId 群组Id
 */
- (instancetype)initWithGroupId:(NSString *)groupId NS_DESIGNATED_INITIALIZER;

/** 群组dp命令下发
 @param dps 命令字典
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)publishDps:(NSDictionary *)dps success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/** 修改群组名称
 @param name 群组名称
 @param success 操作成功回调
 @param failure 操作失败回调
 */
- (void)updateName:(NSString *)name success:(TYSuccessHandler)success failure:(TYFailureError)failure;

/**
 *  解散群组
 *
 *  @param success 操作成功回调
 *  @param failure 操作失败回调
 */
- (void)dismissGroup:(TYSuccessHandler)success failure:(TYFailureError)failure;

@end

#endif
