//
//  Tweet.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
             self.imageURL = [NSURL URLWithString:dictionary[@"user"][@"profile_image_url"]];
        self.id = dictionary[@"id"];
        self.text = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        self.handle = dictionary[@"user"][@"screen_name"];
        self.realName = dictionary[@"user"][@"name"];
        self.retweetCount = dictionary[@"retweet_count"];
        self.favoriteCount = dictionary[@"favorite_count"];
        self.isFavorite = dictionary[@"favorited"];
    }
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

- (id)initTweet:(NSString *)text {
    self = [super init];
    if (self) {
        User* user = [User currentuser];
        self.handle = user.screenName;
        self.realName = user.name;
        self.imageURL = [NSURL URLWithString:user.profileImageUrl];
        self.text = text;
    }
    return self;
}

@end
