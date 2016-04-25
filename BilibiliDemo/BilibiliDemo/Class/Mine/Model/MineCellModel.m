//
//  StaticCellModel.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "MineCellModel.h"

@implementation MineCellModel

+ (instancetype)mineCellModelWithTyep:(MineCellType)mineCellType imageName:(NSString *)imageName title:(NSString *)title{
    MineCellModel *model = [[MineCellModel alloc]initWithTyep:mineCellType imageName:imageName title:title];
    return model;
}

- (instancetype)initWithTyep:(MineCellType)mineCellType imageName:(NSString *)imageName title:(NSString *)title{
    self = [super init];
    if (self) {
        _mineCellType = mineCellType;
        _imageName = imageName;
        _title = title;
    }
    return self;
}

@end
