//
//  TYMemberListCell.m
//  TuyaSmart
//
//  Created by 冯晓 on 16/1/7.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYMemberListCell.h"

@interface TYMemberListCell()

@property (nonatomic,strong) UILabel              *nickNameLabel;
@property (nonatomic,strong) UILabel              *userNameLabel;

@end

@implementation TYMemberListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:[TPViewUtil rightArrowImageView:CGRectMake(APP_SCREEN_WIDTH - 22,(self.height-12)/2, 7, 12)]];
    
    return self;
}


- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [TPViewUtil labelWithFrame:CGRectMake(15, 0, 135, 45) fontSize:16 color:MAIN_FONT_COLOR];
        _nickNameLabel.width = APP_CONTENT_WIDTH - 15 - 36 - 120;
    }
    return _nickNameLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 0, 200, 45) fontSize:14 color:LIGHT_FONT_COLOR];
        _userNameLabel.right = APP_CONTENT_WIDTH - 36;
        _userNameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _userNameLabel;
}

- (void)setMember:(TuyaSmartMemberModel *)member {
    _member                = member;
    _nickNameLabel.text    = member.nickName;
    _userNameLabel.text = member.userName;
}



@end
