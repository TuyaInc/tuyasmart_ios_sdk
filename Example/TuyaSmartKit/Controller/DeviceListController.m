//
//  DeviceListController.m
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/12.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "DeviceListController.h"
#import "SignInController.h"
#import "AppDelegate.h"
#import "ShareViewController.h"
#import "EZActivatorDeviceController.h"
#import "DevicePanelController.h"

#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>

#define DeviceViewCellIdentifier @"DeviceViewCellIdentifier"

@interface DeviceListController ()<UITableViewDelegate,UITableViewDataSource,TuyaDeviceCellViewViewDelegate,TuyaTopBarViewDelegate>

@property (nonatomic, strong) TuyaDeviceListView *deviceListView;
@property (nonatomic, strong) UIButton *addDeviceButton;

@property (nonatomic, strong) NSArray *deviceArray;

@end

@implementation DeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view = self.deviceListView;
    [self.view addSubview:self.addDeviceButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    
    WEAKSELF_TY
    [[TuyaSmartUser sharedInstance] syncDeviceWithCloud:^{
        weakSelf_TY.deviceArray = [TuyaSmartUser sharedInstance].deviceArray;
        [weakSelf_TY.deviceListView.deviceTableView reloadData];
        
        weakSelf_TY.deviceListView.emptyView.hidden = (weakSelf_TY.deviceArray.count > 0) ? YES : NO;
    } failure:^{
        ;
    }];
}

- (TuyaDeviceListView *)deviceListView {
    if (!_deviceListView) {
        _deviceListView = [[TuyaDeviceListView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - 49)];

        _deviceListView.topBarDelegate = self;
        TuyaBarButtonItem *leftItem = [[TuyaBarButtonItem alloc] initWithBarButtonSystemItem:ATBarButtonSystemItemLeftWithoutIcon title:@"共享"];
        leftItem.target = self;
        leftItem.action = @selector(topBarLeftItemTap);
        _deviceListView.topBarView.leftItem = leftItem;
        _deviceListView.topBarView.rightItem.title = NSLocalizedString(@"logout", @"");

        _deviceListView.deviceTableView.frame = CGRectMake(0, _deviceListView.topBarView.height, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT-_deviceListView.topBarView.height);
        _deviceListView.deviceTableView.delegate = self;
        _deviceListView.deviceTableView.dataSource = self;
        [_deviceListView.deviceTableView registerClass:[TuyaDeviceCellView class] forCellReuseIdentifier:DeviceViewCellIdentifier];
    }
    return _deviceListView;
}

- (UIButton *)addDeviceButton {
    if (!_addDeviceButton) {
        _addDeviceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT - 49, APP_SCREEN_WIDTH, 49)];
        _addDeviceButton.backgroundColor = [UIColor whiteColor];
        _addDeviceButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addDeviceButton setTitleColor:HEXCOLOR(0x708088) forState:UIControlStateNormal];
        [_addDeviceButton setTitle:NSLocalizedString(@"home_add_device", @"") forState:UIControlStateNormal];
        [_addDeviceButton addTarget:self action:@selector(addDeviceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addDeviceButton;
}

- (void)addDeviceAction {
    [self.navigationController pushViewController:[EZActivatorDeviceController new] animated:YES];
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController pushViewController:[ShareViewController new] animated:YES];
}

- (void)topBarRightItemTap {
    [self showProgress];
    
    WEAKSELF_TY
    [[TuyaSmartUser sharedInstance] loginOut:^{
        [weakSelf_TY hideProgress];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate resetRootViewController:[SignInController class]];
    } failure:^(NSError *error) {
        [weakSelf_TY hideProgress];
        [UIAlertView bk_showAlertViewWithTitle:error.localizedDescription message:nil cancelButtonTitle:NSLocalizedString(@"confirm", @"") otherButtonTitles:nil handler:nil];
    }];
}

- (void)topBarCenterItemTap {
    
}

#pragma mark - TuyaDeviceCellViewViewDelegate

- (void)deviceCellViewTap:(TuyaDeviceCellView *)deviceCellView {
    TuyaSmartDeviceModel *deviceModel = [[self deviceArray] objectAtIndex:deviceCellView.tag];
    DevicePanelController *panelController = [[DevicePanelController alloc] init];
    panelController.devId = deviceModel.devId;
    [self.navigationController pushViewController:panelController animated:YES];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TuyaDeviceCellView *deviceCellView = [tableView dequeueReusableCellWithIdentifier:DeviceViewCellIdentifier forIndexPath:indexPath];
    deviceCellView.delegate = self;
    deviceCellView.tag = indexPath.row;
    
    TuyaSmartDeviceModel *deviceModel = [self.deviceArray objectAtIndex:indexPath.row];
    
    if (deviceModel.isOnline) {
        if (deviceModel.isShare) {
            [deviceCellView setDeviceStatus:TuyaDeviceStatusShareOnline];
        } else {
            [deviceCellView setDeviceStatus:TuyaDeviceStatusOnline];
        }
    } else {
        if (deviceModel.isShare) {
            [deviceCellView setDeviceStatus:TuyaDeviceStatusShareOffline];
        } else {
            [deviceCellView setDeviceStatus:TuyaDeviceStatusOffline];
        }
    }
    
//    [deviceCellView setDeviceIcon:deviceModel.iconImage];
    [deviceCellView setDeviceName:deviceModel.name];
    [deviceCellView setIsLastCell:(indexPath.row == self.deviceArray.count - 1)];
    
    return deviceCellView;
}

@end
