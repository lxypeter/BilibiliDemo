//
//  DynamicCell.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "DynamicCell.h"
#import "UIImageView+WebCache.h"
#import "VideoInfo.h"

@interface DynamicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *preViewImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumsLabel;

@end

@implementation DynamicCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
}

-(void)setVideoInfo:(VideoInfo *)videoInfo{
    _videoInfo = videoInfo;
    if (videoInfo.headerImageUrl) {
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:videoInfo.headerImageUrl]];
    }
    if (videoInfo.preViewImageUrl) {
        [self.preViewImageView sd_setImageWithURL:[NSURL URLWithString:videoInfo.preViewImageUrl]];
    }
    if (videoInfo.authorName) {
        self.authorNameLabel.text = videoInfo.authorName;
    }
    if (videoInfo.createTime) {
        self.createTimeLabel.text = videoInfo.createTime;
    }
    if (videoInfo.videoTitle) {
        self.videoTitleLabel.text = videoInfo.videoTitle;
    }
    if (videoInfo.playTimes) {
        self.playTimesLabel.text = videoInfo.playTimes;
    }
    if (videoInfo.commentNums) {
        self.commentNumsLabel.text = videoInfo.commentNums;
    }
}

@end
