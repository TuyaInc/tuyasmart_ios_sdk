//
//  TuyaViewCellItem.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TuyaCellViewItem : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) UIColor  *textColor;
@property(nonatomic,assign) float    fontSize;

@property(nonatomic,strong) UIImage *image;

@property (nonatomic, strong) UIView *customView;

+(TuyaCellViewItem *)cellItemWithTitle:(NSString *)title image:(UIImage *)image;
+(TuyaCellViewItem *)cellItemWithArrowImage:(NSString *)title;

@end