//
//  UIImageView+MaskCorner.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/21.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "UIImageView+MaskCorner.h"
#import "UIImage+MaskCorner.h"

@implementation UIImageView (MaskCorner)

- (void)cy_roundCornerRadius:(CGFloat)radius{
    
    self.image = [self.image cy_roundCornerRadius:radius size:self.bounds.size];
    
}

@end
