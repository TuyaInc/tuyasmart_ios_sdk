//
//  TYModel.h
//  TuyaSmartKit
//
//  Created by 高森 on 16/4/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface TYModel : MTLModel <MTLJSONSerializing>

+ (instancetype)modelWithJSON:(NSDictionary*)json;

+ (NSArray *)modelArrayWithJSON:(NSArray *)jsonArray;

+ (NSDictionary *)modelPropertyKeyMap;

@end
