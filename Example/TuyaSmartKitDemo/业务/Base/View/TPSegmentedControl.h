//
//  TPSegmentedControl.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/4/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TPSegmentedControlDelegate <NSObject>

- (void)didSelectCurrentIndex:(NSInteger)index;

@end

@interface TPSegmentedControl : UIView

@property (nonatomic, weak) id <TPSegmentedControlDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items;

- (void)changeToIndex:(NSInteger)index;
@end
