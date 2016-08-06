//
//  ATCountryCodeModel.m
//  Airtake
//
//  Created by fisher on 14/12/11.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "ATCountryCodeModel.h"

@implementation ATCountryCodeModel

+ (ATCountryCodeModel *)getCountryCodeModel:(NSArray *)countryList phoneCode:(NSString *)phoneCode {
    
    ATCountryCodeModel *model;
    
    for (NSDictionary *dict in countryList) {
        if ([[dict objectForKey:@"code"] isEqualToString:phoneCode]) {
            model = [ATCountryCodeModel modelWithJSON:dict];
        }
    }
    return model;
}

+ (ATCountryCodeModel *)getCountryCodeModel:(NSArray *)countryList countryCode:(NSString *)countryCode {
    
    ATCountryCodeModel *model;
    
    for (NSDictionary *dict in countryList) {
        if ([[dict objectForKey:@"abbr"] isEqualToString:countryCode]) {
            model = [ATCountryCodeModel modelWithJSON:dict];
        }
    }
    return model;
}

+ (instancetype)modelWithJSON:(NSDictionary *)json {
    ATCountryCodeModel *model = [[ATCountryCodeModel alloc] init];
    model.countryCode   = [json objectForKey:@"code"];
    model.countryCnName = [json objectForKey:@"chinese"];
    model.countryEnName = [json objectForKey:@"english"];
    model.countrySpell  = [json objectForKey:@"spell"];
    model.countryAbb    = [json objectForKey:@"abbr"];
    
    if ([TPUtils isChinese]) {
        model.countryName = model.countryCnName;
        model.firstLetter = [[model.countrySpell substringToIndex:1] uppercaseString];
    } else {
        model.countryName = model.countryEnName;
        model.firstLetter = [model.countryName substringToIndex:1];
    }
    
    return model;
}

- (id)modelWithJSON:(NSDictionary *)json {
    return nil;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"countryCode": @"code",
        @"countryCnName": @"chinese",
        @"countryEnName": @"english",
        @"countrySpell": @"spell",
        @"countryAbb": @"abbr",
    };
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.countryCnName = @"";
        self.countrySpell = @"";
    }
    return self;
}

@end
