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
#import "DynamicView.h"
#import "AnimeSeriesView.h"
#import "VideoInfo.h"
#import "AnimeInfo.h"

@interface FocusViewController ()<CYSegmentBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) CYSegmentBar *segmentBar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) AnimeSeriesView *animeSeriesView;
@property (nonatomic, strong) DynamicView *dynamicView;
@property (nonatomic, strong) FocusTagView *focusTagView;

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
    UIView *animeSeriesContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, scrollHeight)];
    AnimeSeriesView *animeSeriesView = [[AnimeSeriesView alloc]initWithFrame:animeSeriesContainer.bounds];
    animeSeriesView.owner = self;
    [animeSeriesContainer addSubview:animeSeriesView];
    
#warning 实际从接口返回
    NSMutableArray *animeDataArray = [NSMutableArray array];
    NSDictionary *animeDataDict =@{@"animeName":@"动画标题"};
    for (int i = 0; i<10; i++) {
        AnimeInfo *animeInfo = [AnimeInfo animeInfoWithDictionary:animeDataDict];
        [animeDataArray addObject:animeInfo];
    }
    animeSeriesView.dataArray = animeDataArray;
    
    self.animeSeriesView = animeSeriesView;
    [self.scrollView addSubview:animeSeriesContainer];
    
    //动态页面
    UIView *dynamicContainer = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, scrollHeight)];
    DynamicView *dynamicView = [[DynamicView alloc]initWithFrame:dynamicContainer.bounds];
    dynamicView.owner = self;
    [dynamicContainer addSubview:dynamicView];
    
#warning 实际从接口返回
    NSMutableArray *dynamicDataArray = [NSMutableArray array];
    NSDictionary *dynamicDataDict =@{@"authorName":@"测试标题"};
    for (int i = 0; i<10; i++) {
        VideoInfo *videoInfo = [VideoInfo videoInfoWithDictionary:dynamicDataDict];
        [dynamicDataArray addObject:videoInfo];
    }
    dynamicView.dataArray = dynamicDataArray;
    
    self.dynamicView = dynamicView;
    [self.scrollView addSubview:dynamicContainer];
    
    //标签页面
    UIView *tagContainer = [[UIView alloc]initWithFrame:CGRectMake( ScreenWidth * 2, 0, ScreenWidth, scrollHeight)];
    FocusTagView *focusTagView = [[FocusTagView alloc]initWithFrame:tagContainer.bounds];
#warning 实际从接口返回
    focusTagView.tagArray = @[@"手办模型",@"舞蹈MMD",@"原创音乐",@"动漫杂谈",@"架子鼓",@"LOVELIVE",@"技术宅",@"金坷垃",@"MINECRAFT",@"梁非凡",@"坦克世界",@"VOCALOID",@"言和",@"剧情MMD",@"AMV",@"教程",@"剑网三",@"音MAD",@"ACG配音",@"手书",@"DIY",@"静止系MAD",@"洛天依",@"治愈向"];
    [tagContainer addSubview:focusTagView];
    self.focusTagView = focusTagView;
    [self.scrollView addSubview:tagContainer];
    
    self.segmentBar.selectedIndex = 1;
}

#pragma mark - segmentBar代理
- (void)cySegmentBar:(CYSegmentBar *)segmentBar indexOfSelectedSegment:(NSInteger)index{
    self.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
}

#pragma mark - ScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat selectedBarProgress = scrollView.contentOffset.x *1.0/ (ScreenWidth*2.0);
    self.segmentBar.selectedBarProgress = selectedBarProgress;
}

@end
