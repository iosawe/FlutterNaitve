//
//  FlutterCenter.h
//  flutternative
//
//  Created by ZLL on 2019/11/1.
//  Copyright © 2019 com.hx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FlutterCenter : NSObject
-(void)pushFlutter:(UIViewController *)vc withName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
