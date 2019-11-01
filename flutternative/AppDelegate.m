//
//  AppDelegate.m
//  flutternative
//
//  Created by ZLL on 2019/10/31.
//  Copyright © 2019 com.hx. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

+(instancetype)sharedAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (BOOL)application:(UIApplication*)application
didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    
    self.window                 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *root = [[ViewController alloc] init];
    UINavigationController *rootnav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = rootnav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
