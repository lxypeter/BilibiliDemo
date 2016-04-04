//
//  CYTabBarController.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/3/31.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "CYTabBarController.h"
#import "CYTabBar.h"

@interface CYTabBarController () <CYTabBarDelegate>

@property (nonatomic,strong) CYTabBar *cyTabBar;

@end

@implementation CYTabBarController
#pragma mark - 懒加载
-(CYTabBar *)cyTabBar{
    if (!_cyTabBar) {
        _cyTabBar = [[CYTabBar alloc]initWithFrame:self.tabBar.bounds];
        _cyTabBar.delegate = self;
    }
    return _cyTabBar;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar addSubview:self.cyTabBar];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self animationOfLaunch];
}

#pragma mark - 自定义TabBar回调
-(void)cyTabBar:(CYTabBar *)tabBar indexOfBtnClicked:(NSInteger)index{
    self.selectedIndex = index;
}

#pragma mark - APP启动动画
-(void)animationOfLaunch{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [mainWindow addSubview:launchView];
    
    UIImageView *bgView = [launchView viewWithTag:-11];
    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    CGFloat ratio = 841.0/640.0;
    CGFloat imageViewX = (ScreenWidth - 120)/2;
    CGFloat imageViewY = 100;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, imageViewY, 120, 120*ratio)];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"bilibili_splash_default@2x" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    imageView.image = image;
    [launchView addSubview:imageView];
    
    [UIView animateWithDuration:1.0f animations:^{
        imageView.transform = CGAffineTransformScale(imageView.transform, 2, 2);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}

@end
