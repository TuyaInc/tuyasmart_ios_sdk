//
//  TYAnimations.h
//  AirTake
//
//  Created by fengyu on 14-6-13.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TYAnimations : NSObject

+(void)fadeIn:(UIView *)view;
+(void)fadeIn:(UIView *)view completion:(void (^)(BOOL finished))completion;
+(void)fadeIn:(UIView *)view duration:(float)duration completion:(void (^)(BOOL))completion;

+(void)fadeOut:(UIView *)view;
+(void)fadeOut:(UIView *)view completion:(void (^)(BOOL finished))completion;
+(void)fadeOut:(UIView *)view duration:(float)duration completion:(void (^)(BOOL))completion;

+(void)pushView:(UIView *)view;
+(void)pushView:(UIView *)view completion:(void (^)(BOOL finished))completion;

+(void)popView:(UIView *)view;
+(void)popView:(UIView *)view completion:(void (^)(BOOL finished))completion;

+(void)presentView:(UIView *)view;
+(void)presentView:(UIView *)view completion:(void (^)(BOOL))completion;

+(void)dismissModalView:(UIView *)view;
+(void)dismissModalView:(UIView *)view completion:(void (^)(BOOL))completion;

+(void)verticalMove:(UIView *)view duration:(float)duration distance:(float)distance delay:(float)delay;
+(void)verticalMove:(UIView *)view duration:(float)duration distance:(float)distance delay:(float)delay completion:(void (^)(BOOL))completion;
+(void)verticalMove:(UIView *)view duration:(float)duration distance:(float)distance options:(UIViewAnimationOptions)option delay:(float)delay completion:(void (^)(BOOL))completion;

+ (void)shake:(UIView *)view distance:(float)distance repeatCount:(NSInteger)repeatCount duration:(float)duration;

+ (void)photoViewAppearAnimate:(UIView *)view startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame complete:(void (^)(void))complete;

+ (void)photoDisappearAnimate:(UIView *)animateView startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame animateTime:(float)animateTime completion:(void (^)(void))completion;

+(void)TYFadeIn:(UIView *)view;
+(void)TYPresentView:(UIView *)view;

@end
