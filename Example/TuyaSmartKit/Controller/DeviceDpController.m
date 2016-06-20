//
//  DeviceDpController.m
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/16.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "DeviceDpController.h"
#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>

#define DeviceDpCellViewIdentifier @"DeviceDpCellViewIdentifier"

@interface DeviceDpController ()<TuyaTopBarViewDelegate,TuyaPanelCellViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TuyaSmartDevice *smartDevice;
@property (nonatomic, strong) TuyaDeviceDpView *deviceDpView;
@property (nonatomic, strong) NSMutableArray *rangeValues;
@property (nonatomic, assign) NSUInteger selectedRow;

@end

@implementation DeviceDpController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self initView];
}

- (void)initData {
    _rangeValues = [[NSMutableArray alloc] init];
    
    if ([_schema.property.type isEqualToString:@"bool"]) {
        [_rangeValues addObjectsFromArray:@[@NO,@YES]];
    } else if (_schema.property.range != nil) {
        for (id value in _schema.property.range) {
            [_rangeValues addObject:[NSString stringWithFormat:@"%@",value]];
        }
    } else {
        double min = _schema.property.min;
        double max = _schema.property.max;
        double step = _schema.property.step ? _schema.property.step : 1;
        for (double i = min; i <= max; i=i+step) {
            [_rangeValues addObject:[NSString stringWithFormat:@"%.0f",i]];
        }
    }
}

- (void)initView {
    self.view = self.deviceDpView;
    [self selectRow:_dpValue];
}

- (void)selectRow:(id)dpValue {
    NSUInteger index = [_rangeValues indexOfObject:dpValue];
    _selectedRow = index;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:0];
    [_deviceDpView.dpTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (TuyaDeviceDpView *)deviceDpView {
    if (!_deviceDpView) {
        
        _deviceDpView = [[TuyaDeviceDpView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
        
        _deviceDpView.topBarDelegate = self;
        _deviceDpView.topBarView.leftItem.title = NSLocalizedString(@"action_back", @"");
        _deviceDpView.topBarView.centerItem.title = _schema.name;
        
        _deviceDpView.dpTableView.delegate = self;
        _deviceDpView.dpTableView.dataSource = self;
        [_deviceDpView.dpTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DeviceDpCellViewIdentifier];
    }
    return _deviceDpView;
}

- (TuyaSmartDevice *)smartDevice {
    if (!_smartDevice) {
        _smartDevice = [TuyaSmartDevice deviceWithDeviceId:self.devId];
    }
    return _smartDevice;
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarCenterItemTap {
    
}

- (void)topBarRightItemTap {
    
}

#pragma mark - TuyaPanelCellViewDelegate

- (void)panelCellViewTap:(TuyaPanelCellView *)panelCellView {

}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rangeValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *dpCellView = [tableView dequeueReusableCellWithIdentifier:DeviceDpCellViewIdentifier forIndexPath:indexPath];
    
    NSString *value = [_rangeValues objectAtIndex:indexPath.row];
    dpCellView.textLabel.text = [NSString stringWithFormat:@"%@", value];
    
    return dpCellView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSDictionary *dps = @{_schema.dpId : [_rangeValues objectAtIndex:indexPath.row]};
        
        WEAKSELF_TY
        [weakSelf_TY showProgress];
        [self.smartDevice publishDps:dps success:^{
            [weakSelf_TY hideProgress];
        } failure:^(NSError *error) {
            [weakSelf_TY showProgress:[NSString stringWithFormat:@"操作失败:%@", error.localizedDescription] hideDelay:3];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }];
}

@end
