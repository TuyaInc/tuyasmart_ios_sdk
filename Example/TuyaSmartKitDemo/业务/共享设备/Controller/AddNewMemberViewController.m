//
//  AddNewMemberViewController.m
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "AddNewMemberViewController.h"
#import "AddMemberView.h"
#import "ATSelectCountryViewController.h"
#import "TPViewUtil.h"
#import "TPCountryCodeUtils.h"

@interface AddNewMemberViewController () <ATSelectCountryDelegate>

@property (nonatomic,strong) AddMemberView      *addMemberView;
@property (nonatomic,strong) ATCountryCodeModel *countryCodeModel;
@property (nonatomic,strong) TuyaSmartMember    *memberService;

@end

@implementation AddNewMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initCountryCode];
}

-(void)initView {
    self.view.backgroundColor = MAIN_BACKGROUND_COLOR;
    
    [self initTopBarView];
    [self initAddMemberView];
}

-(void)initTopBarView {
    self.topBarView.leftItem = self.leftCancelItem;
    
    self.centerTitleItem.title = NSLocalizedString(@"new_share", @"");
    self.topBarView.centerItem = self.centerTitleItem;
    
    [self.view addSubview:self.topBarView];
}

-(void)initAddMemberView {
    _addMemberView = [[AddMemberView alloc] initWithFrame:CGRectMake(0, APP_TOP_BAR_HEIGHT, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TAB_BAR_HEIGHT)];
    [_addMemberView.countryCodeLabel addGestureRecognizer:[TPViewUtil singleFingerClickRecognizer:self sel:@selector(selectCountryCode)]];
//    [_addMemberView.contactBookButton addTarget:self action:@selector(selectContact) forControlEvents:UIControlEventTouchUpInside];
    [_addMemberView.submitButton addTarget:self action:@selector(submitButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addMemberView];
    
}

-(void)initCountryCode {
    ATCountryCodeModel *model = [ATCountryCodeModel getCountryCodeModel:[TPCountryCodeUtils getDefaultPhoneCodeJson] phoneCode:[TuyaSmartUser sharedInstance].countryCode];
    [self setCountryCode:model];
}

-(void)selectCountryCode {
    ATSelectCountryViewController *selectCountryViewController = [[ATSelectCountryViewController alloc] init];
    selectCountryViewController.delegate = self;
    [self presentViewController:selectCountryViewController animated:YES completion:nil];
}

-(void)setCountryCode:(ATCountryCodeModel *)model {
    _countryCodeModel = model;
    _addMemberView.countryCodeLabel.text = [NSString stringWithFormat:@"%@ +%@", model.countryName, model.countryCode];
}

- (TuyaSmartMember *)memberService {
    if (!_memberService) {
        _memberService = [TuyaSmartMember new];
    }
    return _memberService;
}

-(void)submitButtonTap:(UIButton *)button {
    
    NSString *userAccount = [_addMemberView phoneNumber];
    [_addMemberView.phoneNumberTextField resignFirstResponder];
    
    if (userAccount.length == 0) {
        [TPProgressUtils showError:NSLocalizedString(@"username_phone_is_null", @"")];
        return;
    }
    
    WEAKSELF_AT
    [self showProgressView];
    [self.memberService addNewMember:@"" phoneCode:_countryCodeModel.countryCode userAccount:userAccount relationship:TYRelationshipOther success:^{
        [weakSelf_AT hideProgressView];
        
        [weakSelf_AT tp_dismissModalViewController];
    } failure:^(NSError *error) {
        [weakSelf_AT hideProgressView];
        [TPProgressUtils showError:error.localizedDescription];
    }];
}

#pragma mark - ATSelectCountryDelegate

- (void)didSelectCountry:(ATSelectCountryViewController *)controller model:(ATCountryCodeModel *)model {
    [self setCountryCode:model];
    [controller tp_dismissModalViewController];
}

@end
