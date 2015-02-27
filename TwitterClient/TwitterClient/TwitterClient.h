//
//  TwitterClient.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/21/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient*) sharedInstance;
- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;
- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void(^)(NSArray *tweets, NSError *error))completion;
- (void)sendTweet:(NSDictionary *)params completion:(void(^)(Tweet *tweet, NSError *error))completion;
-(void)reTweet:(NSString*)tweetId completion:(void (^)(NSDictionary *result, NSError *error))completion;
-(void)favoriteTweet:(NSDictionary*)params favorite:(BOOL)favorite completion:(void (^)(NSDictionary *result, NSError *error))completion;
@end
