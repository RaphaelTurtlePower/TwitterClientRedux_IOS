//
//  TweetViewCell.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "TweetViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "TTTTimeIntervalFormatter.h"
#import "TwitterClient.h"
#import "NewTweetViewController.h"

@implementation TweetViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)initWithTweet:(Tweet *)tweet parent:(UIViewController*)parent {
    self.tweet = tweet;

    [self.tweetText setText:tweet.text];
    self.tweetText.numberOfLines = 10;
    [self.realName setText:tweet.realName];
    [self.handle setText:[NSString stringWithFormat:@"@%@", tweet.handle]];
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm:ss"];
     NSTimeInterval timeInterval = [tweet.createdAt timeIntervalSinceNow];
 
    [timeIntervalFormatter setUsesIdiomaticDeicticExpressions:YES];
    self.tweetTimestamp.text = [timeIntervalFormatter stringForTimeInterval:timeInterval]; // "yesterday"
    
    [self.profileImage setImageWithURL:tweet.imageURL];

}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] reTweet:self.tweet.id completion:^(NSDictionary *result, NSError *error){
        NSLog(@"OnRetweet callback called from TweetViewCell.");
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet"] forState:UIControlStateNormal];
    }];

}
- (IBAction)onFavorite:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.tweet.id;
    BOOL isFavorite = ([self.tweet.isFavorite integerValue]==1);
    [[TwitterClient sharedInstance] favoriteTweet:params favorite:isFavorite completion:^(NSDictionary *result, NSError *error){
        if([self.tweet.isFavorite integerValue] == 1){
            self.tweet.isFavorite = [NSNumber numberWithInt:0];
            [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite_gray"] forState:UIControlStateNormal];
        }else{
            self.tweet.isFavorite = [NSNumber numberWithInt:1];
            [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
        }
    }];

}

- (IBAction)onReply:(id)sender {
    [self.delegate tweetCell:self onReply:YES tweet:self.tweet];
  }



@end
