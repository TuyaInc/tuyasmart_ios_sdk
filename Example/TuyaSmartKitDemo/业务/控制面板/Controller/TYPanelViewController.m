//
//  TYPanelViewController.m
//  TuyaSmartPublic
//
//  Created by 高森 on 16/7/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYPanelViewController.h"
#import "TYPanelDPViewController.h"
#import "ViewControllerUtils.h"

#define DevicePanelCellViewIdentifier   @"DevicePanelCellViewIdentifier"

@interface TYPanelViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TuyaSmartDevice *device;
@property (nonatomic, strong) UITableView     *tableView;

@end

@implementation TYPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self reloadData];
}

- (void)initView {
    
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    self.rightTitleItem.title = NSLocalizedString(@"action_more", @"");
    self.topBarView.rightItem = self.rightTitleItem;
    [self.view addSubview:self.topBarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH,APP_VISIBLE_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)reloadData {
    self.centerTitleItem.title = self.device.deviceModel.name;
    self.topBarView.centerItem = self.centerTitleItem;
    [self.tableView reloadData];
}

- (TuyaSmartDevice *)device {
    if (!_device) {
        _device = [TuyaSmartDevice deviceWithDeviceId:self.devId];
        _device.delegate = self;
    }
    return _device;
}

#pragma mark - menu

- (void)rightBtnAction {
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:NSLocalizedString(@"action_more", @"")];
    
    WEAKSELF_AT
    
    //修改设备名称
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"rename_device", @"") handler:^{
        [weakSelf_AT updateName];
    }];
    
//    //检查固件升级
//    [sheet bk_addButtonWithTitle:NSLocalizedString(@"check_firmware_update", @"") handler:^{
//        
//    }];
//    
//    //恢复出厂设置
//    [sheet bk_addButtonWithTitle:NSLocalizedString(@"ty_control_panel_factory_reset", @"") handler:^{
//        
//    }];
    
    //移除设备
    [sheet bk_addButtonWithTitle:NSLocalizedString(@"cancel_connect", @"") handler:^{
        [weakSelf_AT removeDevice];
    }];
    
    [sheet bk_setCancelButtonWithTitle:NSLocalizedString(@"action_cancel", @"") handler:nil];
    [sheet showInView:self.view];
}

- (void)updateName {
    
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:NSLocalizedString(@"rename_device", @"")];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.text = self.device.deviceModel.name;
    WEAKSELF_AT
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"confirm", @"") handler:^{
        [weakSelf_AT.device updateName:textField.text success:^{
            ;
        } failure:^(NSError *error) {
            [TPProgressUtils showError:error.localizedDescription];
        }];
    }];
    
    [alertView bk_setCancelButtonWithTitle:NSLocalizedString(@"action_cancel", @"") handler:nil];
    
    [alertView show];

}

- (void)removeDevice {
    
    WEAKSELF_AT
    [UIAlertView bk_showAlertViewWithTitle:NSLocalizedString(@"cancel_connect", @"") message:NSLocalizedString(@"device_confirm_remove", @"") cancelButtonTitle:NSLocalizedString(@"action_cancel", @"") otherButtonTitles:@[NSLocalizedString(@"confirm", @"")] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [weakSelf_AT.device remove:^{
                [TPProgressUtils showError:NSLocalizedString(@"device_has_unbinded", @"")];
            } failure:^(NSError *error) {
                [TPProgressUtils showError:error.localizedDescription];
            }];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.device.deviceModel.schemaArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Data point list", @"");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DevicePanelCellViewIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DevicePanelCellViewIdentifier];
    }
    
    TuyaSmartSchemaModel *schemaModel = [self.device.deviceModel.schemaArray objectAtIndex:indexPath.row];
    
    
    //DP 读写属性:
    //1 rw:可读写
    //2 wr:只写
    //3 ro:只读
    if ([schemaModel.mode rangeOfString:@"w"].location == NSNotFound) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    id dpValue = [self.device.deviceModel.dps objectForKey:schemaModel.dpId] ?: @"";
    NSString *value = [NSString stringWithFormat:@"%@ %@", dpValue, (schemaModel.property.unit ?: @"")];
    
    cell.textLabel.text = schemaModel.name;
    cell.detailTextLabel.text = value;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TuyaSmartSchemaModel *schemaModel = [self.device.deviceModel.schemaArray objectAtIndex:indexPath.row];
    if ([schemaModel.mode rangeOfString:@"w"].location == NSNotFound) {
        return;
    }
    
    TYPanelDPViewController *vc = [[TYPanelDPViewController alloc] init];
    vc.devId = self.devId;
    vc.schemaModel = schemaModel;
    [ViewControllerUtils pushViewController:vc from:self];
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)deviceInfoUpdate {
    NSLog(@"deviceInfoUpdate");
    [self reloadData];
}

- (void)deviceRemoved {
    NSLog(@"deviceRemoved");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deviceDpsUpdate:(NSDictionary *)dps {
    NSLog(@"deviceDpsUpdate: %@", dps);
    [self reloadData];
}

- (void)deviceFirmwareUpgradeSuccess {
    NSLog(@"deviceFirmwareUpgradeSuccess");
}

- (void)deviceFirmwareUpgradeFailure {
    NSLog(@"deviceFirmwareUpgradeFailure");
}

@end
