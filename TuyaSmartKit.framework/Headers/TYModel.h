//
//  TYModel.h
//  TuyaSmartKit
//
//  Created by 高森 on 16/4/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TYModel
#define TuyaSmart_TYModel

#import <Mantle/Mantle.h>

@interface TYModel : MTLModel <MTLJSONSerializing>

+ (instancetype)modelWithJSON:(NSDictionary*)json;

+ (NSArray *)modelArrayWithJSON:(NSArray *)jsonArray;

//如果需要自定义key的映射，子类需要重写这个方法，在这个方法实现
+ (NSDictionary *)modelPropertyKeyMap;

@end

#endif