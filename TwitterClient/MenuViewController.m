//
//  MenuViewController.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/26/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuControllerTableViewCell.h"
#import "User.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuControllerTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    self.title=@"Menu";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma menu item


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuControllerTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    switch (indexPath.row) {
        case 0:
            cell.menuLabel.text = @"Home";
            break;
        case 1:
             cell.menuLabel.text = @"Profile";
            break;
        case 2:
             cell.menuLabel.text = @"Mentions";
            break;
        case 3:
            cell.menuLabel.text = @"Sign Out";
            break;
        default:
            cell.menuLabel.text =@"";
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            //Home timeline
            [self.delegate closeMenu:@"home" withUser:nil];
            break;
        case 1:
            //ProfileView
            [self.delegate closeMenu:@"profile" withUser:[User currentuser]];
            break;
        case 2:
            //Mentions
            [self.delegate closeMenu:@"mentions" withUser:nil];
            break;
        default:
            [User logOut];
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
