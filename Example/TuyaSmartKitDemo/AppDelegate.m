//
//  AppDelegate.m
//  TuyaSmart
//
//  Created by fengyu on 15/2/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "AppDelegate.h"
#import "TPSignInViewController.h"
#import "TabBarViewController.h"
#import "TYAppService.h"
#import "TPNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if DEBUG
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#endif
    
    //TODO: 修改AppKey和SecretKey
    [[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
    
    [[TYAppService sharedInstance] configApp:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [self resetRootViewController:[TabBarViewController class]];
    } else {
        [self resetRootViewController:[TPSignInViewController class]];
    }
    
    return YES;
}


- (void)resetRootViewController:(Class)rootController {
    if ([TuyaSmartUser sharedInstance].isLogin) {
        [[TYAppService sharedInstance] loginDoAction];
    }
    [tp_topMostViewController().navigationController popToRootViewControllerAnimated:NO];
    
    TPNavigationController *navigationController = [[TPNavigationController alloc] initWithRootViewController:[rootController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
}

- (void)signOut {
    [[TYAppService sharedInstance] signOut];
    [self resetRootViewController:[TPSignInViewController class]];
}

@end
