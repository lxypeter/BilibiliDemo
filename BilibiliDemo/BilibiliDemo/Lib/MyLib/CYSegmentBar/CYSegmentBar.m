//
//  CYSegmentBar.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/3.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "CYSegmentBar.h"

@interface CYSegmentBar ()

@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) NSMutableArray *segmentButtons;

@property (nonatomic,strong) UIButton *selectedSegment;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *seperateLine;

@end

@implementation CYSegmentBar

#pragma mark - 懒加载
-(NSMutableArray *)segmentButtons{
    if (!_segmentButtons) {
        _segmentButtons = [NSMutableArray array];
    }
    return _segmentButtons;
}

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles validWidth:(CGFloat)validWidth{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        [self initViewsWithFrame:frame titles:titles validWidth:validWidth];
    }
    return self;
}

#pragma mark - 生成控件
-(void)initViewsWithFrame:(CGRect)frame titles:(NSArray *)titles validWidth:(CGFloat)validWidth{
    
    self.backgroundColor = [UIColor whiteColor];
    
    if (!titles||titles.count<=0) return;
    
    //底部图层
    CGRect bgFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    if (validWidth && validWidth > 0) {
        bgFrame.size.width = validWidth;
        bgFrame.origin.x = ([UIScreen mainScreen].bounds.size.width - validWidth)/2;
    }
    self.bgView = [[UIView alloc]initWithFrame:bgFrame];
    self.bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
    
    //按钮
    CGFloat btnWidth = self.bgView.frame.size.width/titles.count;
    CGFloat btnHeight = self.bgView.frame.size.height;
    
    for (int i = 0; i<titles.count; i++) {
        
        CGRect btnFrame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
        
        NSString *title = titles[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:btnFrame];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickSegmentBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.segmentButtons addObject:btn];
        [self.bgView addSubview:btn];
        
        //默认选中第一个
        if (i == 0) {
            self.selectedSegment = btn;
            btn.selected = YES;
        }
    }
    
    //选中条
    self.selectedBar = [[UIView alloc]initWithFrame:CGRectMake(0, btnHeight-3, btnWidth, 3)];
    self.selectedBar.backgroundColor = [UIColor blueColor];
    [self.bgView addSubview:self.selectedBar];
    
    //分割线
    UIView *seperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, btnHeight-0.5, frame.size.width, 0.5)];
    self.seperateLine = seperateLine;
    [self addSubview:seperateLine];
}

#pragma mark - 点击事件
-(void)clickSegmentBtn:(UIButton *)btn{
    [self selectBtn:btn];
}

#pragma mark - 选中
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    UIButton *btn = self.segmentButtons[selectedIndex];
    [self selectBtn:btn];
}

-(void)selectBtn:(UIButton *)btn{
    if (btn == self.selectedSegment) return;
    
    _selectedIndex = btn.tag;
    
    self.selectedSegment.selected = NO;
    
    btn.selected = YES;
    
    self.selectedSegment = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.selectedBar.frame;
        frame.origin.x = btn.frame.origin.x;
        self.selectedBar.frame = frame;
    }];
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(cySegmentBar:indexOfSelectedSegment:)]) {
        [self.delegate cySegmentBar:self indexOfSelectedSegment:btn.tag];
    }
}

#pragma mark - 颜色设置
-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    for (UIButton *btn in self.segmentButtons) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    self.selectedBar.backgroundColor = selectedColor;
}

-(void)setUnselectedColor:(UIColor *)unselectedColor{
    _unselectedColor = unselectedColor;
    for (UIButton *btn in self.segmentButtons) {
        [btn setTitleColor:unselectedColor forState:UIControlStateNormal];
    }
}

-(void)setSeperateLineColor:(UIColor *)seperateLineColor{
    _seperateLineColor = seperateLineColor;
    self.seperateLine.backgroundColor = seperateLineColor;
}

#pragma mark - 字体设置
-(void)setFont:(UIFont *)font{
    _font = font;
    for (UIButton *btn in self.segmentButtons) {
        btn.titleLabel.font = font;
    }
}

-(void)setSelectedBarProgress:(CGFloat)selectedBarProgress{
    
    //移动选中条
    CGRect selectedBarFrame = self.selectedBar.frame;
    selectedBarFrame.origin.x = selectedBarProgress * self.selectedBar.frame.size.width *(self.titles.count-1);
    self.selectedBar.frame = selectedBarFrame;
    
    //计算选中index
    int selectedIndex = selectedBarProgress / (1.0/(self.titles.count-1));
    
    if (selectedIndex == self.selectedSegment.tag) return;
    
    _selectedIndex = selectedIndex;
    
    self.selectedSegment.selected = NO;
    UIButton *selectedBtn = self.segmentButtons[selectedIndex];
    selectedBtn.selected = YES;
    
    self.selectedSegment = selectedBtn;

}
@end
