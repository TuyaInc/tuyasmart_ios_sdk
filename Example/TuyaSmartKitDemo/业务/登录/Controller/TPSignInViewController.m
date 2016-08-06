//
//  SignInViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TPSignInViewController.h"
#import "TabBarViewController.h"
#import "ATSelectCountryViewController.h"
#import "AppDelegate.h"
#import "TPSignInView.h"
#import "TPInputUserAccountController.h"
#import "TPCountryCodeUtils.h"


@interface TPSignInViewController () <TPSignInViewDelegate,TPTopBarViewDelegate,ATSelectCountryDelegate,UITextFieldDelegate>

@property (nonatomic, strong) TPSignInView       *signInView;
@property (nonatomic, strong) NSTimer            *identifyTimer;
@property (nonatomic, strong) ATCountryCodeModel *countryCodeModel;
@property (nonatomic, assign) int                identifyTimes;



@end

@implementation TPSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    [self initCountryCode];
}

- (void)disableTimer {
    if (_identifyTimer) {
        [_identifyTimer invalidate];
        _identifyTimer = nil;
    }
}

- (void)initView {
    _signInView = [[TPSignInView alloc] initWithFrame:self.view.bounds phoneCodeLogin:_phoneCodeLogin];
    _signInView.delegate = self;
    _signInView.topBarDelegate = self;
    [self.view addSubview:_signInView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[TuyaSmartUser sharedInstance] cancelRequest];
}

- (void)initCountryCode {
    ATCountryCodeModel *model = [ATCountryCodeModel getCountryCodeModel:[TPCountryCodeUtils getDefaultPhoneCodeJson] countryCode:[TPCountryCodeUtils getCountryCode]];
    [self setCountryCode:model];
}

- (void)selectCountryCode {
    [MobClick event:@"login_country"];
    ATSelectCountryViewController *selectCountryViewController = [[ATSelectCountryViewController alloc] init];
    selectCountryViewController.delegate = self;
    [self.navigationController presentViewController:selectCountryViewController animated:YES completion:nil];
}

- (void)setCountryCode:(ATCountryCodeModel *)model {
    _countryCodeModel = model;
    [_signInView setCountryCode:model];
}

- (void)signIn {
    [self.view endEditing:YES];
    
    NSString *countryCode   = _countryCodeModel.countryCode;
    NSString *phoneNumber   = _signInView.phoneNumber;
    NSString *code          = _signInView.verifyCode;
    NSString *password      = _signInView.password;

    [self showProgressView];
    
    WEAKSELF_AT
    TYSuccessHandler success = ^{
        [weakSelf_AT loginSuccess];
    };
    
    TYFailureError failure = ^(NSError *error) {
        [weakSelf_AT loginFailure:error];
    };
    
    if (_phoneCodeLogin == YES) {
        [MobClick event:@"event_login_reg_sms_login"];
        
        //手机验证码登录
        [[TuyaSmartUser sharedInstance] login:countryCode phoneNumber:phoneNumber code:code success:success failure:failure];
    } else {
        //手机密码登录
        if ([phoneNumber rangeOfString:@"@"].length > 0) {
            [[TuyaSmartUser sharedInstance] loginByEmail:countryCode email:phoneNumber password:password success:success failure:failure];
        } else {
            [[TuyaSmartUser sharedInstance] loginByPhone:countryCode phoneNumber:phoneNumber password:password success:success failure:failure];
        }
    }
}

- (void)gotoSignUpViewController {
    [MobClick event:@"event_login_reg"];
    TPInputUserAccountController *vc = [TPInputUserAccountController new];
    vc.type = TPVerifyTypeSignUp;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoResetPassViewController {
    [MobClick event:@"event_forget_keyword"];
    
    TPInputUserAccountController *vc = [TPInputUserAccountController new];
    vc.type = TPVerifyTypeReset;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sendIdentCode {
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", nil) toView:nil];
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] sendVerifyCode:_countryCodeModel.countryCode phoneNumber:_signInView.phoneNumber type:0 success:^{
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [weakSelf_AT.signInView disableSendVerifyCodeButton:NSLocalizedString(@"retry_after_60", @"")];
        weakSelf_AT.identifyTimes = 60;
        weakSelf_AT.identifyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf_AT selector:@selector(resendIdentifyCode:) userInfo:nil repeats:YES];
        
    } failure:^(NSError *error) {
        
        [TPProgressUtils hideHUDForView:nil animated:YES];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (void)resendIdentifyCode:(id)userInfo {
    self.identifyTimes--;
    [_signInView disableSendVerifyCodeButton:[NSString stringWithFormat:NSLocalizedString(@"retry_later", @""),self.identifyTimes]];

    if (self.identifyTimes == 0) {
        [_signInView enableSendVerifyCodeButton:NSLocalizedString(@"login_get_code", @"")];
        [self disableTimer];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarRightItemTap {
    [self gotoSignUpViewController];
}

#pragma mark TuyaSignInViewDelegate

- (void)signInViewCountrySelectViewTap:(TPSignInView *)signInView {
    [self selectCountryCode];
}

- (void)signInViewSendVerifyCodeButtonTap:(TPSignInView *)signInView {
    [self sendIdentCode];
}

- (void)signInViewSignInButtonTap:(TPSignInView *)signInView {
    [self signIn];
}

- (void)signInViewPhoneCodeLoginButtonTap:(TPSignInView *)signInView {
    [MobClick event:@"event_login_reg_sms"];
    
    TPSignInViewController *vc = [TPSignInViewController new];
    vc.phoneCodeLogin = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
    //不然选国家区号出不来
    TPNavigationController *navi = [[TPNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)signInViewResetPassButtonTap:(TPSignInView *)signInView {
    [self gotoResetPassViewController];
}

- (BOOL)getCountStatus {
    if (self.identifyTimes == 0) {
        return NO;
    }
    return YES;
}

#pragma mark ATSelectCountryDelegate
- (void)didSelectCountry:(ATSelectCountryViewController *)controller model:(ATCountryCodeModel *)model {
    [self setCountryCode:model];
    [controller tp_dismissModalViewController];
}

- (void)loginSuccess {
    [self hideProgressView];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate resetRootViewController:[TabBarViewController class]];
    
    [self disableTimer];
}

- (void)loginFailure:(NSError *)error {
    [self hideProgressView];
    [TPProgressUtils showError:error.localizedDescription];
}

@end
