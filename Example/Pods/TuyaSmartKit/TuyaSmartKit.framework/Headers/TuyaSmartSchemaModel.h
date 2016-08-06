//
//  TuyaSmartSchemaModel.h
//  TuyaSmartKit
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartSchemaModel
#define TuyaSmart_TuyaSmartSchemaModel

#import "TYModel.h"
#import "TuyaSmartSchemaPropertyModel.h"

@interface TuyaSmartSchemaModel : TYModel

@property (nonatomic, strong) NSString *dpId;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mode;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) TuyaSmartSchemaPropertyModel *property;

@end

#endif