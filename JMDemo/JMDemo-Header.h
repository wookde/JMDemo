//
//  JMDemo-Header.h
//  JMDemo
//
//  Created by liujiemin on 2021/7/21.
//

#ifndef JMDemo_Header_h
#define JMDemo_Header_h

#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 时间状态栏高度*/
#define KGStatusBarH [UIApplication sharedApplication].statusBarFrame.size.height
/** 底部安全区域高度*/
#define KGBottomSafeAreaH [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom
/** 时间状态栏高度*/
#define KGNaviBarH KGStatusBarH + 44
/** 屏幕宽度*/
#define KGScreenW [[UIScreen mainScreen] bounds].size.width
/** 屏幕高度*/
#define KGScreenH [[UIScreen mainScreen] bounds].size.height
/** 等比例*/
#define KGScreenZoom(value) (KGScreenW * value / 375.0)
#define KGScreenZoomH(value) ((KGScreenW/KGScreenH < 375.0/667.0) ? (KGScreenW * value / 375.0) : (KGScreenH * value / 667.0))

#define KGColorRGB16(hexValue,ad) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:ad]

#import <Masonry/Masonry.h>

#endif /* JMDemo_Header_h */
