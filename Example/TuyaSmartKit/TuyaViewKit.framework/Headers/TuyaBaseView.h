//
//  TuyaBaseView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuyaViewUtils.h"
#import "TuyaViewConstants.h"
#import "UIView+ATAdditions.h"
#import "UIImage+Alpha.h"

@interface TuyaBaseView : UIView

@property(nonatomic,assign) BOOL    topLineHidden;
@property(nonatomic,assign) float   topLineWidth;
@property(nonatomic,assign) float   topLineIndent;
@property(nonatomic,strong) UIColor *topLineColor;

@property(nonatomic,assign) BOOL    bottomLineHidden;
@property(nonatomic,assign) float   bottomLineWidth;
@property(nonatomic,assign) float   bottomLineIndent;
@property(nonatomic,strong) UIColor *bottomLineColor;

@end
