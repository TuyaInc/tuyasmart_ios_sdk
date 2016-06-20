//
//  BaseController.h
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/16.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

- (void)showProgress;
- (void)showProgress:(NSString *)message;
- (void)showProgress:(NSString *)message hideDelay:(NSTimeInterval)hideDelay;
- (void)hideProgress;

@end
