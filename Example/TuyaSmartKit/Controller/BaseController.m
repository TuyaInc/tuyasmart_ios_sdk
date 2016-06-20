//
//  BaseController.m
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/16.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "BaseController.h"
#import "MBProgressHUD.h"

@interface BaseController ()

@end

@implementation BaseController


- (void)showProgress {
    [self showProgress:@"" hideDelay:0];
}

- (void)showProgress:(NSString *)message {
    [self showProgress:message hideDelay:0];
}

- (void)showProgress:(NSString *)message hideDelay:(NSTimeInterval)hideDelay {
    
    UIView *view = [UIApplication sharedApplication].keyWindow;
    
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    if (hideDelay > 0) {
        [hud hide:YES afterDelay:1.5];
    }
}

- (void)hideProgress {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
