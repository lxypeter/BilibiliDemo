//
//  CYSegmentBar.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/3.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYSegmentBar;
@protocol CYSegmentBarDelegate <NSObject>

-(void)cySegmentBar:(CYSegmentBar *)segmentBar indexOfSelectedSegment:(NSInteger)index;

@end

@interface CYSegmentBar : UIView

/**
 *  代理
 */
@property (nonatomic,weak) id<CYSegmentBarDelegate> delegate;

@property (nonatomic,strong) UIView *selectedBar;

/**
 *  选中标题及选中条颜色
 */
@property (nonatomic,strong) UIColor *selectedColor;

/**
 *  未选中标题颜色
 */
@property (nonatomic,strong) UIColor *unselectedColor;

/**
 *  分割线颜色
 */
@property (nonatomic,strong) UIColor *seperateLineColor;

/**
 *  标题字体
 */
@property (nonatomic,strong) UIFont *font;

/**
 *  选中序列
 */
@property (nonatomic,assign) NSInteger selectedIndex;

/**
 *  选中条水平平移进度
 */
@property (nonatomic,assign) CGFloat selectedBarProgress;

/**
 *  初始化方法
 *
 *  @param frame
 *  @param titles     标题列表
 *  @param validWidth 中间显示有效宽度，可以为空
 *
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles validWidth:(CGFloat)validWidth;

@end
