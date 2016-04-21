//
//  AnimeInfo.m
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import "AnimeInfo.h"

@implementation AnimeInfo

+ (instancetype)animeInfoWithDictionary:(NSDictionary *)dict{
    AnimeInfo *animeInfo = [[AnimeInfo alloc]initWithDictionary:dict];
    return animeInfo;
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
