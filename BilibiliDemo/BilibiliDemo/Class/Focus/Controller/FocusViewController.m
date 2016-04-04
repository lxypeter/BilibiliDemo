//
//  FocusViewController.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/4.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "FocusViewController.h"
#import "CYSegmentBar.h"

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
    self.segmentBar.font = kFont_13;
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
    UIView *zuiFanContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, scrollHeight)];
    zuiFanContainer.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:zuiFanContainer];
    
    //动态页面
    UIView *dynamicContainer = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, scrollHeight)];
    dynamicContainer.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:dynamicContainer];
    
    //标签页面
    UIView *tagContainer = [[UIView alloc]initWithFrame:CGRectMake( ScreenWidth * 2, 0, ScreenWidth, scrollHeight)];
    tagContainer.backgroundColor = [UIColor blueColor];
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
