//
//  AnimeSeriesCell.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnimeSeriesCell;
@protocol AnimeSeriesCellDelegate <NSObject>

- (void)animeSeriesCellfollowValueChange:(AnimeSeriesCell *)cell;

@end

@class AnimeInfo;
@interface AnimeSeriesCell : UITableViewCell

@property (nonatomic,strong) AnimeInfo *animeInfo;
@property (nonatomic,weak) id<AnimeSeriesCellDelegate> delegate;

@end
