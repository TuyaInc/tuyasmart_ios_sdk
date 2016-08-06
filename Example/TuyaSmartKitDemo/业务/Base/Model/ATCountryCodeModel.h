//
//  ATCountryCodeModel.h
//  Airtake
//
//  Created by fisher on 14/12/11.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATCountryCodeModel : NSObject

@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *countryCnName;
@property (nonatomic, strong) NSString *countryEnName;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *countrySpell;
@property (nonatomic, strong) NSString *firstLetter;
@property (nonatomic, strong) NSString *countryAbb;//缩写

+ (ATCountryCodeModel *)getCountryCodeModel:(NSArray *)countryList phoneCode:(NSString *)phoneCode;
+ (ATCountryCodeModel *)getCountryCodeModel:(NSArray *)countryList countryCode:(NSString *)countryCode;
+ (instancetype)modelWithJSON:(NSDictionary *)json;

@end
