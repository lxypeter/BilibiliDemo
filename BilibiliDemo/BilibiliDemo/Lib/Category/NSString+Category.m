//
//  NSString+Category
//  gs_1210
//
//  Created by musoon on 15/1/2.
//  Copyright (c) 2015年 areo. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+ (CGSize)stringCGSize:(NSString *)str font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height {
    
    str = [NSString toStr: str];
    
    if (nil == font) {
        font = [UIFont systemFontOfSize: 15];
    }
    
    CGSize size = [str sizeWithFont: font constrainedToSize: CGSizeMake(width, height)];
    
    return size;
}

+ (CGSize)stringCGSize:(NSString *)str font:(UIFont *)font width:(CGFloat)width {
    
    str = [NSString toStr: str];
    
    if (nil == font) {
        font = [UIFont systemFontOfSize: 15];
    }
    
    CGSize size = [str sizeWithFont: font constrainedToSize: CGSizeMake(width, MAXFLOAT)];
    
    return size;
}

+ (CGSize)stringCGSize:(NSString *)str font:(UIFont *)font height:(CGFloat)height {
    
    str = [NSString toStr: str];
    
    if (nil == font) {
        font = [UIFont systemFontOfSize: 15];
    }
    
    CGSize size = [str sizeWithFont: font constrainedToSize: CGSizeMake(MAXFLOAT, height)];
    
    return size;
}

+ (CGSize)stringCGSize:(NSString *)str font:(UIFont *)font{
    
    str = [NSString toStr: str];
    
    if (nil == font) {
        font = [UIFont systemFontOfSize: 15];
    }
    
    CGSize size = [str sizeWithFont: font];
    
    return size;
}

+ (float) heightForTextViewWithText: (NSString *) strText width:(CGFloat)width{
    float fPadding = 16.0; // 8.0px x 2
    UIFont *font = [UIFont systemFontOfSize: 13];
    CGSize constraint = CGSizeMake(width, CGFLOAT_MAX);
    
    CGSize size = [strText sizeWithFont:font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    float fHeight = size.height+44;
    
    return fHeight;
}

+ (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


+ (NSString *)toStr:(id)string {
    if (string == nil || string == NULL) {
        return @"";
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if ([string isKindOfClass: [NSNumber class]]) {
        return [NSString stringWithFormat: @"%@", string];
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    return string;
}

+ (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

/**
 *  去左右空格
 *
 *  @param string 待去空格的字符串
 *
 *  @return 处理完的字符串
 */
+ (NSString *)trim:(NSString *)string {
    NSString *trimString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return trimString;
}


/**
 *  @author YYang, 16-02-08 23:02:52
 *
 *  姓名脱敏
 *
 *  @param name 名字
 *
 *  @return 脱敏名字
 */
+(NSString *)nameMask:(NSString *)name{
    
    NSMutableString *custNameDeal = [NSMutableString stringWithString:[name substringToIndex:1]];
    
    for (int i=0; i<name.length-1; i++) {
        [custNameDeal appendString:@"*"];
    }
    
    return custNameDeal;
}


/**
 *  @author YYang, 16-02-08 23:02:20
 *
 *  身份证号脱敏
 *
 *  @param idNum 身份证脱敏
 *
 *  @return 脱敏身份证号
 */
+(NSString *)idCardNumMask:(NSString *)idNum{
    
    if (idNum.length<7) return idNum;
    
    NSMutableString *idNumDeal = [NSMutableString stringWithString:[idNum substringToIndex:6]];
    
    for (int i=0; i<idNum.length-1; i++) {
        [idNumDeal appendString:@"*"];
    }
    
    return idNumDeal;
}


@end
