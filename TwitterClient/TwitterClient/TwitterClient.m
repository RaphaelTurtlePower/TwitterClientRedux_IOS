//
//  TwitterClient.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/21/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString* const kTwitterConsumerKey = @"8Uee6v4JI9Me73LM0c7x7GY8L";
NSString* const kTwitterConsumerSecret = @"mwA4K1uLS4YwC12ZmGoNZcV9bYqeOqB896PW6oiUHjkuYY06ZA";
NSString* const kTwitterBaseUrl=@"https://api.twitter.com";

@interface TwitterClient ()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);


@end

@implementation TwitterClient


+ (TwitterClient * ) sharedInstance{
    static TwitterClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil){
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
            
        }
    });
  
    return instance;
}


- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion{
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"TwitterIOSCodepathClient://oauth"] scope:nil success:^(BDBOAuth1Credential *request_token){
        NSLog(@"TOKEN GENERATED.");
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", request_token.token]];
        
        [[UIApplication sharedApplication] openURL:authURL];
        
    }failure:^(NSError *error){
        NSLog(@"TOKEN NOT GENERATED");
        self.loginCompletion(nil, error);
    }];
}


- (void)openURL:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken){
        NSLog(@"Successful access Token");
        [self.requestSerializer saveAccessToken:accessToken  ];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            NSLog(@"Current User: %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error verifying credentials");
            self.loginCompletion(nil, error);
        }];
    } failure:^(NSError *error){
        NSLog(@"Failure to get acecss Token");
        self.loginCompletion(nil, error);
    }];
}

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void(^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)sendTweet:(NSDictionary *)params completion:(void(^)(Tweet *tweet, NSError *error))completion {
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"Successfully submitting a tweet.");
                completion(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error Submitting a Tweet.");
                    completion(nil, error);
                }];
    }

-(void)favoriteTweet:(NSDictionary*)params favorite:(BOOL)favorite completion:(void (^)(NSDictionary *result, NSError *error))completion
{
    NSString* endpoint = @"1.1/favorites/create.json";
    if(!favorite){
        endpoint = @"1.1/favorites/destroy.json";
    }
    
    [self POST:endpoint parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Favorited a Tweet ! %@",responseObject);
        completion(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}

-(void)reTweet:(NSString*)tweetId completion:(void (^)(NSDictionary *result, NSError *error))completion
{
    NSString *api = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json",tweetId];
    [self POST:api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}




@end
