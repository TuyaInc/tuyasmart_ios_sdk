//
//  AppDelegate.h
//  TuyaSmart
//
//  Created by fengyu on 15/2/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)signOut;
- (void)resetRootViewController:(Class)rootController;

@end

