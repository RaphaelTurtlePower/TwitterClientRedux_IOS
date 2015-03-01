//
//  ContainerViewController.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/26/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetsViewController.h"
#import "MenuViewController.h"

@interface ContainerViewController : UIViewController <ContainerViewControllerDelegate>
@property (strong, nonatomic) UIViewController *menuViewController;
@property (strong, nonatomic) UIViewController *tweetsViewController;
- (id) initWithTweetController:(UIViewController *) tvc withMenu: (UIViewController *) mvc;

@end
