//
//  UIView+MaskCorner.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/21.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "UIView+MaskCorner.h"

@implementation UIView (MaskCorner)

- (void)cy_roundCornerMaskRadius:(CGFloat)radius backgoundColor:(UIColor *)color{
    
    UIImageView *conrnerImageView = [[UIImageView alloc]initWithImage:[self cy_maskCornerImageWithRadius:radius viewSize:self.frame.size color:color]];
    
    [self addSubview:conrnerImageView];
}

- (UIImage *)cy_maskCornerImageWithRadius:(CGFloat)radius viewSize:(CGSize)size color:(UIColor *)color{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //左上
    [self cy_drawArcCornerMaskInContext:context byPointOne:CGPointMake(radius, 0) pointTwo:CGPointMake(0, 0) pointThree:CGPointMake(0, radius) radius:radius];

    
    //右上
    [self cy_drawArcCornerMaskInContext:context byPointOne:CGPointMake(size.width - radius, 0) pointTwo:CGPointMake(size.width, 0) pointThree:CGPointMake(size.width, radius) radius:radius];
    
    //右下
    [self cy_drawArcCornerMaskInContext:context byPointOne:CGPointMake(size.width, size.height - radius) pointTwo:CGPointMake(size.width, size.height) pointThree:CGPointMake(size.width-radius, size.height) radius:radius];
    
    //左下
    [self cy_drawArcCornerMaskInContext:context byPointOne:CGPointMake(radius, size.height) pointTwo:CGPointMake(0, size.height) pointThree:CGPointMake(0, size.height - radius) radius:radius];
    
    [color set];
    CGContextFillPath(context);
    
    UIImage *cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return cornerImage;
}

- (void)cy_drawArcCornerMaskInContext:(CGContextRef)context byPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo pointThree:(CGPoint)pointThree radius:(CGFloat)radius{

    CGContextMoveToPoint(context, pointOne.x, pointOne.y);
    
    CGContextAddArcToPoint(context, pointTwo.x, pointTwo.y, pointThree.x, pointThree.y, radius);
    
    CGContextAddLineToPoint(context, pointTwo.x, pointTwo.y);
    
    CGContextClosePath(context);
}

@end
