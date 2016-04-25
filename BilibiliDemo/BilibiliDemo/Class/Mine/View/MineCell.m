//
//  MineCell.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MineCell.h"
#import "MineCellModel.h"

@interface MineCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MineCell

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 19)];
    imageView.image = [UIImage imageNamed:@"setting_right_arr"];
    self.accessoryView = imageView;
}

- (void)setSelectionStyle:(UITableViewCellSelectionStyle)selectionStyle{
}

-(void)setMineCellModel:(MineCellModel *)mineCellModel{
    _mineCellModel = mineCellModel;
    
    self.iconImageView.image = [UIImage imageNamed:mineCellModel.imageName];
    self.titleLabel.text = mineCellModel.title;
}

@end
