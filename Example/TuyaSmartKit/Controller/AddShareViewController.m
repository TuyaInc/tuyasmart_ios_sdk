//
//  AddShareViewController.m
//  TuyaSmartKitDemo
//
//  Created by 高森 on 15/12/29.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#import "AddShareViewController.h"
#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>

@interface AddShareViewController() <TuyaTopBarViewDelegate>

@property (nonatomic, strong) TuyaSmartMember *smartMember;
@property (nonatomic, strong) TuyaLayoutView *layoutView;
@property (nonatomic, strong) UITextField *phoneCodeTextField;
@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UITextField *nickNameTextField;
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation AddShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    self.view = self.layoutView;
    self.view.backgroundColor = HEXCOLOR(0xF0F0F0);
    
    _phoneCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, APP_SCREEN_WIDTH - 60, 44)];
    _phoneCodeTextField.placeholder = @"区号 / 86";
    [self.view addSubview:_phoneCodeTextField];
    
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, APP_SCREEN_WIDTH - 60, 44)];
    _userNameTextField.placeholder = @"手机号";
    [self.view addSubview:_userNameTextField];
    
    _nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, APP_SCREEN_WIDTH - 60, 44)];
    _nickNameTextField.placeholder = @"昵称";
    [self.view addSubview:_nickNameTextField];

    _submitButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 310, APP_SCREEN_WIDTH - 60, 44)];
    [_submitButton setTitle:@"添加" forState:UIControlStateNormal];
    [_submitButton setTitleColor:HEXCOLOR(0x303030) forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];
}

- (void)submitAction {
    NSString *nickName = _nickNameTextField.text;
    NSString *phoneCode = _phoneCodeTextField.text;
    NSString *userName = _userNameTextField.text;
    
    WEAKSELF_TY
    [self.smartMember addNewMember:nickName phoneCode:phoneCode userAccount:userName relationship:TYRelationshipOther success:^{
        [weakSelf_TY dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [weakSelf_TY showProgress:error.localizedDescription hideDelay:1.5];
    }];
}

- (TuyaSmartMember *)smartMember {
    if (!_smartMember) {
        _smartMember = [[TuyaSmartMember alloc] init];
    }
    return _smartMember;
}

- (TuyaLayoutView *)layoutView {
    if (!_layoutView) {
        _layoutView = [[TuyaLayoutView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];

        TuyaBarButtonItem *leftItem = [[TuyaBarButtonItem alloc] initWithBarButtonSystemItem:ATBarButtonSystemItemLeftWithoutIcon title:NSLocalizedString(@"action_cancel", @"")];
        leftItem.target = self;
        leftItem.action = @selector(topBarLeftItemTap);
        _layoutView.topBarView.leftItem = leftItem;
        _layoutView.topBarView.centerItem.title = NSLocalizedString(@"new_share", @"");
        
        _layoutView.topBarDelegate = self;
        [_layoutView addSubview:_layoutView.topBarView];
    }
    return _layoutView;
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)topBarCenterItemTap {
    
}

- (void)topBarRightItemTap {
    
}

@end
