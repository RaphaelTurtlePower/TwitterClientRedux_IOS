//
//  TweetViewCell.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetViewCell;

@protocol TweetViewCellDelegate <NSObject>
-(void) tweetCell:(TweetViewCell *) cell onReply:(BOOL) state tweet:(Tweet*) tweet;
@end

@interface TweetViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) Tweet* tweet;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *tweetTimestamp;
@property (strong, nonatomic) IBOutlet UILabel *realName;
@property (strong, nonatomic) IBOutlet UILabel *handle;
@property (weak, nonatomic) IBOutlet UIButton *retweetIcon;
@property (weak, nonatomic) IBOutlet UIButton *favoriteIcon;
@property (weak, nonatomic) IBOutlet UIButton *replyIcon;

@property (nonatomic, weak) id<TweetViewCellDelegate> delegate;
- (void)initWithTweet:(Tweet *)tweet parent:(UIViewController*)parent;
@end
