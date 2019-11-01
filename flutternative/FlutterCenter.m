//
//  FlutterCenter.m
//  flutternative
//
//  Created by ZLL on 2019/11/1.
//  Copyright © 2019 com.hx. All rights reserved.
//

#import "FlutterCenter.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"

@interface FlutterCenter ()<FlutterStreamHandler>

@end
@implementation FlutterCenter
-(void)pushFlutter:(UIViewController *)vc withName:(NSString *)name{
    
    if ([AppDelegate sharedAppDelegate].flutterEngine == nil) {
        [AppDelegate sharedAppDelegate].flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
        [[AppDelegate sharedAppDelegate].flutterEngine runWithEntrypoint:nil];
    }
    [GeneratedPluginRegistrant registerWithRegistry:[AppDelegate sharedAppDelegate].flutterEngine];
    
    
    /**
     I use Swift, and i found problem is self.flutterEngine?.run(withEntrypoint: nil) in document https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps. If you do like that, FlutterEngine will run before you create FlutterViewController so you cannot setInitialRoute.
     To solve, you must remove that line in AppDelegate, init FlutterViewController without FlutterEngine let flutterViewController = FlutterViewController(nibName: nil, bundle: nil), and setInitialRoute, final call flutterEngine?.run(withEntrypoint: nil).
     */
    
    //不要用这种方式创建，是个大坑。会导致dart 找不到路由。解决方式来自：github issue
//    FlutterViewController *fluttervc = [[FlutterViewController alloc]initWithEngine:[AppDelegate sharedAppDelegate].flutterEngine nibName:nil bundle:nil];
    
    FlutterViewController *fluttervc = [[FlutterViewController alloc] init];
    fluttervc.navigationController.navigationBarHidden = NO;
    if ([name isEqualToString:@"route1"]) {
        [fluttervc setInitialRoute:@"route1"];//目的是找到对应的widget
        //1.0 交互
        NSString *channelName = @"com.pages.your/native_get";
        FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:fluttervc];
        [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            //方法1
            if([call.method isEqualToString:@"func1"]){
                NSLog(@"flutter call oc");
            }
            //方法2
            if([call.method isEqualToString:@"func2"]){
                NSDictionary *param = call.arguments;
                NSLog(@"%@",param);
            }
            
            //方法3
            if([call.method isEqualToString:@"func3"]){
                if (result) {
                    result(@"oc-param");
                }
            }
        }];
    }else{
        [fluttervc setInitialRoute:@"route2"];
        NSString *channelName = @"com.pages.your/native_post";
           
        FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:fluttervc];
           // 代理FlutterStreamHandler
        [evenChannal setStreamHandler:self];
    }
    [vc.navigationController pushViewController:fluttervc animated:YES];
}
#pragma mark - <FlutterStreamHandler>
// // 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events {
    if (events) {
         events(@"push传值给flutter的vc");
    }
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}


@end
