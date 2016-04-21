//
//  AnimeSeriesCell.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "AnimeSeriesCell.h"
#import "UIImageView+WebCache.h"
#import "AnimeInfo.h"
#import "UIView+MaskCorner.h"

@interface AnimeSeriesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation AnimeSeriesCell

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *borderColor = kPinkColor;
//    self.followButton.layer.masksToBounds = YES;
    self.followButton.layer.cornerRadius = 5;
    [self.followButton cy_roundCornerMaskRadius:5 backgoundColor:[UIColor whiteColor]];
    self.followButton.layer.borderWidth = 1;
    self.followButton.layer.borderColor = borderColor.CGColor;
    [self.followButton setBackgroundImage:[AnimeSeriesCell imageWithColor:[UIColor whiteColor] size:self.followButton.bounds.size] forState:UIControlStateNormal];
    [self.followButton setBackgroundImage:[AnimeSeriesCell imageWithColor:UICOLOR(@"#DEDEDE") size:self.followButton.bounds.size] forState:UIControlStateSelected];
    [self.followButton setTitle:@"追番" forState:UIControlStateNormal];
    [self.followButton setTitle:@"追番中" forState:UIControlStateSelected];
    
    [self.followButton addTarget:self action:@selector(clickFollowButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
}

#pragma mark - 点击事件
- (void)clickFollowButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    if (self.animeInfo) {
        self.animeInfo.followed = btn.selected;
    }
    
    if (btn.selected) {
        self.followButton.layer.borderWidth = 0;
    }else{
        self.followButton.layer.borderWidth = 1;
    }
    
    if ([self.delegate respondsToSelector:@selector(animeSeriesCellfollowValueChange:)]) {
        [self.delegate animeSeriesCellfollowValueChange:self];
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

#pragma mark - setter
- (void)setAnimeInfo:(AnimeInfo *)animeInfo{
    _animeInfo = animeInfo;
    if (animeInfo.coverImageUrl) {
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:animeInfo.coverImageUrl]];
    }
    if (animeInfo.animeName) {
        self.nameTitleLabel.text = animeInfo.animeName;
    }
    if (animeInfo.detail) {
        self.detailLabel.text = animeInfo.detail;
    }
    self.followButton.selected = animeInfo.isFollowed;
    if (animeInfo.isFollowed) {
        self.followButton.layer.borderWidth = 0;
    }else{
        self.followButton.layer.borderWidth = 1;
    }
}

@end
