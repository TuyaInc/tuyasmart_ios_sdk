//
//  TPViewConstants.h
//  TuyaSmart
//
//  Created by fengyu on 15/9/7.
//  Copyright (c) 2015年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_TPViewConstants_h
#define TuyaSmart_TPViewConstants_h

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


// Color
#define HEXCOLORA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HEXCOLOR(rgbValue) HEXCOLORA(rgbValue, 1.0)

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r,g,b) RGBACOLOR(r,g,b,1)


// Screen
#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)
#define APP_STATUS_FRAME    [UIApplication sharedApplication].statusBarFrame

#define APP_TOP_BAR_HEIGHT    (IOS7 ? 64 : 44)
#define APP_STATUS_BAR_HEIGHT (IOS7 ? 20 : 0)
#define APP_TOOL_BAR_HEIGHT   49
#define APP_TAB_BAR_HEIGHT    49
#define APP_CONTENT_WIDTH     (APP_SCREEN_BOUNDS.size.width)
#define APP_CONTENT_HEIGHT    (APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT - APP_TAB_BAR_HEIGHT)
#define APP_VISIBLE_HEIGHT    (APP_SCREEN_HEIGHT - APP_TOP_BAR_HEIGHT)

//----------------- 配色 -----------------//

//导航栏、TabBar相关
#define TOP_BAR_TEXT_COLOR          HEXCOLOR(0x303030)
#define TOP_BAR_BACKGROUND_COLOR    HEXCOLOR(0xFAFAFA)
#define TAB_BAR_TEXT_COLOR          HEXCOLOR(0xFF5800)
#define TAB_BAR_BACKGROUND_COLOR    HEXCOLOR(0xFAFAFA)


//背景颜色
#define MAIN_BACKGROUND_COLOR       HEXCOLOR(0xF2F2F2)

//列表相关
#define LIST_MAIN_TEXT_COLOR        HEXCOLOR(0x303030)
#define LIST_SUB_TEXT_COLOR         HEXCOLOR(0x626262)
#define LIST_LIGHT_TEXT_COLOR       HEXCOLOR(0x9B9B9B)
#define LIST_LINE_COLOR             HEXCOLOR(0xDBDBDB)
#define LIST_BACKGROUND_COLOR       HEXCOLOR(0xFFFFFF)

//提示
#define NOTICE_TEXT_COLOR           HEXCOLOR(0xFF5800)
#define NOTICE_BACKGROUND_COLOR     HEXCOLOR(0xFFF8D8)

//按钮
#define BUTTON_TEXT_COLOR           HEXCOLOR(0xFFFFFF)
#define BUTTON_BACKGROUND_COLOR     HEXCOLOR(0xFF5800)
#define SUB_BUTTON_TEXT_COLOR       HEXCOLOR(0xFF5800)
#define SUB_BUTTON_BACKGROUND_COLOR HEXCOLOR(0xFFFFFF)

//----------------- 配色 -----------------//

//old
#define MAIN_COLOR                  BUTTON_BACKGROUND_COLOR
#define MAIN_FONT_COLOR             LIST_MAIN_TEXT_COLOR
#define SUB_FONT_COLOR              LIST_SUB_TEXT_COLOR
#define LIGHT_FONT_COLOR            LIST_LIGHT_TEXT_COLOR
#define SEPARATOR_LINE_COLOR        LIST_LINE_COLOR


//#define TPLocalizedString(key,comment) NSLocalizedStringFromTableInBundle(key, @"TPViewsLocalizable", [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"TPViews" ofType:@"bundle"]] , comment)
#define TPLocalizedString(key,comment) NSLocalizedStringFromTableInBundle(key, @"TPViewsLocalizable", [NSBundle mainBundle] , comment)


#endif
