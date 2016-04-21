//
//  AnimeSeriesView.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimeSeriesView : UIView

@property (nonatomic, weak) UIViewController *owner;
@property (nonatomic, strong) NSArray *dataArray;

@end
