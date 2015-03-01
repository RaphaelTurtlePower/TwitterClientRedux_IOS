//
//  LoginViewController.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/21/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "BDBOAuth1RequestOperationManager.h"
#import "TweetsViewController.h"
#import "MenuViewController.h"
#import "ContainerViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            NSLog(@"Welcome to %@", user.name);
            TweetsViewController *tvc = [[TweetsViewController alloc] initAsHome:YES];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tvc];
            MenuViewController *mvc = [[MenuViewController alloc] init];
            UINavigationController *nmvc = [[UINavigationController alloc] initWithRootViewController:mvc];
            
            
            ContainerViewController *cvc = [[ContainerViewController alloc] initWithTweetController:nvc withMenu:nmvc];
            
            mvc.delegate = cvc;
            tvc.delegate = cvc;
            
            CGRect frame = nvc.view.frame;
            frame.size.width = 320;
            nvc.view.frame = frame;
            nmvc.view.frame = frame;

            
            
            [self presentViewController:cvc animated:YES completion:nil];
            
        } else {
            // error view
        }
    }];
    


}

     
     - (void)viewDidLoad {
         [super viewDidLoad];
         UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLogin:)];
         singleTap.numberOfTapsRequired = 1;
         singleTap.numberOfTouchesRequired = 1;
         
         [self.backgroundImageView addGestureRecognizer:singleTap];
         [self.backgroundImageView setUserInteractionEnabled:YES];
         // Do any additional setup after loading the view from its nib.
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
