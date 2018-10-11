//
//  PoporPopNCAppDelegate.m
//  PoporPopNC
//
//  Created by wangkq on 06/21/2018.
//  Copyright (c) 2018 wangkq. All rights reserved.
//

#import "PoporPopNCAppDelegate.h"

#import <PoporPopNC/PoporPopNC.h>
#import <PoporFoundation/PrefixSize.h>
#import <PoporFoundation/PrefixColor.h>
#import <PoporUI/UIImage+Tool.h>


#import "PoporPopNCViewController.h"

@implementation PoporPopNCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PoporPopNC * nc = [[PoporPopNC alloc] initWithRootViewController:[PoporPopNCViewController new]];
    nc.updateBarBackTitle = YES;
    nc.barBackTitle = @"返回";
    nc.barBackImage = [UIImage imageNamed:@"NCBack"];
    

    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
