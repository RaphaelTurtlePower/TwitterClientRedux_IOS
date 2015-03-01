//
//  ProfileViewController.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/28/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;

@end

@implementation ProfileViewController

-(id) initWithUser: (User*) user {
    self = [self init];
    self.user = user;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fullName.text = self.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@",self.user.screenName];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.user.profileBackgroundImageURL]];
    self.tweetCount.text = [NSString stringWithFormat:@"%d", (int)self.user.statusCount];
    self.followingCount.text = [NSString stringWithFormat:@"%d", (int)self.user.friendCount];
    self.followersCount.text = [NSString stringWithFormat:@"%d", (int)self.user.followerCount];
    self.title = @"Profile";
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
