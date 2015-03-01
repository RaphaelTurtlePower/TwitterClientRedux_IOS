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
#import "ContainerViewControllerDelegate.h"

@interface TweetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate, TweetViewCellDelegate, ContainerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tweetList;
@property (nonatomic, weak) id<ContainerViewControllerDelegate> delegate;
- (id)initAsHome:(BOOL) isHome;
@end
