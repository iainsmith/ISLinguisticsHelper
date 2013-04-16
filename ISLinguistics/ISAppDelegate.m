//
//  ISAppDelegate.m
//  ISLingusitics
//
//  Created by Iain Smith on 13/04/2013.
//  Copyright (c) 2013 mountain23. All rights reserved.
//

#import "ISAppDelegate.h"

@implementation ISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
