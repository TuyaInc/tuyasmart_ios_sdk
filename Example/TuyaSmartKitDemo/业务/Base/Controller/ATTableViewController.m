//
//  ATTableViewController.m
//  Airtake
//
//  Created by fisher on 14/11/24.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "ATTableViewController.h"


@interface ATTableViewController()

@end

@implementation ATTableViewController


/**
 *  子类先实现自己的，再[super viewDidLoad];
 */
- (void)viewDidLoad {

    [super viewDidLoad];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        WEAKSELF_AT
        if ([self showPullToRefresh]) {
            [_tableView addPullToRefreshWithActionHandler:^{
                __strong ATTableViewController *strongSelf = weakSelf_AT;
                int64_t delayInSeconds = 0.3;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [strongSelf reload];
                });
            }];
        }
        
        
        if ([self showInfinite]) {
            // setup infinite scrolling
            [_tableView addInfiniteScrollingWithActionHandler:^{
                __strong ATTableViewController *strongSelf = weakSelf_AT;
                int64_t delayInSeconds = 0.3;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [strongSelf loadMore];
                });
            }];
        }
        
        
    }
    return _tableView;
}

- (void)stopPullToRefreshAnimation {
    [self.tableView.pullToRefreshView stopAnimating];
}


- (void)stopInfiniteAnimation {
    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)reloadTable {
    [self.tableView reloadData];
}

#pragma mark - 子类继承
//是否显示下拉刷新
- (BOOL)showPullToRefresh {
    return YES;
}
//是否显示上拉刷新
- (BOOL)showInfinite {
    return YES;
}

- (void)reload {
}

- (void)loadMore {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end

