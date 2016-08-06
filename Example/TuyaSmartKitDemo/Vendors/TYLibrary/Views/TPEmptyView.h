//
//  TPEmptyView.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/11.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPBaseView.h"

@interface TPEmptyView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName;

- (void)setTitle:(NSString *)title;

@end
