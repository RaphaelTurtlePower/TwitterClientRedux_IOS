//
//  User.h
//  TwitterClient
//
//  Created by Chris Mamuad on 2/22/15.
//  Copyright (c) 2015 Chris Mamuad. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLogoutNotification;
extern NSString * const UserDidLoginNotification;

@interface User : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagLine;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (User *)currentuser;
+ (void)setCurrentUser:(User *)currentuser;
+ (void)logOut;
@end
