//
//  TweetDetailedViewController.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//
#import "UIImageView+AFNetworking.h"
#import "TweetDetailedViewController.h"
#import "TwitterClient.h"
#import "NewTweetViewController.h"

@interface TweetDetailedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *retweetIcon;
@property (weak, nonatomic) IBOutlet UIButton *favoriteIcon;
@property (weak, nonatomic) IBOutlet UIButton *replyIcon;
@property (weak, nonatomic) User* user;
@end

@implementation TweetDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = self.tweet.user;
    self.userName.text = self.tweet.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.tweetText.delegate = self;
    self.tweetText.text = self.tweet.text;
    
    
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onReply:(id)sender {
    NewTweetViewController *vc = [[NewTweetViewController alloc] init];
    vc.tweet = self.tweet;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}


- (IBAction)onFavorite:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = self.tweet.id;
    BOOL isFavorite = ([self.tweet.isFavorite integerValue]==1);
    [[TwitterClient sharedInstance] favoriteTweet:params favorite:isFavorite completion:^(NSDictionary *result, NSError *error){
        if([self.tweet.isFavorite integerValue] == 1){
            self.tweet.isFavorite = [NSNumber numberWithInt:0];
            [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite_gray"] forState:UIControlStateNormal];
        }else{
            self.tweet.isFavorite = [NSNumber numberWithInt:1];
            [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
        }
    }];
}




- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] reTweet:self.tweet.id completion:^(NSDictionary *result, NSError *error){
         NSLog(@"OnRetweet callback called from TweetDetailedViewController.");
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet"] forState:UIControlStateNormal];
    }];
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
