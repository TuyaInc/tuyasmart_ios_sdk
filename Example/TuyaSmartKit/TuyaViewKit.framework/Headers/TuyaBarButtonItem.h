//
//  ATBarButtonItem.h
//  AirTake
//
//  Created by fisher on 14-6-20.
//  Copyright (c) 2014年 hanbolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    ATBarButtonSystemItemLeftWithIcon = 1,
    ATBarButtonSystemItemLeftWithoutIcon,
    ATBarButtonSystemItemCenter,
    ATBarButtonSystemItemRight,
}ATBarButtonSystemItem;



@interface TuyaBarButtonItem : NSObject
{
    
}


@property (nonatomic, assign) ATBarButtonSystemItem systemItem;
@property (nonatomic, strong) UIImage*              image;
@property (nonatomic, strong) UIImage*              highlightImage;
@property (nonatomic, strong) UIImage*              selectedImage;
@property (nonatomic, strong) UIImage*              backgroundImage;
@property (nonatomic, strong) UIImage*              disabledImage;
@property (nonatomic, strong) NSString*             title;
@property (nonatomic, assign) CGFloat               width;
@property (nonatomic, strong) UIView*               customView;
@property (nonatomic, assign) id                    target;
@property (nonatomic, assign) SEL                   action;
//@property (nonatomic, strong) UIView*               itemView;
@property (nonatomic, assign) BOOL                  selected;
@property (nonatomic, assign) BOOL                  enabled;

@property (nonatomic,assign) float                  contentInsets;


+(TuyaBarButtonItem *)rightTitleItem:(id)target action:(SEL)action;
+(TuyaBarButtonItem *)leftBackItem:(id)target action:(SEL)action;
+(TuyaBarButtonItem *)leftCancelItem:(id)target action:(SEL)action;
+(TuyaBarButtonItem *)rightCancelItem:(id)target action:(SEL)action;
+(TuyaBarButtonItem *)centerTitleItem:(id)target action:(SEL)action;
+(TuyaBarButtonItem *)centerLogoItem:(id)target action:(SEL)action;

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
      selectedImage:(UIImage *)selectedImage
    backgroundImage:(UIImage *)backgroundImage
             target:(id)target
             action:(SEL)action;


- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
      selectedImage:(UIImage *)selectedImage
      disabledImage:(UIImage *)disabledImage
    backgroundImage:(UIImage *)backgroundImage
             target:(id)target
             action:(SEL)action;



- (id)initWithBarButtonSystemItem:(ATBarButtonSystemItem)systemItem
                            title:(NSString *)title;



- (id)initWithBarButtonSystemItem:(ATBarButtonSystemItem)systemItem
                            title:(NSString *)title
                           target:(id)target
                           action:(SEL)action;




- (id)initWithCustomView:(UIView *)customView;



@end
