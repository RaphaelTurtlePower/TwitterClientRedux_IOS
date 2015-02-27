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
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuControllerTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma menu item


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuControllerTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    switch (indexPath.row) {
        case 0:
            cell.MenuItem.text = @"Home Timeline";
       //     [cell.imageView initWithImage:[UIImage imageNamed:@"home.png"]];
            break;
        case 1:
             cell.MenuItem.text = @"Profile";
       //     [cell.imageView initWithImage:[UIImage imageNamed:@"me.png"]];
            break;
        case 2:
             cell.MenuItem.text = @"Mentions";
       //     [cell.imageView initWithImage:[UIImage imageNamed:@"mention.png"]];
            break;
        default:
            cell.MenuItem.text = @"Sign Out";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        case 1:
        case 2:
           // [self.slidableMenuController onMenuSelect:indexPath.row];
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
