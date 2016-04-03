//
//  DetailViewController.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/3/16.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DetailViewController.h"
#import "Masonry.h"
#import <Accelerate/Accelerate.h>

#define kInitVideoViewHeight 210
#define kInitMenuViewHeight 30
#define kInitPlayButtonSize CGSizeMake(54, 50)
#define kInitPlayButtonRight 25
#define kBtnTotolMoveDistant ([UIScreen mainScreen].bounds.size.width/2 - kInitPlayButtonRight + 30)

@interface DetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (weak, nonatomic) IBOutlet UIImageView *videoCoverImageView;

@property (weak, nonatomic) IBOutlet UIButton *videoPlayButton;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIVisualEffectView *videoCoverImageBlurView;

@property (weak, nonatomic) IBOutlet UIButton *briefButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (strong, nonatomic) UIView *buttonSeletedBar;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self tableViewSetting];
    [self imageBlurViewSetting];
    [self menuViewSetting];
}

-(void)viewWillAppear:(BOOL)animated{
    
//    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
//    
//    UIView *launchView = viewController.view;
//    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
//    [mainWindow addSubview:launchView];
//    
//    UIImageView *bgView = [launchView viewWithTag:-11];
//    [bgView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(0);
//    }];
//    
//    CGFloat ratio = 841.0/640.0;
//    CGFloat imageViewX = (ScreenWidth - 120)/2;
//    CGFloat imageViewY = 100;
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, imageViewY, 120, 120*ratio)];
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"bilibili_splash_default@2x" ofType:@"png"];
//    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//    imageView.image = image;
//    [launchView addSubview:imageView];
//    
//    [UIView animateWithDuration:1.0f delay:0.5f options:0 animations:^{
//        imageView.transform = CGAffineTransformScale(imageView.transform, 2, 2);
//    } completion:^(BOOL finished) {
//        [launchView removeFromSuperview];
//    }];
}

#pragma mark - 设置导航栏
-(void)setNavigationBar{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"AV4094394";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navigationController.navigationBar.mas_centerX);
        make.centerY.equalTo(self.navigationController.navigationBar.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
    
    //透明底图实现navigationBar透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"clearbg"] forBarMetrics:UIBarMetricsDefault];
    //去除底部黑线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置后退按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"hd_idct_back"] forState:UIControlStateNormal];
    backBtn.bounds = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - tableView设置
-(void)tableViewSetting{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat topViewHeight = kInitVideoViewHeight + kInitMenuViewHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(topViewHeight, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma mark - videoView模糊层
-(void)imageBlurViewSetting{
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = self.videoCoverImageView.bounds;
    effectview.alpha = 0.3;
    [self.videoCoverImageView addSubview:effectview];
    
    UIBlurEffect *blur2 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview2 = [[UIVisualEffectView alloc] initWithEffect:blur2];
    effectview2.frame = self.videoCoverImageView.bounds;
    effectview2.alpha = 0;
    self.videoCoverImageBlurView = effectview2;
    [self.videoCoverImageView addSubview:effectview2];
}

#pragma mark - menuView设置
-(void)menuViewSetting{
    self.menuView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.menuView.layer.borderWidth = 0.5;
    
    [self.briefButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化选中条
    self.buttonSeletedBar = [[UIView alloc]initWithFrame:CGRectMake(self.briefButton.frame.origin.x, self.menuView.frame.size.height-2, self.briefButton.frame.size.width, 2)];
    self.buttonSeletedBar.backgroundColor = [self.briefButton titleColorForState:UIControlStateNormal];
    [self.menuView addSubview:self.buttonSeletedBar];
    
}

#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%li",indexPath.row];
    
    return cell;
}

#pragma mark - scrollView代理（顶部动画效果）
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //偏移量
    CGFloat deltaY = scrollView.contentOffset.y + kInitVideoViewHeight +kInitMenuViewHeight;
    CGFloat videoViewHeight = kInitVideoViewHeight - deltaY;
    
    if(videoViewHeight > 64 && videoViewHeight < kInitVideoViewHeight){
        
        CGFloat changeRate = deltaY /(kInitVideoViewHeight - 64);

        CGSize btnSize = CGSizeMake(kInitPlayButtonSize.width*(1-0.4*changeRate), kInitPlayButtonSize.height*(1-0.4*changeRate));
        //按钮右方间距
        CGFloat btnRight = kBtnTotolMoveDistant * changeRate + kInitPlayButtonRight;
        
        
        
        if(changeRate<=0.5){//前半位移标题淡出
            CGFloat processRate = changeRate/0.5;
            self.titleLabel.alpha = 1 - processRate;
            
            //标题位移
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.navigationController.navigationBar.mas_centerX).offset(30*processRate);
            }];
            
        }else if(changeRate>=0.8){//位移80%后，标题渐入
            CGFloat processRate = (changeRate - 0.8)/0.2;
            self.titleLabel.alpha = processRate;
            
            //标题位移
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.navigationController.navigationBar.mas_centerX).offset(30 - (15*processRate));
            }];
            
        }
        
        
        [self updateVideoViewHeight:videoViewHeight buttonSize:btnSize buttonRight:btnRight andBlurAlpha:changeRate];
        
    }else if(videoViewHeight >= kInitVideoViewHeight){ //防止拉伸
        
        [self updateVideoViewHeight:kInitVideoViewHeight buttonSize:kInitPlayButtonSize buttonRight:kInitPlayButtonRight andBlurAlpha:0];
        
        //标题
        self.titleLabel.alpha = 1;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navigationController.navigationBar.mas_centerX);
        }];
        
    }else{ //保持最小值 （防止滚动过快bug）
        
        CGSize btnSize = CGSizeMake(kInitPlayButtonSize.width*0.6, kInitPlayButtonSize.height*0.6);
        //按钮右方间距
        CGFloat btnRight = kBtnTotolMoveDistant + kInitPlayButtonRight;
        
        [self updateVideoViewHeight:64 buttonSize:btnSize buttonRight:btnRight andBlurAlpha:1];
        
        //标题
        self.titleLabel.alpha = 1;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navigationController.navigationBar.mas_centerX).offset(15);
        }];
        
    }
    
}

-(void)updateVideoViewHeight:(CGFloat)height buttonSize:(CGSize)size buttonRight:(CGFloat)right andBlurAlpha:(CGFloat)alpha{
    
    //调整磨砂透明度
    self.videoCoverImageBlurView.alpha = alpha;
    
    //调整videoView高度
    [self.videoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    //调整videoPlayButton大小
    [self.videoPlayButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
    
    //调整videoPlayButton与父控件间距（间距属于父控件约束）
    [self.videoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.videoPlayButton.mas_right).with.offset(right);
    }];
}

#pragma mark - menuView点击事件
-(void)menuButtonClick:(UIButton *)btn{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect temFrame = self.buttonSeletedBar.frame;
        temFrame.origin.x = btn.frame.origin.x;
        self.buttonSeletedBar.frame = temFrame;
    }];
    
}

@end
