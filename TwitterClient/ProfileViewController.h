//
//  ProfileViewController.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/28/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ContainerViewControllerDelegate.h"

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *user;
-(id) initWithUser: (User*) user;

@property (nonatomic, weak) id<ContainerViewControllerDelegate> delegate;

@end
