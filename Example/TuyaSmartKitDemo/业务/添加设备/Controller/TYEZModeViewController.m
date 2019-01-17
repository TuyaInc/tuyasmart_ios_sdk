//
//  TYEZModeViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/2.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYEZModeViewController.h"
#import "TYEZAddDeviceView.h"
#import <Reachability/Reachability.h>

@interface TYEZModeViewController ()

@property(nonatomic,strong) TYEZAddDeviceView *addDeviceView;

@end

@implementation TYEZModeViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    [self initDefaultNetworkSetting];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self initTopBarView];
    [self initAddDeviceView];
}

- (void)initTopBarView {
    self.topBarView.leftItem = self.leftBackItem;
    
    self.centerTitleItem.title = NSLocalizedString(@"ty_ez_wifi_title", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    
    self.topBarView.rightItem = nil;
    
    [self.view addSubview:self.topBarView];
}

- (void)initAddDeviceView {
    _addDeviceView = [[TYEZAddDeviceView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_VISIBLE_HEIGHT)];
    [_addDeviceView.ssidView addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(gotoSystemSetting)]];
    [_addDeviceView.nextButton addTarget:self action:@selector(nextButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addDeviceView];
}

- (void)gotoSystemSetting {
    [[UIApplication sharedApplication] openURL:[self prefsUrlWithQuery:@{@"root": @"WIFI"}]];
}

- (NSURL *)prefsUrlWithQuery:(NSDictionary *)query {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:@"QXBwLVByZWZz" options:0];
    NSString *scheme = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableString *url = [NSMutableString stringWithString:scheme];
    for (int i = 0; i < query.allKeys.count; i ++) {
        NSString *key = [query.allKeys objectAtIndex:i];
        NSString *value = [query valueForKey:key];
        [url appendFormat:@"%@%@=%@", (i == 0 ? @":" : @"?"), key, value];
    }
    return [NSURL URLWithString:url];
}

- (void)initDefaultNetworkSetting {
    _addDeviceView.ssid = [TuyaSmartActivator currentWifiSSID];
}

- (void)nextButtonTap:(UIButton *)button {
    NSString *ssid     = [TuyaSmartActivator currentWifiSSID];
    
    if (ssid.length == 0) {
        [TPProgressUtils showError:NSLocalizedString(@"connect_phone_to_network", nil)];
        return;
    }
    
    if (![TPUtils IsEnableInternet]) {
        [TPProgressUtils showError:NSLocalizedString(@"network_time_out", nil)];
        return;
    }
    
    if (_mode == TYActivatorModeEZ && [ssid hasSuffix:@"5G"]) {
        WEAKSELF_AT
        [UIAlertView bk_showAlertViewWithTitle:nil
                                       message:NSLocalizedString(@"ez_notSupport_5G_tip", nil)
                             cancelButtonTitle:NSLocalizedString(@"ez_notSupport_5G_continue", nil)
                             otherButtonTitles:@[NSLocalizedString(@"ez_notSupport_5G_change", nil)]
                                       handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                 
                                         if (buttonIndex == 0) {
                                             [weakSelf_AT gotoActivatorViewController];
                                         } else {
                                             [weakSelf_AT gotoSystemSetting];
                                         }
                             }];
        
    } else {
         [self gotoActivatorViewController];
    }
    
}

- (void)gotoActivatorViewController {
    
    WEAKSELF_AT
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:nil];
    [[TuyaSmartActivator sharedInstance] getToken:^(NSString *token) {
        [TPProgressUtils hideHUDForView:nil animated:NO];

        NSString *ssid = [TuyaSmartActivator currentWifiSSID];
        NSString *password = weakSelf_AT.addDeviceView.password;
        
        if (_mode == TYActivatorModeEZ) {
            [ViewControllerUtils gotoActivatorViewController:weakSelf_AT ssid:ssid password:password token:token mode:weakSelf_AT.mode];
        } else {
            [ViewControllerUtils gotoContectToAPViewController:weakSelf_AT ssid:ssid password:password token:token];
        }
    } failure:^(NSError *error) {
        [TPProgressUtils hideHUDForView:nil animated:NO];
        [TPProgressUtils showError:error.localizedDescription];
    }];
    

}

- (void)reachabilityChanged:(NSNotification *)notification {
    [self initDefaultNetworkSetting];
}

@end
