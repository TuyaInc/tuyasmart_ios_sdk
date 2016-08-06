//
//  UIViewController+ATCategory.m
//  Airtake
//
//  Created by fisher on 14/11/10.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "UIViewController+TPCategory.h"
#import "TPViewConstants.h"

@implementation UIViewController (TPCategory)

- (void)tp_dismissModalViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
