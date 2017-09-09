//
//  MemberEditViewController.h
//  TuyaSmart
//
//  Created by fengyu on 15/3/10.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#import "ATBaseViewController.h"

@interface MemberEditViewController : ATBaseViewController

@property (nonatomic,strong) TuyaSmartMemberModel *member;
@property (nonatomic,assign) NSInteger type;
@end
