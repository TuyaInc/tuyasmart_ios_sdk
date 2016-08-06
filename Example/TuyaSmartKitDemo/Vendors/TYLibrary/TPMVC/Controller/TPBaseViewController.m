//
//  TYBaseViewController.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/4.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPBaseViewController.h"
#import "UIViewController+TPCategory.h"

@implementation TPBaseViewController


#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    //iOS 7 offsets your scroll view 64px (20px for the status bar and 44px for the navigation bar) by default, you can disable this though:
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - rotate
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
