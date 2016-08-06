//
//  TYMemberListDS.h
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseDS.h"

@interface TYMemberListDS : TPBaseDS

- (void)getMemberList:(TYSuccessList)compelete;

- (void)getReceiveMemberList:(TYSuccessList)compelete;

@end
