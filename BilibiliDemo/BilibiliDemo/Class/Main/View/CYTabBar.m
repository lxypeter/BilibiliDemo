//
//  CYTabBar.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/1.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "CYTabBar.h"

@interface CYTabBar ()

@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation CYTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat border = (ScreenWidth - 50.0*4)/5;
    
    UIButton *indexBtn = [[UIButton alloc]init];
    [indexBtn setBackgroundImage:[UIImage imageNamed:@"index_normal"] forState:UIControlStateNormal];
    [indexBtn setBackgroundImage:[UIImage imageNamed:@"index_selected"] forState:UIControlStateHighlighted];
    [indexBtn setBackgroundImage:[UIImage imageNamed:@"index_selected"] forState:UIControlStateSelected];
    indexBtn.tag = 0;
    indexBtn.selected = YES;
    self.selectedBtn = indexBtn;
    [indexBtn addTarget:self action:@selector(clickTabBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:indexBtn];
    
    UIButton *focusBtn = [[UIButton alloc]init];
    [focusBtn setBackgroundImage:[UIImage imageNamed:@"focus_normal"] forState:UIControlStateNormal];
    [focusBtn setBackgroundImage:[UIImage imageNamed:@"focus_selected"] forState:UIControlStateHighlighted];
    [focusBtn setBackgroundImage:[UIImage imageNamed:@"focus_selected"] forState:UIControlStateSelected];
    focusBtn.tag = 1;
    [focusBtn addTarget:self action:@selector(clickTabBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:focusBtn];
    
    UIButton *findBtn = [[UIButton alloc]init];
    [findBtn setBackgroundImage:[UIImage imageNamed:@"find_normal"] forState:UIControlStateNormal];
    [findBtn setBackgroundImage:[UIImage imageNamed:@"find_selected"] forState:UIControlStateHighlighted];
    [findBtn setBackgroundImage:[UIImage imageNamed:@"find_selected"] forState:UIControlStateSelected];
    findBtn.tag = 2;
    [findBtn addTarget:self action:@selector(clickTabBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:findBtn];
    
    UIButton *mineBtn = [[UIButton alloc]init];
    [mineBtn setBackgroundImage:[UIImage imageNamed:@"mine_normal"] forState:UIControlStateNormal];
    [mineBtn setBackgroundImage:[UIImage imageNamed:@"mine_selected"] forState:UIControlStateHighlighted];
    [mineBtn setBackgroundImage:[UIImage imageNamed:@"mine_selected"] forState:UIControlStateSelected];
    mineBtn.tag = 3;
    [mineBtn addTarget:self action:@selector(clickTabBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mineBtn];
    
    [indexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.centerY.equalTo(self.mas_centerY);
        make.left.mas_equalTo(border);
    }];
    
    [focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(indexBtn.mas_right).offset(border);
    }];
    
    [findBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(focusBtn.mas_right).offset(border);
    }];
    
    [mineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(findBtn.mas_right).offset(border);
        make.right.mas_equalTo(-border);
    }];
}

#pragma mark - 点击事件
-(void)clickTabBarBtn:(UIButton *)btn{
    
    if(self.selectedBtn == btn) return;
    
    self.selectedBtn.selected = NO;
    
    btn.selected = YES;
    
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(cyTabBar:indexOfBtnClicked:)]) {
        [self.delegate cyTabBar:self indexOfBtnClicked:btn.tag];
    }
    
}

@end
