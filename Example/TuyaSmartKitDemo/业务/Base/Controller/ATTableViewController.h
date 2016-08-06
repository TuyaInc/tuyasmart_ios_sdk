//
//  ATTableViewController.h
//  Airtake
//
//  Created by fisher on 14/11/24.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "ATBaseViewController.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

@interface ATTableViewController : ATBaseViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView            *tableView;
@property (nonatomic, strong) NSMutableArray         *dataSource;

/**
 *  刷新数据
 */
- (void)reloadTable;


/**
 *  停止下拉刷新
 */
- (void)stopPullToRefreshAnimation;

/**
 *  停止上拉刷新
 */
- (void)stopInfiniteAnimation;
    
@end
