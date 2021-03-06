//
//  MainMacro.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/3/30.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#ifndef MainMacro_h
#define MainMacro_h

#pragma mark - 系统版本
// 当前版本
#define KFSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define KDSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define KSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 是否IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
//是否 iOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




#pragma mark - 设备宽高
//当前应用程序的bounds
#define kAppBounds [[UIScreen mainScreen] bounds]

//顶部导航控制器高度
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height

//顶部状态栏高度
#define kTopStatusViewHeight 20

//NavBar高度
#define NavigationBar_HEIGHT 44
#define NavigationBarHeight (self.navigationController.navigationBar.frame.size.height + 20)
//顶部TabBar的高度
#define TabBarHegith self.tabBarController.tabBar.frame.size.height

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width



#pragma mark - 颜色相关
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UICOLOR(A)  [UIColor colorWithHexString:A]

#define kPinkColor UICOLOR(@"#EA7B9A")
#define kTextGrayColor UICOLOR(@"#969696")

#pragma mark - 图片相关
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]


#pragma mark - 字体相关
#define kFont_10 [UIFont systemFontOfSize: 10]
#define kFont_12 [UIFont systemFontOfSize: 12]
#define kFont_13 [UIFont systemFontOfSize: 13]
#define kFont_14 [UIFont systemFontOfSize: 14]
#define kFont_15 [UIFont systemFontOfSize: 15]
#define kFont_17 [UIFont systemFontOfSize: 17]
#define kFont_20 [UIFont systemFontOfSize: 20]

//label离边界的边距---
#define kLabelTextBorderSpace_5 5
#define kLabelTextBorderSpace_10 10
#define kLabelTextBorderSpace_15 15
#define kLabelTextBorderSpace_20 20
#define kLabelTextBorderSpace_25 25
#define kLabelTextBorderSpace_30 30
#define kLabelTextBorderSpace_35 35
#define kLabelTextBorderSpace_40 40
#define kLabelTextBorderSpace_45 45
#define kLabelTextBorderSpace_50 50

#endif /* MainMacro_h */
