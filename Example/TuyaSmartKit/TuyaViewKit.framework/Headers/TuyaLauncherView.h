//
//  TuyaLauncherView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TuyaLayoutView.h"

@class TuyaLauncherView;

@protocol TuyaLauncherViewDelegate <NSObject>

-(void)launcherViewstartButtonTap:(TuyaLauncherView *)launcherView;

@end

@interface TuyaLauncherView : TuyaLayoutView

@property(nonatomic,assign) NSObject<TuyaLauncherViewDelegate> *delegate;

@end
