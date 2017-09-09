//
//  AddMemberView.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/2.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "AddMemberView.h"

@implementation AddMemberView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self addPromptLabel];
    [self addPhoneNumberView];
    [self addSubview:self.submitButton];
    
    return self;
}

-(void)addPromptLabel {
    
    NSLog(@"addPromptLabel");
    
    UILabel *promptLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 24, APP_SCREEN_WIDTH, 20) fontSize:14 color:LIGHT_FONT_COLOR];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    
    promptLabel.text = NSLocalizedString(@"add_new_user_tip", @"");
    
    [self addSubview:promptLabel];
}

-(void)addPhoneNumberView {
    UIView *phoneNumberView = [TPViewUtil viewWithFrame:CGRectMake(15, 54, APP_SCREEN_WIDTH - 30, 44) color:[UIColor whiteColor]];
    phoneNumberView.layer.cornerRadius = 4;
    
    [phoneNumberView addSubview:self.countryCodeLabel];
    [phoneNumberView addSubview:self.phoneNumberTextField];
    [phoneNumberView addSubview:self.contactBookButton];
    [phoneNumberView addSubview:[TPViewUtil viewWithFrame:CGRectMake(self.countryCodeLabel.right, 8, 0.5, phoneNumberView.height - 16) color:SEPARATOR_LINE_COLOR]];
    
    [self addSubview:phoneNumberView];
}

-(UILabel *)countryCodeLabel {
    if (!_countryCodeLabel) {
        _countryCodeLabel = [TPViewUtil labelWithFrame:CGRectMake(0, 0, 94, 44) fontSize:14 color:MAIN_COLOR];
        _countryCodeLabel.textAlignment = NSTextAlignmentCenter;
        _countryCodeLabel.userInteractionEnabled = YES;
    }
    return _countryCodeLabel;
}

-(UITextField *)phoneNumberTextField {
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [TPViewUtil textFieldWithFrame:CGRectMake(94 + 15, 0, APP_SCREEN_WIDTH - 30 - 94 - 15, 44) fontSize:16 color:[UIColor blackColor]];
        _phoneNumberTextField.placeholder = NSLocalizedString(@"phone_number", @"");
//        _phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneNumberTextField;
}

-(UIButton *)contactBookButton {
    if (!_contactBookButton) {
        _contactBookButton = [TPViewUtil buttonWithFrame:CGRectMake(APP_SCREEN_WIDTH - 30 - 44, 0, 44, 44) fontSize:16 bgColor:[UIColor clearColor] textColor:[UIColor blackColor]];
        [_contactBookButton setBackgroundImage:[[UIImage imageNamed:@"tysmart_addshare_contact"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        _contactBookButton.tintColor = MAIN_COLOR;
    }
    return _contactBookButton;
}

-(UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [TPViewUtil buttonWithFrame:CGRectMake(15, 108, APP_SCREEN_WIDTH - 30, 44) fontSize:16 bgColor:MAIN_COLOR textColor:[UIColor whiteColor]];
        [_submitButton setTitle:NSLocalizedString(@"confirm", @"") forState:UIControlStateNormal];
    }
    return _submitButton;
}

-(NSString *)phoneNumber {
    return _phoneNumberTextField.text;
}

@end
