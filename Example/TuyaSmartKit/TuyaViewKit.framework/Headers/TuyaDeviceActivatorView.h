//
//  TuyaDeviceActivatorView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/14.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TuyaLayoutView.h"
#import "TuyaTextFieldView.h"

@class TuyaDeviceActivatorView;

@protocol TuyaDeviceActivatorViewDelegate <NSObject>

-(void)deviceActivatorViewConfigButtonTap:(TuyaDeviceActivatorView *)deviceActivator;
-(void)deviceActivatorView:(TuyaDeviceActivatorView *)deviceActivator showPassword:(BOOL)showPassword;

@end

@interface TuyaDeviceActivatorView : TuyaLayoutView

@property(nonatomic,assign) NSObject<TuyaDeviceActivatorViewDelegate> *delegate;
@property(nonatomic,strong) TuyaTextFieldView *ssidTextFieldView;
@property(nonatomic,strong) NSString *ssid;
@property(nonatomic,strong) NSString *bssid;
@property(nonatomic,strong) NSString *password;

@end
