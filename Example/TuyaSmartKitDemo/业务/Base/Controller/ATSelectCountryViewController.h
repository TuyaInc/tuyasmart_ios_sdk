//
//  ATSelectCountryViewController.h
//  Airtake
//
//  Created by fisher on 14/12/11.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "ATTableViewController.h"
#import "ATCountryCodeModel.h"

@class ATSelectCountryViewController;

@protocol ATSelectCountryDelegate <NSObject>

- (void)didSelectCountry:(ATSelectCountryViewController *)controller model:(ATCountryCodeModel *)model;

@end

@interface ATSelectCountryViewController : ATBaseViewController

@property (nonatomic,weak) id <ATSelectCountryDelegate> delegate;

@end
