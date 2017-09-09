//
//  TuyaSmartSceneConditionModel.h
//  TuyaSmartKit
//
//  Created by xuyongbo on 2017/9/5.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import "TuyaSmartSceneDPModel.h"

typedef NS_ENUM(NSInteger, TYSceneConditionStatus)
{
    TYSceneConditionStatusLoading = 0,
    TYSceneConditionStatusSuccess,
    TYSceneConditionStatusOffline,
    TYSceneConditionStatusTimeout,
};

@interface TuyaSmartSceneConditionModel : TYModel

/**
 条件id
 */
@property (nonatomic, strong) NSString *conditionId;

/**
 城市或设备id
 */
@property (nonatomic, strong) NSString *entityId;

/**
 城市或设备名称 如：“杭州市” 或 “智能插座”
 */
@property (nonatomic, strong) NSString *entityName;

/**
 条件或设备类型（气象数据 = 3、设备数据 ！= 3）
 */
@property (nonatomic, assign) NSInteger entityType;

/**
 条件显示内容，如: “湿度：舒适” 或 “开关 ：开启”
 */
@property (nonatomic, strong) NSString *exprDisplay;

/**
 场景id
 */
@property (nonatomic, strong) NSString *scenarioId;

/**
 条件或设备的DP点id 如：“humidity” 或 “1”
 */
@property (nonatomic, strong) NSString *entitySubIds;

/**
 条件具体内容
 如：("$humidity","==","comfort") 或（“$dp1”，“==”，“1”）
 */
@property (nonatomic, strong) NSArray *expr;

/**
 条件状态
 */
@property (nonatomic, assign) TYSceneConditionStatus status;


/**
 根据DPModel初始化实例

 @param model 条件或设备DP
 @return 实例
 */
- (instancetype)initWithSceneDPModel:(TuyaSmartSceneDPModel *)model;


@end
