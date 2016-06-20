//
//  TuyaSmartSchemaPropertyModel.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartSchemaPropertyModel
#define TuyaSmart_TuyaSmartSchemaPropertyModel

#import "TYModel.h"

@interface TuyaSmartSchemaPropertyModel : TYModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, assign) double   min;
@property (nonatomic, assign) double   max;
@property (nonatomic, assign) double   step;
@property (nonatomic, strong) NSArray  *range;

@end

#endif