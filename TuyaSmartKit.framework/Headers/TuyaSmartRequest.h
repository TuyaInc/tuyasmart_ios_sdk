//
//  TuyaSmartRequest.h
//  TuyaSmartPublic
//
//  Created by 高森 on 16/5/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaSmartRequest
#define TuyaSmart_TuyaSmartRequest

#import <Foundation/Foundation.h>

@interface TuyaSmartRequest : NSObject

- (void)requestWithApiName:(NSString *)apiName
                  postData:(NSDictionary *)postData
                   version:(NSString *)version
                   success:(TYSuccessID)success
                   failure:(TYFailureError)failure;

@end

#endif
