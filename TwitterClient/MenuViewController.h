//
//  MenuViewController.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/26/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewControllerDelegate.h"

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<ContainerViewControllerDelegate> delegate;

@end
