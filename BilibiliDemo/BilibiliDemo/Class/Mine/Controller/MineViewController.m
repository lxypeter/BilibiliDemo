//
//  MineViewController.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MineViewController.h"
#import "MineCellModel.h"
#import "MyInfoCell.h"
#import "MineCell.h"

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MineViewController

#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad{
    [self initData];
}

- (void)initData{
    MineCellModel *headerModel = [MineCellModel mineCellModelWithTyep:MineInfoCell imageName:nil title:@"吸氧"];
    MineCellModel *specialModel = [MineCellModel mineCellModelWithTyep:MineSpecialCell imageName:nil title:@"来吧！只有会员知道的世界！"];
    [self.dataArray addObject:@[headerModel,specialModel]];
    
    MineCellModel *messageModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_letter" title:@"消息"];
    [self.dataArray addObject:@[messageModel]];
    
    MineCellModel *cacheModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_down" title:@"离线缓存"];
    [self.dataArray addObject:@[cacheModel]];
    
    MineCellModel *historyModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_time" title:@"历史记录"];
    MineCellModel *collectionModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_star" title:@"我的收藏"];
    MineCellModel *focusModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_smile" title:@"我的关注"];
    MineCellModel *payModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_card" title:@"消费记录"];
    MineCellModel *gameModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_time" title:@"游戏中心"];
    MineCellModel *settingModel = [MineCellModel mineCellModelWithTyep:MineNormalCell imageName:@"setting_setting" title:@"设置"];
    [self.dataArray addObject:@[historyModel,collectionModel,focusModel,payModel,gameModel,settingModel]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionData = self.dataArray[section];
    return sectionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineCellModel *mineCellModel = self.dataArray[indexPath.section][indexPath.row];
    
    UITableViewCell *cell;
    switch (mineCellModel.mineCellType) {
        case MineInfoCell:{
            cell = (MyInfoCell *)[[[NSBundle mainBundle]loadNibNamed:@"MyInfoCell" owner:nil options:nil] lastObject];
            ((MyInfoCell *)cell).mineCellModel = mineCellModel;
            break;
        }
        case MineSpecialCell:{
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
            cell.backgroundColor = kPinkColor;
            cell.textLabel.text = mineCellModel.title;
            cell.textLabel.font = kFont_15;
            cell.textLabel.textColor = [UIColor whiteColor];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 19)];
            imageView.image = [UIImage imageNamed:@"setting_right_arr_white"];
            cell.accessoryView = imageView;
            break;
        }
        default:{
            cell = (MineCell *)[[[NSBundle mainBundle]loadNibNamed:@"MineCell" owner:nil options:nil] lastObject];
            ((MineCell *)cell).mineCellModel = mineCellModel;
            break;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCellModel *mineCellModel = self.dataArray[indexPath.section][indexPath.row];
    switch (mineCellModel.mineCellType) {
        case MineInfoCell:{
            return 88;
        }
        default:{
            return 44;
        }
    }
}

@end
