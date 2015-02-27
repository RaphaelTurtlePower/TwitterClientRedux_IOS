//
//  NewTweetViewController.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "NewTweetViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface NewTweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) User* user;
@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.user = [User currentuser];
    self.userName.text = self.user.name;
    self.screenName.text = [NSString stringWithFormat:@"@%@",self.user.screenName];
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.tweetText.delegate = self;
    if(self.tweet){
        self.tweetText.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    }else{
        self.tweetText.text = @"Start Tweeting right now!";
    }
    
    self.navigationItem.title = @"New Tweet";
    UIBarButtonItem* sendTweet = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(onSend)];
    self.navigationItem.rightBarButtonItem = sendTweet;
    
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.leftBarButtonItem = cancel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSend {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.tweetText.text forKey:@"status"];
    [[TwitterClient sharedInstance] sendTweet:params completion:^(Tweet *tweet, NSError *error){
        
    }];
    if(self.delegate != nil){
        Tweet *newTweet = [[Tweet alloc] initTweet:self.tweetText.text];
        [self.delegate NewTweetViewController:self onTweet:newTweet];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
}

- (void)onCancel {
        [self dismissViewControllerAnimated:YES completion:nil];
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
