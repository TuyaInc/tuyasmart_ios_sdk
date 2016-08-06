//
//  TPEmptyView.m
//  TuyaSmart
//
//  Created by fengyu on 15/9/11.
//  Copyright (c) 2015年 TP. All rights reserved.
//

#import "TPEmptyView.h"

@interface TPEmptyView()

@end

@implementation TPEmptyView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [self initWithFrame:frame title:title imageName:nil]) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName {
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        [self addEmptyView:title imageName:imageName];
    }
    return self;
}

- (void)addEmptyView:(NSString *)title imageName:(NSString *)imageName {
    
    
    if (imageName.length == 0) {
        imageName = @"tp_nolist_logo.png";
    }
    
    UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    emptyImageView.left = (self.width - emptyImageView.width)/2.f;
    [self addSubview:emptyImageView];
    
    UILabel *titleLabel = [TPViewUtil labelWithFrame:CGRectMake(0, emptyImageView.bottom + 28, self.width, 20) fontSize:16 color:HEXCOLOR(0xD4CCC4)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    emptyImageView.top = (self.height - titleLabel.bottom) / 2.f;
    titleLabel.top = emptyImageView.bottom + 30;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
