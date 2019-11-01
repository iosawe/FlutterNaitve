//
//  ViewController.m
//  flutternative
//
//  Created by ZLL on 2019/10/31.
//  Copyright © 2019 com.hx. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "FlutterCenter.h"
@interface ViewController ()<FlutterStreamHandler>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 70, 30)];
    [btn1 setTitle:@"method" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pushFlutterVC) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 70, 30)];
    [btn2 setTitle:@"method" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(pushFlutterVC2) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn2];
}

- (IBAction)pushFlutterVC {//flutter 调用vc 包括：正向，反向传值
    
//    FNViewController *vc = [[FNViewController alloc]initWithEngine:[AppDelegate sharedAppDelegate].flutterEngine nibName:nil bundle:nil];
//    [vc setInitialRoute:@"route1"];//目的是找到对应的widget
//    vc.navigationController.navigationBarHidden = NO;
//    [self.navigationController pushViewController:vc animated:YES];
    
//    return;
    FlutterCenter *center = [[FlutterCenter alloc] init];
    [center pushFlutter:self withName:@"route1"];
    return;
    
}
- (IBAction)pushFlutterVC2 {//初始化的时候，oc调用flutter，目前从API来看，只能再初始化的时候，主动发东西给flutter
    FlutterCenter *center = [[FlutterCenter alloc] init];
    [center pushFlutter:self withName:@"route2"];
    
}

@end
