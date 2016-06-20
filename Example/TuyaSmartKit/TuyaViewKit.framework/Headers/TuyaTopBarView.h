//
//  TuyaTopBarView.h
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuyaBaseView.h"
#import "TuyaBarButtonItem.h"

#define AT_LEFT_VIEW_TAG 1200
#define AT_RIGHT_VIEW_TAG 1201
#define AT_CENTER_VIEW_TAG 1202

#define ATTopBarViewTag 35739

@interface TuyaTopBarView : TuyaBaseView

@property (nonatomic,strong) TuyaBarButtonItem *leftItem;
@property (nonatomic,strong) TuyaBarButtonItem *centerItem;
@property (nonatomic,strong) TuyaBarButtonItem *rightItem;

@property (nonatomic,strong) UIColor         *lineColor;
@property (nonatomic,strong) UIColor         *textColor;

-(void)setTopBarBackgroundColor:(NSArray *)backgroundColorArray;
-(void)setTopBarTextColor:(NSArray *)color;
-(void)setTopBarSubTextColor:(NSArray *)color;
-(void)setTopBarSubTextSelectedColor:(NSArray *)color;

@end
