//
//  TYAppService.m
//  TuyaSmart
//
//  Created by fengyu on 15/7/3.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TYAppService.h"
#import "AppDelegate.h"
#import "TPScheduledLocationManager.h"

@interface TYAppService() <TPScheduledLocationManagerDelegate>

@property (strong,nonatomic) TPScheduledLocationManager *slm;

@end

@implementation TYAppService

TP_DEF_SINGLETON(TYAppService)

#pragma mark - Public Method
- (void)configApp:(NSDictionary *)launchOptions {
        
    [UIApplication sharedApplication].statusBarHidden = NO;
    
//    [self setKeyBoardManager];
}


- (void)signOut {
    [[TuyaSmartUser sharedInstance] loginOut:nil failure:nil];

    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TuyaSmartUserNotificationUserSessionInvalid
                                                  object:nil];
}

- (void)loginDoAction {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:TuyaSmartUserNotificationUserSessionInvalid
                                                  object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionInvalid)
                                                 name:TuyaSmartUserNotificationUserSessionInvalid
                                               object:nil];
    
    [self scheduledLocation];
    
}

#pragma mark - Private Method

- (void)sessionInvalid {
    if ([[TuyaSmartUser sharedInstance] isLogin]) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate signOut];
        
        [TPProgressUtils showError:NSLocalizedString(@"login_session_expired", nil)];
    }
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}


- (void)scheduledLocation {
    self.slm = [TPScheduledLocationManager new];
    self.slm.delegate = self;
    [self.slm getUserLocationWithInterval:10];
}

#pragma mark ScheduledLocationManagerDelegate

- (void)scheduledLocationManageDidFailWithError:(NSError *)error {
    NSLog(@"Location Error %@",error);
}

- (void)scheduledLocationManageDidUpdateLocations:(CLLocation *)locations {
    
    if (locations.coordinate.latitude && locations.coordinate.longitude) {
        
        NSString *latitude = [NSString stringWithFormat:@"%f", locations.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", locations.coordinate.longitude];
        
        [[TuyaSmartSDK sharedInstance] setValue:latitude forKey:@"latitude"];
        [[TuyaSmartSDK sharedInstance] setValue:longitude forKey:@"longitude"];
    }
}

@end
