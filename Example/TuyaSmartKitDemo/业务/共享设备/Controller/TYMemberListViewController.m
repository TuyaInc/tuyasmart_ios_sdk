//
//  TYMemberListViewController.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListViewController.h"
#import "TYMemberListDataSource.h"
#import "TYMemberListDelegate.h"
#import "TYMemberListLayout.h"
#import "TYMemberListDS.h"

@interface TYMemberListViewController ()

@property (nonatomic, strong) TYMemberListDataSource *dataSource;
@property (nonatomic, strong) TYMemberListDelegate   *delegate;
@property (nonatomic, strong) TYMemberListLayout     *layout;
@property (nonatomic, strong) TYMemberListDS         *ds;

@end

@implementation TYMemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    self.view = self.layout;
    
    if (_type > 0) {
        [self.layout setCurrentSelectIndex:_type];
    }
    
    [self reloadData];
    
    WEAKSELF_AT
    [self.layout.memberListView.tableView addPullToRefreshWithActionHandler:^{
        __strong TYMemberListViewController *strongSelf = weakSelf_AT;
        
        [NSString bk_performBlock:^{
            
            if (strongSelf) {
                if (strongSelf.layout.memberListView.currentIndex == 0) {
                    [strongSelf getMemberList];
                } else {
                    [strongSelf getReceiveMemberList];
                }
            }
            
        } afterDelay:0.3];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData {
    
    [self getMemberList];
    
    [self getReceiveMemberList];
}

- (void)getMemberList {
    WEAKSELF_AT
    [self.ds getMemberList:^(NSArray *List) {
        weakSelf_AT.dataSource.memberList = List;
        [weakSelf_AT.layout reloadData];
        [weakSelf_AT.layout.memberListView.tableView.pullToRefreshView stopAnimating];
    }];
}


- (void)getReceiveMemberList {
    WEAKSELF_AT
    [self.ds getReceiveMemberList:^(NSArray *List) {
        weakSelf_AT.dataSource.receiveMemberList = List;
        [weakSelf_AT.layout reloadData];
        [weakSelf_AT.layout.memberListView.tableView.pullToRefreshView stopAnimating];
    }];
}


#pragma mark - lazy load
- (TYMemberListDS *)ds {
    if (!_ds) {
        _ds = [TYMemberListDS new];
    }
    return _ds;
}

- (TYMemberListLayout *)layout {
    if (!_layout) {
        _layout = [[TYMemberListLayout alloc] initWithFrame:self.view.bounds];
        _layout.delegate = self.delegate;
        _layout.dataSource = self.dataSource;
    }
    return _layout;
}

- (TYMemberListDelegate *)delegate {
    if (!_delegate) {
        _delegate = [TYMemberListDelegate new];
    }
    return _delegate;
}

- (TYMemberListDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [TYMemberListDataSource new];
    }
    return _dataSource;
}
@end
