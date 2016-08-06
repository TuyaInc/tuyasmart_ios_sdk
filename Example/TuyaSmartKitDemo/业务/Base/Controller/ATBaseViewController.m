//
//  ATBaseViewController.m
//  AirTake
//
//  Created by lvzhiqing on 14-4-15.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "ATBaseViewController.h"

@implementation ATBaseViewController

@synthesize topBarView           = _topBarView;
@synthesize leftBackItem         = _leftBackItem;
@synthesize centerTitleItem      = _centerTitleItem;
@synthesize centerLogoItem       = _centerLogoItem;


- (void)dealloc {
    NSLog(@"%@ is dealloc",NSStringFromClass(self.class));
    [self cancelService];
}

- (void)cancelService {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithQuery:(NSDictionary *)query {
    if (self = [super init]) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (NSString *)pageName {
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_loadAtFirstTime) {
        _loadAtFirstTime = YES;
        [self viewDidAppearAtFirstTime:animated];
    }
}

- (void)viewDidAppearAtFirstTime:(BOOL)animated {}


- (void)viewDidLoad {
    [self.navigationController.navigationBar setHidden:YES];
    
    //iOS 7 offsets your scroll view 64px (20px for the status bar and 44px for the navigation bar) by default, you can disable this though:
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [super viewDidLoad];
}

- (void)showProgressView {
    [TPProgressUtils showMessag:nil toView:nil];
}

- (void)showProgressView:(NSString *)message {
    [TPProgressUtils showMessag:message toView:nil];
}

- (void)hideProgressView {
    [TPProgressUtils hideHUDForView:nil animated:NO];
}

- (TPTopBarView *)topBarView {
    if (!_topBarView) {
        _topBarView = [TPTopBarView new];
        _topBarView.bottomLineHidden = NO;
    }
    return _topBarView;
}

- (TPBarButtonItem *)rightTitleItem {
    if (!_rightTitleItem) {
        _rightTitleItem = [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemRight title:NSLocalizedString(@"done", @"") target:self action:@selector(rightBtnAction)];

    }
    return _rightTitleItem;
}

- (TPBarButtonItem *)leftBackItem {
    if (!_leftBackItem) {
        _leftBackItem = [[TPBarButtonItem alloc ] initWithBarButtonSystemItem:TPBarButtonSystemItemLeftWithIcon title:NSLocalizedString(@"action_back", @"") target:self action:@selector(backButtonTap)];
    }
    return _leftBackItem;
}


- (TPBarButtonItem *)leftCancelItem {
    if (!_leftBackItem) {
        _leftBackItem = [[TPBarButtonItem alloc ] initWithBarButtonSystemItem:TPBarButtonSystemItemLeftWithoutIcon title:NSLocalizedString(@"cancel", @"") target:self action:@selector(CancelButtonTap)];
    }
    return _leftBackItem;
}


- (TPBarButtonItem *)rightCancelItem {
    if (!_rightCancelItem) {
        _rightCancelItem = [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemRight title:NSLocalizedString(@"close", nil) target:self action:@selector(CancelButtonTap)];
    }
    return _rightCancelItem;
}

- (TPBarButtonItem *)centerTitleItem {
    if (!_centerTitleItem) {
        _centerTitleItem = [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemCenter title:@"Title"];
    }
    return _centerTitleItem;
}

- (TPBarButtonItem *)centerLogoItem {
    if (!_centerLogoItem) {
        _centerLogoItem = [[TPBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logo"] highlightedImage:[UIImage imageNamed:@"logo"] selectedImage:[UIImage imageNamed:@"logo"] disabledImage:[UIImage imageNamed:@"logo"] backgroundImage:nil target:nil action:nil];
    }
    return _centerLogoItem;
}

- (TPLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[TPLoadingView alloc] initWithFrame:CGRectZero];
    }
    return _loadingView;
}

- (void)showLoadingView {
    [self.view addSubview:self.loadingView];
    self.loadingView.centerX = self.view.centerX;
    self.loadingView.centerY = self.view.centerY;
}


- (void)hideLoadingView {
    if (_loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
}


- (void)backButtonTap {
    [tp_topMostViewController().navigationController popViewControllerAnimated:YES];
}

- (void)CancelButtonTap {
    [self tp_dismissModalViewController];
}

- (void)rightBtnAction {

}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
