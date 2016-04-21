//
//  AnimeInfo.h
//  BilibiliDemo
//
//  Created by Peter Lee on 16/4/20.
//  Copyright © 2016年 Peter Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimeInfo : NSObject

@property (nonatomic, copy) NSString *coverImageUrl;
@property (nonatomic, copy) NSString *animeName;
@property (nonatomic, copy) NSString *detail;

@property (nonatomic, assign, getter=isFollowed) BOOL followed;

+ (instancetype)animeInfoWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
