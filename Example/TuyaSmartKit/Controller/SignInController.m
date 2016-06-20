//
//  SignInController.m
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/12.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "SignInController.h"
#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>
#import "AppDelegate.h"
#import "DeviceListController.h"

@interface SignInController()<TuyaSignInViewDelegate> {
    int _identifyTimes;
}

@property (nonatomic, strong) TuyaSignInView *signInView;
@property (nonatomic, strong) NSTimer *identifyTimer;

@end

@implementation SignInController

- (void)viewDidLoad {
    [self initView];
}

- (void)initView {
    self.signInView.delegate = self;
    self.view = self.signInView;
}

- (TuyaSignInView *)signInView {
    if (!_signInView) {
        _signInView = [[TuyaSignInView alloc] initWithFrame:self.view.frame];
        _signInView.delegate = self;
        _signInView.topBarView.leftItem = nil;
        [_signInView setCountryCode:@"中国 ＋86"];
    }
    return _signInView;
}

#pragma mark - TuyaSignInViewDelegate

- (void)signInViewCountrySelectViewTap:(TuyaSignInView *)signInView {
    
}

- (void)signInViewSendVerifyCodeButtonTap:(TuyaSignInView *)signInView {
    [[TuyaSmartUser sharedInstance] sendVerifyCode:@"86" phoneNumber:signInView.phoneNumber type:0 success:^{
        NSLog(@"sendVerifyCode success");
    } failure:^(NSError *error) {
        NSLog(@"sendVerifyCode failure");
        [UIAlertView bk_showAlertViewWithTitle:error.localizedDescription message:nil cancelButtonTitle:NSLocalizedString(@"confirm", @"") otherButtonTitles:nil handler:nil];
    }];
    
    [_signInView disableSendVerifyCodeButton:NSLocalizedString(@"retry_after_60", @"")];
    _identifyTimes = 60;
    _identifyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resendIdentifyCode:) userInfo:nil repeats:YES];
}

- (void)signInViewSignInButtonTap:(TuyaSignInView *)signInView {
    
    [self showProgress];
    WEAKSELF_TY
    [[TuyaSmartUser sharedInstance] login:@"86" phoneNumber:signInView.phoneNumber code:signInView.verifyCode success:^{
        [weakSelf_TY hideProgress];
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [delegate resetRootViewController:[DeviceListController class]];
    } failure:^(NSError *error) {
        [weakSelf_TY hideProgress];
        [UIAlertView bk_showAlertViewWithTitle:error.localizedDescription message:nil cancelButtonTitle:NSLocalizedString(@"confirm", @"") otherButtonTitles:nil handler:nil];
    }];
}

- (void)resendIdentifyCode:(id)userInfo {
    _identifyTimes--;
    [_signInView disableSendVerifyCodeButton:[NSString stringWithFormat:NSLocalizedString(@"retry_later", @""), _identifyTimes]];
    
    if (_identifyTimes == 0) {
        [_signInView enableSendVerifyCodeButton:NSLocalizedString(@"login_get_code", @"")];
        [_identifyTimer invalidate];
    }
}

@end
