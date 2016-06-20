//
//  UIAlertView+Block.h
//  TuyaSmart
//
//  Created by fengyu on 15/7/8.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end
