//
//  RoundTagButton.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/5.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "RoundTagButton.h"

@implementation RoundTagButton

+(RoundTagButton *)roundTagButtonWithTitle:(NSString *)title Color:(UIColor *)color Height:(CGFloat)height{
    
    UIFont *titleFont = [UIFont systemFontOfSize:14];
    CGFloat maxWidth = height * 2.5;
    
    NSDictionary *fontAttr = @{NSFontAttributeName:titleFont};
    CGSize fontSize = [title sizeWithAttributes:fontAttr];
    
    CGFloat btnWidth;
    if (fontSize.width + 10<maxWidth) {
        btnWidth = fontSize.width + 10;
    }else{
        btnWidth = maxWidth;
    }
    
    CGRect frame = CGRectMake(0, 0, btnWidth, height);
    
    RoundTagButton *roundTagButton = [[RoundTagButton alloc]initWithFrame:frame];
    
    roundTagButton.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
    roundTagButton.titleLabel.font = titleFont;
    
    [roundTagButton setTitle:title forState:UIControlStateNormal];
    [roundTagButton setTitleColor:color forState:UIControlStateNormal];
    [roundTagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [roundTagButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(frame.size.width, frame.size.height)] forState:UIControlStateNormal];
    [roundTagButton setBackgroundImage:[self imageWithColor:color size:CGSizeMake(frame.size.width, frame.size.height)] forState:UIControlStateSelected];
    
    roundTagButton.layer.masksToBounds = YES;
    roundTagButton.layer.cornerRadius =height/2;
    roundTagButton.layer.borderColor = color.CGColor;
    roundTagButton.layer.borderWidth = 1;

    return roundTagButton;
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

@end
