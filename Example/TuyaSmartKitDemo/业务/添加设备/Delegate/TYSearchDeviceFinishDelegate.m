//
//  TYSearchDeviceFinishDelegate.m
//  TuyaSmart
//
//  Created by 高森 on 16/1/8.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import "TYSearchDeviceFinishDelegate.h"
#import "TYMemberListViewController.h"

@implementation TYSearchDeviceFinishDelegate

- (void)helpAction:(TYSearchDeviceFinishView *)finishView {
    [ViewControllerUtils gotoWebViewController:NSLocalizedString(@"ty_ez_help", @"") url:@"http://smart.tuya.com/failure" from:tp_topMostViewController()];
}

- (void)retryAction:(TYSearchDeviceFinishView *)finishView {
    [MobClick event:@"event_netWorking_again"];
    [tp_topMostViewController().navigationController popToRootViewControllerAnimated:YES];
}

- (void)callAction:(TYSearchDeviceFinishView *)finishView {
    [MobClick event:@"event_netWorking_call"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-159-4688"]];
}

- (void)shareAction:(TYSearchDeviceFinishView *)finishView {
    [MobClick event:@"event_ez_connectDevice_share"];
    [tp_topMostViewController() dismissViewControllerAnimated:NO completion:^{
        [tp_topMostViewController().navigationController pushViewController:[TYMemberListViewController new] animated:YES];
    }];
}

- (void)doneAction:(TYSearchDeviceFinishView *)finishView deviceModel:(TuyaSmartDeviceModel *)deviceModel {
    [tp_topMostViewController() dismissViewControllerAnimated:NO completion:nil];
}

@end
