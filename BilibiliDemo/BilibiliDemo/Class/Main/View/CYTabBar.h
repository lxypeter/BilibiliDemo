//
//  CYTabBar.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/1.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTabBar;
@protocol CYTabBarDelegate <NSObject>

-(void)cyTabBar:(CYTabBar *)tabBar indexOfBtnClicked:(NSInteger)index;

@end

@interface CYTabBar : UIView

@property (nonatomic,weak) id delegate;

@end
