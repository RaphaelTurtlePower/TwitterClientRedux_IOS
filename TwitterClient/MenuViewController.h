//
//  MenuViewController.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/26/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;

@end
