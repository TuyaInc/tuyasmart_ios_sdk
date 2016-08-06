//
//  TYPanelDPViewController.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/7/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelDPViewController.h"

#define DevicePanelDPCellViewIdentifier   @"DevicePanelDPCellViewIdentifier"

@interface TYPanelDPViewController() <TuyaSmartDeviceDelegate>

@property (nonatomic, strong) TuyaSmartDevice *device;
@property (nonatomic, strong) NSMutableArray *rangeValues;

@end

@implementation TYPanelDPViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initData];
}

- (void)initData {

    _rangeValues = [NSMutableArray array];
    if ([_schemaModel.property.type isEqualToString:@"bool"]) {
        [_rangeValues addObjectsFromArray:@[@NO,@YES]];
    } else if (_schemaModel.property.range != nil) {
        for (id value in _schemaModel.property.range) {
            [_rangeValues addObject:value];
        }
    } else {
        double min = _schemaModel.property.min;
        double max = _schemaModel.property.max;
        double step = _schemaModel.property.step ?: 1;
        for (double i = min; i <= max; i += step) {
            [_rangeValues addObject:@(i)];
        }
    }
    
    [self.tableView reloadData];
    
    [self deviceDpsUpdate:self.device.deviceModel.dps];
    
}

- (void)initView {
    self.centerTitleItem.title = self.schemaModel.name;
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    [self.view addSubview:self.topBarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH,APP_VISIBLE_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (TuyaSmartDevice *)device {
    if (!_device) {
        _device = [TuyaSmartDevice deviceWithDeviceId:self.devId];
        _device.delegate = self;
    }
    return _device;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rangeValues.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Data point publish", @"");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DevicePanelDPCellViewIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DevicePanelDPCellViewIdentifier];
    }
    
    id value = [_rangeValues objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", value, (_schemaModel.property.unit ?: @"")];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id value = [_rangeValues objectAtIndex:indexPath.row];
    NSDictionary *dps = @{_schemaModel.dpId: value};
    
    [TPProgressUtils showMessag:NSLocalizedString(@"loading", @"") toView:self.view];
    
    WEAKSELF_AT
    [self.device publishDps:dps success:^{
        [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        NSLog(@"publishDps success");
    } failure:^(NSError *error) {
        [TPProgressUtils hideHUDForView:weakSelf_AT.view animated:NO];
        [TPProgressUtils showError:error.localizedDescription];
        NSLog(@"publishDps failure: %@", error.localizedDescription);
    }];
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)deviceDpsUpdate:(NSDictionary *)dps {
    
    id value = [dps objectForKey:_schemaModel.dpId];
    if (value) {
        NSUInteger index = [_rangeValues indexOfObject:value];
        if (index < _rangeValues.count) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

@end
