//
//  AppDelegate.h
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/12.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)resetRootViewController:(Class)rootController;

@end

