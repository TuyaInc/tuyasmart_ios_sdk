//
//  TYActivatorFinishViewController.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/3/29.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYActivatorFinishViewController.h"
#import "TYSearchDeviceFinishView.h"
#import "TYSearchDeviceFinishDelegate.h"

@interface TYActivatorFinishViewController ()

@property (nonatomic, strong) TYSearchDeviceFinishView     *finishView;
@property (nonatomic, strong) TYSearchDeviceFinishDelegate *delegate;

@end

@implementation TYActivatorFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(TPNavigationController *)self.navigationController disablePopGesture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [(TPNavigationController *)self.navigationController enablePopGesture];
}

- (void)initView {
    [self initTopBarView];
    
    _finishView = [[TYSearchDeviceFinishView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, APP_VISIBLE_HEIGHT) state:_state device:_deviceModel];
    _finishView.delegate = self.delegate;
    [self.view addSubview:_finishView];
}

- (void)initTopBarView {
    self.topBarView.leftItem = self.leftCancelItem;
    self.centerTitleItem.title = (_state == TYActivatorStateOK) ? NSLocalizedString(@"ty_ez_connecting_device_title", @"") : NSLocalizedString(@"ty_ap_error_title", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.rightItem = nil;
    
    [self.view addSubview:self.topBarView];
}

- (TYSearchDeviceFinishDelegate *)delegate {
    if (!_delegate) {
        _delegate = [TYSearchDeviceFinishDelegate new];
    }
    return _delegate;
}

@end
