//
//  StaticCellModel.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/25.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,MineCellType){
    MineInfoCell,
    MineNormalCell,
    MineSpecialCell
};

typedef void (^OperationBlock)();

@interface MineCellModel : NSObject

@property (nonatomic, assign, readonly) MineCellType mineCellType;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy) OperationBlock operationBlock;

+ (instancetype)mineCellModelWithTyep:(MineCellType)mineCellType imageName:(NSString *)imageName title:(NSString *)title;
- (instancetype)initWithTyep:(MineCellType)mineCellType imageName:(NSString *)imageName title:(NSString *)title;

@end
