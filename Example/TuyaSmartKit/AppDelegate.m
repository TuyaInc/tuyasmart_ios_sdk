//
//  AppDelegate.m
//  TuyaSmartKitDemo
//
//  Created by fengyu on 15/9/12.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "AppDelegate.h"
#import <TuyaSmartKit/TuyaSmartKit.h>
#import "SignInController.h"
#import "DeviceListController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     * 初始化SDK
     */
    
    //TODO: 修改AppKey和SecretKey
    [[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
#if DEBUG
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#endif
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[TuyaSmartUser sharedInstance] isLogin]) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DeviceListController alloc] init]];
        navigationController.navigationBarHidden = YES;
        self.window.rootViewController = navigationController;
    } else {
        self.window.rootViewController = [[SignInController alloc] init];
    }
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInvalid) name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
    
    return YES;
}

- (void)resetRootViewController:(Class)rootController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[rootController new]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
}

- (void)sessionInvalid {
    if ([[TuyaSmartUser sharedInstance] isLogin]) {
        [UIAlertView bk_showAlertViewWithTitle:@"登录信息已过期,请重新登录" message:nil cancelButtonTitle:NSLocalizedString(@"confirm", @"") otherButtonTitles:nil handler:nil];
        
        [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];
        [self resetRootViewController:[SignInController class]];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
