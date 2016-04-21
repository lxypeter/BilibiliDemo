//
//  FocusTagView.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/6.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "FocusTagView.h"
#import "RoundTagButton.h"

@implementation TagRefreshButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width * 0.8, contentRect.size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    return CGRectMake(contentRect.size.width * 0.8, (contentRect.size.height - 20)/2, 20, 20);
}

@end

@interface FocusTagView ()

@property (nonatomic,strong) UILabel *introduceLabel;

@property (nonatomic,strong) UIButton *focusButton;

@property (nonatomic,strong) TagRefreshButton *tagRefreshButton;

@property (nonatomic,strong) UIView *tagView;

@end

@implementation FocusTagView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

#pragma mark - 初始化页面
- (void)initSubViews{
    
    self.backgroundColor = UICOLOR(@"#F6F6F6");
    
    //顶部介绍Label
    UILabel *introduceLabel = [[UILabel alloc]init];
    introduceLabel.text = @"快来看看对哪个标签感兴趣！";
    introduceLabel.font = kFont_13;
    introduceLabel.textAlignment = NSTextAlignmentCenter;
    self.introduceLabel = introduceLabel;
    [self addSubview:introduceLabel];

    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(30);
        make.right.mas_offset(0);
        make.left.mas_offset(0);
        make.height.mas_offset(12);
    }];
    
    //底部关注按钮
    UIButton *focusButton = [[UIButton alloc]init];
    focusButton.titleLabel.font = kFont_12;
    focusButton.backgroundColor = [UIColor whiteColor];
    UIColor *btnColor = kPinkColor;
    [focusButton setTitle:@"马上关注！" forState:UIControlStateNormal];
    [focusButton setTitleColor:btnColor forState:UIControlStateNormal];
    focusButton.layer.masksToBounds = YES;
    focusButton.layer.cornerRadius = 5;
    focusButton.layer.borderColor = btnColor.CGColor;
    focusButton.layer.borderWidth = 1;
    self.focusButton = focusButton;
    [self addSubview:focusButton];
    
    [focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.left.mas_offset(10);
        make.height.mas_offset(50);
    }];
    
    //换一拨按钮
    TagRefreshButton *tagRefreshButton = [[TagRefreshButton alloc]init];
    tagRefreshButton.titleLabel.font = kFont_13;
    tagRefreshButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tagRefreshButton setTitle:@"再换一拨看看" forState:UIControlStateNormal];
    [tagRefreshButton setTitleColor:kPinkColor forState:UIControlStateNormal];
    [tagRefreshButton setImage:[UIImage imageNamed:@"refreshIcon"] forState:UIControlStateNormal];
    [tagRefreshButton addTarget:self action:@selector(refreshButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.tagRefreshButton = tagRefreshButton;
    [self addSubview:tagRefreshButton];
    
    [tagRefreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(focusButton.mas_top).offset(-30);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(125);
    }];
    
    //标签父View
    UIView *tagView = [[UIView alloc]init];
    self.tagView = tagView;
    [self addSubview:tagView];
    
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introduceLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(tagRefreshButton.mas_top).offset(-10);
    }];
}

#pragma mark - 刷新按钮点击
- (void)refreshButtonClicked:(TagRefreshButton *)btn{
    
    //动画效果
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"transform.rotation";
    
    animation.toValue = @(M_PI *4);
    
    animation.duration = 1;
    
    [btn.imageView.layer addAnimation:animation forKey:nil];
    
    //刷新操作
    if (self.refreshButtonBlock) {
        self.refreshButtonBlock();
    }
    
}

#pragma mark - 标签按钮点击
- (void)tagButtonClick:(RoundTagButton *)tagButton{
    tagButton.selected = !tagButton.selected;
}

#pragma mark - 关注按钮点击
- (void)focusButtonClick:(UIButton *)btn{
    //关注操作
    if (self.focusButtonBlock) {
        self.focusButtonBlock();
    }
}

//设置标签
- (void)setTagArray:(NSArray *)tagArray{
    
    for (UIView *subView in self.tagView.subviews) {
        [subView removeFromSuperview];
    }
    
    NSMutableArray *threeColumnArray = [NSMutableArray array];
    NSMutableArray *fourColumnArray = [NSMutableArray array];
    
    //创建button 并分类
    for (int i=0; i<tagArray.count; i++) {
        
        UIColor *btnColor;
        if (i<7) {
            btnColor = UICOLOR(@"#f2bc42");
        }else if (i>=17) {
            btnColor = UICOLOR(@"#52aef8");
        }else{
            btnColor = UICOLOR(@"#b7d278");
        }
        
        RoundTagButton *tagButton = [RoundTagButton roundTagButtonWithTitle:tagArray[i] Color:btnColor Height:35];
        [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i%7<3) {//3列
            [threeColumnArray addObject:tagButton];
        }else{//4列
            [fourColumnArray addObject:tagButton];
        }
    }
    
    CGFloat btnMarginH = 3;
    CGFloat rowHeight = 50;
    //添加三列行
    for (int i = 0; i<threeColumnArray.count/3; i++) {
        int beginIndex = i *3;
        RoundTagButton *btn1 = threeColumnArray[beginIndex];
        RoundTagButton *btn2 = threeColumnArray[beginIndex+1];
        RoundTagButton *btn3 = threeColumnArray[beginIndex+2];
        CGFloat totalWidth = btn1.bounds.size.width + btn2.bounds.size.width +btn3.bounds.size.width + 2 * btnMarginH;
        
        UIView *tagBtnBar = [[UIView alloc]init];
        [self.tagView addSubview:tagBtnBar];
        [tagBtnBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(totalWidth);
            make.height.mas_equalTo(rowHeight);
            make.top.equalTo(self.tagView.mas_top).offset(rowHeight * 2 * i);
            make.centerX.equalTo(self.tagView.mas_centerX);
            
        }];
        
        [tagBtnBar addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn1.frame.size.height);
            make.width.mas_equalTo(btn1.frame.size.width);
            make.left.mas_equalTo(0);
            make.centerY.equalTo(tagBtnBar.mas_centerY);
        }];
        
        [tagBtnBar addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn2.frame.size.height);
            make.width.mas_equalTo(btn2.frame.size.width);
            make.left.equalTo(btn1.mas_right).offset(btnMarginH);
            make.centerY.equalTo(tagBtnBar.mas_centerY);
        }];
        
        [tagBtnBar addSubview:btn3];
        [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn3.frame.size.height);
            make.width.mas_equalTo(btn3.frame.size.width);
            make.left.equalTo(btn2.mas_right).offset(btnMarginH);
            make.centerY.equalTo(tagBtnBar.mas_centerY);
        }];
        
    }
    
    //添加4列行
    for (int i = 0; i<fourColumnArray.count/4; i++) {
        int beginIndex = i *4;
        RoundTagButton *btn1 = fourColumnArray[beginIndex];
        RoundTagButton *btn2 = fourColumnArray[beginIndex+1];
        RoundTagButton *btn3 = fourColumnArray[beginIndex+2];
        RoundTagButton *btn4 = fourColumnArray[beginIndex+3];
        CGFloat totalWidth = btn1.bounds.size.width + btn2.bounds.size.width +btn3.bounds.size.width +btn4.bounds.size.width + 3 * btnMarginH;
        
        UIView *tagBtnBar = [[UIView alloc]init];
        [self.tagView addSubview:tagBtnBar];
        [tagBtnBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(totalWidth);
            make.height.mas_equalTo(rowHeight);
            make.top.equalTo(self.tagView.mas_top).offset(rowHeight + rowHeight * 2 * i);
            make.centerX.equalTo(self.tagView.mas_centerX);
            
        }];
        
        [tagBtnBar addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn1.frame.size.height);
            make.width.mas_equalTo(btn1.frame.size.width);
            make.left.mas_equalTo(0);
            make.centerY.equalTo(tagBtnBar.mas_centerY);
        }];
        
        [tagBtnBar addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn2.frame.size.height);
            make.width.mas_equalTo(btn2.frame.size.width);
            make.left.equalTo(btn1.mas_right).offset(btnMarginH);
            make.centerY.equalTo(tagBtnBar.mas_centerY);
        }];
        
        [tagBtnBar addSubview:btn3];
        [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn3.frame.size.height);
            make.width.mas_equalTo(btn3.frame.size.width);
            make.left.equalTo(btn2.mas_right).offset(btnMarginH);
            make.centerY.equalTo(tagBtnBar.mas_centerY);
        }];
        
        [tagBtnBar addSubview:btn4];
        [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(btn4.frame.size.height);
            make.width.mas_equalTo(btn4.frame.size.width);
            make.left.equalTo(btn3.mas_right).offset(btnMarginH);
            make.centerY.equalTo(tagBtnBar.mas_centerY);
        }];
        
    }
}

@end
