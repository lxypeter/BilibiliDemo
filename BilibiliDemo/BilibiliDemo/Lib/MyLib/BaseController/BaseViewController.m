//
//  BaseViewController.m
//  HNAppPallet
//
//  Created by Peter Lee on 15/11/5.
//  Copyright © 2015年 ZTESoft. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - 懒加载

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    //设置导航栏颜色
//    [self.navigationController.navigationBar setBarTintColor: UICOLOR(@"#FEFFFF")];
    
    //设置标题颜色
    UIColor * color = [UIColor blackColor];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //xy从导航栏开始计算
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark - 导航栏
#pragma mark -创建后退按钮
-(void)setBackBtn
{
    UIBarButtonItem*backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:self action:@selector(backToLastController)];
    [self.navigationItem setBackBarButtonItem:backItem];
}

- (void)backToLastController {
    
    [self.navigationController popViewControllerAnimated: YES];
    
}


#pragma mark - Hud方法
- (void)showHudWithMsg:(NSString *)msg{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

- (void)hideHud{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
