//
//  ATBaseViewController.h
//  AirTake
//
//  Created by lvzhiqing on 14-4-15.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPLoadingView.h"
#import "TPTopBarView.h"

@interface ATBaseViewController : UIViewController

@property (nonatomic, strong) TPTopBarView    *topBarView;
@property (nonatomic, strong) TPBarButtonItem *rightTitleItem;
@property (nonatomic, strong) TPBarButtonItem *leftBackItem;
@property (nonatomic, strong) TPBarButtonItem *leftCancelItem;
@property (nonatomic, strong) TPBarButtonItem *rightCancelItem;
@property (nonatomic, strong) TPBarButtonItem *centerTitleItem;
@property (nonatomic, strong) TPBarButtonItem *centerLogoItem;
@property (nonatomic, strong) NSDictionary    *query;
@property (nonatomic, assign) BOOL            loadAtFirstTime;

@property (nonatomic, strong) TPLoadingView   *loadingView;



- (instancetype)initWithQuery:(NSDictionary *)query;

- (void)viewDidAppearAtFirstTime:(BOOL)animated;



- (void)backButtonTap;

- (void)CancelButtonTap;

- (void)cancelService;

#pragma mark - 小菊花 加载中

- (void)showLoadingView;

- (void)hideLoadingView;

#pragma mark - 黑色的大菊花
- (void)showProgressView;

- (void)showProgressView:(NSString *)message;

- (void)hideProgressView;
@end

