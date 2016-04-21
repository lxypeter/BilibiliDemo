//
//  DynamicView.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DynamicView.h"
#import "DynamicCell.h"
#import "DetailViewController.h"

@interface DynamicView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DynamicView

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
    self.tableView = tableView;
    [self addSubview:tableView];
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}

#pragma mark - tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"DynamicCell";
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = (DynamicCell *)[[[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:nil options:nil]lastObject];
    }
    
    VideoInfo *info = _dataArray[indexPath.section];
    cell.videoInfo = info;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailViewController *ctrl = [sb instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [ctrl setHidesBottomBarWhenPushed:YES];
    [self.owner.navigationController pushViewController:ctrl animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

@end
