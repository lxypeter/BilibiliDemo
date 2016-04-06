//
//  FocusViewController.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "FocusViewController.h"
#import "CYSegmentBar.h"
#import "FocusTagView.h"

@interface FocusViewController ()<CYSegmentBarDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) CYSegmentBar *segmentBar;

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation FocusViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews{
    
    //标题栏
    self.segmentBar = [[CYSegmentBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth *0.5, 44) titles:@[@"追番",@"动态",@"标签"] validWidth:0];
    self.segmentBar.font = kFont_15;
    self.segmentBar.selectedColor = kPinkColor;
    self.segmentBar.unselectedColor = kTextGrayColor;
    self.segmentBar.selectedIndex = 1;
    self.segmentBar.delegate = self;
    self.navigationItem.titleView = self.segmentBar;
    
    //ScorllView
    CGFloat scrollHeight = ScreenHeight - self.tabBarController.tabBar.bounds.size.height - 64;
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 3, scrollHeight);
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    //追番页面
    UIView *zuiFanContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, scrollHeight)];
    zuiFanContainer.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:zuiFanContainer];
    
    //动态页面
    UIView *dynamicContainer = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, scrollHeight)];
    dynamicContainer.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:dynamicContainer];
    
    //标签页面
    UIView *tagContainer = [[UIView alloc]initWithFrame:CGRectMake( ScreenWidth * 2, 0, ScreenWidth, scrollHeight)];
    FocusTagView *focusTagView = [[FocusTagView alloc]initWithFrame:tagContainer.bounds];
    focusTagView.tagArray = @[@"手办模型",@"舞蹈MMD",@"原创音乐",@"动漫杂谈",@"架子鼓",@"LOVELIVE",@"技术宅",@"金坷垃",@"MINECRAFT",@"梁非凡",@"坦克世界",@"VOCALOID",@"言和",@"剧情MMD",@"AMV",@"教程",@"剑网三",@"音MAD",@"ACG配音",@"手书",@"DIY",@"静止系MAD",@"洛天依",@"治愈向"];
    [tagContainer addSubview:focusTagView];
    [self.scrollView addSubview:tagContainer];
    
}

#pragma mark - segmentBar代理
-(void)cySegmentBar:(CYSegmentBar *)segmentBar indexOfSelectedSegment:(NSInteger)index{
    self.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
}

#pragma mark - ScrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.segmentBar.selectedBarProgress = scrollView.contentOffset.x *1.0/ (scrollView.frame.size.width*2.0);
    
}

@end
