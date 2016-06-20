//
//  TuyaLayoutView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TuyaTopBarView.h"

@class TuyaLayoutView;

@protocol TuyaTopBarViewDelegate <NSObject>

-(void)topBarLeftItemTap;
-(void)topBarCenterItemTap;
-(void)topBarRightItemTap;

@end

@interface TuyaLayoutView : UIView

@property(nonatomic,assign) NSObject<TuyaTopBarViewDelegate> *topBarDelegate;
@property(nonatomic,strong) TuyaTopBarView *topBarView;

@end
