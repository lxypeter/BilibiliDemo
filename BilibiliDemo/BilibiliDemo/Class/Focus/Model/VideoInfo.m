//
//  VideoInfo.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/19.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "VideoInfo.h"

@implementation VideoInfo

+ (instancetype)videoInfoWithDictionary:(NSDictionary *)dict{
    VideoInfo *videoInfo = [[VideoInfo alloc]initWithDictionary:dict];
    return videoInfo;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        if (dict&&dict.count>0) {
            for (NSString *key in dict.allKeys) {
                [self setValue:dict[key] forKey:key];
            }
        }
    }
    return self;
}

@end
