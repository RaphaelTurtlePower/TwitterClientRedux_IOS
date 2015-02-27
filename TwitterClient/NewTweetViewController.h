//
//  NewTweetViewController.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class NewTweetViewController;

@protocol NewTweetViewControllerDelegate <NSObject>
-(void) NewTweetViewController: (NewTweetViewController*) viewController onTweet:(Tweet*) tweet;
@end


@interface NewTweetViewController : UIViewController
@property (nonatomic, weak) id<NewTweetViewControllerDelegate> delegate;
@property (strong, nonatomic) Tweet *tweet;
@end
