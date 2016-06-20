//
//  TuyaViewConstants.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TuyaViewConstants_h
#define TuyaSmart_TuyaViewConstants_h

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define HEXCOLORA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HEXCOLOR(rgbValue) HEXCOLORA(rgbValue, 1.0)

#define TUYA_APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define TUYA_APP_SCREEN_HEIGHT   (TUYA_APP_SCREEN_BOUNDS.size.height)
#define TUYA_APP_SCREEN_WIDTH    (TUYA_APP_SCREEN_BOUNDS.size.width)
#define TUYA_APP_STATUS_FRAME    [UIApplication sharedApplication].statusBarFrame
#define TUYA_APP_CONTENT_WIDTH   (TUYA_APP_SCREEN_BOUNDS.size.width)
#define TUYA_APP_VISIBLE_HEIGHT  (TUYA_APP_SCREEN_HEIGHT - 64)

#define HELVETICA_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]
#define HELVETICA_Medium_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Medium" size:s]
#define HELVETICA_REGULAR_FONT(s) [UIFont fontWithName:@"HelveticaNeue-Regular" size:s]
#define HELVETICANEUE_FONT(s) [UIFont fontWithName:@"HelveticaNeue" size:s]
#define GOTHAMBOOK_FONT(s) [UIFont fontWithName:@"GothamBook" size:s]
#define GOTHAMBOLD_FONT(s) [UIFont fontWithName:@"GothamBold" size:s]
#define HEIZHONG_FONT(s) [UIFont fontWithName:@"STHeitiSC-Medium" size:s]

#define TUYA_APP_TOP_BAR_HEIGHT    (IOS7 ? 64 : 44)
#define TUYA_APP_TOOL_BAR_HEIGHT   49
#define TUYA_APP_STATUS_BAR_HEIGHT (IOS7 ? 20 : 0)
#define TUYA_APP_TAB_BAR_HEIGHT    49
#define TUYA_APP_CONTENT_HEIGHT  (TUYA_APP_SCREEN_HEIGHT - TUYA_APP_TOP_BAR_HEIGHT - TUYA_APP_TAB_BAR_HEIGHT)

#define TUYA_MAIN_BACKGROUND_COLOR HEXCOLOR(0xF0F0F0)

#define TUYA_TOP_BAR_BACKGROUND_COLOR HEXCOLOR(0xFF4800)
#define TUYA_TOP_BAR_TEXT_COLOR HEXCOLOR(0xFFFFFF)
#define TUYA_TOP_BAR_SUB_TEXT_COLOR HEXCOLOR(0xFFFFFF)
#define TUYA_TOP_BAR_SUB_TEXT_SELECTED_COLOR HEXCOLORA(0xFFFFFF, 0.5)


#define TUYA_MAIN_COLOR HEXCOLOR(0xFF4800)
#define TUYA_MAIN_FONT_COLOR HEXCOLOR(0x303030)
#define TUYA_SUB_FONT_COLOR HEXCOLOR(0x626262)
#define TUYA_LIGHT_FONT_COLOR HEXCOLOR(0x9B9B9B)
#define TUYA_SEPARATOR_LINE_COLOR HEXCOLOR(0xDBDBDB)

#endif
