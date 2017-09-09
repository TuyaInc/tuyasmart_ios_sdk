//
//  TYReceiveMemberDeviceListCell.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/6.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYReceiveMemberDeviceListCell.h"
#import "UIImageView+WebCache.h"

@interface TYReceiveMemberDeviceListCell()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UIView      *line;

@end

@implementation TYReceiveMemberDeviceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = MAIN_BACKGROUND_COLOR;
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.line];
        
    }
    return self;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(15, 44 - 0.5, APP_CONTENT_WIDTH, 0.5)];
        _line.backgroundColor = SEPARATOR_LINE_COLOR;
    }
    return _line;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (44 - 32)/2, 32, 32)];
    }
    return _iconImageView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [TPViewUtil simpleLabel:CGRectMake(self.iconImageView.right + 10, 0, APP_CONTENT_WIDTH - _iconImageView.right - 10, 44) f:14 tc:LIGHT_FONT_COLOR t:@""];
    }
    return _titleLabel;
}

- (void)setModel:(id)model {
    self.titleLabel.text = [model name];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[model iconUrl]] placeholderImage:nil];

}

@end
