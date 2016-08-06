//
//  TuyaTopBarView.m
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "TPTopBarView.h"

@interface TPTopBarView()

@property (nonatomic,assign) NSInteger topBarHeight;

@end

@implementation TPTopBarView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        self.textColor = TOP_BAR_TEXT_COLOR;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _topBarHeight = APP_TOP_BAR_HEIGHT - APP_STATUS_BAR_HEIGHT;
        
        self.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_TOP_BAR_HEIGHT);
        self.tag = TPTopBarViewTag;
        self.topLineHidden = YES;
        self.bottomLineHidden = YES;
    }
    return self;
}

- (void)setTopBarBackgroundColor:(NSArray *)color {
    self.backgroundColor = [self colorFromRgbaArray:color];
}

- (void)setTopBarTextColor:(NSArray *)color {
    UIButton *btn = (UIButton *)[self viewWithTag:TP_CENTER_VIEW_TAG];
    if ([btn respondsToSelector:@selector(setTitleColor:forState:)]) {
        [btn setTitleColor:[self colorFromRgbaArray:color] forState:UIControlStateNormal];
    }
}

- (void)setTopBarSubTextColor:(NSArray *)color {
    UIButton *leftBtn = (UIButton *)[self viewWithTag:TP_LEFT_VIEW_TAG];
    if ([leftBtn respondsToSelector:@selector(setTitleColor:forState:)]) {
        [leftBtn setTitleColor:[self colorFromRgbaArray:color] forState:UIControlStateNormal];
    }
    UIButton *rightBtn = (UIButton *)[self viewWithTag:TP_RIGHT_VIEW_TAG];
    if ([rightBtn respondsToSelector:@selector(setTitleColor:forState:)]) {
        [rightBtn setTitleColor:[self colorFromRgbaArray:color] forState:UIControlStateNormal];
    }
}

- (void)setTopBarSubTextSelectedColor:(NSArray *)color {
    UIButton *leftBtn = (UIButton *)[self viewWithTag:TP_LEFT_VIEW_TAG];
    if ([leftBtn respondsToSelector:@selector(setTitleColor:forState:)]) {
        [leftBtn setTitleColor:[self colorFromRgbaArray:color] forState:UIControlStateSelected];
    }
    UIButton *rightBtn = (UIButton *)[self viewWithTag:TP_RIGHT_VIEW_TAG];
    if ([rightBtn respondsToSelector:@selector(setTitleColor:forState:)]) {
        [rightBtn setTitleColor:[self colorFromRgbaArray:color] forState:UIControlStateSelected];
    }
}

- (UIColor *)colorFromRgbaArray:(NSArray *)rgba {
    return [UIColor colorWithRed:[rgba[0] intValue]/255.0
                           green:[rgba[1] intValue]/255.0
                            blue:[rgba[2] intValue]/255.0
                           alpha:[rgba[3] intValue]];
}

- (void)setLeftItem:(TPBarButtonItem *)leftItem {
    if (_leftItem != leftItem) {
        _leftItem = leftItem;
        [self setNeedsLayout];
    }
}

- (void)setRightItem:(TPBarButtonItem *)rightItem {
    if (_rightItem != rightItem) {
        _rightItem = rightItem;
        [self setNeedsLayout];
    }
}

- (void)setCenterItem:(TPBarButtonItem *)centerItem {
    if (_centerItem != centerItem ) {
        _centerItem = centerItem;
        [self setNeedsLayout];
    } else {
        //just update title
        if (_centerItem.systemItem == TPBarButtonSystemItemCenter) {
            UIButton *btn = (UIButton *)[self viewWithTag:TP_CENTER_VIEW_TAG];
            if ([btn isKindOfClass:[UIButton class]]) {
                [btn setTitle:centerItem.title ? : @"" forState:UIControlStateNormal];
             
                CGFloat width =  [_centerItem.title sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}].width;
                
                
                btn.frame = CGRectMake((APP_SCREEN_WIDTH - width)/2, APP_STATUS_BAR_HEIGHT, width, _topBarHeight);
            }
        }
    }
}


//从左至右画
- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIColor *normalTextColor = _textColor;
    
    float leftContentInsets;
    if (isnan(_leftItem.contentInsets)) {
        leftContentInsets = 8;
    } else {
        leftContentInsets = _leftItem.contentInsets;
    }
    
    
    float rightContentInsets;
    if (isnan(_rightItem.contentInsets)) {
        rightContentInsets = 8;
    } else {
        rightContentInsets = _rightItem.contentInsets;
    }
    
//    float leftContentInsets = _leftItem.contentInsets ? : 8;
//    float rightContentInsets = _rightItem.contentInsets ? : 12;
    
    NSArray *array = @[
                       [NSNumber numberWithInteger:TP_LEFT_VIEW_TAG],
                       [NSNumber numberWithInteger:TP_CENTER_VIEW_TAG],
                       [NSNumber numberWithInteger:TP_RIGHT_VIEW_TAG],
                       ];
    
    for (NSNumber *num in array) {
        NSInteger tag = [num intValue];
        UIView *view = [self viewWithTag:tag];
        
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    
    //left btn
    if (_leftItem) {
        if (_leftItem.customView) {
            _leftItem.customView.frame = CGRectMake(leftContentInsets,  APP_STATUS_BAR_HEIGHT + (_topBarHeight - _leftItem.customView.height)/2 , _leftItem.customView.width, _leftItem.customView.height);
            [self addSubview:_leftItem.customView];
            _leftItem.customView.tag = TP_LEFT_VIEW_TAG;
        } else {
            UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftBtn.tag = TP_LEFT_VIEW_TAG;
            
            //默认的没有返回按钮 只有文字
            if (_leftItem.systemItem == TPBarButtonSystemItemLeftWithoutIcon) {
                
                [leftBtn setTitle:_leftItem.title ? : @"" forState:UIControlStateNormal];
                leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
                [leftBtn setTitleColor:self.textColor forState:UIControlStateNormal];
                [leftBtn setTitleColor:[self.textColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
                CGFloat width =  [_leftItem.title sizeWithAttributes:@{NSFontAttributeName : leftBtn.titleLabel.font}].width;

                
                
                
                leftBtn.frame = CGRectMake(leftContentInsets, APP_STATUS_BAR_HEIGHT, width, _topBarHeight);
            } else if (_leftItem.systemItem == TPBarButtonSystemItemLeftWithIcon) {
                //默认的有返回按钮 并有文字
                UIImage *image = [UIImage imageNamed:@"tp_top_bar_back"];
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                
                [leftBtn setTitle:_leftItem.title ? : @"" forState:UIControlStateNormal];
                [leftBtn setImage:image forState:UIControlStateNormal];
                [leftBtn setImage:[image imageByApplyingAlpha:0.5] forState:UIControlStateHighlighted];
                leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
                leftBtn.titleEdgeInsets = UIEdgeInsetsMake(1.5,4,0,0);
                //btn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
                leftBtn.titleLabel.font = [UIFont systemFontOfSize:17];
                //_backTitleButton.backgroundColor = [UIColor redColor];
                [leftBtn setTitleColor:self.textColor forState:UIControlStateNormal];
                [leftBtn setTitleColor:[self.textColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
                leftBtn.frame = CGRectMake(leftContentInsets,APP_STATUS_BAR_HEIGHT,160,_topBarHeight);

            } else {
                //根据参数设置
                
                if (_leftItem.image) {
                    [leftBtn setImage:_leftItem.image forState:UIControlStateNormal]; //不会拉伸
                }
                
                if (_leftItem.highlightImage) {
                    [leftBtn setImage:_leftItem.highlightImage forState:UIControlStateHighlighted];
                }
                
                if (_leftItem.selectedImage) {
                    [leftBtn setImage:_leftItem.selectedImage forState:UIControlStateSelected];
                }
                
                if (_leftItem.disabledImage) {
                    [leftBtn setImage:_leftItem.disabledImage forState:UIControlStateDisabled];
                }

                if (_leftItem.backgroundImage) {
                    [leftBtn setBackgroundImage:_leftItem.backgroundImage forState:UIControlStateNormal]; //会拉伸
                }
                
                
                CGSize size = _leftItem.image.size;
                leftBtn.frame = CGRectMake(leftContentInsets,(_topBarHeight - size.height)/2 + APP_STATUS_BAR_HEIGHT, size.width, size.height);
            
            }
            
            [leftBtn setTintColor:self.textColor];
            leftBtn.backgroundColor = [UIColor clearColor];
            
            if (_leftItem.target && _leftItem.action) {
                [leftBtn addTarget:_leftItem.target action:_leftItem.action forControlEvents:UIControlEventTouchUpInside];
            }
            
            [self addSubview:leftBtn];
        }
    } else {
        
        //remove
        UIView *view = [self viewWithTag:TP_LEFT_VIEW_TAG];
        if (view) {
            [view removeFromSuperview];
        }
        
    }
    
    
    //center btn
    if (_centerItem) {
        if (_centerItem.customView) {
            _centerItem.customView.frame = CGRectMake((self.width - _centerItem.customView.width)/2, APP_STATUS_BAR_HEIGHT +(_topBarHeight - _centerItem.customView.height)/2 , _centerItem.customView.width, _centerItem.customView.height);
            [self addSubview:_centerItem.customView];
            _centerItem.customView.tag = TP_CENTER_VIEW_TAG;
            
        } else {
            UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            centerBtn.tag = TP_CENTER_VIEW_TAG;
            //默认的样式 只有文字
            if (_centerItem.systemItem == TPBarButtonSystemItemCenter) {
                
                [centerBtn setTitle:_centerItem.title ? : @"" forState:UIControlStateNormal];
                centerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                centerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
                [centerBtn setTitleColor:normalTextColor ? : HEXCOLOR(0x1f1f1f) forState:UIControlStateNormal];
                
                CGFloat width =  [_centerItem.title sizeWithAttributes:@{NSFontAttributeName : centerBtn.titleLabel.font}].width;
                
                double maxWidth = APP_CONTENT_WIDTH - 120;
                
                width = width > maxWidth ? maxWidth : width;
                
                centerBtn.frame = CGRectMake((self.width - width)/2, APP_STATUS_BAR_HEIGHT, width, _topBarHeight);
                
            } else {
                //根据参数设置
                if (_centerItem.image) {
                    [centerBtn setImage:_centerItem.image forState:UIControlStateNormal]; //不会拉伸
                }
                
                if (_centerItem.highlightImage) {
                    [centerBtn setImage:_centerItem.highlightImage forState:UIControlStateHighlighted];
                }
                
                if (_centerItem.selectedImage) {
                    [centerBtn setImage:_centerItem.selectedImage forState:UIControlStateSelected];
                }
                
                if (_centerItem.disabledImage) {
                    [centerBtn setImage:_centerItem.disabledImage forState:UIControlStateDisabled];
                }
                
                if (_centerItem.backgroundImage) {
                    [centerBtn setBackgroundImage:_centerItem.backgroundImage forState:UIControlStateNormal]; //会拉伸
                }
                
                
                CGSize size = _centerItem.image.size;
                centerBtn.frame = CGRectMake((self.width - size.width)/2,(_topBarHeight - size.height)/2 + APP_STATUS_BAR_HEIGHT, size.width, size.height);
                
            }
            
            centerBtn.backgroundColor = [UIColor clearColor];
            
            if (_centerItem.target && _centerItem.action) {
                [centerBtn addTarget:_centerItem.target action:_centerItem.action forControlEvents:UIControlEventTouchUpInside];
            }
            
            [self addSubview:centerBtn];
        }
    } else {
        
        //remove
        UIView *view = [self viewWithTag:TP_CENTER_VIEW_TAG];
        if (view) {
            [view removeFromSuperview];
        }

    }
    
    //right btn
    if (_rightItem) {
        
        if (_rightItem.customView) {
            _rightItem.customView.frame = CGRectMake(self.width - _rightItem.customView.width - rightContentInsets, (_topBarHeight - _rightItem.customView.height)/2 + APP_STATUS_BAR_HEIGHT , _rightItem.customView.width, _rightItem.customView.height);
            [self addSubview:_rightItem.customView];
            _rightItem.customView.tag = TP_RIGHT_VIEW_TAG;
            
        } else {
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.tag = TP_RIGHT_VIEW_TAG;

            if (_rightItem.systemItem == TPBarButtonSystemItemRight) {
            
                [rightBtn setTitle:_rightItem.title ? : @"" forState:UIControlStateNormal];
                rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                rightBtn.titleLabel.font = [UIFont systemFontOfSize:17];
                [rightBtn setTitleColor:self.textColor forState:UIControlStateNormal];
                [rightBtn setTitleColor:[self.textColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
                
//                CGFloat width =  [_rightItem.title sizeWithFont:rightBtn.titleLabel.font].width;
                CGFloat width = 80;
                rightBtn.frame = CGRectMake(self.width - width - rightContentInsets, APP_STATUS_BAR_HEIGHT, width, _topBarHeight);
            } else {
                
                //根据参数设置
                if (_rightItem.image) {
                    [rightBtn setImage:_rightItem.image forState:UIControlStateNormal]; //不会拉伸
                }
                
                if (_rightItem.highlightImage) {
                    [rightBtn setImage:_rightItem.highlightImage forState:UIControlStateHighlighted];
                }
                
                if (_rightItem.selectedImage) {
                    [rightBtn setImage:_rightItem.selectedImage forState:UIControlStateSelected];
                }
                
                if (_rightItem.disabledImage) {
                    [rightBtn setImage:_rightItem.disabledImage forState:UIControlStateDisabled];
                }
                
                if (_rightItem.backgroundImage) {
                    [rightBtn setBackgroundImage:_rightItem.backgroundImage forState:UIControlStateNormal]; //会拉伸
                }
                
                
                CGSize size = _rightItem.image.size;
                rightBtn.frame = CGRectMake(self.width - size.width - rightContentInsets,(_topBarHeight - size.height)/2 + APP_STATUS_BAR_HEIGHT, size.width, size.height);
                
            }
            
            [rightBtn setTintColor:self.textColor];
            rightBtn.backgroundColor = [UIColor clearColor];
            
            if (_rightItem.target && _rightItem.action) {
                [rightBtn addTarget:_rightItem.target action:_rightItem.action forControlEvents:UIControlEventTouchUpInside];
            }
            
            [self addSubview:rightBtn];

            
        }

        
    } else {
        //remove
        UIView *view = [self viewWithTag:TP_RIGHT_VIEW_TAG];
        if (view) {
            [view removeFromSuperview];
        }
    }
}


@end
