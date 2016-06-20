//
//  DevicePanelController.m
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>
#import "DevicePanelController.h"
#import "DeviceDpController.h"

#define DevicePanelCellViewIdentifier @"DevicePanelCellViewIdentifier"

@interface DevicePanelController ()<TuyaTopBarViewDelegate, TuyaPanelCellViewDelegate, UITableViewDataSource, UITableViewDelegate, TuyaSmartDeviceDelegate>

@property (nonatomic, strong) TuyaDevicePanelView *panelView;
@property (nonatomic, strong) TuyaSmartDevice *smartDevice;

@end

@implementation DevicePanelController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self initView];
}

- (void)initView {
    self.view = self.panelView;
}

- (void)initData {
    _smartDevice = [TuyaSmartDevice deviceWithDeviceId:self.devId];
    _smartDevice.delegate = self;
    
    WEAKSELF_TY
    [_smartDevice syncWithCloud:^{
        NSLog(@"dps:%@",weakSelf_TY.smartDevice.deviceModel.dps);
        [weakSelf_TY.panelView.panelTableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (TuyaDevicePanelView *)panelView {
    if (!_panelView) {
        _panelView = [[TuyaDevicePanelView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
        
        _panelView.topBarDelegate = self;
        _panelView.topBarView.leftItem.title = NSLocalizedString(@"action_back", @"");
        _panelView.topBarView.centerItem.title = _smartDevice.deviceModel.name;
        _panelView.topBarView.rightItem.title = NSLocalizedString(@"移除设备", @"");

        _panelView.panelTableView.delegate = self;
        _panelView.panelTableView.dataSource = self;
        [_panelView.panelTableView registerClass:[TuyaPanelCellView class] forCellReuseIdentifier:DevicePanelCellViewIdentifier];
    }
    return _panelView;
}

- (NSDictionary *)dps {
    return _smartDevice.deviceModel.dps;
}

- (NSArray *)schemaArray {
    return _smartDevice.deviceModel.schemaArray;
}

- (id)dpValueForDpId:(NSString *)dpId {
    id value = [[self dps] objectForKey:dpId];
    return value ? value : @"";
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarCenterItemTap {
    
}

- (void)topBarRightItemTap {
    WEAKSELF_TY
    [UIAlertView bk_showAlertViewWithTitle:@"确认移除设备?" message:nil cancelButtonTitle:NSLocalizedString(@"cancel", @"") otherButtonTitles:@[NSLocalizedString(@"confirm", @"")] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [weakSelf_TY.smartDevice remove:^{
                [weakSelf_TY.navigationController popViewControllerAnimated:YES];
            } failure:nil];
        }
    }];
}

#pragma mark - TuyaPanelCellViewDelegate

- (void)panelCellViewTap:(TuyaPanelCellView *)panelCellView {
    NSLog(@"panelCellViewTap");
    
    TuyaSmartSchemaModel *schema = [[self schemaArray] objectAtIndex:panelCellView.tag];
    DeviceDpController *dpController = [[DeviceDpController alloc] init];
    dpController.devId   = self.devId;
    dpController.dpValue = [self dpValueForDpId:schema.dpId];
    dpController.schema  = schema;
    [self.navigationController pushViewController:dpController animated:YES];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self schemaArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TuyaPanelCellView *panelCellView = [tableView dequeueReusableCellWithIdentifier:DevicePanelCellViewIdentifier forIndexPath:indexPath];
    panelCellView.delegate = self;
    panelCellView.tag = indexPath.row;
    
    TuyaSmartSchemaModel *schemaModel = [[self schemaArray] objectAtIndex:indexPath.row];

    
    NSString *dpValue = [NSString stringWithFormat:@"%@ %@",[self dpValueForDpId:schemaModel.dpId],(schemaModel.property.unit ? schemaModel.property.unit : @"")];
    
    NSLog(@"%@,%@",schemaModel.name,dpValue);
    
    panelCellView.nameLabel.text = schemaModel.name;
    panelCellView.valueLabel.text = dpValue;
    
    return panelCellView;
}

#pragma mark - TuyaSmartDeviceDelegate

/// 设备数据更新
- (void)deviceInfoUpdate {
    NSLog(@"deviceInfoUpdate");
    [self.panelView.panelTableView reloadData];
}

/// 设备被移除
- (void)deviceRemoved {
    NSLog(@"deviceRemoved");
}

/// dp数据更新
- (void)deviceDpsUpdate:(NSDictionary *)dps {
    NSLog(@"deviceDpsUpdate: %@", dps);
    [self.panelView.panelTableView reloadData];
}

/// 固件升级成功
- (void)deviceFirmwareUpgradeSuccess {
    NSLog(@"deviceFirmwareUpgradeSuccess");
}

/// 固件升级失败
- (void)deviceFirmwareUpgradeFailure {
    NSLog(@"deviceFirmwareUpgradeFailure");
}

@end
