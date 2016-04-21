//
//  UIImage+MaskCorner.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/21.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "UIImage+MaskCorner.h"

@implementation UIImage (MaskCorner)

- (UIImage *)cy_roundCornerRadius:(CGFloat)radius size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen mainScreen].scale);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    CGContextAddPath(context, bPath.CGPath);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
