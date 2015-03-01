//
//  ContainerViewController.m
//  TwitterClient
//
//  Created by Chris Mamuad on 2/26/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"
#import "TweetsViewController.h"
#import "User.h"
#import "ProfileViewController.h"

@interface ContainerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *tweetView;
@property (nonatomic) CGPoint originalCenter;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;


@end

@implementation ContainerViewController

- (id) initWithTweetController:(UIViewController *) tvc withMenu: (UIViewController *) mvc {
    self = [self init];
    if (self){
        self.menuViewController = mvc;
        self.tweetsViewController = tvc;
        self.menuView = self.menuViewController.view;
        self.tweetView = self.tweetsViewController.view;
        
           }
    return self;
}


- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender translationInView:self.tweetView];
    if (sender.state == UIGestureRecognizerStateBegan) {
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.tweetView.frame;
        frame.origin.x = location.x;
        self.tweetView.frame = frame;
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        CGFloat totalWidth = [UIScreen mainScreen].bounds.size.width;
        if (self.tweetView.frame.origin.x > (totalWidth/2)) {
            //open
            [self openMenu];
        } else {
            //close
            [self closeMenu:nil withUser:nil];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.menuView addSubview:self.menuViewController.view];
    [self addChildViewController:self.menuViewController];
    [self.menuViewController didMoveToParentViewController:self];
    
    [self.tweetView addSubview:self.tweetsViewController.view];
    [self addChildViewController:self.tweetsViewController];
    [self.tweetsViewController didMoveToParentViewController:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openMenu{
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect frame = self.tweetView.frame;
                         frame.origin.x = [UIScreen mainScreen].bounds.size.width - 50;
                         self.tweetView.frame = frame;
                     } completion:^(BOOL finished){
                         if(finished){
                             NSLog(@"Animation finished.");
                         }
                     }];
}



-(void) closeMenu:(NSString*) page withUser:(User*) user{
    if(page ==nil){
        
    }else if([page isEqualToString:@"profile"]){
        if(user != nil){
            ProfileViewController *pvc = [[ProfileViewController alloc] initWithUser:user];
            pvc.delegate = self;
            UINavigationController *nav = (UINavigationController*)self.tweetsViewController;
            [nav pushViewController:pvc animated:NO];
            self.tweetsViewController = nav;
        }
    }else if([page isEqualToString:@"mentions"]){
        TweetsViewController *tvc = [[TweetsViewController alloc] initAsHome:NO];
        tvc.delegate = self;
        UINavigationController *nav = (UINavigationController*)self.tweetsViewController;
        [nav pushViewController:tvc animated:NO];
        self.tweetsViewController = nav;
    }else if([page isEqualToString:@"home"]){
        TweetsViewController *tvc = [[TweetsViewController alloc] initAsHome:YES];
        tvc.delegate = self;
        UINavigationController *nav = (UINavigationController*) self.tweetsViewController;
        [nav pushViewController:tvc animated:NO];
        self.tweetsViewController = nav;
    }
    
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         CGRect frame = self.tweetView.frame;
                         frame.origin.x = 0;
                         self.tweetView.frame = frame;
                     } completion:^(BOOL finished) {
                         if(finished){
                             
                         }
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
