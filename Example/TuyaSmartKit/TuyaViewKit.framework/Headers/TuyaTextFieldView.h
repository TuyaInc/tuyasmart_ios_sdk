//
//  TuyaTextFieldView.h
//  TuyaViewSDK
//
//  Created by fengyu on 15/9/8.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuyaBaseView.h"

@protocol TuyaTextFieldViewDelegate <NSObject>

-(void)textFieldRightItemViewTap;

@end

@interface TuyaTextFieldView : TuyaBaseView

@property(nonatomic,strong) NSObject<TuyaTextFieldViewDelegate> *delegate;

@property(nonatomic,assign) BOOL roundCorner;

@property(nonatomic,strong) UIImage *leftImage;

@property(nonatomic,strong) UIImage *rightImage;
@property(nonatomic,strong) UIImage *rightImageSelected;

@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,retain) UIColor  *textColor;
@property(nonatomic,copy)   NSString *placeholder;

@end
