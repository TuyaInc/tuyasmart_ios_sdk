//
//  ShareViewController.m
//  TuyaSmartKitDemo
//
//  Created by 高森 on 15/12/28.
//  Copyright © 2015年 Tuya. All rights reserved.
//

#import "ShareViewController.h"
#import "AddShareViewController.h"

#import <TuyaSmartKit/TuyaSmartKit.h>
#import <TuyaViewKit/TuyaViewKit.h>

@interface ShareViewController() <TuyaTopBarViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TuyaSmartMember *smartMember;

@property (nonatomic, strong) TuyaLayoutView *shareView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addShareButton;

@property (nonatomic, strong) NSArray *memberList;
@property (nonatomic, strong) NSArray *receiveMemberList;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)initView {
    self.view = self.shareView;
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    
    [self.view addSubview:self.addShareButton];
}

- (void)reloadData {
    
    WEAKSELF_TY
    [self.smartMember getMemberList:^(NSArray *List) {
        weakSelf_TY.memberList = List;
        [weakSelf_TY.tableView reloadData];
    } failure:^{
        ;
    }];
    
    [self.smartMember getReceiveMemberList:^(NSArray *List) {
        weakSelf_TY.receiveMemberList = List;
        [weakSelf_TY.tableView reloadData];
    } failure:^{
        ;
    }];
}

- (TuyaSmartMember *)smartMember {
    if (!_smartMember) {
        _smartMember = [[TuyaSmartMember alloc] init];
    }
    return _smartMember;
}

- (TuyaLayoutView *)shareView {
    if (!_shareView) {
        _shareView = [[TuyaLayoutView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - 49)];
        _shareView.topBarView.centerItem.title = @"共享";
        _shareView.topBarView.leftItem.title = NSLocalizedString(@"action_back", @"");
        _shareView.topBarDelegate = self;
        [_shareView addSubview:_shareView.topBarView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//        static NSString *cellIdentifier = @"shareCellIdentifier";
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        [_shareView addSubview:_tableView];
    }
    return _shareView;
}

- (UIButton *)addShareButton {
    if (!_addShareButton) {
        _addShareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, APP_SCREEN_HEIGHT - 49, APP_SCREEN_WIDTH, 49)];
        _addShareButton.backgroundColor = [UIColor whiteColor];
        _addShareButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addShareButton setTitleColor:HEXCOLOR(0x708088) forState:UIControlStateNormal];
        [_addShareButton setTitle:NSLocalizedString(@"new_share", @"") forState:UIControlStateNormal];
        [_addShareButton addTarget:self action:@selector(addShareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addShareButton;
}

- (void)addShareAction {
    [self presentViewController:[AddShareViewController new] animated:YES completion:nil];
}

#pragma mark - TuyaTopBarViewDelegate

- (void)topBarLeftItemTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)topBarCenterItemTap {
    
}

- (void)topBarRightItemTap {
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.memberList.count;
    } else if (section == 1) {
        return self.receiveMemberList.count;
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"下列用户正在共享你绑定的设备";
    } else if (section == 1) {
        return @"下列用户绑定的设备已经共享给你";
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"shareCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    TuyaSmartMemberModel *member;
    if (indexPath.section == 0) {
        member = [self.memberList objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        member = [self.receiveMemberList objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = member.nickName;
    cell.detailTextLabel.text = member.userName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TuyaSmartMemberModel *member;
        if (indexPath.section == 0) {
            member = [self.memberList objectAtIndex:indexPath.row];
        } else if (indexPath.section == 1) {
            member = [self.receiveMemberList objectAtIndex:indexPath.row];
        }
        
        WEAKSELF_TY
        [self.smartMember removeMember:member.memberId success:^{
            [weakSelf_TY showProgress:@"删除成功" hideDelay:1.0];
            [weakSelf_TY reloadData];
        } failure:^(NSError *error) {
            [weakSelf_TY showProgress:error.localizedDescription hideDelay:1.0];
            [weakSelf_TY reloadData];
        }];
        
    }
}

@end
