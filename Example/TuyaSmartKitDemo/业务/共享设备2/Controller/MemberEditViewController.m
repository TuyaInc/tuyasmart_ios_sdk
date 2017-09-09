//
//  MemberEditViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "MemberEditViewController.h"
#import "MemberEditView.h"
#import "TYReceiveMemberDeviceListView.h"

@interface MemberEditViewController ()

@property (nonatomic, strong) MemberEditView  *memberEditView;
@property (nonatomic, strong) NSArray         *deviceList;
@property (nonatomic, strong) TuyaSmartMember *memberService;
@property (nonatomic, strong) TYReceiveMemberDeviceListView *deviceListView;

@end

@implementation MemberEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (TuyaSmartMember *)memberService {
    if (!_memberService) {
        _memberService = [TuyaSmartMember new];
    }
    return _memberService;
}

- (TYReceiveMemberDeviceListView *)deviceListView {
    if (!_deviceListView) {
        _deviceListView = [[TYReceiveMemberDeviceListView alloc] initWithFrame:CGRectMake(0, self.memberEditView.bottom, APP_CONTENT_WIDTH, APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT - self.memberEditView.height) deviceList:self.deviceList];
    }
    return _deviceListView;
}

-(void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self initTopBarView];
    [self initMemberEditView];
    [self addDeviceList];
}

-(void)initTopBarView {
    self.topBarView.leftItem = self.leftBackItem;
    
    self.centerTitleItem.title = NSLocalizedString(@"edit", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    
    self.rightTitleItem.title = NSLocalizedString(@"done", @"");;
    self.topBarView.rightItem = self.rightTitleItem;
    
    [self.view addSubview:self.topBarView];
}

-(void)initMemberEditView {
    _memberEditView = [[MemberEditView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, 440/2 - 8)];
    [_memberEditView setup:_member];
    [self.view addSubview:_memberEditView];
}

- (void)addDeviceList {
    if (_type == 0) {
        return;
    }
    
    NSMutableArray *deviceList = [NSMutableArray new];
    [deviceList addObjectsFromArray:self.member.deviceList];
    [deviceList addObjectsFromArray:self.member.groupList];
    self.deviceList = [NSArray arrayWithArray:deviceList];
    
    [self.view addSubview:self.deviceListView];

}

- (void)rightBtnAction {
    [self showProgressView];
    
    WEAKSELF_AT
    [self saveAction:^{
        [weakSelf_AT hideProgressView];
        
        weakSelf_AT.member.nickName    = weakSelf_AT.memberEditView.comments;
//        weakSelf_AT.member.phoneNumber = weakSelf_AT.memberEditView.username;

        
        [weakSelf_AT backButtonTap];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (void)saveAction:(TYSuccessHandler)success failure:(TYFailureError)failure {
    if (_type == 0) {
        [self.memberService modifyMemberName:_member.memberId name:_memberEditView.comments success:success failure:failure];
    } else {
        [self.memberService modifyReceiveMemberName:_member.memberId name:_memberEditView.comments success:success failure:failure];
    }
}
@end
