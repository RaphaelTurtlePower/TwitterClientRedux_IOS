//
//  ContainerViewControllerDelegate.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/28/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#ifndef TwitterClient_ContainerViewControllerDelegate_h
#define TwitterClient_ContainerViewControllerDelegate_h
#import "User.h"

@protocol ContainerViewControllerDelegate <NSObject>

@required
- (void)openMenu;
-(void) closeMenu:(NSString*) page withUser:(User*) user;

@end


#endif
