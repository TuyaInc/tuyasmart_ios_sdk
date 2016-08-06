//
//  TYSearchOneDeviceLayout.m
//  TuyaSmart
//
//  Created by 高森 on 16/1/27.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSearchOneDeviceLayout.h"
#import <DACircularProgress/DALabeledCircularProgressView.h>

@interface TYSearchOneDeviceLayout ()

@property (nonatomic, strong) DALabeledCircularProgressView *circularView;
@property (nonatomic, strong) UILabel *tipsLabel;
//@property (nonatomic, strong) UILabel *noWifiLabel;

@property (nonatomic, strong) UIImageView *statusIcon1;
@property (nonatomic, strong) UIImageView *statusIcon2;
@property (nonatomic, strong) UIImageView *statusIcon3;
@property (nonatomic, strong) UILabel     *statusLabel1;
@property (nonatomic, strong) UILabel     *statusLabel2;
@property (nonatomic, strong) UILabel     *statusLabel3;

@end

@implementation TYSearchOneDeviceLayout

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MAIN_BACKGROUND_COLOR;
        
//        _noWifiLabel = [TPViewUtil labelWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_CONTENT_WIDTH, 30) fontSize:14 color:NOTICE_TEXT_COLOR];
//        _noWifiLabel.textAlignment = NSTextAlignmentCenter;
//        _noWifiLabel.backgroundColor = NOTICE_BACKGROUND_COLOR;
//        _noWifiLabel.text = NSLocalizedString(@"network_time_out", @"");
//        _noWifiLabel.alpha = 0.f;
//        [self addSubview:_noWifiLabel];
        
        _circularView = [[DALabeledCircularProgressView alloc] initWithFrame:CGRectMake((APP_CONTENT_WIDTH - 100) / 2, APP_TOP_BAR_HEIGHT + (APP_VISIBLE_HEIGHT - 100) / 3, 100, 100)];
        _circularView.trackTintColor = [MAIN_COLOR colorWithAlphaComponent:0.2];
        _circularView.progressTintColor = MAIN_COLOR;
        _circularView.innerTintColor = [UIColor whiteColor];
        _circularView.thicknessRatio = 0.05;
        _circularView.roundedCorners = YES;
        
        _circularView.progressLabel.font = [UIFont systemFontOfSize:24];
        _circularView.progressLabel.textColor = MAIN_COLOR;
        [self addSubview:_circularView];
        
        _tipsLabel = [TPViewUtil labelWithFrame:CGRectMake((APP_CONTENT_WIDTH - 300) / 2, _circularView.bottom + 24, 300, 60) fontSize:14 color:SUB_FONT_COLOR];
        _tipsLabel.numberOfLines = 0;
        
        NSString *labelText = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"ty_ez_connecting_devicei_note1", @""), NSLocalizedString(@"ty_ez_connecting_device_note2", @"")];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineSpacing = 3;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        
        _tipsLabel.attributedText = attributedString;
        [self addSubview:_tipsLabel];
        
        self.topBarView.leftItem.image = [UIImage imageNamed:@"back_white.png"];
        self.topBarView.centerItem.title = NSLocalizedString(@"ty_ez_connecting_device_title", @"");
        self.topBarView.rightItem = nil;
        [self addSubview:self.topBarView];
        
        [self initStatusLabel];
        [self setProgress:0];
    }
    return self;
}

- (void)initStatusLabel {
    _statusIcon3 = [TPViewUtil imageViewWithFrame:CGRectMake(APP_SCREEN_WIDTH * 0.4, APP_SCREEN_HEIGHT - 30 - 10, 10, 10) imageName:@"ty_adddevice_icon_none"];
    _statusIcon2 = [TPViewUtil imageViewWithFrame:CGRectMake(_statusIcon3.left, _statusIcon3.top - 10 - 10, 10, 10) imageName:@"ty_adddevice_icon_none"];
    _statusIcon1 = [TPViewUtil imageViewWithFrame:CGRectMake(_statusIcon3.left, _statusIcon2.top - 10 - 10, 10, 10) imageName:@"ty_adddevice_icon_none"];
    
    _statusLabel1 = [TPViewUtil labelWithFrame:CGRectMake(_statusIcon1.right + 4, _statusIcon1.top - 2, 180, 14) fontSize:12 color:LIST_LIGHT_TEXT_COLOR];
    _statusLabel2 = [TPViewUtil labelWithFrame:CGRectMake(_statusIcon2.right + 4, _statusIcon2.top - 2, 180, 14) fontSize:12 color:LIST_LIGHT_TEXT_COLOR];
    _statusLabel3 = [TPViewUtil labelWithFrame:CGRectMake(_statusIcon3.right + 4, _statusIcon3.top - 2, 180, 14) fontSize:12 color:LIST_LIGHT_TEXT_COLOR];
    
    CGRect rect1 = [self getContentRect:NSLocalizedString(@"ty_add_device_find_dev", @"") size:_statusLabel1.size fontSize:12];
    CGRect rect2 = [self getContentRect:NSLocalizedString(@"ty_add_device_reg_cloud", @"") size:_statusLabel2.size fontSize:12];
    CGRect rect3 = [self getContentRect:NSLocalizedString(@"ty_add_device_initialize", @"") size:_statusLabel3.size fontSize:12];
    
    CGFloat maxWidth = fmaxf(fmaxf(rect1.size.width, rect2.size.width), rect3.size.width);
    CGFloat left = (APP_SCREEN_WIDTH - maxWidth) / 2 - 5;
    
    _statusIcon1.left = left;
    _statusLabel1.left = _statusIcon1.right + 4;
    _statusIcon2.left = left;
    _statusLabel2.left = _statusIcon2.right + 4;
    _statusIcon3.left = left;
    _statusLabel3.left = _statusIcon3.right + 4;
    
    _statusLabel1.text = NSLocalizedString(@"ty_add_device_find_dev", @"");
    _statusLabel2.text = NSLocalizedString(@"ty_add_device_reg_cloud", @"");
    _statusLabel3.text = NSLocalizedString(@"ty_add_device_initialize", @"");
    
    [self addSubview:_statusLabel1];
    [self addSubview:_statusLabel2];
    [self addSubview:_statusLabel3];
    [self addSubview:_statusIcon1];
    [self addSubview:_statusIcon2];
    [self addSubview:_statusIcon3];

}

- (CGRect)getContentRect:(NSString *)text size:(CGSize)size fontSize:(CGFloat)fontSize {
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return rect;
}

- (void)setProgress:(CGFloat)progress {
    [_circularView setProgress:progress animated:YES];
    _circularView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", 100 * progress];
}

- (void)setState:(TYActivatorState)state {
    
    if (state == TYActivatorStateConfigure) {
        _statusIcon1.image = [UIImage imageNamed:@"ty_adddevice_icon_ok"];
        _statusLabel1.textColor = HEXCOLOR(0x61ba00);
    } else if (state == TYActivatorStateDeviceLogin) {
        _statusIcon2.image = [UIImage imageNamed:@"ty_adddevice_icon_ok"];
        _statusLabel2.textColor = HEXCOLOR(0x61ba00);
    } else if (state == TYActivatorStateOK) {
        _statusIcon3.image = [UIImage imageNamed:@"ty_adddevice_icon_ok"];
        _statusLabel3.textColor = HEXCOLOR(0x61ba00);
    }
}

@end
