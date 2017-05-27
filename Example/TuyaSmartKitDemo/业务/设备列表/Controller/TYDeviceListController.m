//
//  TYDeviceListController.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYDeviceListController.h"
#import "TYDeviceListViewCell.h"
#import "TYCommonPanelViewController.h"
#import "TYSwitchPanelViewController.h"

#define DeviceListCellViewIdentifier    @"DeviceListCellViewIdentifier"

@interface TYDeviceListController()

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) TPEmptyView      *emptyView;

@property (nonatomic, strong) TuyaSmartRequest *request;

@end

@implementation TYDeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self reloadDataFromCloud];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadData];
}

- (void)initView {
    self.centerTitleItem.title = NSLocalizedString(@"my_smart_home", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    [self.view addSubview:self.topBarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadDataFromCloud) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.emptyView = [[TPEmptyView alloc] initWithFrame:self.tableView.bounds title:NSLocalizedString(@"no_device", @"") imageName:@"ty_list_empty"];
    UIButton *button = [TPViewUtil buttonWithFrame:CGRectMake(APP_SCREEN_WIDTH / 2 - 100, self.emptyView.titleLabel.bottom + 20, 200, 44) fontSize:16 bgColor:[UIColor whiteColor] textColor:LIST_MAIN_TEXT_COLOR borderColor:LIST_LINE_COLOR];
    [button setTitle:NSLocalizedString(@"Add Test Device", @"") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getTestDevice) forControlEvents:UIControlEventTouchUpInside];
    [self.emptyView addSubview:button];
    [self.tableView addSubview:self.emptyView];
    
}

- (void)reloadDataFromCloud {
    WEAKSELF_AT
    [self.refreshControl beginRefreshing];
    [[TuyaSmartUser sharedInstance] syncDeviceWithCloud:^{
        [weakSelf_AT reloadData];
    } failure:^(NSError *error) {
        [weakSelf_AT.refreshControl endRefreshing];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (void)reloadData {
    [self.refreshControl endRefreshing];
    self.emptyView.hidden = [[TuyaSmartUser sharedInstance].deviceArray count] != 0;
    [self.tableView reloadData];
}

//添加一个特定的虚拟演示设备
- (void)getTestDevice {

#warning 绑定演示设备到账号下面，生产环境勿使用
    
    [self showProgressView:NSLocalizedString(@"loading", @"")];
    WEAKSELF_AT
    [self.request requestWithApiName:@"s.m.dev.sdk.demo.list" postData:nil version:@"1.0" success:^(id result) {
        [weakSelf_AT hideProgressView];
        [weakSelf_AT reloadDataFromCloud];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

- (TuyaSmartRequest *)request {
    if (!_request) {
        _request = [TuyaSmartRequest new];
    }
    return _request;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [TuyaSmartUser sharedInstance].deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TYDeviceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeviceListCellViewIdentifier];
    if (!cell) {
        cell = [[TYDeviceListViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DeviceListCellViewIdentifier];
    }
    
    TuyaSmartDeviceModel *deviceModel = [[TuyaSmartUser sharedInstance].deviceArray objectAtIndex:indexPath.row];
    [cell setItem:deviceModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    TuyaSmartDeviceModel *deviceModel = [[TuyaSmartUser sharedInstance].deviceArray objectAtIndex:indexPath.row];
    
    
    //演示设备produckId
    if ([deviceModel.productId isEqualToString:@"4eAeY1i5sUPJ8m8d"]) {
        
        TYSwitchPanelViewController *vc = [[TYSwitchPanelViewController alloc] init];
        vc.devId = deviceModel.devId;
        [ViewControllerUtils pushViewController:vc from:self];

    } else {
        
        TYCommonPanelViewController *vc = [[TYCommonPanelViewController alloc] init];
        vc.devId = deviceModel.devId;
        [ViewControllerUtils pushViewController:vc from:self];
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
