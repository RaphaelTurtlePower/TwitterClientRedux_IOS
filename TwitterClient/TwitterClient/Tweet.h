//
//  Tweet.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15. XiaoXiao
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString* realName;
@property (nonatomic, strong) NSString* handle;
@property (nonatomic, strong) NSURL* imageURL;
@property (nonatomic, strong) NSString* id;

@property (nonatomic, strong) NSNumber *favoriteCount;
@property (nonatomic, strong) NSNumber *retweetCount;
@property (nonatomic, assign) NSNumber *isFavorite;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

- (id)initTweet:(NSString *)text;
@end
