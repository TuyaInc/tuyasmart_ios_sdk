//
//  TYMemberListDelegate.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListDelegate.h"
#import "AddNewMemberViewController.h"
#import "MemberEditViewController.h"

@interface TYMemberListDelegate()

@property (nonatomic,strong) TuyaSmartMember    *memberService;

@end


@implementation TYMemberListDelegate



- (TuyaSmartMember *)memberService {
    if (!_memberService) {
        _memberService = [TuyaSmartMember new];
    }
    return _memberService;
}



- (void)memberListView:(TYMemberListView *)memberListView didSelectRowAtModel:(TuyaSmartMemberModel *)member currentType:(TYMemberCurrentType)currentType {
    
    
    MemberEditViewController *editViewController = [MemberEditViewController new];
    editViewController.member                    = member;
    
    if (currentType == TYMemberSend) {
        editViewController.type = 0;
    } else {
        editViewController.type = 1;
    }
    
    [tp_topMostViewController().navigationController pushViewController:editViewController animated:YES];
    
}

- (void)memberListView:(TYMemberListView *)memberListView deleteRowWithMember:(TuyaSmartMemberModel *)member currentType:(TYMemberCurrentType)currentType success:(TYSuccessHandler)success failure:(TYFailureError)failure {

    [self.memberService removeMember:member.memberId success:^{
        if (success) success();
        
        [[TuyaSmartUser sharedInstance] syncDeviceWithCloud:nil failure:nil];
    } failure:^(NSError *error) {
        if (failure) failure(error);
    }];
    
}


- (void)addNewMember:(TYMemberListView *)memberListView {
    AddNewMemberViewController *addNewMemberViewController = [AddNewMemberViewController new];
    [tp_topMostViewController().navigationController presentViewController:addNewMemberViewController animated:YES completion:nil];
}

@end
