//
//  TuyaViewCell.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TuyaBaseView.h"
#import "TuyaCellViewItem.h"

@class TuyaCellView;

@protocol TuyaCellViewDelegate <NSObject>

-(void)tuyaCellViewTap:(TuyaCellView *)tuyaCellView;

@end

@interface TuyaCellView : TuyaBaseView

@property(nonatomic,assign) NSObject<TuyaCellViewDelegate> *delegate;

@property(nonatomic,assign) BOOL roundCorner;

@property(nonatomic,strong) TuyaCellViewItem *leftItem;
@property(nonatomic,strong) TuyaCellViewItem *centerItem;
@property(nonatomic,strong) TuyaCellViewItem *rightItem;

+(TuyaCellView *)seperateCellView:(CGRect)frame  backgroundColor:(UIColor *)backgroundColor;

-(void)showRightArrow;

@end
