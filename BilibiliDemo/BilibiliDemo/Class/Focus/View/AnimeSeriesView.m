//
//  AnimeSeriesView.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "AnimeSeriesView.h"
#import "AnimeSeriesCell.h"
#import "AnimeInfo.h"

@interface AnimeSeriesView () <UITableViewDelegate,UITableViewDataSource,AnimeSeriesCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *tipsView;

@end

@implementation AnimeSeriesView

#pragma mark - 懒加载
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
        headerView.backgroundColor = UICOLOR(@"#F6F6F6");
        
        //图片
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"dynamicheader"];
        [headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.equalTo(headerView.mas_centerX);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(310);
        }];
        
        //提示语
        UILabel *tipsLabel = [[UILabel alloc]init];
        tipsLabel.text = @"可以追这些番哦~";
        tipsLabel.font = kFont_12;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:tipsLabel];
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(40);
        }];
        
        _tableHeaderView = headerView;
    }
    return _tableHeaderView;
}

- (UIView *)tipsView{
    if (!_tipsView) {
        _tipsView = [[UIView alloc]init];
        _tipsView.backgroundColor = [UIColor colorWithRed:0.87 green:0.42 blue:0.55 alpha:0.8];
        [self addSubview:_tipsView];
        [_tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(35);
        }];
        
        UILabel *tipsLabel = [[UILabel alloc]init];
        tipsLabel.text = @"关注成功！刷新一下查看哦！";
        tipsLabel.font = kFont_15;
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        [_tipsView addSubview:tipsLabel];
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }
    return _tipsView;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    tableView.rowHeight = 110;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = UICOLOR(@"#F6F6F6");
    self.tableView = tableView;
    [self addSubview:tableView];
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"DynamicCell";
    AnimeSeriesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = (AnimeSeriesCell *)[[[NSBundle mainBundle]loadNibNamed:@"AnimeSeriesCell" owner:nil options:nil]lastObject];
        cell.delegate = self;
    }
    AnimeInfo *animeInfo = _dataArray[indexPath.row];
    cell.animeInfo = animeInfo;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.tableHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

#pragma mark - cell代理
- (void)animeSeriesCellfollowValueChange:(AnimeSeriesCell *)cell{
    
    if (cell.animeInfo.isFollowed) {
        self.tipsView.hidden = NO;
        return;
    }
    
    for (AnimeInfo *info in self.dataArray) {
        if (info.isFollowed) {
            self.tipsView.hidden = NO;
            return;
        }
    }
    
    self.tipsView.hidden = YES;
}
@end
