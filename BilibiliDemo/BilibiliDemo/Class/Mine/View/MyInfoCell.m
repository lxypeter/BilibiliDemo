//
//  MyInfoCell.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MyInfoCell.h"
#import "MineCellModel.h"

@interface MyInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lvImageView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;

@end

@implementation MyInfoCell

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
    
    if (mineCellModel.imageName) {
        self.headerImageView.image = [UIImage imageNamed:mineCellModel.imageName];
    }
    self.nameLabel.text = mineCellModel.title;
}
@end
