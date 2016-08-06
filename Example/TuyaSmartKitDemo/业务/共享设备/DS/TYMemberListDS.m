//
//  TYMemberListDS.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListDS.h"

@interface TYMemberListDS()

@property (nonatomic,strong) TuyaSmartMember    *memberService;

@end

@implementation TYMemberListDS


- (void)getMemberList:(TYSuccessList)compelete {
    [self.memberService getMemberList:^(NSArray *List) {
        if (compelete) compelete(List);
    } failure:^{
        if (compelete) compelete(nil);
    }];
}

- (void)getReceiveMemberList:(TYSuccessList)compelete {
    [self.memberService getReceiveMemberList:^(NSArray *List) {
        if (compelete) compelete(List);
    } failure:^{
        if (compelete) compelete(nil);
    }];
}


- (TuyaSmartMember *)memberService {
    if (!_memberService) {
        _memberService = [TuyaSmartMember new];
    }
    return _memberService;
}

@end
