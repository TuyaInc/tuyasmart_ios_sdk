//
//  APActivatorDeviceController.m
//  TuyaSmartKitDemo
//
//  Created by 高森 on 15/12/28.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#import "APActivatorDeviceController.h"
#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>

@interface APActivatorDeviceController() <TuyaDeviceActivatorViewDelegate, TuyaSmartActivatorDelegate, TuyaTopBarViewDelegate, UIPickerViewDelegate>

@property (nonatomic, strong) TuyaDeviceActivatorView *activatorView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *SSIDList;

@end

@implementation APActivatorDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView {
    self.view = self.activatorView;
}

- (void)initData {
    WEAKSELF_TY
    [self showProgress:@"正在获取WiFi列表" hideDelay:5];
    [[TuyaSmartActivator sharedInstance] getSSIDList:^(NSDictionary *dict) {
        [weakSelf_TY hideProgress];
        weakSelf_TY.SSIDList = [dict objectForKey:@"ssid_list"];
        weakSelf_TY.activatorView.ssidTextFieldView.text = [weakSelf_TY.SSIDList firstObject];
    } failure:^{
        [weakSelf_TY showProgress:@"获取WiFi列表失败" hideDelay:1];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}

- (TuyaDeviceActivatorView *)activatorView {
    if (!_activatorView) {
        _activatorView = [[TuyaDeviceActivatorView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
        _activatorView.topBarView.leftItem.title = @"取消";
        _activatorView.topBarView.centerItem.title = @"热点模式";
        _activatorView.topBarDelegate = self;
        _activatorView.delegate = self;
        _activatorView.ssidTextFieldView.textField.userInteractionEnabled = NO;
        [_activatorView.ssidTextFieldView addGestureRecognizer:[TuyaViewUtils singleFingerClickRecognizer:self sel:@selector(selectSSID)]];
    }
    return _activatorView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT, APP_SCREEN_WIDTH, 160)];
        _pickerView.backgroundColor = self.view.backgroundColor;
        _pickerView.delegate = self;
        [self.view addSubview:_pickerView];
    }
    return _pickerView;
}

- (void)startConfig {
    [TuyaSmartActivator sharedInstance].delegate = self;
    [[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeAP ssid:self.activatorView.ssid password:self.activatorView.password timeout:100];
}

- (void)selectSSID {
    if (self.SSIDList.count > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pickerView.bottom = APP_SCREEN_HEIGHT;
        }];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];

    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.top = APP_SCREEN_HEIGHT;
    }];
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarCenterItemTap {
    
}

- (void)topBarRightItemTap {
    
}

#pragma mark - TuyaDeviceActivatorViewDelegate

- (void)deviceActivatorViewConfigButtonTap:(TuyaDeviceActivatorView *)deviceActivator {
    [self startConfig];
}

- (void)deviceActivatorView:(TuyaDeviceActivatorView *)deviceActivator showPassword:(BOOL)showPassword {
    
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.SSIDList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.SSIDList objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.activatorView.ssidTextFieldView.text = [self.SSIDList objectAtIndex:row];
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
