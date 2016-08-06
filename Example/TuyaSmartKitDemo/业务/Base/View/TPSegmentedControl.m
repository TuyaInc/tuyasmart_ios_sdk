//
//  TPSegmentedControl.m
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/4/15.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TPSegmentedControl.h"

@interface TPSegmentedControl()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIView  *lineView;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation TPSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *> *)items {

    if (self = [super initWithFrame:frame]) {
        _items = items;
        _currentIndex = 0;
        
        
        self.backgroundColor = TAB_BAR_BACKGROUND_COLOR;
        
        [self reloadView];
        
    }
    
    return self;
    
}

- (void)reloadView {
    
    NSInteger count = _items.count;
    
    for (NSInteger i = 0 ; i < count ; i++) {
        
        UIButton *btn = [TPViewUtil buttonWithFrame:CGRectMake(i * self.width / count, 0, self.width / count, self.height) fontSize:13 bgColor:TAB_BAR_BACKGROUND_COLOR textColor:MAIN_COLOR];
        [btn setTitle:[_items objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self addSubview:btn];
    }
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 2, self.width / count, 2)];
    _lineView.backgroundColor = MAIN_COLOR;
    [self addSubview:_lineView];
    
}


- (void)segmentAction:(UIButton *)button {
    if (_currentIndex != button.tag) {
     
        [self changeToIndex:button.tag];
    }
}


- (void)changeToIndex:(NSInteger)index {
    if (index >= _items.count) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectCurrentIndex:)]) {
        [self.delegate didSelectCurrentIndex:index];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.left = index * _lineView.width;
        
        
    } completion:^(BOOL finished) {
        _currentIndex = index;
    }];
    
    
}
@end
