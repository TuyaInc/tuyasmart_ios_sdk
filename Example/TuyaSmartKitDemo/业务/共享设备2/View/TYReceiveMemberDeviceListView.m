//
//  TYReceiveMemberDeviceListView.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYReceiveMemberDeviceListView.h"
#import "TYReceiveMemberDeviceListCell.h"

@interface TYReceiveMemberDeviceListView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray     *deviceList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIView *tableHeaderView;


@end

@implementation TYReceiveMemberDeviceListView

- (instancetype)initWithFrame:(CGRect)frame deviceList:(NSArray *)deviceList {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _deviceList = deviceList;
     
        [self addSubview:self.tableHeaderView];
        [self addSubview:self.tableView];
    }
    return self;
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_CONTENT_WIDTH, 14 + 16)];
        _tableHeaderView.backgroundColor = [UIColor clearColor];
     
        
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(15, 0, APP_CONTENT_WIDTH - 30, 14 + 16) f:14 tc:HEXCOLOR(0xB0B0B0) t:NSLocalizedString(@"ty_add_share_receive_device", nil)];
        
        [_tableHeaderView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _tableHeaderView.height - 0.5, _tableHeaderView.width, 0.5)];
        line.backgroundColor = SEPARATOR_LINE_COLOR;
        [_tableHeaderView addSubview:line];
        
    }
    return _tableHeaderView;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.tableHeaderView.bottom , APP_SCREEN_WIDTH, self.height - self.tableHeaderView.bottom)
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TYReceiveMemberDeviceListCell class] forCellReuseIdentifier:@"MemberTableViewCell"];
    }
    return _tableView;
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYReceiveMemberDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberTableViewCell"];
    
    id model = [self.deviceList objectAtIndex:indexPath.row];
    
    [cell setModel:model];
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
