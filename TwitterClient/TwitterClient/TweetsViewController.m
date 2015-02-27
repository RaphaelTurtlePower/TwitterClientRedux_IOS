//
//  TweetsViewController.m
//  Twitter
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetViewCell.h"
#import "SVPullToRefresh.h"
#import "NewTweetViewController.h"
#import "TweetDetailedViewController.h"

@interface TweetsViewController ()
@property (strong, nonatomic) NSMutableArray* tweets;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweets = [[NSMutableArray alloc] init];
    self.tweetList.delegate = self;
    self.tweetList.dataSource = self;
    [self.tweetList registerNib:[UINib nibWithNibName:@"TweetViewCell" bundle:nil] forCellReuseIdentifier:@"TweetViewCell"];
    self.tweetList.estimatedRowHeight = 100;
    self.tweetList.rowHeight = UITableViewAutomaticDimension;
    self.title = @"Home";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Sign Out" style: UIBarButtonItemStylePlain
                                             target:self action:@selector(logoutClicked:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Compose" style: UIBarButtonItemStylePlain
                                              target:self action:@selector(composeClicked:)];
    [self loadData:nil refresh:NO];
   
    [self.tweetList addPullToRefreshWithActionHandler:^{
        [self loadData: self.tweets[0] refresh:YES];
    }];
    
    [self.tweetList addInfiniteScrollingWithActionHandler:^{
        [self loadData: self.tweets[[self.tweets count]-1] refresh:NO];
    }];
}

- (void) loadData: (Tweet*)tweet refresh: (BOOL) refresh{
    
    NSDictionary *params =  nil;
    if(tweet != nil){
        NSLog(@"TweetId: %@", tweet.id);
        if(refresh){
            params = [[NSDictionary alloc] initWithObjectsAndKeys:tweet.id, @"since_id", nil];
        }else{
            params = [[NSDictionary alloc] initWithObjectsAndKeys:tweet.id, @"max_id", nil];
        }
    }
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:params completion:^(NSArray *tweets, NSError *error) {
        if(refresh){
            self.tweets = [[tweets arrayByAddingObjectsFromArray:self.tweets] mutableCopy];
            [self.tweetList.pullToRefreshView stopAnimating];
        }else{
            if([self.tweets count] > 0){
                [self.tweets removeLastObject];
            }
            [self.tweets addObjectsFromArray:tweets];
            [self.tweetList.infiniteScrollingView stopAnimating];
        }
       
        [self.tweetList reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOut:(id)sender {
    [User logOut];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewCell* cell = [self.tweetList dequeueReusableCellWithIdentifier:@"TweetViewCell"];
    [cell initWithTweet:self.tweets[indexPath.row] parent:self];
    cell.delegate = self;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TweetDetailedViewController *vc = [[TweetDetailedViewController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.tweet = self.tweets[indexPath.row];
   [self presentViewController:nvc animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void) logoutClicked:(id) sender {
    [User logOut];
}

- (void)composeClicked:(id)sender {
    NewTweetViewController  *vc = [[NewTweetViewController alloc]init];
    vc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void) NewTweetViewController: (NewTweetViewController*) viewController onTweet:(Tweet*) tweet{
    [self.tweets insertObject:tweet atIndex:0];
    [self.tweetList reloadData];
}

-(void) tweetCell:(TweetViewCell *)cell onReply:(BOOL)state tweet:(Tweet*) tweet{
    NewTweetViewController *vc = [[NewTweetViewController alloc] init];
    vc.tweet = tweet;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];

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
