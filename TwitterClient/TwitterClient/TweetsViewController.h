//
//  TweetsViewController.h
//  Twitter
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTweetViewController.h"
#import "TweetViewCell.h"

@interface TweetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate, TweetViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetList;

@end
