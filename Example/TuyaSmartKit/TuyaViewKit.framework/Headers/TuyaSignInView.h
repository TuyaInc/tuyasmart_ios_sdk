//
//  TuyaSignInView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/9.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "TuyaLayoutView.h"
#import "TuyaCellView.h"
#import "TuyaTextFieldView.h"

@class TuyaSignInView;

@protocol TuyaSignInViewDelegate <NSObject>

-(void)signInViewCountrySelectViewTap:(TuyaSignInView *)signInView;
-(void)signInViewSendVerifyCodeButtonTap:(TuyaSignInView *)signInView;
-(void)signInViewSignInButtonTap:(TuyaSignInView *)signInView;

@end

@interface TuyaSignInView : TuyaLayoutView

@property(nonatomic,assign) NSObject<TuyaSignInViewDelegate> *delegate;

@property(nonatomic,strong) NSString *phoneNumber;
@property(nonatomic,strong) NSString *verifyCode;

-(void)setCountryCode:(NSString *)countryCode;

-(void)enableSendVerifyCodeButton:(NSString *)title;
-(void)disableSendVerifyCodeButton:(NSString *)title;
-(void)enableSignInButton;
-(void)disableSignInButton;

@end
