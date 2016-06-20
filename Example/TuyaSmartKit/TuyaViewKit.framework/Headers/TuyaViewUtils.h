//
//  TuyaViewUtils.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TuyaViewUtils : NSObject

+(UIView *)viewWithFrame:(CGRect)frame;
+(UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;
+(UIView *)lineView:(CGPoint)origin width:(float)width color:(UIColor *)color;
+(UILabel *)labelWithFrame:(CGRect)frame fontSize:(int)fontSize color:(UIColor *)color;
+(UIButton *)buttonWithFrame:(CGRect)frame fontSize:(int)fontSize bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor borderColor:(UIColor *)borderColor;
+(UIImage *)imageNamed:(NSString *)imageName;

+(UITapGestureRecognizer *)singleFingerClickRecognizer:(id)target sel:(SEL)sel;
+(UITapGestureRecognizer *)singleFingerDoubleClickRecognizer:(id)target sel:(SEL)sel;

@end
