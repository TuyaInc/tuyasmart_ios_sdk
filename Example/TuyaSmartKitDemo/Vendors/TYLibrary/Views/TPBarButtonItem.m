//
//  ATBarButtonItem.m
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import "TPBarButtonItem.h"
#import "TPViewConstants.h"
#import "TPBaseView.h"

@implementation TPBarButtonItem

+ (TPBarButtonItem *)rightTitleItem:(id)target action:(SEL)action {
    return [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemRight title:UIKitLocalizedString(@"Done") target:target action:action];
}

+ (TPBarButtonItem *)leftBackItem:(id)target action:(SEL)action {
    return [[TPBarButtonItem alloc ] initWithBarButtonSystemItem:TPBarButtonSystemItemLeftWithIcon title:UIKitLocalizedString(@"Back") target:target action:action];
}

+ (TPBarButtonItem *)leftCancelItem:(id)target action:(SEL)action {
    return [[TPBarButtonItem alloc ] initWithBarButtonSystemItem:TPBarButtonSystemItemLeftWithoutIcon title:UIKitLocalizedString(@"Cancel") target:target action:action];
}

+ (TPBarButtonItem *)rightCancelItem:(id)target action:(SEL)action {
    return [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemRight title:TPLocalizedString(@"close", nil) target:target action:action];
}

+ (TPBarButtonItem *)centerTitleItem:(id)target action:(SEL)action {
    return [[TPBarButtonItem alloc] initWithBarButtonSystemItem:TPBarButtonSystemItemCenter title:@"Title"];
}

+ (TPBarButtonItem *)centerLogoItem:(id)target action:(SEL)action {
    return [[TPBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logo"] highlightedImage:[UIImage imageNamed:@"logo"] selectedImage:[UIImage imageNamed:@"logo"] disabledImage:[UIImage imageNamed:@"logo"] backgroundImage:nil target:target action:action];
}

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
      selectedImage:(UIImage *)selectedImage
    backgroundImage:(UIImage *)backgroundImage
             target:(id)target
             action:(SEL)action {
    
    if (self = [super init]) {
        
        self.image = image;
        self.highlightImage = highlightedImage;
        self.selectedImage = selectedImage;
        self.backgroundImage = backgroundImage;
        self.target = target;
        self.action = action;
        
        _contentInsets = NAN;
    }
    return self;
}


- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
      selectedImage:(UIImage *)selectedImage
      disabledImage:(UIImage *)disabledImage
    backgroundImage:(UIImage *)backgroundImage
             target:(id)target
             action:(SEL)action {
    if (self = [super init]) {

        self.image = image;
        self.highlightImage = highlightedImage;
        self.selectedImage = selectedImage;
        self.disabledImage = disabledImage;
        self.backgroundImage = backgroundImage;
        self.target = target;
        self.action = action;
        _contentInsets = NAN;
    }
    return self;

    
}


- (id)initWithBarButtonSystemItem:(TPBarButtonSystemItem)systemItem
                            title:(NSString *)title {
    if (self = [super init]) {
        self.systemItem = systemItem;
        self.title = title;
        _contentInsets = NAN;
    }
    return self;
}

- (id)initWithBarButtonSystemItem:(TPBarButtonSystemItem)systemItem
                            title:(NSString *)title
                           target:(id)target
                           action:(SEL)action {
    if (self = [super init]) {
        self.systemItem = systemItem;
        self.title = title;
        self.target = target;
        self.action = action;
        _contentInsets = NAN;
    }
    return self;

}

- (id)initWithBarButtonSystemItem:(TPBarButtonSystemItem)systemItem
                           target:(id)target
                           action:(SEL)action {
    if (self = [super init]) {
        self.systemItem = systemItem;
        self.target = target;
        self.action = action;
        _contentInsets = NAN;
    }
    return self;

}



- (id)initWithCustomView:(UIView *)customView {
    if (self = [super init]) {
        self.customView = customView;
    }
    return self;
}




@end
