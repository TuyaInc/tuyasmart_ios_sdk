//
//  TuyaDeviceListView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/11.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TuyaLayoutView.h"
#import "TuyaEmptyView.h"

@interface TuyaDeviceListView : TuyaLayoutView

@property(nonatomic,strong) UITableView *deviceTableView;
@property(nonatomic,strong) TuyaEmptyView *emptyView;

@end
