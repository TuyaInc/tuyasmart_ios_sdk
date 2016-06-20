//
//  EZActivatorDeviceController.m
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/14.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "EZActivatorDeviceController.h"
#import "APActivatorDeviceController.h"
#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>

@interface EZActivatorDeviceController () <TuyaDeviceActivatorViewDelegate, TuyaSmartActivatorDelegate, TuyaTopBarViewDelegate>

@property (nonatomic, strong) TuyaDeviceActivatorView *activatorView;

@end

@implementation EZActivatorDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView {
    self.view = self.activatorView;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)initData {
    _activatorView.ssidTextFieldView.text = [TuyaSmartActivator currentWifiSSID];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}

- (TuyaDeviceActivatorView *)activatorView {
    if (!_activatorView) {
        _activatorView = [[TuyaDeviceActivatorView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
        _activatorView.topBarView.leftItem.title = @"取消";
        _activatorView.topBarView.centerItem.title = @"快连模式";
        _activatorView.topBarView.rightItem.title = @"热点模式";
        _activatorView.topBarDelegate = self;
        _activatorView.delegate = self;
    }
    return _activatorView;
}

- (void)startConfig {
    [TuyaSmartActivator sharedInstance].delegate = self;
    [[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeEZ ssid:self.activatorView.ssid password:self.activatorView.password timeout:100];
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarCenterItemTap {
    
}

- (void)topBarRightItemTap {
    [self.navigationController pushViewController:[APActivatorDeviceController new] animated:YES];
}

#pragma mark - TuyaDeviceActivatorViewDelegate

- (void)deviceActivatorViewConfigButtonTap:(TuyaDeviceActivatorView *)deviceActivator {
    [self startConfig];
}

- (void)deviceActivatorView:(TuyaDeviceActivatorView *)deviceActivator showPassword:(BOOL)showPassword {
    
}

#pragma mark - TuyaSmartActivatorDelegate

- (void)activator:(TuyaSmartActivator *)activator didUpdateState:(TYActivatorState)state device:(TuyaSmartDeviceModel *)deviceModel {
    if (state == TYActivatorStateSearch) {
        [self showProgress:@"正在搜索设备"];
    } else if (state == TYActivatorStateConfigure) {
        [self showProgress:@"正在配置Wifi"];
    } else if (state == TYActivatorStateOK) {
        [self hideProgress];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (state == TYActivatorStateFailed) {
        [self showProgress:@"配置失败" hideDelay:1.5];
    } else if (state == TYActivatorStateTimeOut) {
        [self showProgress:@"配置超时" hideDelay:1.5];
    } else if (state == TYActivatorStateNetworkError) {
        [self showProgress:@"网络错误" hideDelay:1.5];
    }
}

@end
