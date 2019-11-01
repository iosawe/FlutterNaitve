//
//  AppDelegate.h
//  flutternative
//
//  Created by ZLL on 2019/10/31.
//  Copyright © 2019 com.hx. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Flutter;
@import FlutterPluginRegistrant;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;
@property (nonatomic,strong) FlutterEngine *flutterEngine;
+(instancetype)sharedAppDelegate;
@end

