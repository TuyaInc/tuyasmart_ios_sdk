//
//  TuyaPanelCellView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/15.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuyaBaseView.h"

@class TuyaPanelCellView;

@protocol TuyaPanelCellViewDelegate <NSObject>

-(void)panelCellViewTap:(TuyaPanelCellView *)panelCellView;

@end

@interface TuyaPanelCellView : UITableViewCell

@property(nonatomic,strong) NSObject<TuyaPanelCellViewDelegate> *delegate;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *valueLabel;

@end
